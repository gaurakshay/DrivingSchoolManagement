<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cs5513.hw.ConnectionManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<!-- Image for tab and title of page. -->
		<link rel="icon" href="../resources/favicon.jpg">
		<title>Web Database Application</title>
		
		<!-- Import (in that order):
				1. Material icons
				2. StyleSheet for Material design
				3. JavaScript for that effects and responses.
				4. Roboto font.
		-->
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">
		<link href="https://code.getmdl.io/1.1.3/material.red-indigo.min.css" rel="stylesheet" type="text/css">
		<script defer src="https://code.getmdl.io/1.1.2/material.min.js"></script>
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
		
		<!-- Customized CSS properties. -->
		<link href="../resources/main.css" rel="stylesheet" type="text/css">

	</head>
	<body>
		<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-color--grey-100">
			<header class="mdl-layout__header mdl-color--red-900">
				<div class="mdl-layout__header-row">
					<a class="mdl-navigation__link" style="opacity:100;" href="../index.jsp">
					<div class="mdl-layout-title" style="width:400px"><img alt="Sooners!"
						src="../resources/ou-logo-white.svg" height="8%" width="8%"> CS 5513 HOMEWORK #2 </div>
					</a>
					<div class="mdl-layout-spacer"></div>
					<% 
					//session.setAttribute("session.userid", null);
					String userId = (String) request.getSession(true).getAttribute("session.userid");
					if (!(userId == "" || userId == null)) {
					%>
						<div class="mdl-typography--title mdl-color-text--grey-200">
									<%= userId.toUpperCase() %> &nbsp;&nbsp;&nbsp;&nbsp; 
						</div>
					<%
					} else {
					%>
						<a href="#" class="mdl-navigation__link" onclick="return false">
							<span class="mdl-color-text--white mdl-typography--title" >
								Login
							</span>
						</a>
					<%
					}
					%>
					<button id="menu-speed" class="mdl-button mdl-js-button mdl-button--icon">
  						<i class="material-icons">menu</i>
					</button>
					<ul class="mdl-menu mdl-js-menu mdl-js-ripple-effect mdl-menu--bottom-right" for="menu-speed">
						<li class="mdl-menu__item">
							<a href="../index.jsp" class="mdl-layout__tab" style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" 
									style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Home
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/insertVehicle.jsp" class="mdl-layout__tab" style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Insert Vehicle
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/insertInstructor.jsp" class="mdl-layout__tab" style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Insert Instructor
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/insertStudent.jsp" class="mdl-layout__tab" style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Insert Student
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/studentByCity.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Find Student (By City)
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/studentByDrvInst.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Find Student (By Driving Instructor)
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/studentByDate.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Find Student (By Session Date)
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/carByEquipOpt.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Find Car
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/driverByTruckWeight.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Find Driver
								</span>
							</a>
						</li>
						<li class="mdl-menu__item">
							<a href="../pages/deleteCars.jsp" class="mdl-layout__tab " style="display:table; width:90%;">
								<span class="mdl-color-text--grey-700 mdl-typography--body-2" style="display:table-cell;vertical-align:middle;width=100%; text-align:left;">
									Delete Cars
								</span>
							</a>
						</li>
					</ul>
				</div>
			</header>
			<main class="mdl-layout__content">
				<div class="mdl-grid" align="center">
					<div class="mdl-cell mdl-cell--12-col" style="margin:3em">
					<% 
					if (!(userId == "" || userId == null)) {
					%>
						<div class="mdl-typography--subheading mdl-color-text--grey-600">
							You are successfully logged in with userId:
						</div>
						<div class="mdl-typography--headline mdl-color-text--grey-600">
							<%= userId  %> 
						</div>
						<div class="mdl-typography--subheading mdl-color-text--grey-600">
							Redirecting to home page...
						</div>
						<br>
						<br>
						<div style="width: 200px" class="mdl-progress mdl-js-progress mdl-progress--indeterminate mdl-color-text--red-900"></div>

						
						
						<script>
						  setTimeout(function() {
						      document.location = "../index.jsp";
						  }, 1000);
						</script>
						
						
						
					<%
					} else {
					%>
						<!-- <form action="login.jsp" method="post">  -->
						<form method="post">
							<div class="mdl-card mdl-shadow--6dp">
								<div class="mdl-card__title mdl-color-text--grey-100 mdl-color--red-900">
									<h2 class="mdl-card__title-text mdl-typography--title">Oracle Sign-In</h2>
								</div>
								<div class="mdl-card__supporting-text">
	
										<!-- Text fields for UserId and Password. -->
										<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
											<input class = "mdl-textfield__input" type="text" id="userid" name="userid"/>
											<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "userid">UserID</label>
										</div>
										<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
											<input class = "mdl-textfield__input" type="password" id="pwd" name="pwd"/>
											<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "pwd">Password</label>
										</div>
	
								<!-- Supporting text ends here. -->
								</div>
								
								<!-- Action area -->
								<div class="mdl-card__actions mdl-card--border" align="left">
									<button type="submit" value="Submit" 
											class="mdl-button mdl-color-text--red-900 mdl-js-button
													mdl-js-ripple-effect" name="loginClicked">
									Login
									</button>
								</div>
							</div>
						</form>
						
					<%	
					
					//Continuing from the else in the jsp code above.
						if( !(request.getParameter("loginClicked") == null) ) {
							String uid = request.getParameter("userid");
							String pwd = request.getParameter("pwd");
							if(!((uid == null)||(uid == "")||(pwd == "")||(pwd == null))) {
								ConnectionManager connMgr = new ConnectionManager();
								Connection conn = connMgr.getOracleConnection(uid, pwd);
								if(conn == null){
							%>
									<br/><br/><br/>
									<div class="mdl-typography--title mdl-color-text--grey-600">
										Login unsuccessful. Please enter the details again.
									</div>
							<%
								}
								else {
									session.setAttribute("session.userid", uid);
									session.setAttribute("session.pwd", pwd);
									try {
										if (conn != null) {
											conn.close();
										}
									} catch (SQLException e) { e.printStackTrace(); }
									%>
									
									<script>
									  setTimeout(function() {
									      document.location = "./login.jsp";
									  }, 0); // <-- this is the delay in milliseconds
									</script>
									
									<%
								}
							} else {
							%>
								<br/><br/><br/>
								<div class="mdl-typography--title mdl-color-text--grey-600">
									Please double check your entries!
								</div>
							<%
							}
						}
					}

					
					
					
					
					
					
					
					
					
					
					

					%>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
					</div>
				</div>
			
			</main>
		</div>
	</body>
</html>