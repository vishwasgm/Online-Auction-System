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
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
	</head>
	<body>
		<%
			try {
			UserBean user = null;
			ApplicationDB database = new ApplicationDB();
			Connection conn = database.getConnection();
			
			// Closing the expired bids
			BuyMeUtils.closeExpiredBids(conn);
			
			Statement stmt = conn.createStatement();
			
			String username = request.getParameter("username");
			String passwordString = request.getParameter("password");
			String password = BuyMeUtils.encryptPassword(passwordString);
			String employeeType = request.getParameter("employeeType");
			String query = "";
			String landingPage = "";
			boolean endUser = false;
			
			if(employeeType != null)  {
				if(employeeType.equalsIgnoreCase(BuyMeConstants.ADMIN)) {
					query = BuyMeConstants.ADMIN_USER_LOOKUP;
					landingPage = "AdminHome";
					
					 
				} else if(employeeType.equalsIgnoreCase(BuyMeConstants.CUSTOMER_REP)) {
					query = BuyMeConstants.CUST_REP_USER_LOOKUP;
					landingPage = "CustomerRepHome";
				}
			} else {
				endUser = true;
				query = BuyMeConstants.END_USER_LOOKUP;
				landingPage = "UserHome";
			}
			
			
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);
			
			
			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
				user = new UserBean();
				
				user.setName(rs.getString("name"));
				
				if(endUser) user.setRating(Double.parseDouble(rs.getString("rating")));
				
				user.setUserId(rs.getInt("userId"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setLocation(rs.getString("location"));
				
				session.setAttribute("user", user);
				
				/* request.setAttribute("user", user);
				request.getRequestDispatcher("UserHome.jsp").forward(request, response); */
				response.sendRedirect( landingPage +".jsp");
				
			
			} else {
				if(endUser) {
				%>
				<jsp:forward page="Login.jsp">
					<jsp:param name="loginFailed" value="true"/>
				</jsp:forward>			
				<% } else {
					%>  
					<jsp:forward page="EmployeeLogin.jsp">
						<jsp:param name="loginFailed" value="true"/>
					</jsp:forward>	
			<% 	}
			}
			preparedStatement.close();
			conn.close();
			
			} catch (Exception e) {
				
			} 
			
			
		%>
	</body>
</html>
