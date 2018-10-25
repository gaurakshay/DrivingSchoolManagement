<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cs5513.hw.ConnectionManager"%>
<%@ page import="java.sql.ResultSet"%>
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
<link href="../resources/main.css" rel="stylesheet" type="text/css">

</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-color--grey-100">	
	<header class="mdl-layout__header mdl-color--red-900">
		<div class="mdl-layout__header-row">
			<!-- Title -->
			<a class="mdl-navigation__link" style="opacity:100;" href="../index.jsp">
			<div class="mdl-layout-title" style="width:400px"><img alt="Sooners!"
				src="../resources/ou-logo-white.svg" height="8%" width="8%"> CS 5513 HOMEWORK #2 </div>
			</a>
			<div class="mdl-layout-spacer"></div>

			<!-- Username if logged in. -->
			<%
				boolean logOut = false;
				//String userId = (String) request.getSession(true).getAttribute("session.userid");
				if (!(request.getSession(true).getAttribute("session.userid") == "" 
						|| request.getSession(true).getAttribute("session.userid") == null)) {
			%>
			<div class="mdl-typography--title mdl-color-text--white">
				<%=request.getSession(true).getAttribute("session.userid").toString().toUpperCase()%>
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
			<a href="../pages/login.jsp" class="mdl-navigation__link"> <span
				class="mdl-color-text--white mdl-typography--title"> Login</span>
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
				<li class="mdl-menu__item"><a href="../index.jsp"
					class="mdl-layout__tab" style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Home </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/insertVehicle.jsp" class="mdl-layout__tab"
					style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Insert Vehicle </span>
				</a></li>
				<li class="mdl-menu__item"><a href="#" class="mdl-layout__tab"
					style="display: table; width: 90%;"  onclick="return false"> <span
						class="mdl-color-text--red-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Insert Instructor </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/insertStudent.jsp"
					class="mdl-layout__tab" style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Insert Student </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/studentByCity.jsp"
					class="mdl-layout__tab " style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Find Student (By City) </span>
				</a></li>
				<li class="mdl-menu__item"><a
					href="../pages/studentByDrvInst.jsp" class="mdl-layout__tab "
					style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Find Student (By Driving Instructor) </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/studentByDate.jsp"
					class="mdl-layout__tab " style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Find Student (By Session Date) </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/carByEquipOpt.jsp"
					class="mdl-layout__tab " style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Find Car </span>
				</a></li>
				<li class="mdl-menu__item"><a
					href="../pages/driverByTruckWeight.jsp" class="mdl-layout__tab "
					style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Find Driver </span>
				</a></li>
				<li class="mdl-menu__item"><a href="../pages/deleteCars.jsp"
					class="mdl-layout__tab " style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Delete Cars </span>
				</a></li>
			</ul>
			<!-- End of links here. -->

		</div>
	</header>

	<main class="mdl-layout__content">
	<div class="mdl-grid" align="center">
		<!-- Show message if user logs out. -->
<%
	if (request.getParameter("logoutClicked") != null) {
		logOut = true;
		request.getSession(true).invalidate();
%>


		<div class="mdl-cell mdl-cell--12-col" style="margin: 3em">
			<div class="mdl-typography--title mdl-color-text--grey-600">
				Logging out...</div>
			<br> <br>
			<div style="width: 200px"
				class="mdl-progress mdl-js-progress mdl-progress--indeterminate mdl-color-text--red-900">
			</div>
			<script type="text/javascript">
				setTimeout(function() {
					document.location = "./insertVehicle.jsp";
				}, 1000);
			</script>
		</div>
<%} else if (((request.getSession(true).getAttribute("session.userid") == "")
		|| (request.getSession(true).getAttribute("session.userid") == null)
		|| (request.getSession(true).getAttribute("session.pwd") == "")
		|| (request.getSession(true).getAttribute("session.pwd") == null)) && !logOut) { %>
		<div class="mdl-cell mdl-cell--12-col"
			style="margin: 3em; text-align: center;">

			<div class="mdl-typography--title mdl-color-text--grey-700">
				Please <a href="./login.jsp" class="mdl-navigation__link"> <span
					class="mdl-color-text--red-800 mdl-typography--title">
						login </span>
				</a> first!
			</div>
		</div>
<%} else if (!((request.getSession(true).getAttribute("session.userid") == "")
	|| (request.getSession(true).getAttribute("session.userid") == null)
	|| (request.getSession(true).getAttribute("session.pwd") == "")
	|| (request.getSession(true).getAttribute("session.pwd") == null)) && !logOut) {
		String uid = request.getSession(true).getAttribute("session.userid").toString();
		String pwd = request.getSession(true).getAttribute("session.pwd").toString();
	%>
	<div class="mdl-cell mdl-cell--12-col" style="margin:1em;">
		<div style="display:table;width:80%">
			<div style="display:table-row; vertical-align: middle;">
			<div style="display:table-cell; vertical-align:middle;width:25%">
			<span class="mdl-typography--title mdl-color-text--grey-700" style="float:left;">
				Enter Instructor details:
			</span>
			</div>
			<form method="post">
				<div style="display:table-cell; vertical-align:middle;">
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:150px">
						<input class = "mdl-textfield__input" type="text" id="drvid" name="drvid" required pattern="[0-9]{1,5}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "drvid">Instructor ID</label>
						<span class="mdl-textfield__error">Max 5 digits</span>
					</div>
				</div>
				<div style="display:table-cell; vertical-align:middle">
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:150px">
						<input class = "mdl-textfield__input" type="text" id="drvnm" name="drvnm" required pattern=".{1,40}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "drvnm">Instructor Name</label>
						<span class="mdl-textfield__error">Max 40 chars</span>
					</div>
				</div>
				<div style="display:table-cell; vertical-align:middle">
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:150px">
						<input class = "mdl-textfield__input" type="text" id="licplt" name="licplt" required pattern=".{1,15}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "licplt">Lic. Plate</label>
						<span class="mdl-textfield__error">Max 10 chars</span>
					</div>
				</div>
				<div style="display:table-cell; vertical-align:middle;width:15%">
				<button type="submit" value="insertDrvr"
						class="mdl-button mdl-color--red-900 mdl-js-button mdl-color-text--grey-100
								mdl-js-ripple-effect mdl-button--raised" name="insertDrvr">
				Insert
				</button>
				</div>
			</form>	
			</div>
		</div>
	</div>
	<%
		if( request.getParameter("insertDrvr") != null ) {
			String drvId = request.getParameter("drvid");
			String drvNm = request.getParameter("drvnm").toUpperCase();
			String licPlt = request.getParameter("licplt").toUpperCase();
			ConnectionManager connMgr = new ConnectionManager();
			String result = connMgr.insertDrvngInstrctr(uid, pwd, drvId, drvNm, licPlt); %>
	<div class="mdl-typography--body-1" style="margin:0;width:100%;text-align:center;">
		<h6><%=result %></h6>
	</div>
		<%}
		ResultSet drvVhcl = null;
		ConnectionManager connMgr = new ConnectionManager();
		drvVhcl = connMgr.getDriverDetails(uid, pwd);
		if (drvVhcl != null) {
			if (drvVhcl.isBeforeFirst()) { %>
	<div class="mdl-cell mdl-cell--12-col" style="margin: 1em">
		<br />
		<div class="mdl-typography--title mdl-color-text--red-900">DRIVERS</div>
		<br />
		<table class="mdl-data-table mdl-js-data-table mdl-shadow--6dp">
			<thead>
				<tr>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							ID</div>
					</th>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							NAME</div>
					</th>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							LIC PLATE</div>
					</th>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							MAKE</div>
					</th>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							MODEL</div>
					</th>
					<th class="mdl-data-table__cell--non-numeric">
						<div class="mdl-typography--body-1 mdl-color-text--grey-600">
							YEAR</div>
					</th>
				</tr>
			</thead>
			<tbody>
			<%
				while (drvVhcl.next()) {
			%>
					<tr>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(1)%>
							</div>
						</td>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(2)%>
							</div>
						</td>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(3)%>
							</div>
						</td>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(4)%>
							</div>
						</td>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(5)%>
							</div>
						</td>
						<td class="mdl-data-table__cell--non-numeric">
							<div class="mdl-typography--caption mdl-color-text--grey-600">
								<%=drvVhcl.getString(6)%>
							</div>
						</td>
					</tr>
			<%
				}
			%>
				</tbody>
	<%
			}
		}
	%>
			</table>
		</div>
<%} %>
	</div>
	</main>
</div>

</body>
</html>