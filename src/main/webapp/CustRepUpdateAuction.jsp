<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    Connection con = null;
    try {
        ApplicationDB database = new ApplicationDB();
        con = database.getConnection();
%>

<div class="container mt-5">
    <h3>Items listed for auction by this user</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Subcategory</th>
                <th>Initial Price</th>
                <th>Closing Time</th>
                <th># Active Bids</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                PreparedStatement itemStmt = null;
                ResultSet itemRs = null;
                try {
                    /* String itemQuery = "SELECT * FROM Item WHERE userId = ?"; */
                    String itemQuery = "SELECT Item.*, COUNT(Bid.bid_id) as active_bids " +
                            "FROM Item LEFT JOIN Bid ON Item.itemId = Bid.itemId AND Bid.status = 'active' " +
                            "WHERE Item.userId = ? " +
                            "GROUP BY Item.itemId";
                    itemStmt = con.prepareStatement(itemQuery);
                    itemStmt.setInt(1, userId);
                    itemRs = itemStmt.executeQuery();
                    while (itemRs.next()) {
            %>
            <tr>
                <td><%= itemRs.getString("itemId") %></td>
                <td><%= itemRs.getString("name") %></td>
                <td><%= itemRs.getString("description") %></td>
                <td><%= itemRs.getString("subcategory") %></td>
                <td><%= itemRs.getDouble("initialprice") %></td>
                <td><%= itemRs.getTimestamp("closingtime") %></td>
                <td><%= itemRs.getInt("active_bids") %></td>
                
                <td>
                    <form action="RemoveItemServlet" method="post">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <input type="hidden" name="itemId" value="<%= itemRs.getString("itemId") %>">
                        <input type="submit" value="Remove" class="btn btn-danger" onclick="return confirm('Are you sure you want to remove this auction? All associated bids will also be removed');">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                	try {
                		 if (itemRs != null) {
                			 itemRs.close();
                		 }
                		 if (itemStmt != null) {
                			 itemStmt.close();
                		 }
                	} catch(SQLException e) {
                	 	e.printStackTrace();
                	}
                }
            %>
        </tbody>
    </table>
    
    	<%
		    if (request.getParameter("item_remove") != null && Boolean.parseBoolean(request.getParameter("item_remove"))) {
		    %>
		    <p class="text-center">Operation successful.</p>
		    <% } else if (request.getParameter("item_remove") != null && !Boolean.parseBoolean(request.getParameter("item_remove"))){ %>
		    <p class="text-center text-danger">Operation failed. Please try again later. </p>
		    <% }%>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
