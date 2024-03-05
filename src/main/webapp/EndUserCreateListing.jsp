<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>
<%@ page import= "java.time.Instant"   %>
<%@ page import= "java.text.SimpleDateFormat, java.util.Date" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy Me Application</title>
	</head>
	<body>
		<%
			int userId = Integer.parseInt(request.getParameter("userId"));
			String userID = Integer.toString(userId);
			PreparedStatement preparedStatement = null;
			
			
			try {
				ApplicationDB database = new ApplicationDB();
				Connection conn = database.getConnection();
				
				String message = "";
				
				String itemName = request.getParameter("item_name");
				String itemDescription = request.getParameter("item_description");
				String itemSubcategory = request.getParameter("subcategory");
				double itemInitialPrice = Double.parseDouble(request.getParameter("item_initial_price"));
				String itemClosingTime = request.getParameter("item_closing_time");
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				Date parsedDate = dateFormat.parse(itemClosingTime);
				//finally creating a timestamp
				Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
				double itemBidIncrement = Double.parseDouble(request.getParameter("item_bid_increment"));
				double itemMinimumPrice = Double.parseDouble(request.getParameter("item_min_price"));
				
				String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());
				
				Random random = new Random();
				String random_three_digit_number = String.format("%03d", random.nextInt(1000));
				
				long ts = System.currentTimeMillis() / 1000L;
				
				String prefix = "";		//substring containing first 4 characters

				if (itemName.length() > 4)
				{
					prefix = itemName.substring(0, 4);
				} else {
					prefix = itemName;
				}
				
				String itemId = prefix + "-" + itemSubcategory + String.valueOf(ts) + userID + random_three_digit_number;
				
				String query = "Insert into Item (userId, itemId, name, description, subcategory, initialprice, closingtime, bidincrement, minprice) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				preparedStatement = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				preparedStatement.setString(1, userID);
				preparedStatement.setString(2, itemId.toUpperCase());
				preparedStatement.setString(3, itemName);
				preparedStatement.setString(4, itemDescription);
				preparedStatement.setString(5, itemSubcategory);
				preparedStatement.setDouble(6, itemInitialPrice);
				preparedStatement.setTimestamp(7, timestamp);
				preparedStatement.setDouble(8, itemBidIncrement);
				preparedStatement.setDouble(9, itemMinimumPrice);
				int rowsAffected  = preparedStatement.executeUpdate();
				
				
				preparedStatement.close();
				
				
				conn.close();
				
				if (rowsAffected > 0) {
					message = "Item has been posted for auction.";
                	response.sendRedirect("CreateListing.jsp?" + "&status=true");
                } else {
                	message = "Error processing your request. Please try again!";
                	response.sendRedirect("CreateListing.jsp?" + "&status=false"  );
                }
			
				
			} catch(Exception e) {
				System.out.println("Here {}"+ e);
				String message = "Error processing your request. Please try again!";
            	response.sendRedirect("CreateListing.jsp?" + "&status=false"  );
				
			} finally {
				if (preparedStatement  != null) {
	                try {
	                	preparedStatement.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
			}
		%>
	</body>
</html>