
<cfcomponent displayname="inqueryDAO" >

	<cffunction name="init" access="public" output="false" returntype="inqueryDAO">
		<cfargument name="dsn" required="true" inject="coldbox:datasource:hauntworld" />
		<cfset variables.dsn = arguments.dsn.getName() >
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="inquery">
		<cfargument name="inquery" type="inquery" required="true" />
		
		
		<cfset var qCreate = "" />
		<cfset var qID = "" />
		<cftransaction>
			<cfquery name="qCreate" datasource="#variables.dsn#">
				INSERT INTO `inquery` ( 					companyname, 					contactperson, 					address, 					city, 					state, 					country, 					zipcode, 					phone1, 					phone2, 					mobile, 					email, 					tourtype, 					destination, 					totalpassenger, 					adult, 					child, 					child511year, 					child11plus, 					hotelcategory, 					roomsharing, 					vehicletype, 					allss, 					allentry, 					departuredate, 					transporttype, 					traintype, 					foodtype, 					mealplan, 					noofPassenger, 					soundsystem, 					project, 					amt_pmt, 					stagedecoration, 					B2B, 					DJParty, 					cocktailparty, 					artist, 					cultureparty, 					productlaunching, 					sitevisit, 					remark, 					createddate, 					createdby)
				VALUES ( 					<cfqueryparam value="#arguments.inquery.getcompanyname()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcompanyname())#" />, 					<cfqueryparam value="#arguments.inquery.getcontactperson()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcontactperson())#" />, 					<cfqueryparam value="#arguments.inquery.getaddress()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getaddress())#" />, 					<cfqueryparam value="#arguments.inquery.getcity()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcity())#" />, 					<cfqueryparam value="#arguments.inquery.getstate()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getstate())#" />, 					<cfqueryparam value="#arguments.inquery.getcountry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcountry())#" />, 					<cfqueryparam value="#arguments.inquery.getzipcode()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getzipcode())#" />, 					<cfqueryparam value="#arguments.inquery.getphone1()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getphone1())#" />, 					<cfqueryparam value="#arguments.inquery.getphone2()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getphone2())#" />, 					<cfqueryparam value="#arguments.inquery.getmobile()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getmobile())#" />, 					<cfqueryparam value="#arguments.inquery.getemail()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getemail())#" />, 					<cfqueryparam value="#arguments.inquery.gettourtype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettourtype())#" />, 					<cfqueryparam value="#arguments.inquery.getdestination()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getdestination())#" />, 					<cfqueryparam value="#arguments.inquery.gettotalpassenger()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettotalpassenger())#" />, 					<cfqueryparam value="#arguments.inquery.getadult()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getadult())#" />, 					<cfqueryparam value="#arguments.inquery.getchild()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild())#" />, 					<cfqueryparam value="#arguments.inquery.getchild511year()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild511year())#" />, 					<cfqueryparam value="#arguments.inquery.getchild11plus()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild11plus())#" />, 					<cfqueryparam value="#arguments.inquery.gethotelcategory()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gethotelcategory())#" />, 					<cfqueryparam value="#arguments.inquery.getroomsharing()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getroomsharing())#" />, 					<cfqueryparam value="#arguments.inquery.getvehicletype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getvehicletype())#" />, 					<cfqueryparam value="#arguments.inquery.getallss()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getallss())#" />, 					<cfqueryparam value="#arguments.inquery.getallentry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getallentry())#" />, 					<cfqueryparam value="#arguments.inquery.getdeparturedate()#" cfsqltype="cf_sql_timestamp" null="#not len(arguments.inquery.getdeparturedate())#" />, 					<cfqueryparam value="#arguments.inquery.gettransporttype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettransporttype())#" />, 					<cfqueryparam value="#arguments.inquery.gettraintype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettraintype())#" />, 					<cfqueryparam value="#arguments.inquery.getfoodtype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getfoodtype())#" />, 					<cfqueryparam value="#arguments.inquery.getmealplan()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getmealplan())#" />, 					<cfqueryparam value="#arguments.inquery.getnoofPassenger()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getnoofPassenger())#" />, 					<cfqueryparam value="#arguments.inquery.getsoundsystem()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getsoundsystem())#" />, 					<cfqueryparam value="#arguments.inquery.getproject()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getproject())#" />, 					<cfqueryparam value="#arguments.inquery.getamt_pmt()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getamt_pmt())#" />, 					<cfqueryparam value="#arguments.inquery.getstagedecoration()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getstagedecoration())#" />, 					<cfqueryparam value="#arguments.inquery.getB2B()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getB2B())#" />, 					<cfqueryparam value="#arguments.inquery.getDJParty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getDJParty())#" />, 					<cfqueryparam value="#arguments.inquery.getcocktailparty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcocktailparty())#" />, 					<cfqueryparam value="#arguments.inquery.getartist()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getartist())#" />, 					<cfqueryparam value="#arguments.inquery.getcultureparty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcultureparty())#" />, 					<cfqueryparam value="#arguments.inquery.getproductlaunching()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getproductlaunching())#" />, 					<cfqueryparam value="#arguments.inquery.getsitevisit()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getsitevisit())#" />, 					<cfqueryparam value="#arguments.inquery.getremark()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getremark())#" />, 					<cfqueryparam value="#arguments.inquery.getcreateddate()#" cfsqltype="cf_sql_timestamp"  />, 					<cfqueryparam value="#arguments.inquery.getcreatedby()#" cfsqltype="cf_sql_integer"  />
				)
			</cfquery>
			
			<cfquery name="qID" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS Id
			</cfquery>
			<cfset arguments.inquery.setId(qID.Id) >
		</cftransaction>
		
		<cfreturn arguments.inquery />
	</cffunction>
	
	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="inquery" type="inquery" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		
		<cfquery name="qRead" datasource="#variables.dsn#">
			SELECT	Id,companyname,contactperson,address,city,state,country,zipcode,phone1,phone2,mobile,email,tourtype,destination,totalpassenger,adult,child,child511year,child11plus,hotelcategory,roomsharing,vehicletype,allss,allentry,departuredate,transporttype,traintype,foodtype,mealplan,noofPassenger,soundsystem,project,amt_pmt,stagedecoration,B2B,DJParty,cocktailparty,artist,cultureparty,productlaunching,sitevisit,remark,createddate,createdby
			FROM		`inquery`
			WHERE		0=0
			AND		Id = <cfqueryparam value="#arguments.inquery.getId()#" cfsqltype="cf_sql_integer" />
		</cfquery>
	
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.inquery.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>
	
	<cffunction name="update" access="public" output="false" returntype="inquery">
		<cfargument name="inquery" type="inquery" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
			UPDATE	`inquery`
			SET							companyname = <cfqueryparam value="#arguments.inquery.getcompanyname()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcompanyname())#" />, 					contactperson = <cfqueryparam value="#arguments.inquery.getcontactperson()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcontactperson())#" />, 					address = <cfqueryparam value="#arguments.inquery.getaddress()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getaddress())#" />, 					city = <cfqueryparam value="#arguments.inquery.getcity()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcity())#" />, 					state = <cfqueryparam value="#arguments.inquery.getstate()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getstate())#" />, 					country = <cfqueryparam value="#arguments.inquery.getcountry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcountry())#" />, 					zipcode = <cfqueryparam value="#arguments.inquery.getzipcode()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getzipcode())#" />, 					phone1 = <cfqueryparam value="#arguments.inquery.getphone1()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getphone1())#" />, 					phone2 = <cfqueryparam value="#arguments.inquery.getphone2()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getphone2())#" />, 					mobile = <cfqueryparam value="#arguments.inquery.getmobile()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getmobile())#" />, 					email = <cfqueryparam value="#arguments.inquery.getemail()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getemail())#" />, 					tourtype = <cfqueryparam value="#arguments.inquery.gettourtype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettourtype())#" />, 					destination = <cfqueryparam value="#arguments.inquery.getdestination()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getdestination())#" />, 					totalpassenger = <cfqueryparam value="#arguments.inquery.gettotalpassenger()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettotalpassenger())#" />, 					adult = <cfqueryparam value="#arguments.inquery.getadult()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getadult())#" />, 					child = <cfqueryparam value="#arguments.inquery.getchild()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild())#" />, 					child511year = <cfqueryparam value="#arguments.inquery.getchild511year()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild511year())#" />, 					child11plus = <cfqueryparam value="#arguments.inquery.getchild11plus()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getchild11plus())#" />, 					hotelcategory = <cfqueryparam value="#arguments.inquery.gethotelcategory()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gethotelcategory())#" />, 					roomsharing = <cfqueryparam value="#arguments.inquery.getroomsharing()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getroomsharing())#" />, 					vehicletype = <cfqueryparam value="#arguments.inquery.getvehicletype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getvehicletype())#" />, 					allss = <cfqueryparam value="#arguments.inquery.getallss()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getallss())#" />, 					allentry = <cfqueryparam value="#arguments.inquery.getallentry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getallentry())#" />, 					departuredate = <cfqueryparam value="#arguments.inquery.getdeparturedate()#" cfsqltype="cf_sql_timestamp" null="#not len(arguments.inquery.getdeparturedate())#" />, 					transporttype = <cfqueryparam value="#arguments.inquery.gettransporttype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettransporttype())#" />, 					traintype = <cfqueryparam value="#arguments.inquery.gettraintype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.gettraintype())#" />, 					foodtype = <cfqueryparam value="#arguments.inquery.getfoodtype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getfoodtype())#" />, 					mealplan = <cfqueryparam value="#arguments.inquery.getmealplan()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getmealplan())#" />, 					noofPassenger = <cfqueryparam value="#arguments.inquery.getnoofPassenger()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getnoofPassenger())#" />, 					soundsystem = <cfqueryparam value="#arguments.inquery.getsoundsystem()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getsoundsystem())#" />, 					project = <cfqueryparam value="#arguments.inquery.getproject()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getproject())#" />, 					amt_pmt = <cfqueryparam value="#arguments.inquery.getamt_pmt()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getamt_pmt())#" />, 					stagedecoration = <cfqueryparam value="#arguments.inquery.getstagedecoration()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getstagedecoration())#" />, 					B2B = <cfqueryparam value="#arguments.inquery.getB2B()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getB2B())#" />, 					DJParty = <cfqueryparam value="#arguments.inquery.getDJParty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getDJParty())#" />, 					cocktailparty = <cfqueryparam value="#arguments.inquery.getcocktailparty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcocktailparty())#" />, 					artist = <cfqueryparam value="#arguments.inquery.getartist()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getartist())#" />, 					cultureparty = <cfqueryparam value="#arguments.inquery.getcultureparty()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getcultureparty())#" />, 					productlaunching = <cfqueryparam value="#arguments.inquery.getproductlaunching()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getproductlaunching())#" />, 					sitevisit = <cfqueryparam value="#arguments.inquery.getsitevisit()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getsitevisit())#" />, 					remark = <cfqueryparam value="#arguments.inquery.getremark()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.inquery.getremark())#" />, 					createddate = <cfqueryparam value="#arguments.inquery.getcreateddate()#" cfsqltype="cf_sql_timestamp"  />, 					createdby = <cfqueryparam value="#arguments.inquery.getcreatedby()#" cfsqltype="cf_sql_integer"  /> 
			WHERE		0=0				AND		Id = <cfqueryparam value="#arguments.inquery.getId()#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn arguments.inquery />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="inquery" type="inquery" required="true" />

		<cfset var qDelete = "">
		
			<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	`inquery`
				WHERE		0=0				AND		Id = <cfqueryparam value="#arguments.inquery.getId()#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="inquery" >
		<cfargument name="inquery" type="inquery" required="true" >
	
		<cfif len(arguments.inquery.getId()) AND arguments.inquery.getId() NEQ 0 >
			<cfreturn update(arguments.inquery) >
		<cfelse>
			<cfset arguments.inquery.setId(0) >
			<cfreturn create(arguments.inquery) >
		</cfif>
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="inquery" type="inquery" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	`inquery`
			WHERE		0=0			AND		Id = <cfqueryparam value="#arguments.inquery.getId()#" cfsqltype="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			var row = 1;
			var ii = 1;
			var cols = listToArray(qry.columnList);
			var stReturn = structnew();
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			return stReturn;
		</cfscript>
	</cffunction>
</cfcomponent>

