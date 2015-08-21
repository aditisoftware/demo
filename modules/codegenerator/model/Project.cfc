<cfcomponent>
	<cfproperty name="projectName" default="" type="string">
	<cfproperty name="datasource" default="" type="string">
	<cfproperty name="databaseType" default="" type="string">
	<cfproperty name="tables" type="Array">

	<cfset variables.instance = structNew()>
	<cffunction name="init" access="public" output="false" returntype="Project">
		<cfargument name="projectName" default="" required="false" type="string" />
		<cfargument name="datasource" default="" required="false" type="string" />
		<cfargument name="databaseType" required="false" default="" type="string" />
		<cfargument name="tables" required="false" default="#arrayNew(1)#" type="array" />
		<cfscript>
			variables.instance.projectName = arguments.projectName;
			variables.instance.datasource = arguments.datasource;
			variables.instance.databaseType = arguments.databaseType;
			variables.instance.tables = arguments.tables;

			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="setMemento" access="public" returntype="Project" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>

	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="getMeta" access="public" returntype="struct" output="false" >
		<cfreturn  getMetaData(this)/>
	</cffunction>

	<cffunction name="getProjectName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.ProjectName>
	</cffunction>

	<cffunction name="setProjectName" access="public" output="false" returntype="void">
		<cfargument name="mProjectName" type="string">
		<cfset variables.instance.ProjectName = arguments.mProjectName>
	</cffunction>

	<cffunction name="getDatasource" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Datasource>
	</cffunction>

	<cffunction name="setDatasource" access="public" output="false" returntype="void">
		<cfargument name="mDatasource" type="string">
		<cfset variables.instance.Datasource = arguments.mDatasource>
	</cffunction>

	<cffunction name="getTables" access="public" output="false" returntype="Array">
		<cfreturn variables.instance.Tables>
	</cffunction>

	<cffunction name="setTables" access="public" output="false" returntype="void">
		<cfargument name="mTables" type="Array">
		<cfset variables.instance.Tables = arguments.mTables>
	</cffunction>

	<cffunction name="addTable" access="public" output="false" returntype="void">
		<cfargument name="mTable" type="Table">
		<cfset ArrayAppend(variables.instance.Tables,arguments.mTable)>
	</cffunction>

	<cffunction name="setDatabaseType" access="public" returntype="void" output="false">
		<cfargument name="DatabaseType" type="string" required="true" />
		<cfset variables.instance.DatabaseType = trim(arguments.DatabaseType) />
	</cffunction>
	<cffunction name="getDatabaseType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DatabaseType />
	</cffunction>
</cfcomponent>