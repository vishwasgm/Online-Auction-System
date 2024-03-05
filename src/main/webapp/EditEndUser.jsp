<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit End User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>

		<jsp:include page="Navbar.jsp">
			<jsp:param name="username" value="${user.name}" />
			<jsp:param name="isEmployee" value="true" />
			<jsp:param name="landingPage" value="CustomerRepHome" />
		</jsp:include>

		<jsp:include page="CustRepUpdateEndUser.jsp">
			<jsp:param name="isEmployee" value="true" />
		</jsp:include>
		
		
		<jsp:include page="CustRepUpdateBid.jsp"/>
		<jsp:include page="CustRepUpdateAuction.jsp"/>
		<jsp:include page="CustRepFAQ.jsp"/>
	
</body>
</html>

                
