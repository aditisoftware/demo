<cfcomponent>
	<cfproperty name="columnService" inject="model:columnService" scope="instance">

	<cffunction name="createTable" access="public" description="create table object" output="false" returntype="table">
		<cfargument name="tableName" required="false" type="string">
		<cfargument name="tableType" required="false" type="string">
		<cfargument name="componentName" required="false" type="string">
		<cfargument name="componentUserFriendlyName" required="false" type="string">
		<cfargument name="column" required="false" default="#arrayNew(1)#" type="array">
		
		<cfreturn createObject("component","table").init(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="getTable" access="public" returntype="Table" output="false">
		<cfargument name="tableName" type="string" required="yes" />
		<cfargument name="dsn" type="string" required="yes" />
		<cfscript>
			var objDBMS = instance.adminAPIFacade.getDatasource(arguments.dsn).getDbms();
			var objTable = createObject("component","table").init(argumentCollection = arguments);
			var columns = ArrayNew(1);
			var i = 0;
			objDBMS.setTable(arguments.tableName);
			columns = objDBMS.getTableColumns();
			for(i=1;i<=arrayLen(columns);i=i+1){
				objTable.addColumn(instance.columnService.createColumn(argumentCollection=columns[i]));
			}
			return objTable;
		</cfscript>
	</cffunction>

</cfcomponent>