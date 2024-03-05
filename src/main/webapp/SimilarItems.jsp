<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<link href="assets/css/carousel.css" rel="stylesheet"/>
<!-- Similar items carousel -->
<div class="container mt-5">
    <h3>Similar Items</h3>
    <div class="carousel">
        <div class="carousel-track">
            <%
                String itemId = request.getParameter("itemId");
                PreparedStatement similarItemsStmt = null;
                ResultSet similarItemsRs = null;
                Connection con = null;
                try {
                    ApplicationDB database = new ApplicationDB();
                    con = database.getConnection();
                    // Close expired bids
                    BuyMeUtils.closeExpiredBids(con);
                    String similarItemsQuery = "SELECT i.itemId, i.name, i.description, i.initialprice, i.closingtime FROM Item i WHERE i.subcategory = (SELECT subcategory FROM Item WHERE itemId = ?) AND i.itemId != ? AND i.closingtime > NOW() - INTERVAL 1 MONTH AND i.closingtime < NOW()";
                    similarItemsStmt = con.prepareStatement(similarItemsQuery);
                    similarItemsStmt.setString(1, itemId);
                    similarItemsStmt.setString(2, itemId);
                    similarItemsRs = similarItemsStmt.executeQuery();
                    while (similarItemsRs.next()) {
                
                %>
            <div class="carousel-card">
			    <a href="Item.jsp?itemId=<%= similarItemsRs.getString("itemId") %>" class="item-card-link">
			        <div class="card">
			            <div class="card-body">
			                <h5 class="card-title"><%= similarItemsRs.getString("name") %></h5>
			                <p class="card-desc"><%= similarItemsRs.getString("description") %></p>
			                <p class="card-text">Price: <%= similarItemsRs.getDouble("initialprice") %></p>
			            </div>
			        </div>
			    </a>
			</div>
            <% 
                }
                } catch (SQLException e) {
                e.printStackTrace();
                } finally {
                if (similarItemsRs != null) {
                    try {
                        similarItemsRs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (similarItemsStmt != null) {
                    try {
                        similarItemsStmt.close();
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
        </div>
    </div>
</div>