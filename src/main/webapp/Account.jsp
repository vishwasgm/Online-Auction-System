<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<%
    UserBean user = (UserBean)session.getAttribute("user");
    
    if(user == null ) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
    } else {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
    <jsp:include page="Navbar.jsp">
        <jsp:param name="username" value="${user.name}" />
        <jsp:param name="landingPage" value="UserHome" />
    </jsp:include>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col border-end">
                <jsp:include page="CustRepUpdateEndUser.jsp">
                    <jsp:param name="userId" value="${user.userId}" />
                    <jsp:param name="isEmployee" value="false" />
                </jsp:include>
            </div>
            <div class="col">
                <jsp:include page="ManageInterests.jsp">
                    <jsp:param name="userId" value="${user.userId}" />
                </jsp:include>
            </div>
        </div>
    </div>
    
    <jsp:include page="AskQuestion.jsp">
        <jsp:param name="userId" value="${user.userId}" />
    </jsp:include>
    
    <jsp:include page="Footer.jsp" />
    
</body>
</html>
<%} %>
