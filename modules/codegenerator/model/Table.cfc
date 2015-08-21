<cfcomponent>

	<cfproperty name="tableName" default="" type="string">
	<cfproperty name="componentName" default="" type="string">
	<cfproperty name="componentUserFriendlyName" default="" type="string">
	<cfproperty name="tableType" default="" type="string">
	<cfproperty name="columns" type="Array">
	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="Table">
		<cfargument name="tableName" default="" required="false" type="string" />
		<cfargument name="componentName" default="" required="false" type="String" />
		<cfargument name="componentUserFriendlyName" default="" required="false" type="String" />
		<cfargument name="tableType" default="" required="false" type="string">
		<cfargument name="columns" default="#ArrayNew(1)#" required="false" type="Array" />
		<cfscript>
			variables.instance.tableName = arguments.tableName;
			variables.instance.componentName = arguments.componentName;
			variables.instance.componentUserFriendlyName = arguments.componentUserFriendlyName;
			variables.instance.columns = arguments.columns;
			variables.instance.tableType = arguments.tableType;
			return this;
		</cfscript>
	</cffunction>


	<cffunction name="getMeta" access="public" returntype="struct" output="false" >
		<cfreturn  getMetaData(this)/>
	</cffunction>


	<cffunction name="setMemento" access="public" returntype="table" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>


	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>


	<cffunction name="gettableName" access="public" output="false" returntype="String">
		<cfreturn trim(variables.instance.tableName)>
	</cffunction>


	<cffunction name="settableName" access="public" output="false" returntype="void">
		<cfargument name="mtableName" type="String">
		<cfset variables.instance.tableName = trim(arguments.mtableName)>
	</cffunction>


	<cffunction name="setTableType" access="public" returntype="void" output="false">
		<cfargument name="TableType" type="String" required="true" />
		<cfset variables.instance.colname = trim(arguments.TableType) />
	</cffunction>


	<cffunction name="getTableType" access="public" returntype="String" output="false">
		<cfreturn variables.instance.TableType />
	</cffunction>


	<cffunction name="getColumns" access="public" output="false" returntype="Array">
		<cfreturn variables.instance.Columns>
	</cffunction>


	<cffunction name="setColumns" access="public" output="false" returntype="void">
		<cfargument name="mColumns" type="Array">
		<cfset variables.instance.Columns = arguments.mColumns>
	</cffunction>


	<cffunction name="addColumn" access="public" output="false" returntype="void">
		<cfargument name="mColumn" type="Column">
		<cfset ArrayAppend(variables.instance.Columns,arguments.mColumn)>
	</cffunction>


	<cffunction name="getcomponentName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.componentName>
	</cffunction>


	<cffunction name="setcomponentName" access="public" output="false" returntype="void">
		<cfargument name="mcomponentName" type="string">
		<cfset variables.instance.componentName = arguments.mcomponentName>
	</cffunction>


	<cffunction name="getcomponentUserFriendlyName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.componentUserFriendlyName>
	</cffunction>


	<cffunction name="setcomponentUserFriendlyName" access="public" output="false" returntype="void">
		<cfargument name="mcomponentUserFriendlyName" type="string">
		<cfset variables.instance.componentUserFriendlyName = arguments.mcomponentUserFriendlyName>
	</cffunction>


</cfcomponent>
