<cfcomponent name="datasource" displayname="datasource" hint="a datasource bean">
	<cffunction name="init" access="public" output="false" returntype="datasource">
		<cfargument name="dsnName" type="string" required="true" inject="coldbox:setting:datasource@codegenerator" />
		<cfargument name="adminPass" type="string" required="true" inject="coldbox:setting:adminPassword@codegenerator"/>
		<cfargument name="tableService" inject="model:Tableservice" scope="variables">
		<cfargument name="columnService" inject="model:ColumnService" scope="variables">
		<!--- TODO: Error Handling --->
		<cfset variables.administrator = createObject("component","cfide.adminapi.administrator").login(arguments.adminPass) />
		<cfset variables.dsProperty = createObject("component","cfide.adminapi.datasource").getDataSources(arguments.dsnName) />
		<cfset variables.tableService = arguments.tableService>
		<cfset variables.columnService = arguments.columnService>
		<cfset setDsnName(arguments.dsnName) />
		<cfset setDsnType(driverOrClassToType(variables.dsProperty)) />
		<cfset setDbms() />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setDsnName" access="public" output="false" returntype="void">
		<cfargument name="dsnName" type="string" required="false" default="" />
		
		<cfset variables.dsnName = arguments.dsnName />
	</cffunction>
	<cffunction name="getDsnName" access="public" output="false" returntype="string">
		<cfreturn variables.dsnName />
	</cffunction>
	
	<cffunction name="setDsnType" access="public" output="false" returntype="void">
		<cfargument name="dsnType" type="string" required="false" default="" />
		
		<cfset variables.dsnType = arguments.dsnType />
	</cffunction>
	<cffunction name="getDsnType" access="public" output="false" returntype="string">
		<cfreturn variables.dsnType />
	</cffunction>
	
	<cffunction name="setDbms" access="public" output="false" returntype="void">
		<cfset var injector = createObject("component","coldbox.system.ioc.Injector").init()>
		<cfset variables.dbms = createObject("component","#dsntype#").init(getDsnName(),variables.tableService,variables.columnService) />
	</cffunction>
	<cffunction name="getDbms" access="public" output="false" returntype="any">
		<cfreturn variables.dbms />
	</cffunction>
	
	<cffunction name="driverOrClassToType" access="private" output="false" returntype="string">
		<cfargument name="datasource" required="true" type="struct" />

		<cfif ((arguments.datasource.driver eq "MSSQLServer")  or (arguments.datasource.class contains "MSSQLServer"))>
			<cfreturn "mssql" />
		<cfelseif ((arguments.datasource.driver contains "mySQL") or (arguments.datasource.class contains "mySQL"))>
			<cfreturn "mysql" />
		<cfelseif ((arguments.datasource.driver contains "Oracle") or (arguments.datasource.class contains "Oracle"))>
			<cfreturn "oracle" />
		<cfelseif ((arguments.datasource.driver contains "Informix") or (arguments.datasource.class contains "Informix"))>
			<cfreturn "informix" />
		<cfelseif ((arguments.datasource.driver contains "Postgres") or (arguments.datasource.class contains "postgresql"))>
			<cfreturn "postgresql" />
		<!--- if you are running cf8 we can try to leverage db metadata tags --->
		<cfelseif listFirst(server.coldfusion.ProductVersion) gte 8 and arguments.datasource.driver neq "MSAccess"><!--- only access with unicode seems to work with dbinfo --->
			<cfreturn "scorpio" />
		<cfelse><!--- not a supported type --->
			<cfreturn "" />
		</cfif>
	</cffunction>

</cfcomponent>