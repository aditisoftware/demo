<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <i class="fa fa-dashboard"></i> #Ucase(Session.uName)#'s Dashboard
            </h1>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-sun-o fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">#rc.qYesterdayInquiryCount.count#</div>
                            <div>Y'Day Inquery</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-4">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-tasks fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">#rc.qLastMonthInquiryCount.count#</div>
                            <div>Monthly Inquery</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-4">
            <div class="panel panel-yellow">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-shopping-cart fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">#rc.qCurrentYearInquiryCount.recordcount#</div>
                            <div>Yearly Inquery</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-4">
            <div class="panel panel-red">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-history fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">#rc.qTotalInquiryCount.cnt#</div>
                            <div>Total Inquery</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</cfoutput>
