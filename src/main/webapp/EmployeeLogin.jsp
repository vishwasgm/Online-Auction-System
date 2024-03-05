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
				<h3 class="h3 mb-3 font-weight-normal">Employee Login</h3>
				
				<label for="inputEmpType" class="sr-only">Employee Type</label>
			    <select class="form-control login-select" id="inputEmpType" name="employeeType" required>
			    	<option value="" disabled selected>Select Employee Type</option>
					<option value="admin">Admin</option>
				    <option value="custrep">Customer Representative</option>
			    </select>
			    
				<label for="inputUser" class="sr-only">Username</label>
				<input id="inputUser" class="form-control" type="text" name="username" placeholder="Username" required autofocus>
					
				<label for="inputPassword" class="sr-only">Password</label>
				<input id="inputPassword" class="form-control" type="password" name="password" placeholder="Password" required>
				
				<% if(Boolean.parseBoolean(request.getParameter("loginFailed"))) { %>	
					<span>Invalid username or password. Please try again</span>
				<% }%>
				
				<button class="btn btn-primary btn-lg btn-login" type="submit" value="Login">Sign in</button>
				
				<p> <a href="Login.jsp">Click Here</a> to go back to home page.</p>
			</form>	
		</div>
	</body>
</html>