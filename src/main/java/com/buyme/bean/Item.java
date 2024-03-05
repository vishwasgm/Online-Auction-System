package com.buyme.bean;
import java.sql.Timestamp;

public class Item {
	
	 private int userId;
	    private String itemId;
	    private String name;
	    private String description;
	    private String subcategory;
	    private double initialPrice;
	    private Timestamp closingTime;
	    private double bidIncrement;
	    private double minPrice;
	    private String sellerName;
	    private double highestBid;
	    private double userBid;

	    public String getSellerName() {
			return sellerName;
		}

		public void setSellerName(String sellerName) {
			this.sellerName = sellerName;
		}

		public double getHighestBid() {
			return highestBid;
		}

		public void setHighestBid(Double highestBid) {
			this.highestBid = highestBid;
		}

		public double getUserBid() {
			return userBid;
		}

		public void setUserBid(double userBid) {
			this.userBid = userBid;
		}
		
		public Item() {
			
		}

		public Item(int userId, String itemId, String name, String description, String subcategory, double initialPrice, Timestamp closingTime, double bidIncrement, double minPrice) {
	        this.userId = userId;
	        this.itemId = itemId;
	        this.name = name;
	        this.description = description;
	        this.subcategory = subcategory;
	        this.initialPrice = initialPrice;
	        this.closingTime = closingTime;
	        this.bidIncrement = bidIncrement;
	        this.minPrice = minPrice;
	    }

	    public int getUserId() {
	        return userId;
	    }

	    public void setUserId(int userId) {
	        this.userId = userId;
	    }

	    public String getItemId() {
	        return itemId;
	    }

	    public void setItemId(String itemId) {
	        this.itemId = itemId;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getDescription() {
	        return description;
	    }

	    public void setDescription(String description) {
	        this.description = description;
	    }

	    public String getSubcategory() {
	        return subcategory;
	    }

	    public void setSubcategory(String subcategory) {
	        this.subcategory = subcategory;
	    }

	    public double getInitialPrice() {
	        return initialPrice;
	    }

	    public void setInitialPrice(double initialPrice) {
	        this.initialPrice = initialPrice;
	    }

	    public Timestamp getClosingTime() {
	        return closingTime;
	    }

	    public void setClosingTime(Timestamp closingTime) {
	        this.closingTime = closingTime;
	    }

	    public double getBidIncrement() {
	        return bidIncrement;
	    }

	    public void setBidIncrement(double bidIncrement) {
	        this.bidIncrement = bidIncrement;
	    }

	    public double getMinPrice() {
	        return minPrice;
	    }

	    public void setMinPrice(double minPrice) {
	        this.minPrice = minPrice;
	    }

}
