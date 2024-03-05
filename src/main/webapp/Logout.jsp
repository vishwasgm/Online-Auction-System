<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<html>
	<head>
		<title>Buy Me | User Home Page</title>
	</head>
	<body>
		
		<h2>Signing out user ${user.name} </h2>
		<%if(session != null) {
			session.removeAttribute("user");
			session.invalidate();
			response.sendRedirect(request.getContextPath() + "/Login.jsp");
		} %>
	</body>
</html>