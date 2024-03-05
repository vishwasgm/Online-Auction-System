<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
		<link href="assets/css/global.css" rel="stylesheet"/>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			
			<form class="text-center form-signin" method="post" action="RegisterUser.jsp">
				<!-- <h1 class="h3 mb-3 font-weight-normal">Welcome to BuyMe</h1> -->
				<h3 class="h3 mb-3 font-weight-normal">Registration</h3>
				<%if(Boolean.parseBoolean(request.getParameter("userExists")) || Boolean.parseBoolean(request.getParameter("passwordErr"))) { %>
					<p><%=request.getParameter("message")%></p>
				<% } %>
				
				<label for="inputName" class="sr-only">Name</label>
				<input id="inputName" class="form-control" type="text" name="name" placeholder="Name" required autofocus>
				
				<label for="inputLocation" class="sr-only">Location</label>
				<input id="inputLocation" class="form-control" type="text" name="location" placeholder="Location" >
				
				<label for="inputUser" class="sr-only">Username</label>
				<input id="inputUser" class="form-control" type="text" name="username" placeholder="Username" required autofocus>
				
				<label for="inputEmail" class="sr-only">Email</label>
				<input id="inputEmail" class="form-control" type="text" name="email" placeholder="Email" required >
				
				<label for="inputPassword" class="sr-only">Password</label>
				<input id="inputPassword" class="form-control" type="password" name="password" placeholder="Password" required>
				
				<label for="inputPasswordConfirm" class="sr-only">Confirm Password</label>
				<input id="inputPasswordConfirm" class="form-control" type="password" name="confirmPassword" placeholder="Confirm Password" required>	
				
				<div class="form-terms">
					<input type="checkbox" class="form-check-input" id="terms" required>
    				<label class="form-check-label" for="terms">I agree to the <a href="#">terms and conditions</a>.</label>
				</div>
				
				<button class="btn btn-primary btn-lg btn-login" type="submit" value="Login">Register</button>
		
				<p> <a href="Login.jsp">Click Here</a> to go back to home page.</p>
		</form>		</div>
	</body>
</html>