
<cfcomponent displayname="usermasterGateway" output="false">
	
	<cffunction name="init" access="public" output="false" returntype="usermasterGateway">
		<cfargument name="dsn" required="true" inject="coldbox:datasource:demo" />
		<cfset variables.dsn = arguments.dsn.Name >
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="Id" type="numeric" required="false" />
		<cfargument name="firstname" type="string" required="false" />
		<cfargument name="lastname" type="string" required="false" />
		<cfargument name="address1" type="string" required="false" />
		<cfargument name="address2" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="username" type="string" required="false" />
		<cfargument name="password" type="string" required="false" />
		<cfargument name="usertype" type="string" required="false" />
		<cfargument name="createddate" type="date" required="false" />
		<cfargument name="createdby" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","usermaster").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="Id" type="numeric" required="false" />
		<cfargument name="firstname" type="string" required="false" />
		<cfargument name="lastname" type="string" required="false" />
		<cfargument name="address1" type="string" required="false" />
		<cfargument name="address2" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="username" type="string" required="false" />
		<cfargument name="password" type="string" required="false" />
		<cfargument name="usertype" type="string" required="false" />
		<cfargument name="createddate" type="date" required="false" />
		<cfargument name="createdby" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#">
			SELECT	
				usermaster.Id,
				usermaster.firstname,
				usermaster.lastname,
				usermaster.address1,
				usermaster.address2,
				usermaster.city,
				usermaster.state,
				usermaster.country,
				usermaster.username,
				usermaster.password,
				usermaster.usertype,
				usermaster.createddate,
				usermaster.createdby
			FROM `usermaster`
			WHERE 0=0
			<cfif structKeyExists(arguments,"Id") and len(arguments.Id)>
				AND	usermaster.Id = <cfqueryparam value="#arguments.Id#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"firstname") and len(arguments.firstname)>
				AND	usermaster.firstname = <cfqueryparam value="#arguments.firstname#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"lastname") and len(arguments.lastname)>
				AND	usermaster.lastname = <cfqueryparam value="#arguments.lastname#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"address1") and len(arguments.address1)>
				AND	usermaster.address1 = <cfqueryparam value="#arguments.address1#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"address2") and len(arguments.address2)>
				AND	usermaster.address2 = <cfqueryparam value="#arguments.address2#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"city") and len(arguments.city)>
				AND	usermaster.city = <cfqueryparam value="#arguments.city#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"state") and len(arguments.state)>
				AND	usermaster.state = <cfqueryparam value="#arguments.state#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"country") and len(arguments.country)>
				AND	usermaster.country = <cfqueryparam value="#arguments.country#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"username") and len(arguments.username)>
				AND	usermaster.username = <cfqueryparam value="#arguments.username#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"password") and len(arguments.password)>
				AND	usermaster.password = <cfqueryparam value="#arguments.password#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"usertype") and len(arguments.usertype)>
				AND	usermaster.usertype = <cfqueryparam value="#arguments.usertype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"createddate") and len(arguments.createddate)>
				AND	usermaster.createddate = <cfqueryparam value="#arguments.createddate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<cfif structKeyExists(arguments,"createdby") and len(arguments.createdby)>
				AND	usermaster.createdby = <cfqueryparam value="#arguments.createdby#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
				ORDER BY #arguments.orderby#
			</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>
	
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
		<cfargument name="pagesize" default="30">
		<cfargument name="gridsortcolumn" default="Id">
		<cfargument name="gridstartdirection" default="">
		
		<cfset var startrow = (arguments.page-1) * arguments.pagesize>		
		<cfset var gridstruct = structNew()>
		
		<cfquery name="gridstruct.query" datasource="#variables.dsn#">
			SELECT 
				usermaster.Id,
				usermaster.firstname,
				usermaster.lastname,
				usermaster.address1,
				usermaster.address2,
				usermaster.city,
				usermaster.state,
				usermaster.country,
				usermaster.username,
				usermaster.password,
				usermaster.usertype,
				usermaster.createddate,
				usermaster.createdby
			FROM `usermaster` 
			ORDER BY #arguments.gridsortcolumn# #arguments.gridstartdirection#
			LIMIT #StartRow#, #pagesize#
		</cfquery>
		
		<cfquery name="qTotalRecord" datasource="#variables.dsn#">
			SELECT COUNT(*) AS CountAll FROM `usermaster`
		</cfquery>
		
		<cfset gridstruct.totalrowcount=qTotalRecord.countall>
          
		<cfreturn gridstruct>
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

