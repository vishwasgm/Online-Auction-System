package com.buyme.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.buyme.db.ApplicationDB;

@WebServlet("/RemoveItemServlet")
public class RemoveItemServlet extends HttpServlet  {
	
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int userId = Integer.parseInt(request.getParameter("userId"));
	    String itemId = request.getParameter("itemId");

	    Connection con = null;
	    PreparedStatement itemStmt = null;
	    PreparedStatement bidStmt = null;
	    boolean success = false;

	    try {
	        ApplicationDB database = new ApplicationDB();
	        con = database.getConnection();

	        con.setAutoCommit(false); // Begin transaction

	        // Remove bids for the item
	        String removeBidQuery = "DELETE FROM Bid WHERE itemId = ?";
	        bidStmt = con.prepareStatement(removeBidQuery);
	        bidStmt.setString(1, itemId);
	        bidStmt.executeUpdate();

	        // Remove item
	        String removeItemQuery = "DELETE FROM Item WHERE itemId = ?";
	        itemStmt = con.prepareStatement(removeItemQuery);
	        itemStmt.setString(1, itemId);
	        itemStmt.executeUpdate();

	        con.commit(); // Commit transaction
	        success = true;
	        response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&item_remove=" + success);
	    } catch (SQLException e) {
	        e.printStackTrace();
	        try {
	            con.rollback(); // Rollback transaction in case of an error
	        } catch (SQLException e1) {
	            e1.printStackTrace();
	            response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&item_remove=" + false);
	        }
	        response.sendRedirect("EditEndUser.jsp?userId=" + userId + "&item_remove=" + false);
	    } finally {
	        if (itemStmt != null) {
	            try {
	                itemStmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (bidStmt != null) {
	            try {
	                bidStmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (con != null) {
	            try {
	                con.setAutoCommit(true);
	                con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	   
	}


}
