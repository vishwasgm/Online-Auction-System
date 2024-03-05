package com.buyme.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.buyme.bean.Item;
import com.buyme.db.ApplicationDB;

@WebServlet("/SimilarItemsServlet")
public class SimilarItemsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("itemId");
        List<Item> similarItems = getSimilarItems(itemId);
        request.setAttribute("similarItems", similarItems);
        request.getRequestDispatcher("Item.jsp").forward(request, response);
    }

    private List<Item> getSimilarItems(String itemId) {
        List<Item> similarItems = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
        	ApplicationDB database = new ApplicationDB();
            connection = database.getConnection();
            String sql = "SELECT I1.* FROM Item I1, Item I2 WHERE I1.itemId != I2.itemId AND I1.itemId = ? AND " +
                         "I1.subcategory = I2.subcategory AND " +
                         "(I1.name LIKE CONCAT('%', I2.name, '%') OR I1.description LIKE CONCAT('%', I2.description, '%')) AND " +
                         "I1.closingtime BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()";

            statement = connection.prepareStatement(sql);
            statement.setString(1, itemId);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	Item item = new Item();
                item.setItemId(resultSet.getString("itemId"));
                item.setName(resultSet.getString("name"));
                item.setDescription(resultSet.getString("description"));
                item.setSubcategory(resultSet.getString("subcategory"));
                item.setInitialPrice(resultSet.getDouble("initialprice"));
                item.setClosingTime(resultSet.getTimestamp("closingtime"));
                item.setBidIncrement(resultSet.getDouble("bidincrement"));
                item.setMinPrice(resultSet.getDouble("minprice"));
                similarItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	if (statement != null) {
	            try {
	            	statement.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (connection != null) {
	            try {
	            	connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
        }
        return similarItems;
    }
}

