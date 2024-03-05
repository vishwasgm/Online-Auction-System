package com.buyme.utils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;


public final class BuyMeUtils {
	
	
	public static String encryptPassword(String password)  {
		
	    String encryptedPassword = null;

	    try {
	      MessageDigest md = MessageDigest.getInstance("MD5");

	      md.update(password.getBytes());

	      byte[] bytes = md.digest();

	      StringBuilder sb = new StringBuilder();
	      for (int i = 0; i < bytes.length; i++) {
	        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	      }

	      encryptedPassword = sb.toString();
	    } catch (NoSuchAlgorithmException e) {
	      e.printStackTrace();
	    }
	    return encryptedPassword;
	  }
	
//	public static void closeExpiredBids(Connection con) {
//	    PreparedStatement stmt = null;
//	    try {
//	        // Update the bids' status for items with closing times that have passed
//	        String updateBidsStatusQuery = "UPDATE Bid b JOIN Item i ON b.itemId = i.itemId SET b.status = 'closed' WHERE i.closingtime < NOW() AND b.status = 'active'";
//	        stmt = con.prepareStatement(updateBidsStatusQuery);
//	        stmt.executeUpdate();
//	    } catch (SQLException e) {
//	        e.printStackTrace();
//	    } finally {
//	        if (stmt != null) {
//	            try {
//	                stmt.close();
//	            } catch (SQLException e) {
//	                e.printStackTrace();
//	            }
//	        }
//	    }
//	}
	
	public static void closeExpiredBids(Connection con) {
//	    PreparedStatement stmt = null;
	    PreparedStatement stmt1 = null;
	    PreparedStatement stmt2 = null;
	    PreparedStatement stmt3 = null;
	    try {
	        // Update the bids' status for items with closing times that have passed
	        String updateBidsStatusQuery = "UPDATE Bid b JOIN Item i ON b.itemId = i.itemId SET b.status = 'closed' WHERE i.closingtime < NOW() AND b.status = 'active'";
	        stmt1 = con.prepareStatement(updateBidsStatusQuery);
	        stmt1.executeUpdate();

	        // Update the winning_bid column for the winning bids
	        //String updateWinningBidsQuery = "UPDATE Bid b1 JOIN (SELECT b.itemId, b.userId, b.time, RANK() OVER (PARTITION BY b.itemId ORDER BY b.price DESC, b.time ASC) as bid_rank FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE i.closingtime < NOW() AND b.status = 'closed') AS ranked_bids ON b1.itemId = ranked_bids.itemId AND b1.userId = ranked_bids.userId AND b1.time = ranked_bids.time SET b1.winning_bid = 1 WHERE ranked_bids.bid_rank = 1";
	        String updateWinningBidsQuery = "UPDATE Bid b1 JOIN (SELECT b.itemId, b.userId, b.time, RANK() OVER (PARTITION BY b.itemId ORDER BY b.price DESC, b.time ASC) as bid_rank FROM Bid b JOIN Item i ON b.itemId = i.itemId WHERE i.closingtime < NOW() AND b.status = 'closed' AND b.price >= i.minprice) AS ranked_bids ON b1.itemId = ranked_bids.itemId AND b1.userId = ranked_bids.userId AND b1.time = ranked_bids.time SET b1.winning_bid = 1 WHERE ranked_bids.bid_rank = 1";
	        stmt2 = con.prepareStatement(updateWinningBidsQuery);
	        stmt2.executeUpdate();
	        
	        // Insert a new record in the Sale table for the sold items
	        String insertSaleRecordQuery = "INSERT INTO Sale (seller_id, buyer_id, item_id, list_price, sale_price) SELECT i.userId, b.userId, i.itemId, i.initialprice, b.price FROM Item i JOIN Bid b ON i.itemId = b.itemId WHERE b.winning_bid = 1 AND NOT EXISTS (SELECT 1 FROM Sale s WHERE s.item_id = i.itemId)";
	        stmt3 = con.prepareStatement(insertSaleRecordQuery);
	        stmt3.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	    	if (stmt1 != null) {
	            try {
	                stmt1.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (stmt2 != null) {
	            try {
	                stmt2.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (stmt3 != null) {
	            try {
	                stmt3.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}

	
	public static void triggerAutoBids(Connection con, String itemId, double highestActiveBid) {
	    boolean autoBidsPlaced = true;
	    Set<Integer> triggeredUsers = new HashSet<>();

	    while (autoBidsPlaced) {
	        autoBidsPlaced = false;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;

	        try {
	            String findAutoBidsQuery = "SELECT a.userId, a.auto_bid_increment, a.upper_limit FROM AutoBid a JOIN Bid b ON a.userId = b.userId AND a.itemId = b.itemId WHERE a.itemId = ? AND b.status = 'active' AND a.upper_limit > ?";
	            if (!triggeredUsers.isEmpty()) {
	                findAutoBidsQuery += " AND a.userId NOT IN " + usersIn(triggeredUsers);
	            }
	            stmt = con.prepareStatement(findAutoBidsQuery);
	            stmt.setString(1, itemId);
	            stmt.setDouble(2, highestActiveBid);
	            rs = stmt.executeQuery();

	            System.out.println(stmt.toString());
	            while (rs.next() && !rs.wasNull()) {
	            	
	                int userId = rs.getInt("userId");
	                System.out.println("here: "+ userId);
	                double autoBidIncrement = rs.getDouble("auto_bid_increment");
	                double upperLimit = rs.getDouble("upper_limit");
	                System.out.println("upperLimit: "+ upperLimit);	
	                double newBidPrice = highestActiveBid + autoBidIncrement;
	                
	                System.out.println("newBidPrice: "+ newBidPrice);
	                
	                if (newBidPrice <= upperLimit) {
	                    String closePreviousBidQuery = "UPDATE Bid SET status = 'closed' WHERE userId = ? AND itemId = ? AND status = 'active'";
	                    stmt = con.prepareStatement(closePreviousBidQuery);
	                    stmt.setInt(1, userId);
	                    stmt.setString(2, itemId);
	                    stmt.executeUpdate();

	                    String insertBidQuery = "INSERT INTO Bid (userId, itemId, price, time, status) VALUES (?, ?, ?, NOW(), 'active')";
	                    stmt = con.prepareStatement(insertBidQuery);
	                    stmt.setInt(1, userId);
	                    stmt.setString(2, itemId);
	                    stmt.setDouble(3, newBidPrice);
	                    stmt.executeUpdate();

	                    highestActiveBid = newBidPrice;
	                    autoBidsPlaced = true;
	                    triggeredUsers.add(userId);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (rs != null) {
	                try {
	                    rs.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	            if (stmt != null) {
	                try {
	                    stmt.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }
	}

	private static String usersIn(Set<Integer> users) {
	    if (users.isEmpty()) {
	        return "(NULL)";
	    }
	    return "(" + users.stream().map(String::valueOf).collect(Collectors.joining(",")) + ")";
	}



}
