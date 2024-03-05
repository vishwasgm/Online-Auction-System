<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>Falling Behind: Your Losing Bids</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Bid Price</th>
                <th>Bid Time</th>
                <th>Current Highest Bid</th>
            </tr>
        </thead>
        <tbody>
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement losingBidsStmt = null;
                ResultSet losingBidsRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
					String losingBidsQuery = "SELECT b.itemId, i.name, b.price, b.time, MAX(b2.price) as current_highest_bid FROM Bid b JOIN Item i ON b.itemId = i.itemId JOIN Bid b2 ON b2.itemId = i.itemId WHERE b.userId = ? AND b.status = 'active' AND EXISTS (SELECT 1 FROM Bid WHERE itemId = b.itemId AND price > b.price AND status = 'active') AND b2.status = 'active' GROUP BY b.itemId, b.price, b.time";
                    losingBidsStmt = con.prepareStatement(losingBidsQuery);
                    losingBidsStmt.setInt(1, userId);
                    losingBidsRs = losingBidsStmt.executeQuery();
                    while (losingBidsRs.next()) {
            %>
            <tr>
               	<td><a href="Item.jsp?itemId=<%= losingBidsRs.getString("itemId") %>"><%= losingBidsRs.getString("itemId") %></a></td>
                <td><%= losingBidsRs.getString("name") %></td>
                <td><%= losingBidsRs.getDouble("price") %></td>
                <td><%= losingBidsRs.getTimestamp("time") %></td>
                <td><%= losingBidsRs.getDouble("current_highest_bid") %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (losingBidsRs != null) {
                        losingBidsRs.close();
                    }
                    if (losingBidsStmt != null) {
                        losingBidsStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>
