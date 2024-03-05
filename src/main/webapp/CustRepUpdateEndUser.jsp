<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<div class="container mt-4">
        
        <%
            int userId = Integer.parseInt(request.getParameter("userId"));
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            boolean isEmployee = false;
            if(Boolean.parseBoolean(request.getParameter("isEmployee"))) {
            	isEmployee = true;
            }
            try {
                ApplicationDB database = new ApplicationDB();
                con = database.getConnection();
                String query = "SELECT * FROM User u INNER JOIN EndUser e ON u.userId = e.userId WHERE u.userId = ?";
                stmt = con.prepareStatement(query);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();
                if (rs.next()) {
        %>
        <h3 class="my-5">Update User Details</h3>
        <form action="UpdateEndUserServlet" method="post" class="<%= isEmployee ? "w-50" : "w-auto" %>">
		    <input type="hidden" name="userId" value="<%= userId %>">
		    <div class="row">
		        <div class="col-md-6">
		            <div class="mb-3">
		                <label for="username" class="form-label">Username</label>
		                <input type="text" class="form-control" id="username" name="username" value="<%= rs.getString("username") %>">
		            </div>
		        </div>
		        <div class="col-md-6">
		            <div class="mb-3">
		                <label for="name" class="form-label">Name</label>
		                <input type="text" class="form-control" id="name" name="name" value="<%= rs.getString("name") %>">
		            </div>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-md-6">
		            <div class="mb-3">
		                <label for="email" class="form-label">Email</label>
		                <input type="email" class="form-control" id="email" name="email" value="<%= rs.getString("email") %>">
		            </div>
		        </div>
		        <div class="col-md-6">
		            <div class="mb-3">
		                <label for="password" class="form-label">Reset Password</label>
		                <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
		            </div>
		        </div>
		    </div>
		    <div class="row">
		        <div class="col-md-6">
		            <div class="mb-3">
		                <label for="location" class="form-label">Location</label>
		                <input type="text" class="form-control" id="location" name="location" value="<%= rs.getString("location") %>">
		            </div>
		        </div>
		        <%-- <div class="col-md-6">
		            <div class="mb-3">
		                <label for="rating" class="form-label">Rating</label>
		                <input type="number" step="0.01" class="form-control" id="rating" name="rating" value="<%=  rs.getDouble("rating") %>" required>
		            </div>
		        </div> --%>
		    </div>
		    <div class="d-flex justify-content-center mb-3">
		        <button type="submit" class="btn btn-primary me-5">Update</button>
		        <a type="submit" href="<%= isEmployee ? "CustomerRepHome.jsp" : "UserHome.jsp" %>" class="btn btn-primary">Cancel</a>
		        <button type="button" class="btn btn-danger ms-5" id="deleteUser">Delete User</button>
		        
		        
		    </div>
		    <%
		    if (request.getParameter("status") != null && Boolean.parseBoolean(request.getParameter("status"))) {
		    %>
		    <p class="text-center">User details updated successfully</p>
		    <% } else if (request.getParameter("status") != null && !Boolean.parseBoolean(request.getParameter("status"))){ %>
		    <p class="text-center text-danger">Error updating user details. Please try again later. </p>
		    <% }%>
		</form>

		<% }
                } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (stmt != null) {
                            try {
                                stmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }%>
	</div>
	
	
	<script>
	    document.getElementById("deleteUser").addEventListener("click", function() {
	        if (confirm("Are you sure you want to delete this user?")) {
	            window.location.href = "DeleteEndUserServlet?userId=" + <%=userId%> + "&isEmployee=" + <%=isEmployee%>;
	        }
	    });
	</script>

	