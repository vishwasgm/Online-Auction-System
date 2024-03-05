package com.buyme.servlets;

import com.buyme.db.ApplicationDB;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("question_id"));

        Connection con = null;
        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();

            PreparedStatement stmt = con.prepareStatement("DELETE FROM UserQuestion WHERE id = ?");
            stmt.setInt(1, questionId);
            stmt.executeUpdate();

            stmt.close();

            response.sendRedirect("Account.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
