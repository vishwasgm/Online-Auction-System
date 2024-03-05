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

@WebServlet("/EditBidServlet")
public class EditBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditBidServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bidId = Integer.parseInt(request.getParameter("bid_id"));
        double newPrice = Double.parseDouble(request.getParameter("new_price"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();
            String updateQuery = "UPDATE Bid SET price = ? WHERE bid_id = ?";
            pstmt = con.prepareStatement(updateQuery);

            pstmt.setDouble(1, newPrice);
            pstmt.setInt(2, bidId);

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
