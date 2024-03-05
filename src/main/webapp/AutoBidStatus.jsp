<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>Autobid Status</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Upper Limit</th>
                <th>Current Highest Bid</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement autobidStatusStmt = null;
                ResultSet autobidStatusRs = null;
                Connection con = null;
                try {
                    ApplicationDB database = new ApplicationDB();
                    con = database.getConnection();
                   // String autobidStatusQuery = "SELECT ab.itemId, i.name, ab.upper_limit, (SELECT MAX(b.price) FROM Bid b WHERE b.itemId = ab.itemId) as highest_bid FROM AutoBid ab JOIN Item i ON ab.itemId = i.itemId WHERE ab.userId = ?";
                    String autobidStatusQuery = "SELECT ab.itemId, i.name, ab.upper_limit, (SELECT MAX(b.price) FROM Bid b WHERE b.itemId = ab.itemId) as highest_bid FROM AutoBid ab JOIN Item i ON ab.itemId = i.itemId WHERE ab.userId = ? AND i.closingtime > NOW()";

                    autobidStatusStmt = con.prepareStatement(autobidStatusQuery);
                    autobidStatusStmt.setInt(1, userId);
                    autobidStatusRs = autobidStatusStmt.executeQuery();

                    while (autobidStatusRs.next()) {
                        String itemId = autobidStatusRs.getString("itemId");
                        String itemName = autobidStatusRs.getString("name");
                        double upperLimit = autobidStatusRs.getDouble("upper_limit");
                        double highestBid = autobidStatusRs.getDouble("highest_bid");
                        String status = highestBid <= upperLimit ? "Active" : "Limit Exceeded";
                        String rowClass = status.equals("Limit Exceeded") ? "table-danger" : "";
            %>
            <tr class="<%= rowClass %>">
                <td><a href="Item.jsp?itemId=<%= itemId %>"><%= itemId %></a></td>
                <td><%= itemName %></td>
                <td><%= upperLimit %></td>
                <td><%= highestBid %></td>
                <td><%= status %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (autobidStatusRs != null) {
                        autobidStatusRs.close();
                    }
                    if (autobidStatusStmt != null) {
                        autobidStatusStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>
