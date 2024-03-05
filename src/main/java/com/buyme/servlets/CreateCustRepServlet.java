package com.buyme.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.buyme.db.ApplicationDB;
import com.buyme.utils.BuyMeUtils;
import com.mysql.jdbc.Statement;


@WebServlet("/CreateCustRepServlet")
public class CreateCustRepServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateCustRepServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String passwordString = request.getParameter("password");
        String password = BuyMeUtils.encryptPassword(passwordString);
        String location = request.getParameter("location");
       // float rating = Float.parseFloat(request.getParameter("rating"));

        Connection con = null;
        PreparedStatement pstmt = null;
        //PreparedStatement ps2 =null;

        try {
            ApplicationDB database = new ApplicationDB();
            con = database.getConnection();
            int userId = -1;
            String updateQuery = "INSERT INTO User SET name = ?, username = ?, email = ?, password = ?, location = ? ";
            pstmt = con.prepareStatement(updateQuery,Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, name);
            pstmt.setString(2, username);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, location);
            //pstmt.setInt(6, userId);
            
            int rowsAffectedByInsertUser = pstmt.executeUpdate();
            if(rowsAffectedByInsertUser >0)
            {
            	ResultSet rs = pstmt.getGeneratedKeys();
    			
    			while (rs.next()) {
    		         userId = Integer.parseInt(rs.getString(1));
    	      	}
    			
    			pstmt.close();
    			
    			String query2 = "INSERT INTO CustomerRep SET userId =? ";
    			
    			pstmt =  con.prepareStatement(query2);
    			pstmt.setInt(1, userId);
    			//ps2.executeUpdate();
    			
//                
               int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
              // ps2.close();
                	response.sendRedirect("AdminHome.jsp?" + "&status=true");
                } else {
                	response.sendRedirect("AdminHome.jsp?" + "&status=false");
                }
            }
            else {
            	response.sendRedirect("AdminHome.jsp?" + "&status=false");
            }
            
            
           

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AdminHome.jsp?" + "&status=false");
           
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
