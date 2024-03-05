package com.buyme.servlets;

import com.buyme.db.ApplicationDB;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/DeleteEndUserServlet")
public class DeleteEndUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean isEmployee = Boolean.parseBoolean(request.getParameter("isEmployee"));

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();

            // Deleting the user
            String deleteUserQuery = "DELETE FROM User WHERE userId = ?";
            stmt = con.prepareStatement(deleteUserQuery);
            stmt.setInt(1, userId);
            stmt.executeUpdate();

         // After the deletion is executed
            if (!isEmployee) {
            	HttpSession session = request.getSession();
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/Login.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/CustomerRepHome.jsp?status=deleted");
            }


        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp");
        } finally {
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
        }
    }
}

