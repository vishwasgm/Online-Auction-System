<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Buy Me Application | FAQ</title>
        <link href="assets/css/global.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
        <%
        UserBean user = (UserBean) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
        } else { 
            String searchKeyword = request.getParameter("searchKeyword");

            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                ApplicationDB database = new ApplicationDB();
                con = database.getConnection();

                String sql = "SELECT * FROM faq";
                if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    sql += " WHERE question LIKE ? OR answer LIKE ?";
                }
                sql += " ORDER BY display_order";

                pstmt = con.prepareStatement(sql);
                if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    pstmt.setString(1, "%" + searchKeyword + "%");
                    pstmt.setString(2, "%" + searchKeyword + "%");
                }
                rs = pstmt.executeQuery();
        %>
        <jsp:include page="Navbar.jsp">
            <jsp:param name="username" value="${user.name}" />
            <jsp:param name="landingPage" value="UserHome" />
        </jsp:include>

        <div class="container mt-5">
            <h2 class="mb-3">Frequently Asked Questions</h2>

            <form class="d-flex mb-5 mx-auto" method="GET" action="FAQ.jsp">
                <input class="form-control me-2" type="search" name="searchKeyword" placeholder="Search for FAQs" value="<%= searchKeyword == null ? "" : searchKeyword %>">
                <button class="btn btn-outline-primary" type="submit">Search</button>
            </form>

            <% if (rs.next()) { %>
                <div class="accordion" id="faqAccordion">
                    <% int count = 1; do { %>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="heading<%= count %>">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%= count %>" aria-expanded="false" aria-controls="collapse<%= count %>">
                                    <%= rs.getString("question") %>
                                </button>
                            </h2>
                            <div id="collapse<%= count %>" class="collapse" aria-labelledby="heading<%= count %>" data-bs-parent="#faqAccordion">
								<div class="accordion-body">
									<%= rs.getString("answer") %>
								</div>
							</div>
						</div>
						<% count++; } while (rs.next()); %>
				</div>
			<% } else { %>
				<p>No FAQs found.</p>
			<% } %>
		</div>
		    <jsp:include page="Footer.jsp" />
    <%
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                con.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
    }
    %>
    
</body>
		
