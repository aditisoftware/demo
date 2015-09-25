<cfcomponent name="inqueryGateway" output="false" cache="true" cachetimeout="30" extends="inqueryGatewayBase">
	<cffunction name="getTourtype" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT * FROM tourtype 
		</cfquery>
		<cfreturn list>
	</cffunction>

	<cffunction name="getYesterdayInquiryCount" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT count(*) as count FROM inquery where 1 = 1 and createddate > <cfqueryparam value="#dateadd("d",-1,now())#" CFSQLType="cf_sql_timestamp" />
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getLastMonthInquiryCount" access="public" returntype="any" output="false">
		<cfset firstOfThisMonth = createDate(year(now()), month(now())-1, 1)> 
		<cfset lastOfNextMonth = dateAdd("d", -1, dateAdd("m", 1, firstOfThisMonth))> 
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT count(*) as count FROM inquery where 1 = 1 
			and createddate >= <cfqueryparam value="#firstOfThisMonth#" CFSQLType="cf_sql_timestamp" />
			and createddate <= <cfqueryparam value="#lastOfNextMonth#" CFSQLType="cf_sql_timestamp" />
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getCurrentYearInquiryCount" access="public" returntype="any" output="false">
		<cfset firstOfThisYear = createDate(year(now()), month(now())-1, 1)> 
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT * FROM inquery where 1 = 1 
			and createddate >= <cfqueryparam value="#firstOfThisYear#" CFSQLType="cf_sql_timestamp" />
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getTotalInquiryCount" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT count(*) as cnt FROM inquery where 1 = 1
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getRecentInqList" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT * FROM inquery 
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
			order by id desc limit 25
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getTop10AgentInquery" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT username,cnt FROM (
				SELECT (SELECT CONCAT(firstname," ",lastname) FROM `usermaster` WHERE id = inquery.createdby) AS username ,COUNT(*) AS cnt FROM inquery GROUP BY createdby
			)test ORDER BY cnt DESC LIMIT 10
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getqLast5MonthInquery" access="public" returntype="any" output="false">
		<cfset firstOfThisMonth = createDate(year(now()), month(now())-5, 1)> 
		<cfset lastOfNextMonth = dateAdd("d", -1, dateAdd("m", 1, firstOfThisMonth))> 
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT * FROM inquery where 1 = 1 
			and createddate >= <cfqueryparam value="#firstOfThisMonth#" CFSQLType="cf_sql_timestamp" />
			and createddate <= <cfqueryparam value="#lastOfNextMonth#" CFSQLType="cf_sql_timestamp" />
			<cfif StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype neq "superadmin">
				and createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getAgentLast5DayInquery" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT DATE_FORMAT(createddate,'%m-%d-%Y') as createdon,COUNT(*) AS cnt FROM inquery where createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" /> GROUP BY createdon  ORDER BY createdon DESC limit 5
		</cfquery>
		<cfreturn list>
	</cffunction>
	<cffunction name="getAgentLast6MonthInquery" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT DATE_FORMAT(createddate,'%M') AS createdon,COUNT(*) AS cnt FROM inquery WHERE createdby = <cfqueryparam value="#Session.userid#" CFSQLType="cf_sql_integer" /> GROUP BY createdon  ORDER BY id ASC LIMIT 6
		</cfquery>
		<cfreturn list>
	</cffunction>
</cfcomponent>

