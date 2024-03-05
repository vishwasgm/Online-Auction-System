<%@ page import="java.sql.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    Connection con = null;
    try {
        ApplicationDB database = new ApplicationDB();
        con = database.getConnection();

        if (request.getParameter("submit_question") != null) {
            String question = request.getParameter("question");
            PreparedStatement stmt = con.prepareStatement("INSERT INTO UserQuestion (userId, question) VALUES (?, ?)");
            stmt.setInt(1, userId);
            stmt.setString(2, question);
            stmt.executeUpdate();
            stmt.close();
        }
%>
<div class="container mt-5">
    <h3>Ask a question</h3>
    <form method="post">
        <div class="form-group">
            <label for="question" class="mb-3">Your question:</label>
            <textarea class="form-control mb-3" id="question" name="question" rows="3" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary" name="submit_question">Submit</button>
    </form>

    <h3 class="mt-5">Your questions and answers</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Question</th>
                <th>Answer</th>
            </tr>
        </thead>
        <tbody>
            <%
                PreparedStatement stmt = con.prepareStatement("SELECT * FROM UserQuestion WHERE userId = ?");
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("question") %></td>
		        <td><%= rs.getString("answer") == null ? "Not answered yet" : rs.getString("answer") %></td>
		        <td>
		            <form action="DeleteQuestionServlet" method="post">
		                <input type="hidden" name="question_id" value="<%= rs.getInt("id") %>">
		                <input type="submit" value="Delete" class="btn btn-danger">
		            </form>
		        </td>
            </tr>
            <%
                }
                rs.close();
                stmt.close();
            %>
        </tbody>
    </table>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
