<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>Your Leading Bids</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Bid Price</th>
                <th>Bid Time</th>
            </tr>
        </thead>
        <tbody>
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement leadingBidsStmt = null;
                ResultSet leadingBidsRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
                    String leadingBidsQuery = "SELECT b.itemId, i.name, b.price, b.time FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = ? AND b.status = 'active' AND NOT EXISTS (SELECT 1 FROM Bid WHERE itemId = b.itemId AND price > b.price AND status = 'active')";
                    leadingBidsStmt = con.prepareStatement(leadingBidsQuery);
                    leadingBidsStmt.setInt(1, userId);
                    leadingBidsRs = leadingBidsStmt.executeQuery();
                    while (leadingBidsRs.next()) {
            %>
            <tr>
              	<td><a href="Item.jsp?itemId=<%= leadingBidsRs.getString("itemId") %>"><%= leadingBidsRs.getString("itemId") %></a></td>
                <td><%= leadingBidsRs.getString("name") %></td>
                <td><%= leadingBidsRs.getDouble("price") %></td>
                <td><%= leadingBidsRs.getTimestamp("time") %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (leadingBidsRs != null) {
                        leadingBidsRs.close();
                    }
                    if (leadingBidsStmt != null) {
                    	leadingBidsStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>	
