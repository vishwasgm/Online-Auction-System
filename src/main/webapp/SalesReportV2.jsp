<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Sales Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>

 			<%
            UserBean user = (UserBean)session.getAttribute("user");
            
            if(user == null ) {
            	response.sendRedirect(request.getContextPath() + "/Login.jsp");
            } else {  
            boolean isEmployee = true;
            }
            %>
		<jsp:include page="Navbar.jsp">
			<jsp:param name="username" value="${user.name}" />
			<jsp:param name="isEmployee" value="true" />
			<jsp:param name="landingPage" value="AdminHome" />
		</jsp:include>
    <div class="container  mt-4">
        <h3 class="text-center">Sales Report</h3>
        <h3 class="mt-4">Total Earnings</h3>
        <table class="table table-striped">
            
            <tbody>
                <%
                    Connection con = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        ApplicationDB database = new ApplicationDB();
                        con = database.getConnection();
                        String query = "SELECT SUM(sale_price) as total_earnings FROM Sale";
                        stmt = con.prepareStatement(query);
                        rs = stmt.executeQuery();
                        if (rs.next()) {
                %>
                    <tr>
                        <td>$<%= rs.getDouble("total_earnings") %></td>
                    </tr>
                <%
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
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </tbody>
        </table>

        <h3 class="mt-4">Earnings per Item, Item Type, End User</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Item ID</th>
                    <th>Item Type</th>
                    <th>Buyer Name</th>
                    <th>List Price</th>
                    <th>Sale Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                    	ApplicationDB database = new ApplicationDB();
                        con = database.getConnection();
                        String query = "SELECT s.item_id, i.subcategory, i.name as itemname, s.buyer_id, s.sale_price, s.list_price, u.name as username FROM Sale s, Item i, User u WHERE s.item_id = i.itemId AND s.buyer_id = u.userId";
                        stmt = con.prepareStatement(query);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("itemname") %></td>
                        <td><%= rs.getString("subcategory") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td>$<%= rs.getDouble("list_price") %></td>
                        <td>$<%= rs.getDouble("sale_price") %></td>
                    </tr>
                <%
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
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </tbody>
        </table>

        <h3 class="mt-4">Best Selling Categories</h3>
		<table class="table table-striped">
		    <thead>
		        <tr>
		            <th>Category</th>
		            <th>Total Sales</th>
		            <th>Total Earnings</th>
		        </tr>
		    </thead>
		    <tbody>
		        <%
		            try {
		                ApplicationDB database = new ApplicationDB();
		                con = database.getConnection();
		                String query = "SELECT i.subcategory, COUNT(s.item_id) as total_sales, SUM(s.sale_price) as total_earnings FROM Sale s JOIN Item i ON s.item_id = i.itemId GROUP BY i.subcategory ORDER BY total_sales DESC";
		                stmt = con.prepareStatement(query);
		                rs = stmt.executeQuery();
		                while (rs.next()) {
		        %>
		            <tr>
		                <td><%= rs.getString("subcategory") %></td>
		                <td><%= rs.getInt("total_sales") %></td>
		                <td>$<%= rs.getDouble("total_earnings") %></td>
		            </tr>
		        <%
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
		                if (con != null) {
		                    try {
		                        con.close();
		                    } catch (SQLException e) {
		                        e.printStackTrace();
		                    }
		                }
		            }
		        %>
		    </tbody>
		</table>
		
		<h3 class="mt-4">Best Sellers</h3>
		<table class="table table-striped">
		    <thead>
		        <tr>
		            <th>Name</th>
		            <th>Total Sales</th>
		            <th>Total Earnings</th>
		        </tr>
		    </thead>
		    <tbody>
		        <%
		            try {
		                ApplicationDB database = new ApplicationDB();
		                con = database.getConnection();
		                String query = "SELECT u.name, COUNT(s.item_id) as total_sales, SUM(s.sale_price) as total_earnings FROM Sale s JOIN User u ON s.seller_id = u.userId GROUP BY s.seller_id, u.name ORDER BY total_sales DESC";
		                stmt = con.prepareStatement(query);
		                rs = stmt.executeQuery();
		                while (rs.next()) {
		        %>
		            <tr>
		                <td><%= rs.getString("name") %></td>
		                <td><%= rs.getInt("total_sales") %></td>
		                <td>$<%= rs.getDouble("total_earnings") %></td>
		            </tr>
		        <%
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
		                if (con != null) {
		                    try {
		                        con.close();
		                    } catch (SQLException e) {
		                        e.printStackTrace();
		                    }
		                }
		            }
		        %>
		    </tbody>
		</table>
				


       	<h3 class="mt-4">Best Buyers</h3>
		<table class="table table-striped">
		    <thead>
		        <tr>
		            <th>Name</th>
		            <th>Purchase Count</th>
		            <th>Total Purchase Worth</th>
		        </tr>
		    </thead>
		    <tbody>
		        <%
		            try {
		                ApplicationDB database = new ApplicationDB();
		                con = database.getConnection();
		                String query = "SELECT u.name, COUNT(s.item_id) as purchase_count, SUM(s.sale_price) as total_purchase_worth FROM Sale s JOIN User u ON s.buyer_id = u.userId GROUP BY s.buyer_id, u.name ORDER BY purchase_count DESC";
		                stmt = con.prepareStatement(query);
		                rs = stmt.executeQuery();
		                while (rs.next()) {
		        %>
		            <tr>
		                <td><%= rs.getString("name") %></td>
		                <td><%= rs.getInt("purchase_count") %></td>
		                <td>$<%= rs.getDouble("total_purchase_worth") %></td>
		            </tr>
		        <%
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
		                if (con != null) {
		                    try {
		                        con.close();
		                    } catch (SQLException e) {
		                        e.printStackTrace();
		                    }
		                }
		            }
		        %>
		    </tbody>
		</table>
    </div>
</body>
</html>

