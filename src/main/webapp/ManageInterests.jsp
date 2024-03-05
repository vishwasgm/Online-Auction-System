<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>


   <%
   		Set<String> userInterests = new HashSet<>();
	    if (request.getMethod().equals("POST")) {
	        String[] interests = request.getParameterValues("interests");
	        int userId = Integer.parseInt(request.getParameter("userId"));
	
	        try {
	            ApplicationDB database = new ApplicationDB();
	            Connection conn = database.getConnection();
	
	            // Delete existing interests for the user
	            String deleteQuery = "DELETE FROM UserInterests WHERE userId = ?";
	            PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
	            deleteStmt.setInt(1, userId);
	            deleteStmt.executeUpdate();
	
	            // Insert new interests
	            String insertQuery = "INSERT INTO UserInterests (userId, interest) VALUES (?, ?)";
	            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
	
	            for (String interest : interests) {
	                insertStmt.setInt(1, userId);
	                insertStmt.setString(2, interest);
	                insertStmt.addBatch();
	            }
	            insertStmt.executeBatch();
	
	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
	    // Load user interests
	    int userId = Integer.parseInt(request.getParameter("userId"));
	    PreparedStatement interestsStmt = null;
	    ResultSet interestsRs = null;
	    try {
	        ApplicationDB database = new ApplicationDB();
	        Connection con = database.getConnection();
	        String interestsQuery = "SELECT interest FROM UserInterests WHERE userId = ?";
	        interestsStmt = con.prepareStatement(interestsQuery);
	        interestsStmt.setInt(1, userId);
	        interestsRs = interestsStmt.executeQuery();
	        while (interestsRs.next()) {
	            userInterests.add(interestsRs.getString("interest"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (interestsRs != null) {
	            interestsRs.close();
	        }
	        if (interestsStmt != null) {
	            interestsStmt.close();
	        }
	    }
   %>
   
   <div class="container mt-5">
        <h3>Manage Interests</h3>
        <form id="interestForm" method="POST" action="Account.jsp">
            <div class="mb-3">
                <label for="interests" class="form-label">Select Interests</label>
                <select multiple class="form-select" id="interests" name="interests">
                    <option value="Laptop" <% if (userInterests.contains("Laptop")) { %>selected<% } %>>Laptop</option>
                    <option value="Smartphone" <% if (userInterests.contains("Smartphone")) { %>selected<% } %>>Smartphone</option>
                    <option value="Tablet" <% if (userInterests.contains("Tablet")) { %>selected<% } %>>Tablet</option>
                    <option value="M1 Macbook Air" <% if (userInterests.contains("M1 Macbook Air")) { %>selected<% } %>>M1 Macbook Air</option>
                    <option value="M1 Macbook Pro" <% if (userInterests.contains("M1 Macbook Pro")) { %>selected<% } %>>M1 Macbook Pro</option>
                    <option value="Acer" <% if (userInterests.contains("Acer")) { %>selected<% } %>>Acer</option>
                    <option value="Lenovo" <% if (userInterests.contains("Lenovo")) { %>selected<% } %>>Lenovo</option>
                    <option value="iPad" <% if (userInterests.contains("iPad")) { %>selected<% } %>>iPad</option>
                    <option value="Samsung" <% if (userInterests.contains("Samsung")) { %>selected<% } %>>Samsung</option>
                    <option value="4GB Graphics Nvidia" <% if (userInterests.contains("4GB Graphics Nvidia")) { %>selected<% } %>>4GB Graphics Nvidia</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Save Interests</button>
        </form>
    </div>