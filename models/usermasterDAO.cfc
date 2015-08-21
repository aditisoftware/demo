
<cfcomponent displayname="usermasterDAO" >

	<cffunction name="init" access="public" output="false" returntype="usermasterDAO">
		<cfargument name="dsn" required="true" inject="coldbox:datasource:demo" />
		<cfset variables.dsn = arguments.dsn.Name >
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="usermaster">
		<cfargument name="usermaster" type="usermaster" required="true" />
		
		
		<cfset var qCreate = "" />
		<cfset var qID = "" />
		<cftransaction>
			<cfquery name="qCreate" datasource="#variables.dsn#">
				INSERT INTO `usermaster` ( 
					firstname, 
					lastname, 
					address1, 
					address2, 
					city, 
					state, 
					country, 
					username, 
					password, 
					usertype, 
					createddate, 
					createdby)
				VALUES ( 
					<cfqueryparam value="#arguments.usermaster.getfirstname()#" cfsqltype="cf_sql_varchar"  />, 
					<cfqueryparam value="#arguments.usermaster.getlastname()#" cfsqltype="cf_sql_varchar"  />, 
					<cfqueryparam value="#arguments.usermaster.getaddress1()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getaddress1())#" />, 
					<cfqueryparam value="#arguments.usermaster.getaddress2()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getaddress2())#" />, 
					<cfqueryparam value="#arguments.usermaster.getcity()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getcity())#" />, 
					<cfqueryparam value="#arguments.usermaster.getstate()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getstate())#" />, 
					<cfqueryparam value="#arguments.usermaster.getcountry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getcountry())#" />, 
					<cfqueryparam value="#arguments.usermaster.getusername()#" cfsqltype="cf_sql_varchar"  />, 
					<cfqueryparam value="#arguments.usermaster.getpassword()#" cfsqltype="cf_sql_varchar"  />, 
					<cfqueryparam value="#arguments.usermaster.getusertype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getusertype())#" />, 
					<cfqueryparam value="#arguments.usermaster.getcreateddate()#" cfsqltype="cf_sql_timestamp"  />, 
					<cfqueryparam value="#arguments.usermaster.getcreatedby()#" cfsqltype="cf_sql_integer"  />
				)
			</cfquery>
			
			<cfquery name="qID" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS Id
			</cfquery>
			<cfset arguments.usermaster.setId(qID.Id) >
		</cftransaction>
		
		<cfreturn arguments.usermaster />
	</cffunction>
	
	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="usermaster" type="usermaster" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		
		<cfquery name="qRead" datasource="#variables.dsn#">
			SELECT	Id,firstname,lastname,address1,address2,city,state,country,username,password,usertype,createddate,createdby
			FROM		`usermaster`
			WHERE		0=0
			AND		Id = <cfqueryparam value="#arguments.usermaster.getId()#" cfsqltype="cf_sql_integer" />
		</cfquery>
	
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.usermaster.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>
	
	<cffunction name="update" access="public" output="false" returntype="usermaster">
		<cfargument name="usermaster" type="usermaster" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
			UPDATE	`usermaster`
			SET		
					firstname = <cfqueryparam value="#arguments.usermaster.getfirstname()#" cfsqltype="cf_sql_varchar"  />, 
					lastname = <cfqueryparam value="#arguments.usermaster.getlastname()#" cfsqltype="cf_sql_varchar"  />, 
					address1 = <cfqueryparam value="#arguments.usermaster.getaddress1()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getaddress1())#" />, 
					address2 = <cfqueryparam value="#arguments.usermaster.getaddress2()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getaddress2())#" />, 
					city = <cfqueryparam value="#arguments.usermaster.getcity()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getcity())#" />, 
					state = <cfqueryparam value="#arguments.usermaster.getstate()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getstate())#" />, 
					country = <cfqueryparam value="#arguments.usermaster.getcountry()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getcountry())#" />, 
					username = <cfqueryparam value="#arguments.usermaster.getusername()#" cfsqltype="cf_sql_varchar"  />, 
					password = <cfqueryparam value="#arguments.usermaster.getpassword()#" cfsqltype="cf_sql_varchar"  />, 
					usertype = <cfqueryparam value="#arguments.usermaster.getusertype()#" cfsqltype="cf_sql_varchar" null="#not len(arguments.usermaster.getusertype())#" />, 
					createddate = <cfqueryparam value="#arguments.usermaster.getcreateddate()#" cfsqltype="cf_sql_timestamp"  />, 
					createdby = <cfqueryparam value="#arguments.usermaster.getcreatedby()#" cfsqltype="cf_sql_integer"  /> 
			WHERE		0=0
				AND		Id = <cfqueryparam value="#arguments.usermaster.getId()#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn arguments.usermaster />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="usermaster" type="usermaster" required="true" />

		<cfset var qDelete = "">
		
			<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	`usermaster`
				WHERE		0=0
				AND		Id = <cfqueryparam value="#arguments.usermaster.getId()#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="usermaster" >
		<cfargument name="usermaster" type="usermaster" required="true" >
	
		<cfif len(arguments.usermaster.getId()) AND arguments.usermaster.getId() NEQ 0 >
			<cfreturn update(arguments.usermaster) >
		<cfelse>
			<cfset arguments.usermaster.setId(0) >
			<cfreturn create(arguments.usermaster) >
		</cfif>
		
	</cffunction>
	
	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="usermaster" type="usermaster" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	`usermaster`
			WHERE		0=0
			AND		Id = <cfqueryparam value="#arguments.usermaster.getId()#" cfsqltype="cf_sql_integer" />
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

