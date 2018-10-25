<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- Image for tab and title of page. -->
	<link rel="icon" href="./resources/favicon.jpg">
	<title>Web Database Application</title>
	
	<!-- Import (in that order):
			1. Material icons
			2. StyleSheet for Material design
			3. JavaScript for that effects and responses.
			4. ROBOTO font.
	-->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
		rel="stylesheet" type="text/css">
	<link href="https://code.getmdl.io/1.1.3/material.red-indigo.min.css"
		rel="stylesheet" type="text/css">
	<script defer src="https://code.getmdl.io/1.1.2/material.min.js"
		type="text/javascript"></script>
	<link rel="stylesheet"
		href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700"
		type="text/css">

	<!-- Customized CSS properties. -->
	<link href="./resources/main.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div
		class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-color--grey-100">
		<header class="mdl-layout__header mdl-color--red-900">
			<div class="mdl-layout__header-row">
				<!-- Title -->
				<a class="mdl-navigation__link" style="opacity:100;" href="#">
				<div class="mdl-layout-title" style="width:400px"><img alt="Sooners!"
					src="./resources/ou-logo-white.svg" height="8%" width="8%"> CS 5513 HOMEWORK #2 </div>
				</a>
				<div class="mdl-layout-spacer"></div>
	
				<!-- Username if logged in. -->
				<%
					String userId = (String) request.getSession(true).getAttribute("session.userid");
					if (!(userId == "" || userId == null)) {
				%>
				<div class="mdl-typography--title mdl-color-text--white">
					<%=userId.toUpperCase()%>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				
				<!-- Logout functionality. -->
				<form method="post" action="">
					<button type="submit" name="logoutClicked"
						class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
						<i class="material-icons">power_settings_new</i>
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</form>
				<%
					} else {
				%>
				
				<!-- Link to login if not logged in. -->
				<a href="./pages/login.jsp" class="mdl-navigation__link">
					<span class="mdl-color-text--white mdl-typography--title">
						Login</span>
				</a>
				<%
					}
				%>
				
				
				<!-- Links to various pages. -->
				<button id="menu-speed"
					class="mdl-button mdl-js-button mdl-button--icon">
					<i class="material-icons">menu</i>
				</button>
				<ul
					class="mdl-menu mdl-js-menu mdl-js-ripple-effect mdl-menu--bottom-right"
					for="menu-speed">
					<li class="mdl-menu__item"><a href="#" class="mdl-layout__tab"
						style="display: table; width: 90%;" onclick="return false">
							<span class="mdl-color-text--red-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Home
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/insertVehicle.jsp"
						class="mdl-layout__tab" style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Insert Vehicle
							</span>
					</a></li>
					<li class="mdl-menu__item"><a
						href="./pages/insertInstructor.jsp" class="mdl-layout__tab"
						style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Insert Instructor
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/insertStudent.jsp"
						class="mdl-layout__tab" style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Insert Student
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/studentByCity.jsp"
						class="mdl-layout__tab " style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Find Student (By City)
							</span>
					</a></li>
					<li class="mdl-menu__item"><a
						href="./pages/studentByDrvInst.jsp" class="mdl-layout__tab "
						style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Find Student (By Driving Instructor)
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/studentByDate.jsp"
						class="mdl-layout__tab " style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Find Student (By Session Date)
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/carByEquipOpt.jsp"
						class="mdl-layout__tab " style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Find Car
							</span>
					</a></li>
					<li class="mdl-menu__item"><a
						href="./pages/driverByTruckWeight.jsp" class="mdl-layout__tab "
						style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Find Driver
							</span>
					</a></li>
					<li class="mdl-menu__item"><a href="./pages/deleteCars.jsp"
						class="mdl-layout__tab " style="display: table; width: 90%;">
							<span class="mdl-color-text--grey-700 mdl-typography--body-2"
								style="display: table-cell; vertical-align: middle;width=100%; text-align:left">
								Delete Cars
							</span>
					</a></li>
				</ul>
				<!-- End of links here. -->
	
			</div>
		</header>
		<main class="mdl-layout__content">
			<div class="mdl-grid">
			<!-- Show message if user logs out. -->
			<%
				if (!(request.getParameter("logoutClicked") == null)) {
					request.getSession(true).invalidate();
			%>
				<div class="mdl-cell mdl-cell--12-col" style="margin:3em">
					<div class="mdl-typography--title mdl-color-text--grey-600">
						Logging out...
					</div>
					<br>
					<br>
					<div style="width: 200px" 
						class="mdl-progress mdl-js-progress mdl-progress--indeterminate mdl-color-text--red-900">
					</div>
					<script>
					  setTimeout(function() {
					      document.location = "./index.jsp";
					  }, 1000);
					</script>
				</div>
			<%
				}
			%>
			<!-- Link cards with all the links. -->
			<div style="display:table; text-align:center; horizontal-align:middle;margin:0 auto;">
				<div style="display:table-row;vertical-align:middle;">
					
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/insertVehicle.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Insert a vehicle.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/insertInstructor.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Insert an instructor.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/insertStudent.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Insert a student.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/studentByCity.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Find student by city.</h4>
								</div>
							</div>
						</a>
					</div>
				</div>

				<div style="display:table-row;vertical-align:middle;">
					
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/studentByDrvInst.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Find student by instructor.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/studentByDate.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Find student by session date.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/carByEquipOpt.jsp" style="opacity:100; text-align:middle; ">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand"">
									<h4>Find a car by equipment option.</h4>
								</div>
							</div>
						</a>
					</div>
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/driverByTruckWeight.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Find driver by truck weight.</h4>
								</div>
							</div>
						</a>
					</div>
				</div>
				<div style="display:table-row;vertical-align:middle;">
					<div style="display:table-cell;padding:2em;vertical-align:middle;">
						<a class="mdl-navigation__link" href="./pages/deleteCars.jsp" style="opacity:100;">
							<div class="mdl-js-button mdl-js-ripple-effect mdl-card mdl-shadow--6dp" style="height:200px;width:200px;" >
								<div class="mdl-color-text--grey-100  mdl-color--red-900 mdl-card__title mdl-card--expand">
									<h4>Delete cars by door number.</h4>
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
			</div>
		</main>
	</div>
</body>
</html>