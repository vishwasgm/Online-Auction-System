<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    // Get the seller's userId from the request parameter
    int userId = Integer.parseInt(request.getParameter("userId"));
    
    // Retrieve the seller's information from the database
    UserBean seller = null;
    float sellerRating = 0.0f;
    PreparedStatement sellerStmt = null;
    ResultSet sellerRs = null;
    Connection con = null;
    DecimalFormat df_obj = new DecimalFormat("#.#");
    try {
        ApplicationDB database = new ApplicationDB();
        
        con = database.getConnection();
        String sellerQuery = "SELECT u.*, e.rating FROM User u INNER JOIN EndUser e ON u.userId = e.userId WHERE u.userId = ?";
        sellerStmt = con.prepareStatement(sellerQuery);
        sellerStmt.setInt(1, userId);
        sellerRs = sellerStmt.executeQuery();
        if (sellerRs.next()) {
            seller = new UserBean (sellerRs.getInt("userId"), sellerRs.getString("name"), sellerRs.getString("username"), sellerRs.getString("password"), sellerRs.getString("email"), sellerRs.getString("location"));
            sellerRating = sellerRs.getFloat("rating");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (sellerRs != null) {
            try {
                sellerRs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (sellerStmt != null) {
            try {
                sellerStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Retrieve the items posted by the seller from the database
    List<Item> items = new ArrayList<>();
    PreparedStatement itemsStmt = null;
    ResultSet itemsRs = null;
    try {
        ApplicationDB database = new ApplicationDB();
        con = database.getConnection();
        String itemsQuery = "SELECT i.* FROM Item i WHERE i.userId = ?";
        itemsStmt = con.prepareStatement(itemsQuery);
        itemsStmt.setInt(1, userId);
        itemsRs = itemsStmt.executeQuery();
        while (itemsRs.next()) {
            Item item = new Item(itemsRs.getInt("userId"), itemsRs.getString("itemId"), itemsRs.getString("name"), itemsRs.getString("description"), itemsRs.getString("subcategory"), itemsRs.getDouble("initialprice"), itemsRs.getTimestamp("closingtime"), itemsRs.getDouble("bidincrement"), itemsRs.getDouble("minprice"));
            items.add(item);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (itemsRs != null) {
            try {
                itemsRs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (itemsStmt != null) {
            try {
                itemsStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Info</title>
    <link href="assets/css/global.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
  <jsp:include page="Navbar.jsp">
            <jsp:param name="username" value="${user.name}" />
            <jsp:param name="landingPage" value="UserHome" />
        </jsp:include>
    <div class="container mt-5">
    <h3 class="mb-4">Seller Information</h3>
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
        <h5 class="font-weight-bold mb-0"><%= seller.getName() %></h5>
        <p class="mb-0">Rating: <%= df_obj.format(sellerRating) %></p>
    </div>
</div>
		
    <div class="container mt-5">
    <h3>Items for Sale</h3>
    <div class="row">
    <% for (Item item : items) {
        Timestamp closingTime = item.getClosingTime();
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        boolean isClosed = closingTime.before(currentTime);
    %>
    <div class="col-md-4 mb-3">
        <a href="Item.jsp?itemId=<%= item.getItemId() %>" class="item-card-link">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= item.getName() %></h5>
                    <p class="card-text"><%= item.getDescription() %></p>
                    <p class="card-text">Price: <%= item.getInitialPrice() %></p>
                    <% if (isClosed) { %>
                    <div class="closed-indicator">Closed</div>
                    <% } %>
                </div>
            </div>
        </a>
    </div>
    <% } %>
</div>
</div>
<jsp:include page="Footer.jsp" />
</body>
</html>    