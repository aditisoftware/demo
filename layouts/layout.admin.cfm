<cfoutput>
    #html.doctype()#
    <html lang="en">
    <head runat="server">
        <title></title>
        <link href="/includes/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="/includes/css/sb-admin.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="/includes/css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="/includes/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div id="wrapper">
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.html">ANT Inquery</a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    <li class="dropdown">
                        <a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> User Name<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="##"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="logout.aspx"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li>
                            <a href="index.html"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="useradd.aspx"><i class="fa fa-fw fa-users"></i> Users Add</a>
                        </li>
                        <li>
                            <a href="tables.html"><i class="fa fa-fw fa-table"></i> Tables</a>
                        </li>
                        <li>
                            <a href="forms.html"><i class="fa fa-fw fa-edit"></i> Forms</a>
                        </li>
                        <li>
                            <a href="bootstrap-elements.html"><i class="fa fa-fw fa-desktop"></i> Bootstrap Elements</a>
                        </li>
                        <li>
                            <a href="bootstrap-grid.html"><i class="fa fa-fw fa-wrench"></i> Bootstrap Grid</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="##demo"><i class="fa fa-fw fa-arrows-v"></i> Dropdown <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="demo" class="collapse">
                                <li>
                                    <a href="##">Dropdown Item</a>
                                </li>
                                <li>
                                    <a href="##">Dropdown Item</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="blank-page.html"><i class="fa fa-fw fa-file"></i> Blank Page</a>
                        </li>
                        <li>
                            <a href="index-rtl.html"><i class="fa fa-fw fa-dashboard"></i> RTL Dashboard</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>
            <div id="page-wrapper">
                <div class="container-fluid">
    				#renderView()#
                </div>
            </div>
        </div>
        <script src="includes/js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="includes/js/bootstrap.min.js"></script>

        <!-- Morris Charts JavaScript -->
        <script src="includes/js/plugins/morris/raphael.min.js"></script>
        <script src="includes/js/plugins/morris/morris.min.js"></script>
        <script src="includes/js/plugins/morris/morris-data.js"></script>
    </body>
    </html>
</cfoutput>
