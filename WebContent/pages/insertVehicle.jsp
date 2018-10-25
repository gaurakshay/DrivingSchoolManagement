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
	<div
		class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-color--grey-100">
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
				<li class="mdl-menu__item"><a href="#" class="mdl-layout__tab"
					style="display: table; width: 90%;" onclick="return false"> <span
						class="mdl-color-text--red-700 mdl-typography--body-2"
						style="display: table-cell; vertical-align: middle; width =100%; text-align: left">
							Insert Vehicle </span>
				</a></li>
				<li class="mdl-menu__item"><a
					href="../pages/insertInstructor.jsp" class="mdl-layout__tab"
					style="display: table; width: 90%;"> <span
						class="mdl-color-text--grey-700 mdl-typography--body-2"
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


			<%
				}
				if (!((request.getSession(true).getAttribute("session.userid") == "")
						|| (request.getSession(true).getAttribute("session.userid") == null)
						|| (request.getSession(true).getAttribute("session.pwd") == "")
						|| (request.getSession(true).getAttribute("session.pwd") == null))) {
					String uid = request.getSession(true).getAttribute("session.userid").toString();
					String pwd = request.getSession(true).getAttribute("session.pwd").toString();
					String selectedVehicle = null;
					String vehicle = null;
					boolean carFlag   = false;
					boolean truckFlag = false;
					selectedVehicle = (String) request.getParameter("radio-vehicle");
					if (selectedVehicle == null) {
						//request.getSession(true).setAttribute("session.selected.vehicle", null);
						carFlag = false;
						truckFlag = false;
					} else if (selectedVehicle.equalsIgnoreCase("car")) {
						request.getSession(true).setAttribute("session.selected.vehicle", "car");
						carFlag = true;
						truckFlag = false;
					} else if (selectedVehicle.equalsIgnoreCase("truck")) {
						request.getSession(true).setAttribute("session.selected.vehicle", "truck");
						carFlag = false;
						truckFlag = true;
					}
					
					vehicle = (String) request.getSession(true).getAttribute("session.selected.vehicle");
			%>
			<div class="mdl-cell mdl-cell--12-col" style="margin:1em;text-align:left;">

				<div class="mdl-typography--title mdl-color-text--grey-700" style="float:left;width:20%;">
					Choose new entry:
				<br /><br />
				<form method="post" action="">
						<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect"
							for="radio-car"> <input type="radio" id="radio-car"
							class="mdl-radio__button" name="radio-vehicle"
							onclick="submit();" value="car" <%if(vehicle != null && vehicle.equalsIgnoreCase("car")) {out.println("checked");}%>> <span
							class="mdl-radio__label">Car</span>
						</label> <br /> <br /> <label
							class="mdl-radio mdl-js-radio mdl-js-ripple-effect"
							for="radio-truck"> <input type="radio" id="radio-truck"
							class="mdl-radio__button" name="radio-vehicle"
							onclick="submit();" value="truck" <%if(vehicle != null && vehicle.equalsIgnoreCase("truck")) {out.println("checked");}%>> <span
							class="mdl-radio__label">Truck</span>
						</label>
					
				</form>
				</div>
			<%
				if (!(vehicle == null)) {
			%>
			
			<form method="post">
				<!-- Div for generic vehicle input -->
					<!-- Text fields for UserId and Password. -->
				<div style="float:left;width:50%;">
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px;">
						<input class = "mdl-textfield__input" type="text" id="licplt" name="licplt" required pattern=".{1,10}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "licplt">Lic. Plate</label>
						<span class="mdl-textfield__error">Max 10 chars</span>
					</div> &nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="make" name="make" required pattern=".{1,15}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "make">Make</label>
						<span class="mdl-textfield__error">Max 15 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="mdl" name="mdl" required pattern=".{1,15}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "mdl">Model</label>
						<span class="mdl-textfield__error">Max 15 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:50px">
						<input class = "mdl-textfield__input" type="text" id="yr" name="yr" required pattern="[0-9]{4}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "yr">Year</label>
						<span class="mdl-textfield__error">4 Digits</span>
					</div><br>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="opt1" name="opt1" pattern=".{1,30}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "opt1">Option1</label>
						<span class="mdl-textfield__error">Max 30 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="opt2" name="opt2" pattern=".{1,30}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "opt2">Option2</label>
						<span class="mdl-textfield__error">Max 30 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="opt3" name="opt3" pattern=".{1,30}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "opt3">Option3</label>
						<span class="mdl-textfield__error">Max 30 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="opt4" name="opt4" pattern=".{1,30}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "opt4">Option4</label>
						<span class="mdl-textfield__error">Max 30 chars</span>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="opt5" name="opt5" pattern=".{1,30}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "opt5">Option5</label>
						<span class="mdl-textfield__error">Max 30 chars</span>
					</div>
				</div>
				
				
					<div style="float:left;width:10%;">
				<%if(vehicle.equalsIgnoreCase("car")) { %>
					<br/>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px;">
						<input class = "mdl-textfield__input" type="text" id="doornum" name="doornum" required pattern="[0-9][0-9]?"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "doornum">No of Doors</label>
						<span class="mdl-textfield__error">Max 2 digits</span>
					</div>
		
		
				<% } else if(vehicle.equalsIgnoreCase("truck")) { %>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="cabintype" name="cabintype" required pattern=".{1,15}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "cabintype">Cabin Type</label>
						<span class="mdl-textfield__error">Max 15 chars</span>
					</div><br/>
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="width:100px">
						<input class = "mdl-textfield__input" type="text" id="trckwght" name="trckwght" required pattern="[0-9]{1,5}"/>
						<label class = "mdl-textfield__label mdl-color-text--grey-600" for = "trckwght">Truck Weight</label>
						<span class="mdl-textfield__error">Max 5 digits</span>
					</div>
		
			<% } %>
					</div>
 				<div style="float:left;width:8%;">
 				<br/><br/>
					<button type="submit" value="insertVehicle"
							class="mdl-button mdl-color--red-900 mdl-js-button mdl-color-text--grey-100
									mdl-js-ripple-effect mdl-button--raised" name="insertVehicle">
					Insert
					</button>
				</div>
			
			</form>	
			</div>
			<% 
			String insertCheck = request.getParameter("insertVehicle");
			if(insertCheck != null){
				String result = null;
				//Insert the values submitted by the user.
				if(vehicle.equalsIgnoreCase("car")) {
					boolean validEntries = true;
					String[] carDetails = new String[10];
					
					carDetails[0] = request.getParameter("licplt").toUpperCase();
					carDetails[1] = request.getParameter("make").toUpperCase();
					carDetails[2] = request.getParameter("mdl").toUpperCase();
					carDetails[3] = request.getParameter("yr");
					carDetails[4] = request.getParameter("opt1").toUpperCase();
					carDetails[5] = request.getParameter("opt2").toUpperCase();
					carDetails[6] = request.getParameter("opt3").toUpperCase();
					carDetails[7] = request.getParameter("opt4").toUpperCase();
					carDetails[8] = request.getParameter("opt5").toUpperCase();
					carDetails[9] = request.getParameter("doornum");
					ConnectionManager connMgr = new ConnectionManager();
					result = connMgr.insertVehicle(uid, pwd, vehicle, carDetails);
				} else if(vehicle.equalsIgnoreCase("truck")){
					String[] truckDetails = new String[11];
					truckDetails[0] = request.getParameter("licplt").toUpperCase();
					truckDetails[1] = request.getParameter("make").toUpperCase();
					truckDetails[2] = request.getParameter("mdl").toUpperCase();
					truckDetails[3] = request.getParameter("yr");
					truckDetails[4] = request.getParameter("opt1").toUpperCase();
					truckDetails[5] = request.getParameter("opt2").toUpperCase();
					truckDetails[6] = request.getParameter("opt3").toUpperCase();
					truckDetails[7] = request.getParameter("opt4").toUpperCase();
					truckDetails[8] = request.getParameter("opt5").toUpperCase();
					truckDetails[9] = request.getParameter("cabintype").toUpperCase();
					truckDetails[10] = request.getParameter("trckwght");
					ConnectionManager connMgr = new ConnectionManager();
					result = connMgr.insertVehicle(uid, pwd, vehicle, truckDetails);
				}%>
						<div class="mdl-typography--body-1" style="margin:0;width:100%;text-align:center;">
							<h6><%=result %></h6>
						</div>
			<%}
			
			int i = 0;
			
			%>			
			
			
			
			<div class="mdl-cell mdl-cell--12-col" style="margin: 1em">
				<%
					ResultSet rsCar = null;
					ResultSet rsTruck = null;
					ConnectionManager connMgr = new ConnectionManager();
					ResultSet rs = connMgr.getVehicleDetails(uid, pwd, vehicle);
					if (vehicle.equalsIgnoreCase("car")) {
						rsCar = rs;
					} else if (vehicle.equalsIgnoreCase("truck")) {
						rsTruck = rs;
					}
					if (rsCar != null) {
						if (rsCar.isBeforeFirst()) {
				%>
				<br />
				<div class="mdl-typography--title mdl-color-text--red-900">CARS</div>
				<br />
				<table class="mdl-data-table mdl-js-data-table mdl-shadow--6dp">
					<thead>
						<tr>
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
									YR</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									DOOR #</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 1</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 2</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 3</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 4</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 5</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<%
							while (rsCar.next()) {
						%>
						<tr>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsCar.getString(1)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsCar.getString(2)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsCar.getString(3)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsCar.getString(4)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(5) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(5));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(6) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(6));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(7) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(7));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(8) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(8));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(9) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(9));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsCar.getString(10) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(10));
															}
									%>
								</div>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
								}
							}
							if (rsTruck != null) {
								if (rsTruck.isBeforeFirst()) {
				%>
				<br />
				<div class="mdl-typography--title mdl-color-text--red-900">TRUCKS</div>
				<br />
				<table class="mdl-data-table mdl-js-data-table mdl-shadow--6dp">
					<thead>
						<tr>
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
									YR</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									CABIN TYPE</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									WGT</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 1</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 2</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 3</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 4</div>
							</th>
							<th class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--body-1 mdl-color-text--grey-600">
									OPTION 5</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<%
							while (rsTruck.next()) {
						%>
						<tr>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsTruck.getString(1)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsTruck.getString(2)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsTruck.getString(3)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsTruck.getString(4)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%=rsTruck.getString(5)%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(6) == null) {
																out.println("");
															} else {
																out.println(rsTruck.getString(6) + " LBS");
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(7) == null) {
																out.println("");
															} else {
																out.println(rsTruck.getString(7));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(8) == null) {
																out.println("");
															} else {
																out.println(rsTruck.getString(8));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(9) == null) {
																out.println("");
															} else {
																out.println(rsTruck.getString(9));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(10) == null) {
																out.println("");
															} else {
																out.println(rsTruck.getString(10));
															}
									%>
								</div>
							</td>
							<td class="mdl-data-table__cell--non-numeric">
								<div class="mdl-typography--caption mdl-color-text--grey-600">
									<%
										if (rsTruck.getString(11) == null) {
																out.println("");
															} else {
																out.println(rsCar.getString(11));
															}
									%>
								</div>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
								}
							}
				}
				%>

			</div>
			<%
				} else {
					if (!logOut) {
			%>

			<div class="mdl-cell mdl-cell--12-col"
				style="margin: 3em; text-align: center;">

				<div class="mdl-typography--title mdl-color-text--grey-700">
					Please <a href="./login.jsp" class="mdl-navigation__link"> <span
						class="mdl-color-text--red-800 mdl-typography--title">
							login </span>
					</a> first!
				</div>
			</div>
			<%
				}
			}
			%>
		</div>
		</main>
	</div>
</body>
</html>