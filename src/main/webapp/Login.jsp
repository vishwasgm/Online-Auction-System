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
			
			<form class="text-center form-signin" method="post" action="VerifyLogin.jsp">
				<!-- <h1 class="h3 mb-3 font-weight-normal">Welcome to BuyMe</h1> -->
				<h2>Welcome to BuyMe</h2>
				<h3 class="h3 mb-3 font-weight-normal">Please sign in</h3>
				<label for="inputUser" class="sr-only">Username</label>
				<input id="inputUser" class="form-control" type="text" name="username" placeholder="Username" required autofocus>
				
				<label for="inputPassword" class="sr-only">Password</label>
				<input id="inputPassword" class="form-control" type="password" name="password" placeholder="Password" required>
				
				
				<% if(Boolean.parseBoolean(request.getParameter("loginFailed"))) { %>	
					<span>Invalid username or password. Please try again</span>
				<% }%>
				
				
				<button class="btn btn-primary btn-lg btn-login" type="submit" value="Login">Sign in</button>
				
				<p><a class="btn-register" href="Register.jsp">Create an Account</a></p>
				
				<p> Are you an Employee? <a href="EmployeeLogin.jsp">Click Here</a></p>
				
		</form>
		</div>
	</body>
</html>
