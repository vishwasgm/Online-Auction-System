<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.buyme.*" %>
<%@ page import="com.buyme.bean.Item" %>
<%@ page import="com.buyme.db.ApplicationDB" %>
<%@ page import="com.buyme.bean.UserBean" %>
<%@ page import="com.buyme.utils.BuyMeUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Buy Me Application | Item Page</title>
        <link href="assets/css/global.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
        <%
            UserBean user = (UserBean)session.getAttribute("user");
            if(user == null ) {
            	response.sendRedirect(request.getContextPath() + "/Login.jsp");
            } else {
            	// Get the item ID from the query parameter
            	String itemId = request.getParameter("itemId");
            	if(itemId == null || itemId.trim().length() == 0) {
            		response.sendRedirect(request.getContextPath() + "/UserHome.jsp");
            	} else {
            		// Connect to the database
            		Connection con = null;
            		PreparedStatement stmt = null;
            		ResultSet rs = null;
            		Item item = null;
            		
            		try {
            			ApplicationDB database = new ApplicationDB();
            			con = database.getConnection();
            			
            			// Close expired bids
            	        BuyMeUtils.closeExpiredBids(con);
            			
            			// Execute the query to retrieve the item details
            			String sql = "SELECT i.*, u.name AS seller_name, MAX(b.price) AS highest_bid, MAX(CASE WHEN b.userId = ? THEN b.price ELSE NULL END) AS user_bid FROM Item i LEFT JOIN Bid b ON i.itemId = b.itemId AND b.status = 'active' LEFT JOIN User u ON i.userId = u.userId WHERE i.itemId = ? GROUP BY i.itemId";
            
            			stmt = con.prepareStatement(sql);
            			stmt.setInt(1, user.getUserId());
            			stmt.setString(2, itemId);
            			rs = stmt.executeQuery();
            			// Retrieve the item details from the result set
            			
            			if(rs.next()) {
            				item = new Item(
            						rs.getInt("userId"),
            						rs.getString("itemId"),
            						rs.getString("name"),
            						rs.getString("description"),
            						rs.getString("subcategory"),
            						rs.getDouble("initialprice"),
            						rs.getTimestamp("closingtime"),
            						rs.getDouble("bidincrement"),
            						rs.getDouble("minprice")
            				);
            				item.setSellerName(rs.getString("seller_name"));
            				item.setHighestBid(rs.getDouble("highest_bid"));
            				item.setUserBid(rs.getDouble("user_bid"));
            
            			}
            			
            			 // Check if the item's closing time has passed
            		    LocalDateTime now = LocalDateTime.now();
            		    LocalDateTime closingTime = item.getClosingTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            		    boolean biddingClosed = now.isAfter(closingTime);
            			
            			String autoBidSql = "SELECT a.upper_limit FROM AutoBid a JOIN Bid b ON b.userId = a.userId WHERE a.itemId = ? AND b.userId = ? AND b.status = 'active'";
            			PreparedStatement autoBidStmt = con.prepareStatement(autoBidSql);
            			autoBidStmt.setString(1, itemId);
            			autoBidStmt.setInt(2, user.getUserId());
            			ResultSet autoBidRs = autoBidStmt.executeQuery();
            
            			boolean autoBidSet = false;
            			double autoBidUpperLimit = 0.0;
            			if (autoBidRs.next()) {
            				
            				System.out.println("HERE trye: ");
            			    autoBidSet = true;
            			    autoBidUpperLimit = autoBidRs.getDouble("upper_limit");
            			}
            			autoBidStmt.close();
            			%>
        <jsp:include page="Navbar.jsp">
            <jsp:param name="username" value="${user.name}" />
            <jsp:param name="landingPage" value="UserHome" />
        </jsp:include>
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <h2><%= item.getName() %> </h2>
                </div>
                <div class="card-body">
                    <p class="card-text lead"><%= item.getDescription() %> </p>
                    <div class="row">
                        <div class="col-sm-6">
                            <p class="card-text mb-1">
                                <strong>Listing Price: </strong>$<%= item.getInitialPrice() %>
                            </p>
                            <%--  <p class="card-text mb-1">
                                <strong>Closing time: </strong><%= item.getClosingTime() %>
                                </p> --%>
                            <p class="card-text mb-1">
                                <strong>Closing time: </strong><span id="countdown"></span>
                            </p>
                            <p class="card-text mb-1">
                                <strong>Current bid placed by you: </strong>$<%=  item.getUserBid() == 0.0 ? "None" : item.getUserBid() %>
                            </p>
                            <p class="card-text mb-1">
                                <strong>Highest bid placed on the item: </strong>$<%= item.getHighestBid() == 0.0 ? "None" : item.getHighestBid()  %>
                            </p>
                            <p class="card-text mb-1">
                                <strong>Auto bid set: </strong><%= autoBidSet ? "True" : "False" %>
                            </p>
                            <% if (autoBidSet) { %>
                            <p class="card-text mb-1">
                                <strong>Auto bid upper limit value: </strong>$<%= autoBidUpperLimit %>
                            </p>
                            <% } %>
                            <p class="card-text mb-1">
                                <strong>Seller: </strong>
                                <a href="SellerInfo.jsp?userId=<%= item.getUserId() %>">
                               	 <%= item.getSellerName() %> 
                                </a>
                            </p>
                            <p class="card-text mb-1">
                            	<strong>Rate the seller: </strong>
                            	<span id="rating" class="rating">
						            <span class="rating-star" data-value="5">&#9733;</span>
						            <span class="rating-star" data-value="4">&#9733;</span>
						            <span class="rating-star" data-value="3">&#9733;</span>
						            <span class="rating-star" data-value="2">&#9733;</span>
						            <span class="rating-star" data-value="1">&#9733;</span>
						        </span>
                            </p>
					        
                        </div>
                        <div class="col-sm-6">
                            <% if (item.getUserId() != user.getUserId() && !biddingClosed) { %>
                            <form action="PlaceBidWithAutobid.jsp" method="post" class="mb-3">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <div class="mb-3">
                                    <label for="bidPrice" class="form-label">
                                    <strong>Bid Price:</strong>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <%-- <input type="number" name="bidPrice" id="bidPrice" class="form-control" min="<%= item.getUserBid() == 0.0 ? item.getInitialPrice() : item.getUserBid()%>" step="<%= item.getBidIncrement() %>" value="<%= item.getUserBid() == 0.0 ? "" : item.getUserBid() %>" required> --%>
                                        <input type="number" name="bidPrice" id="bidPrice" class="form-control" min="<%= item.getHighestBid() == 0.0 ? item.getInitialPrice() : item.getHighestBid() + item.getBidIncrement() %>" step="<%= item.getBidIncrement() %>" value="<%= item.getHighestBid() == 0.0 ? item.getInitialPrice() : item.getHighestBid() + item.getBidIncrement() %>" required>
                                    </div>
                                    <p class="small text-muted mt-1">*Next minimum bid: $<%= item.getHighestBid() == 0.0 ? item.getInitialPrice() : (item.getHighestBid() + item.getBidIncrement()) %></p>
                                </div>
                                <button type="submit" name="placeBid" class="btn btn-primary">Place Bid</button>
                            </form>
                            <!-- Form to update upper limit -->
                            <form action="UpdateAutoBid.jsp" method="post" class="mt-3">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>" />
                                <input type="hidden" name="bidPrice" value="<%= item.getUserBid() == 0.0 ? 0.0 : item.getUserBid() %>">
                                <div class="mb-3">
                                    <label for="upperLimit" class="form-label">
                                    <strong>Autobid Upper Limit (optional):</strong>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" name="upperLimit" id="upperLimit" class="form-control" min="<%= item.getInitialPrice() %>" value="<%= autoBidSet ? autoBidUpperLimit : "" %>" step="<%= item.getBidIncrement() %>">
                                    </div>
                                </div>
                                <button type="submit" name="updateUpperLimit" class="btn btn-primary">Update Upper Limit</button>
                            </form>
                            <% } else if (biddingClosed) { %>
                            <div class="alert alert-warning" role="alert">
                                This item is closed for bidding.
                            </div>
                            <% } else { %>
                            <div class="alert alert-warning" role="alert">
                                You cannot place a bid on your own item. This helps maintain fair and transparent bidding practices for all users.
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            // Execute the query to retrieve the winning user's information
            String winningUserSql = "SELECT u.username AS user_name FROM Bid b JOIN User u ON b.userId = u.userId WHERE b.itemId = ? AND b.winning_bid = 1";
            PreparedStatement winningUserStmt = con.prepareStatement(winningUserSql);
            winningUserStmt.setString(1, itemId);
            ResultSet winningUserRs = winningUserStmt.executeQuery();
            String winningUserName = null;
            if (winningUserRs.next()) {
              winningUserName = winningUserRs.getString("user_name");
            }
            winningUserStmt.close();
            
            
            	
            %>
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <h2>Winner of the Auction</h2>
                </div>
                <div class="card-body">
                    <% if (winningUserName != null) { %>
                    <p class="card-text lead">
                        The winner of this auction is
                        <% if (winningUserName != null) { %>
                        <span class="winner-username"><%= winningUserName %></span>
                        <% } else { %>
                        No winner for this auction yet.
                        <% } %>
                    </p>
                    <% } else { %>
                    <p class="card-text lead">No winner for this auction yet.</p>
                    <% } %>
                </div>
            </div>
        </div>
        <%
            // Execute the query to retrieve the bid history
            	  String bidHistorySql = "SELECT b.*, u.username AS user_name FROM Bid b JOIN User u ON b.userId = u.userId WHERE b.itemId = ? ORDER BY b.time DESC";
            
            PreparedStatement bidHistoryStmt = con.prepareStatement(bidHistorySql);
            bidHistoryStmt.setString(1, itemId);
            ResultSet bidHistoryRs = bidHistoryStmt.executeQuery();
            
            
            %>
        <div class="container mt-5">
            <div class="accordion" id="bidHistoryAccordion">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingBidHistory">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBidHistory" aria-expanded="true" aria-controls="collapseBidHistory">
                        Bid History
                        </button>
                    </h2>
                    <div id="collapseBidHistory" class="accordion-collapse collapse" aria-labelledby="headingBidHistory" data-bs-parent="#bidHistoryAccordion">
                        <div class="accordion-body">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Bidder</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Time</th>
                                        <th scope="col">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (bidHistoryRs.next()) {
                                          String userName = bidHistoryRs.getString("user_name");
                                          double bidPrice = bidHistoryRs.getDouble("price");
                                          Timestamp bidTime = bidHistoryRs.getTimestamp("time");
                                          String bidStatus = bidHistoryRs.getString("status");
                                          int isWinningBid = bidHistoryRs.getInt("winning_bid");
                                        %>
                                    <tr <%= isWinningBid == 1 ? "class=\"winning-bid\"" : "" %>>
                                        <td><%= userName %></td>
                                        <td><%= bidPrice %></td>
                                        <td><%= bidTime %></td>
                                        <td><%= bidStatus %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <jsp:include page="SimilarItems.jsp" />
        <jsp:include page="Footer.jsp" />
        <%bidHistoryStmt.close();
            } catch(SQLException e) {
            	e.printStackTrace();
            } finally {
            	stmt.close();
            	con.close();
            	
            } %>
            
            <script>
            document.querySelectorAll('.rating-star').forEach((star) => {
                star.addEventListener('click', (e) => {
                    const rating = e.target.dataset.value;
                    const userId = <%= item.getUserId() %>;

                    const params = new URLSearchParams();
                    params.append('userId', userId);
                    params.append('rating', rating);

                    fetch('UpdateSellerRatingServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: params
                    })
                    .then((response) => {
                        if (response.ok) {
                            alert('Thank you for your rating!');
                        } else {
                            alert('An error occurred while submitting your rating. Please try again later.');
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        alert('An error occurred while submitting your rating. Please try again later.');
                    });
                });
            });


			</script>
            
            
        <script>
            // Countdown timer script goes here
            	const countdownElement = document.getElementById('countdown');
            const closingTime = new Date('<%= item.getClosingTime() %>').getTime();
            console.log(closingTime)
            function updateCountdown() {
             const now = new Date().getTime();
             
             const remainingTime = closingTime - now;
            
             if (remainingTime < 0) {
               countdownElement.innerHTML = 'Auction closed';
               clearInterval(countdownInterval);
               return;
             }
            
             const days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
             const hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
             const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
             const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
            
             countdownElement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s";
            }
            
            const countdownInterval = setInterval(updateCountdown, 1000);
            
        </script>
        <% 	}	
            }%>
            
            
            
            
    </body>
</html>