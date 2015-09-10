<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Admin Login-AntInquery</title>
        <meta name="viewport" content="width=device-width" />
        <script src="/includes/js/jquery.js"></script>
        <script type="text/javascript" src="/includes/js/jquery.validate.js"></script>
        <script src="/includes/js/bootstrap.min.js"></script>
        <link href="/includes/css/bootstrap.min.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="/includes/css/errorbox.css">
        <script type="text/javascript">
            $(function() {
                $("#editor_form").validate({
                    rules: {
                        username: {required: true,maxlength: 100},
                        password: {required: true,maxlength: 100}
                    },
                    messages:{
                        username: {required: "Username is required",maxlength: "username no more than 15 characters"},
                        password: {required: "Password is required",maxlength: "password no more than 128 characters"}
                    },
                    highlight: function(element, errorClass) {
                        if (this.numberOfInvalids() > 0) {
                            $("#usermasterJSError").hide();
                        }
                        $(element).addClass(errorClass);
                    },
                    errorClass:"error",
                    errorElement:"li"
                    /*errorContainer: $("#usermasterJSError"),
                    errorLabelContainer: $("#usermasterULError")*/
                });
            });
        </script>
    </head>
    <body>
        <div class="row">
            <div class="col-md-12">&nbsp;</div>
            <div class="col-md-12">&nbsp;</div>
            <div class="col-md-12">&nbsp;</div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-6 col-md-offset-3">
                <div class="panel panel-success">
                    <div class="panel-heading">Enter username and password.</div>
                    <cfoutput>
                        <form name="editor_form" id="editor_form" action="#event.buildlink("#rc.xehDoLogin#")#" method="post" >
                            <div class="row panel-body">
                                <cfoutput>#getInstance("ErrorBox").renderIt("loginError")#</cfoutput>
                                <div id="usermasterJSError" class="errorbox" style="display:none">
                                    <ul id="usermasterULError"></ul>
                                </div>

                                <div class="col-md-offset-2 col-md-8 margin-bottom-15">
                                    <label for="username">Username</label>
                                    <input type="text" ID="username" name="username" runat="server" class="form-control" placeholder="Enter Username" />
                                </div>
                                <div class="col-md-offset-2 col-md-8 margin-bottom-15">
                                    <label for="password">Password</label>
                                    <input type="password" ID="password" name="password" runat="server" class="form-control" placeholder="Enter Password" TextMode="Password" />
                                </div>
                                <div class="col-md-offset-2 col-md-8 margin-bottom-15">
                                    <input type="submit" ID="signin" runat="server" Class="btn btn-primary" Text="Sign In" />&nbsp;<input id="reset" class="btn btn-default" title="Reset" type="reset" value="Reset" />
                                </div>
                            </div>
                        </form>
                    </cfoutput>
                </div>
            </div>
        </div>
    </body>
</html>
