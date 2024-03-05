<%@ page import="java.sql.*" %><%@ page import="com.buyme.db.ApplicationDB" %><%
    int userId = Integer.parseInt(request.getParameter("userId"));
    Connection con = null;
    try {
        ApplicationDB database = new ApplicationDB();
        con = database.getConnection();
%> <div class="container mt-5">
  <h3>User questions</h3>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>Question</th>
        <th>Answer</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
    <%
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM UserQuestion WHERE userId = ?");
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
	%> <tr>
        <td><%= rs.getString("question") %> </td>
        <td><%= rs.getString("answer") == null ? "Not answered yet" : rs.getString("answer") %> </td>
        <td>
          <form action="AnswerQuestionServlet" method="post">
            <input type="hidden" name="question_id" value="<%= rs.getInt("id") %>">
            <input type="hidden" name="userId" value="<%= userId %>">
            <textarea class="form-control" name="answer" rows="2" required></textarea>
            <button type="submit" class="btn btn-primary mt-2">Submit answer</button>
          </form>
        </td>
      </tr><%
}
rs.close();
stmt.close();
%> </tbody>
  </table>
</div><%
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