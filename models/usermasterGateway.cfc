
<cfcomponent name="usermasterGateway" output="false" cache="true" cachetimeout="0" extends="usermasterGatewayBase">
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
		<cfargument name="pagesize" default="30">
		<cfargument name="gridsortcolumn" default="Id">
		<cfargument name="gridstartdirection" default="">
		<cfargument name="searchname" default="" />
		<cfargument name="searchcity" default="" />
		<cfargument name="searchusertype" default="" />

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
			FROM `usermaster` where 1 = 1
			<cfif structKeyExists(arguments,"searchname") and len(arguments.searchname)>
				AND	(
					usermaster.firstname like <cfqueryparam value="%#arguments.searchname#%" CFSQLType="cf_sql_varchar" />
					OR 
					usermaster.lastname like <cfqueryparam value="%#arguments.searchname#%" CFSQLType="cf_sql_varchar" />
					OR 
					usermaster.username like <cfqueryparam value="%#arguments.searchname#%" CFSQLType="cf_sql_varchar" />
				)
			</cfif>
			<cfif structKeyExists(arguments,"searchcity") and len(arguments.searchcity)>
				AND	usermaster.city like <cfqueryparam value="%#arguments.searchcity#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"searchusertype") and len(arguments.searchusertype)>
				AND	usermaster.usertype = <cfqueryparam value="#arguments.searchusertype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			ORDER BY #arguments.gridsortcolumn# #arguments.gridstartdirection#
			LIMIT #StartRow#, #pagesize#
		</cfquery>
		
		<cfquery name="qTotalRecord" datasource="#variables.dsn#">
			SELECT COUNT(*) AS CountAll FROM `usermaster`where 1 = 1
			<cfif structKeyExists(arguments,"searchname") and len(arguments.searchname)>
				AND	(
					usermaster.firstname like <cfqueryparam value="%#arguments.firstname#%" CFSQLType="cf_sql_varchar" />
					OR 
					usermaster.lastname like <cfqueryparam value="%#arguments.lastname#%" CFSQLType="cf_sql_varchar" />
					OR 
					usermaster.username like <cfqueryparam value="%#arguments.username#%" CFSQLType="cf_sql_varchar" />
				)
			</cfif>
			<cfif structKeyExists(arguments,"searchcity") and len(arguments.searchcity)>
				AND	usermaster.city like <cfqueryparam value="%#arguments.searchcity#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"searchusertype") and len(arguments.searchusertype)>
				AND	usermaster.usertype = <cfqueryparam value="#arguments.searchusertype#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfquery>
		
		<cfset gridstruct.totalrowcount=qTotalRecord.countall>
          
		<cfreturn gridstruct>		
	</cffunction>
</cfcomponent>

