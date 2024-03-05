<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>Sale Analysis</title>
      <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Rubik:400,700'>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
      <link href="./StandardTemp.css" rel="stylesheet" type="text/css">
      <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
   </head>
   <body>
      <jsp:include page="Navbar.jsp">
			<jsp:param name="username" value="${user.name}" />
			<jsp:param name="isEmployee" value="true" />
			<jsp:param name="landingPage" value="AdminHome" />
		</jsp:include>
      <div class="container mt-4">
         <h1 class="text-center">Sales Report</h1>
      </div>
      <table class="table table-striped">
         <thead>
            <tr>
               <th><span>Itemname</span></th>
               <th><span>Price sold</span></th>
               <th>&nbsp;</th>
            </tr>
         </thead>
         <tbody>
            <%
               ApplicationDB DBconnect = new ApplicationDB();
               Connection con = DBconnect.getConnection();
               Statement stmt = con.createStatement();
               
               ResultSet rs = stmt.executeQuery("SELECT Sale.sale_price, Item.name, Item.subcategory, Sale.seller_id, Sale.buyer_id FROM Sale JOIN Item ON Sale.item_id = Item.itemId");
               int priceInt = Integer.parseInt("0");
               
               while (rs.next()) {
               	String Itemname = rs.getString("name");
               	String price = rs.getString("sale_price"); 
               	priceInt = priceInt+ Integer.parseInt(price);
               	out.println("<tr>");
               	out.println("<td>" + Itemname + "</td>");
               	out.println("<td>" + price + "</td>");
               	out.println("<td>&nbsp;</td>");
               	out.println("</tr>");
               }
               
               out.println("<h3>Total Earnings: $" + priceInt + "</h3>");
               rs.close();
               stmt.close();
               con.close();
               
               %>
         </tbody>
      </table>
      <table class="table table-striped">
         <thead>
            <tr>
               <th><span>Category</span></th>
               <th><span>Earnings</span></th>
               <th>&nbsp;</th>
            </tr>
         </thead>
         <tbody>
            <%
               ApplicationDB DBconnect1 = new ApplicationDB();
               Connection con1 = DBconnect1.getConnection();
               Statement stmt1 = con1.createStatement();
               
               ResultSet rs1 = stmt1.executeQuery("SELECT Item.subcategory, sum(Sale.sale_price) as b FROM Sale JOIN Item ON Sale.item_id = Item.itemid GROUP BY subcategory");
               while (rs1.next()) {
               	String Category = rs1.getString("subcategory");
               	String price = rs1.getString("b"); 
               	out.println("<tr>");
               	out.println("<td>" + Category + "</td>");
               	out.println("<td>" + price + "</td>");
               	out.println("<td>&nbsp;</td>");
               	out.println("</tr>");
               }
               
               rs1.close();
               stmt1.close();
               con1.close();
               
               %>
         </tbody>
      </table>
      <table class="table table-striped">
         <thead>
            <tr>
               <th><span>Seller</span></th>
               <th><span>Earnings</span></th>
               <th>&nbsp;</th>
            </tr>
         </thead>
         <tbody>
            <%
               // Connect to the database
               ApplicationDB DBconnect2 = new ApplicationDB();
               Connection con2 = DBconnect2.getConnection();
               Statement stmt2 = con2.createStatement();
               Statement stmtn = con2.createStatement();
               
               ResultSet rs2 = stmt2.executeQuery("SELECT Sale.seller_id, sum(Sale.sale_price) as b FROM Sale JOIN Item ON Sale.item_id = Item.itemid GROUP BY seller_id");
               while (rs2.next()) {
               	int Seller = rs2.getInt("seller_id");
               	String price = rs2.getString("b"); 
               	ResultSet rsnew = stmtn.executeQuery("SELECT user.name FROM user WHERE userId = " + Seller );
               	rsnew.next();
               	String SellerName = rsnew.getString("name"); 
               	out.println("<tr>");
               	out.println("<td>" + SellerName + "</td>");
               	out.println("<td>" + price + "</td>");
               	out.println("<td>&nbsp;</td>");
               	out.println("</tr>");
               }
               
               rs2.close();
               stmt2.close();
               con2.close();
               
               %>
         </tbody>
      </table>
      <table class="table table-striped">
         <thead>
            <tr>
               <th><span>Buyer</span></th>
               <th><span>Earnings</span></th>
               <th>&nbsp;</th>
            </tr>
         </thead>
         <tbody>
            <%
               ApplicationDB DBconnect3 = new ApplicationDB();
               Connection con3 = DBconnect3.getConnection();
               Statement stmt3 = con3.createStatement();
               Statement stmtn1 = con3.createStatement();
               
               ResultSet rs3 = stmt3.executeQuery("SELECT Sale.buyer_id, sum(Sale.sale_price) as b FROM Sale JOIN Item ON Sale.item_id = Item.itemid GROUP BY buyer_id;");
               while (rs3.next()) {
               	int Buyer = rs3.getInt("buyer_id");
               	String price = rs3.getString("b"); 
               	ResultSet rsnew1 = stmtn1.executeQuery("SELECT user.name from user where userId =" +Buyer);
               	rsnew1.next();
               	String BuyerName = rsnew1.getString("name"); 
               	out.println("<tr>");
               	out.println("<td>" + BuyerName + "</td>");
               	out.println("<td>" + price + "</td>");
               	out.println("<td>&nbsp;</td>");
               	out.println("</tr>");
               }
               
               rs3.close();
               stmt3.close();
               con3.close();
               
               %>
         </tbody>
      </table>
   </body>
</html>