<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%
    UserBean user = (UserBean)session.getAttribute("user");
    
    if(user == null ) {
    	response.sendRedirect(request.getContextPath() + "/Login.jsp");
    } else {
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Buy Me Application</title>
        <link href="assets/css/global.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="Navbar.jsp">
            <jsp:param name="username" value="${user.name}" />
            <jsp:param name="landingPage" value="UserHome" />
        </jsp:include>
         <div class="container">
            <form method="post" action="EndUserCreateListing.jsp" class="w-50">
                <h3 class="h3 mb-3 font-weight-normal">Post an item for auction</h3>
                <input type="hidden" name="userId" value=${user.userId}></input>
                
                <div class="form-floating mb-2">
                    <input id="itemName" class="form-control" type="text" name="item_name" placeholder="Item Name" required autofocus>
                    <label for="itemName">Item Name</label>
                </div>
                <div class="form-floating mb-2">
                    <textarea id="itemDescription" class="form-control" name="item_description" rows="4" cols="40" placeholder="Description" required></textarea>
                    <label for="itemDescription">Description</label>
                </div>
                <div class="form-floating mb-2">
                    <select class="form-control" id="itemSubcategory" name="subcategory" required>
                        <option value="" disabled selected>Select Subcategory</option>
                        <option value="laptop">Laptops</option>
                        <option value="smartphone">Smartphones</option>
                        <option value="tablet">Tablets</option>
                    </select>
                    <label for="itemSubcategory">Subcategory</label>
                </div>
                <div class="form-floating mb-2">
                    <input id="itemInitialPrice" class="form-control" type="number" name="item_initial_price" placeholder="Initial Price" required autofocus>
                    <label for="itemInitialPrice">Initial Price</label>
                </div>
                <div class="form-floating mb-2">
                    <input id="itemClosingTime" class="form-control" type="datetime-local" name="item_closing_time" required autofocus>
                    <label for="itemClosingTime">Closing Time</label>
                </div>
                <div class="form-floating mb-2">
                    <input id="itemBidIncrement" class="form-control" type="number" name="item_bid_increment" placeholder="Bid Increment" required autofocus>
                    <label for="itemBidIncrement">Bid Increment</label>
                </div>
                <div class="form-floating mb-3">
                    <input id="itemMinPrice" class="form-control" type="number" name="item_min_price" placeholder="Minimum Price" required autofocus>
                    <label for="itemMinPrice">Minimum Price</label>
                </div>
                
                <div class="d-flex justify-content-center mb-3">
                    <button type="submit" class="btn btn-primary me-5">Submit</button>
                </div>
            </form>
            <div class=" text-center w-50">
                <%
                    if (request.getParameter("status") != null && Boolean.parseBoolean(request.getParameter("status"))) {
                    %>
                <p>Item has been posted for auction.</p>
                <% } else if (request.getParameter("status") != null && !Boolean.parseBoolean(request.getParameter("status"))){ %>
                <p class=" text-danger">Error processing your request. Please try again! </p>
                <% }%>
            </div>
        </div>
    </body>
</html>
<%} %>