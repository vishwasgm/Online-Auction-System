package com.buyme.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.buyme.db.ApplicationDB;
import com.buyme.utils.BuyMeUtils;

@WebServlet("/UpdateEndUserServlet")
public class UpdateEndUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateEndUserServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String passwordString = request.getParameter("password");
        String password = BuyMeUtils.encryptPassword(passwordString);
        String location = request.getParameter("location");
//        float rating = Float.parseFloat(request.getParameter("rating"));
        float rating = 0f;

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();
            String updateQuery = "UPDATE User SET name = ?, username = ?, email = ?, password = ?, location = ? WHERE userId = ?";
            pstmt = con.prepareStatement(updateQuery);

            pstmt.setString(1, name);
            pstmt.setString(2, username);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, location);
            pstmt.setInt(6, userId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                pstmt.close();

                String updateEndUserQuery = "UPDATE EndUser SET rating = ? WHERE userId = ?";
                pstmt = con.prepareStatement(updateEndUserQuery);

                pstmt.setFloat(1, rating);
                pstmt.setInt(2, userId);

                pstmt.executeUpdate();

                response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&status=true");
            } else {
                response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&status=false");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&status=false");
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
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
