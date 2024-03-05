package com.buyme.constants;

public final class BuyMeConstants {
	
	public static final String ADMIN = "admin";
	
	public static final String CUSTOMER_REP = "custrep";

	public static final String END_USER_LOOKUP = "SELECT * FROM User u, EndUser eu WHERE username = ? and password = ? AND u.userId = eu.userId";
	
	public static final String ADMIN_USER_LOOKUP = "SELECT * FROM User u, Admin adm WHERE username = ? and password = ? AND u.userId = adm.userId";
	
	public static final String CUST_REP_USER_LOOKUP = "SELECT * FROM User u, CustomerRep cr WHERE username = ? and password = ? AND u.userId = cr.userId";
			
}
