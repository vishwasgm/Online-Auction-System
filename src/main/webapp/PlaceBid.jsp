<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>

<%
	// Get the user and item IDs from the session and request parameters
	UserBean user = (UserBean)session.getAttribute("user");
	String itemId = request.getParameter("itemId");
	double bidPrice = Double.parseDouble(request.getParameter("bidPrice"));
	
	// Connect to the database
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try {
		ApplicationDB database = new ApplicationDB();
		con = database.getConnection();
		
		// Insert the bid into the Bid table
		String sql = "INSERT INTO Bid (price, time) VALUES (?, ?)";
		stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setDouble(1, bidPrice);
		stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
		stmt.executeUpdate();
		
		// Retrieve the ID of the bid that was just inserted
		rs = stmt.getGeneratedKeys();
		int bidId = 0;
		if(rs.next()) {
			bidId = rs.getInt(1);
		}
		
		// Insert the user's bid into the Places table
		sql = "INSERT INTO Places (userId, bid_id) VALUES (?, ?)";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, user.getUserId());
		stmt.setInt(2, bidId);
		stmt.executeUpdate();
		
		// Redirect the user to the item page with a success message
		response.sendRedirect(request.getContextPath() + "/Item.jsp?itemId=" + itemId + "&success=true");
	} catch(SQLException e) {
		e.printStackTrace();
		// Redirect the user to the item page with an error message
		response.sendRedirect(request.getContextPath() + "/Item.jsp?itemId=" + itemId + "&error=true");
	} finally {
		con.close();
		stmt.close();
	}
%>
 --%>