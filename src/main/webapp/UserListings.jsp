<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
    <h3>Items You've Listed for Auction</h3>
    <table class="table">
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Name</th>
                <!-- <th>Description</th> -->
                <th>Subcategory</th>
                <th>Initial Price</th>
                <th>Closing Time</th>
                <th>Highest Bid Price</th>
            </tr>
        </thead>
        <tbody>
            <%
            	int userId = Integer.parseInt(request.getParameter("userId"));
                PreparedStatement itemsPostedStmt = null;
                ResultSet itemsPostedRs = null;
                Connection con = null;
                try {
                	ApplicationDB database = new ApplicationDB();
					con = database.getConnection();
                    //String itemsPostedQuery = "SELECT i.itemId, i.name, i.description, i.subcategory, i.initialprice, i.closingtime, IFNULL(MAX(b.price), i.initialprice) as current_bid_price FROM Item i LEFT JOIN Bid b ON i.itemId = b.itemId WHERE i.userId = ? GROUP BY i.itemId";
                    String itemsPostedQuery = "SELECT i.itemId, i.name, i.description, i.subcategory, i.initialprice, i.closingtime, MAX(b.price) as current_bid_price FROM Item i LEFT JOIN Bid b ON i.itemId = b.itemId WHERE i.userId = ? GROUP BY i.itemId";

                    itemsPostedStmt = con.prepareStatement(itemsPostedQuery);
                    itemsPostedStmt.setInt(1, userId);
                    itemsPostedRs = itemsPostedStmt.executeQuery();
                    while (itemsPostedRs.next()) {
            %>
            <tr>
              	<td><a href="Item.jsp?itemId=<%= itemsPostedRs.getString("itemId") %>"><%= itemsPostedRs.getString("itemId") %></a></td>
                <td><%= itemsPostedRs.getString("name") %></td>
                <%-- <td><%= itemsPostedRs.getString("description") %></td> --%>
                <td><%= itemsPostedRs.getString("subcategory") %></td>
                <td><%= itemsPostedRs.getDouble("initialprice") %></td>
                <td><%= itemsPostedRs.getTimestamp("closingtime") %></td>
                <td><%= itemsPostedRs.getDouble("current_bid_price") %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (itemsPostedRs != null) {
                        itemsPostedRs.close();
                    }
                    if (itemsPostedStmt != null) {
                        itemsPostedStmt.close();
                    }
                }
            %>
        </tbody>
    </table>
</div>
