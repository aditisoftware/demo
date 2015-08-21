<cfsetting enablecfoutputonly="false" /><!DOCTYPE html>
<html>
<head>
	<title><%cfoutput%>rc.pageTitle<%/cfoutput%></title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="expires" content="0" value="" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<meta name="keywords" content="" />
	<script type="text/javascript" src="/includes/javascript/jquery-latest.js"></script>
	<script type="text/javascript" src="/includes/javascript/jquery.validate.js"></script>
	<script type="text/javascript" src="/includes/javascript/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/includes/javascript/jquery-ui-timepicker-addon.js"></script>
	<link rel="stylesheet" href="/includes/styles/smoothness/jquery-ui.css" />
	<script type="text/javascript" src="/includes/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="/includes/styles/admin.display.css" />
</head>
<body>
<%cfoutput%>
	<div class="main">
		<div class="header">
			<div class="nav_header">
				<a href="##">logout</a>
			</div>
			<h1>Admin Panel</h1>
		</div>
		<div class="content">
			<div class="leftpanel">
				<ul><cfloop array="#variables.project.getTables()#" index="table">
						<cfoutput><cfif len(trim(table.getComponentName()))>
					<li>
						<a href="%event.buildlink('admin.#table.getComponentName()#.list')%" <%cfif "#table.getComponentName()#" EQ event.getCurrentHandler()%>class="selected"<%/cfif%>>#table.GetComponentUserFriendlyName()#</a>
					</li></cfif></cfoutput></cfloop>
				</ul>
			</div>
			<div class="rightpanel">
				%getMyPlugin("ErrorBox").renderIt()%
				%renderView()%
			</div>
		</div>
		<div class="footer">
			© #year(now())# iSummation Technologies
		</div>
	</div>
<%/cfoutput%>
</body>
</html>