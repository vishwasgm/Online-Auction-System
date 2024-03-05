<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-5">
				    <h3>Your Active Bids</h3>
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

				                PreparedStatement activeBidsStmt = null;
				                ResultSet activeBidsRs = null;
				                Connection con = null;

				                try {
				                	ApplicationDB database = new ApplicationDB();
									con = database.getConnection();
				                    String activeBidsQuery = "SELECT b.itemId, i.name, b.price, b.time FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE b.userId = ? AND b.status = 'active'";
				                    activeBidsStmt = con.prepareStatement(activeBidsQuery);
				                    activeBidsStmt.setInt(1, userId);
				                    activeBidsRs = activeBidsStmt.executeQuery();
				                    while (activeBidsRs.next()) {
				            %>
				            <tr>
				                <td><a href="Item.jsp?itemId=<%= activeBidsRs.getString("itemId") %>"><%= activeBidsRs.getString("itemId") %></a></td>
				                <td><%= activeBidsRs.getString("name") %></td>
				                <td><%= activeBidsRs.getDouble("price") %></td>
				                <td><%= activeBidsRs.getTimestamp("time") %></td>
				            </tr>
				            <%
				                    }
				                } catch (SQLException e) {
				                    e.printStackTrace();
				                } finally {
				                    if (activeBidsRs != null) {
				                        activeBidsRs.close();
				                    }
				                    if (activeBidsStmt != null) {
				                        activeBidsStmt.close();
				                    }
				                }
				            %>
				        </tbody>
				    </table>
				</div>