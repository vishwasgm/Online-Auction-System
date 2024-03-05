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

@WebServlet("/RemoveBidServlet")
public class RemoveBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RemoveBidServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int userId = Integer.parseInt(request.getParameter("userId"));
    	int bid_id = Integer.parseInt(request.getParameter("bid_id"));
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();
            String removeQuery = "DELETE FROM Bid WHERE bid_id = ?";
            pstmt = con.prepareStatement(removeQuery);

            pstmt.setInt(1, bid_id);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&bid_update=true");
            } else {
                response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&bid_update=false");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&bid_update=false");
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
