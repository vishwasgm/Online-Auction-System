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

@WebServlet("/UpdateSellerRatingServlet")
public class UpdateSellerRatingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String userIdStr = request.getParameter("userId");
        String ratingStr = request.getParameter("rating");
        
        if (userIdStr == null || userIdStr.isEmpty() || ratingStr == null || ratingStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        float rating = Float.parseFloat(request.getParameter("rating"));
        
       


        Connection con = null;
        PreparedStatement stmt = null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();
            String query = "UPDATE EndUser SET rating = ((rating * num_ratings) + ?) / (num_ratings + 1), num_ratings = num_ratings + 1 WHERE userId = ?";
            stmt = con.prepareStatement(query);
            stmt.setFloat(1, rating);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
