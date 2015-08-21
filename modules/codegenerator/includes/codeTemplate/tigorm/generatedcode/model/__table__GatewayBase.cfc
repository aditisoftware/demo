<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getprimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getname())>
	</cfif>
</cfloop>
<cfoutput>
<cfif variables.project.getdatabaseType() EQ "mssql">
	<cfset variables.dbCharStart = "[">
	<cfset variables.dbCharEnd = "]">
<cfelseif variables.project.getdatabaseType() EQ "mysql">
	<cfset variables.dbCharStart = "`">
	<cfset variables.dbCharEnd = "`">
<cfelse>
	<cfset variables.dbCharStart = "">
	<cfset variables.dbCharEnd = "">
</cfif>
<%cfcomponent displayname="#variables.table.getComponentName()#Gateway" output="false"%>
	
	<%cffunction name="init" access="public" output="false" returntype="#variables.table.getComponentName()#Gateway"%>
		<%cfargument name="dsn" required="true" inject="coldbox:datasource:#variables.project.getDatasource()#" /%>
		<%cfset variables.dsn = arguments.dsn.getName() %>
		<%cfreturn this /%>
	<%/cffunction%>
	
	<%cffunction name="getByAttributes" access="public" output="false" returntype="array"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfargument name="#column.getName()#" type="#column.getDataType()#" required="false" /%>
		</cfloop><%cfargument name="orderby" type="string" required="false" /%>
		
		<%cfset var qList = getByAttributesQuery(argumentCollection=arguments) /%>		
		<%cfset var arrObjects = arrayNew(1) /%>
		<%cfset var tmpObj = "" /%>
		<%cfset var i = 0 /%>
		<%cfloop from="1" to="%qList.recordCount%" index="i"%>
			<%cfset tmpObj = createObject("component","#variables.table.getComponentName()#").init(argumentCollection=queryRowToStruct(qList,i)) /%>
			<%cfset arrayAppend(arrObjects,tmpObj) /%>
		<%/cfloop%>
				
		<%cfreturn arrObjects /%>
	<%/cffunction%>
	
	<%cffunction name="getByAttributesQuery" access="public" output="false" returntype="query"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfargument name="#column.getName()#" type="#column.getDataType()#" required="false" /%>
		</cfloop><%cfargument name="orderby" type="string" required="false" /%>
		
		<%cfset var qList = "" /%>		
		<%cfquery name="qList" datasource="%variables.dsn%"%>
			SELECT	<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i">#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##variables.table.getTableName()#.#variables.table.getColumns()[i].getName()#<cfif i neq arrayLen(variables.table.getColumns())>,</cfif></cfloop>
			FROM #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			WHERE 0=0<cfloop array="#variables.table.getColumns()#" index="column">#chr(13)##chr(9)##chr(9)##chr(9)#<%cfif structKeyExists(arguments,"#column.getName()#") and len(arguments.#column.getName()#)%>
				AND	#variables.table.getTableName()#.#column.getName()# = <%cfqueryparam value="%arguments.#column.getName()#%" CFSQLType="#column.getcfSqlType()#" /%>
			<%/cfif%></cfloop>
			<%cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)%>
				ORDER BY %arguments.orderby%
			<%/cfif%>
		<%/cfquery%>
		
		<%cfreturn qList /%>
	<%/cffunction%>
	
	<%cffunction name="getBypage" access="public" returntype="any" output="false"%>
		<%cfargument name="page" default="1"%>
		<%cfargument name="pagesize" default="30"%>
		<%cfargument name="gridsortcolumn" default="#listPKs#"%>
		<%cfargument name="gridstartdirection" default=""%>
		<cfif variables.project.getdatabaseType() EQ "mysql">
		<%cfset var startrow = (arguments.page-1) * arguments.pagesize%><cfelse>
		<%cfset var startrow = (arguments.page-1) * arguments.pagesize +1%>
		<%cfset var endrow = startrow + pagesize -1%>
		</cfif>		
		<%cfset var gridstruct = structNew()%>
		<cfif variables.project.getdatabaseType() EQ "mysql">
		<%cfquery name="gridstruct.query" datasource="%variables.dsn%"%>
			SELECT <cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getDisplayInGrid()>#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##variables.table.getTableName()#.#variables.table.getColumns()[i].getName()#</cfif><cfif variables.table.getColumns()[i].getDisplayInGrid() AND variables.table.getColumns()[i].getInputSourceType() EQ "cfc" AND len(variables.table.getColumns()[i].getInputSourceProperty())><cfset prop = deserializejson(variables.table.getColumns()[i].getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>,#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##prop['pktable']#_#variables.table.getColumns()[i].getName()#.#prop['label']# AS #variables.table.getColumns()[i].getName()#_#prop['label']#</cfif></cfif><cfif i neq arrayLen(variables.table.getColumns())>,</cfif></cfloop>
			FROM #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid() AND column.getInputSourceType() EQ "cfc" AND len(column.getInputSourceProperty())><cfset prop = deserializejson(column.getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>
			LEFT JOIN #variables.dbCharStart##prop['pktable']##variables.dbCharEnd# AS #prop['pktable']#_#column.getName()# ON #variables.table.getTableName()#.#column.getName()# = #prop['pktable']#_#column.getName()#.#prop['value']#</cfif></cfif></cfloop>
			ORDER BY %arguments.gridsortcolumn% %arguments.gridstartdirection%
			LIMIT %StartRow%, %pagesize%
		<%/cfquery%>
		<cfelse>
		<%cfquery name="gridstruct.query" datasource="%variables.dsn%"%>
			WITH Page#variables.table.getTableName()# AS 
			( 
				SELECT <cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid()>#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)#tbl.#column.getName()#,</cfif><cfif column.getDisplayInGrid() AND column.getInputSourceType() EQ "cfc" AND len(column.getInputSourceProperty())><cfset prop = deserializejson(column.getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##prop['pktable']#_#column.getName()#.#prop['label']# AS #column.getName()#_#prop['label']#,</cfif></cfif></cfloop>
				ROW_NUMBER() OVER(ORDER BY %arguments.gridsortcolumn% %arguments.gridstartdirection%) AS RowNumber 
				FROM #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd# tbl
				<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid() AND column.getInputSourceType() EQ "cfc" AND len(column.getInputSourceProperty())><cfset prop = deserializejson(column.getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>
				LEFT JOIN #variables.dbCharStart##prop['pktable']##variables.dbCharEnd# AS #prop['pktable']#_#column.getName()# ON tbl.#column.getName()# = #prop['pktable']#_#column.getName()#.#prop['value']#</cfif></cfif></cfloop>
			) 
			SELECT <cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif column.getDisplayInGrid()>#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)#Page#variables.table.getTableName()#.#variables.table.getColumns()[i].getName()#</cfif><cfif variables.table.getColumns()[i].getDisplayInGrid() AND column.getInputSourceType() EQ "cfc" AND len(variables.table.getColumns()[i].getInputSourceProperty())><cfset prop = deserializejson(variables.table.getColumns()[i].getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>,#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##prop['pktable']#_#variables.table.getColumns()[i].getName()#.#prop['label']# AS #variables.table.getColumns()[i].getName()#_#prop['label']#</cfif></cfif><cfif i neq arrayLen(variables.table.getColumns())>,</cfif></cfloop>
			FROM Page#variables.table.getTableName()#
			<cfloop array="#variables.table.getColumns()#" index="column">
				<cfif column.getDisplayInGrid() AND column.getInputSourceType() EQ "cfc" AND len(column.getInputSourceProperty())>
					<cfset prop = deserializejson(column.getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>
			LEFT JOIN #prop['pktable']# AS #prop['pktable']#_#column.getName()# ON Page#variables.table.getTableName()#.#column.getName()# = #prop['pktable']#_#column.getName()#.#prop['value']#</cfif>
				</cfif>
			</cfloop>
			WHERE RowNumber >= %StartRow% AND RowNumber <= %EndRow%
			ORDER BY %arguments.gridsortcolumn% %arguments.gridstartdirection%
		<%/cfquery%>
		</cfif>
		<%cfquery name="qTotalRecord" datasource="%variables.dsn%"%>
			SELECT COUNT(*) AS CountAll FROM #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
		<%/cfquery%>
		
		<%cfset gridstruct.totalrowcount=qTotalRecord.countall%>
          
		<%cfreturn gridstruct%>
	<%/cffunction%>

	<%cffunction name="queryRowToStruct" access="private" output="false" returntype="struct"%>
		<%cfargument name="qry" type="query" required="true"%>
		
		<%cfscript%>
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
		<%/cfscript%>
	<%/cffunction%>
	
<%/cfcomponent%>
</cfoutput>