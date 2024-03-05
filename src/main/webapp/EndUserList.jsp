<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.constants.BuyMeConstants" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>

<h3>End Users</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Location</th>
                    <th>Rating</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        ApplicationDB database = new ApplicationDB();
                        con = database.getConnection();
                        String query = "SELECT e.userId, u.name, u.username, u.email, u.location, e.rating FROM EndUser e INNER JOIN User u ON e.userId = u.userId";
                        stmt = con.prepareStatement(query);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("userId") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("location") %></td>
                        <td><%= rs.getFloat("rating") %></td>
                        <td>
                            <a href="EditEndUser.jsp?userId=<%= rs.getInt("userId") %>" class="btn btn-primary">Edit</a>
                        </td>
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