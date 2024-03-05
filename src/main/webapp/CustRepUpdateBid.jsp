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
    <h3>Active Bids for this user</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Bid ID</th>
                <th>Item ID</th>
                <th>Price</th>
                <th>Time</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                PreparedStatement bidStmt = null;
                ResultSet bidRs = null;
                try {
/*                     String bidQuery = "SELECT * FROM Bid WHERE userId = ? AND status = 'active'";
 */                    String bidQuery = "SELECT Bid.*, Item.bidincrement FROM Bid INNER JOIN Item ON Bid.itemId = Item.itemId WHERE Bid.userId = ? AND Bid.status = 'active'";
                    bidStmt = con.prepareStatement(bidQuery);
                    bidStmt.setInt(1, userId);
                    bidRs = bidStmt.executeQuery();
                    while (bidRs.next()) {
                    	int bidId = bidRs.getInt("bid_id");
            %>
            <tr>
                <td><%= bidRs.getInt("bid_id") %></td>
                <td><%= bidRs.getString("itemId") %></td>
                <td>
                	<form action="EditBidServlet" method="post">
                        <input type="hidden" name="bid_id" value="<%= bidId %>">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <input type="number" step="<%= bidRs.getDouble("bidincrement") %>" name="new_price" value="<%= bidRs.getDouble("price") %>" class="editable-price" required>
                        <input type="submit" value="Edit" class="btn btn-primary" onclick="return confirm('Are you sure you want to edit this bid's price?');">
                    </form>
                </td>
                
                <td><%= bidRs.getTimestamp("time") %></td>
                <td><%= bidRs.getString("status") %></td>
                <td>
                    
                    <form action="RemoveBidServlet" method="post" class="d-inline-block">
                    	<input type="hidden" name="userId" value="<%= userId %>">
                        <input type="hidden" name="bid_id" value="<%= bidRs.getInt("bid_id") %>">
                        <input type="submit" value="Remove" class="btn btn-danger" onclick="return confirm('Are you sure you want to remove this bid?');">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (bidRs != null) {
                        try {
                            bidRs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (bidStmt != null) {
                        try {
                            bidStmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </tbody>
    </table>
    
    		    <%
		    if (request.getParameter("bid_update") != null && Boolean.parseBoolean(request.getParameter("bid_update"))) {
		    %>
		    <p class="text-center">Operation successful.</p>
		    <% } else if (request.getParameter("bid_update") != null && !Boolean.parseBoolean(request.getParameter("bid_update"))){ %>
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
