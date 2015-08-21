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
<cfoutput>
<cfset arrPKs = ArrayNew(1)>
<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes"><cfset ArrayAppend(arrPKs, column.getname())></cfif></cfloop>
<%cfcomponent displayname="#variables.table.getComponentName()#DAO"%>

	<%cffunction name="init" access="public" output="false" returntype="#variables.table.getComponentName()#DAO"%>
		<%cfargument name="dsn" required="true" inject="coldbox:datasource:#variables.project.getDatasource()#" /%>
		
		<%cfset variables.dsn = arguments.dsn.Name %>
		<%cfreturn this%>
	<%/cffunction%>
	
	<%cffunction name="create" access="public" output="false" returntype="#variables.table.getComponentName()#"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>
		
		<cfif variables.project.getdatabaseType() EQ "mssql">
			<%cfset var qCreate = "" /%>
			<%cfquery name="qCreate" datasource="%variables.dsn%"%>
				INSERT INTO #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd# (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif NOT variables.table.getColumns()[i].getIdentity()>
						#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)##variables.table.getColumns()[i].getName()#<cfif i neq ArrayLen(variables.table.getColumns())>,</cfif></cfif></cfloop>)
				VALUES (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif NOT variables.table.getColumns()[i].getIdentity()>
						#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getName()#()%" cfsqltype="#variables.table.getColumns()[i].getcfSqlType()#" <cfif ListFindNoCase("cf_sql_decimal,cf_sql_numeric","#variables.table.getColumns()[i].getcfSqlType()#") and val(variables.table.getColumns()[i].getNumeric_Scale())>scale="#variables.table.getColumns()[i].getNumeric_Scale()#" </cfif><cfif variables.table.getColumns()[i].getrequired() neq "Yes">null="%not len(arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getName()#())%"</cfif> /%><cfif i neq ArrayLen(variables.table.getColumns())>,</cfif></cfif></cfloop>
				)
				<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes" AND column.getIdentity() eq "Yes">SELECT @@identity AS #column.getname()#</cfif></cfloop>
			<%/cfquery%>
			<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes" AND column.getIdentity() eq "Yes"><%cfset arguments.#variables.table.getComponentName()#.set#column.getname()#(qCreate.#column.getname()#) %></cfif></cfloop>
		</cfif>
		<cfif variables.project.getdatabaseType() EQ "mysql">
		<%cfset var qCreate = "" /%>
		<%cfset var qID = "" /%>
		<%cftransaction%>
			<%cfquery name="qCreate" datasource="%variables.dsn%"%>
				INSERT INTO #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd# (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif NOT variables.table.getColumns()[i].getIdentity()>
						#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)##variables.table.getColumns()[i].getName()#<cfif i neq ArrayLen(variables.table.getColumns())>,</cfif></cfif></cfloop>)
				VALUES (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif NOT variables.table.getColumns()[i].getIdentity()>
						#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##chr(9)#<%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getName()#()%" cfsqltype="#variables.table.getColumns()[i].getcfSqlType()#" <cfif ListFindNoCase("cf_sql_decimal,cf_sql_numeric","#variables.table.getColumns()[i].getcfSqlType()#") and val(variables.table.getColumns()[i].getNumeric_Scale())>scale="#variables.table.getColumns()[i].getNumeric_Scale()#" </cfif><cfif variables.table.getColumns()[i].getrequired() neq "Yes">null="%not len(arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getName()#())%"</cfif> /%><cfif i neq ArrayLen(variables.table.getColumns())>,</cfif></cfif></cfloop>
				)
			<%/cfquery%>
			<cfloop array="#variables.table.getColumns()#" index="column">
			<cfif column.getPrimaryKey() eq "Yes" AND column.getIdentity() eq "Yes">
			<%cfquery name="qID" datasource="%variables.dsn%"%>
				SELECT LAST_INSERT_ID() AS #column.getname()#
			<%/cfquery%>
			</cfif>
			</cfloop>
			<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes" AND column.getIdentity() eq "Yes"><%cfset arguments.#variables.table.getComponentName()#.set#column.getname()#(qID.#column.getname()#) %></cfif></cfloop>
		<%/cftransaction%>
		</cfif>
		<%cfreturn arguments.#variables.table.getComponentName()# /%>
	<%/cffunction%>
	
	<%cffunction name="read" access="public" output="false" returntype="void"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>

		<%cfset var qRead = "" /%>
		<%cfset var strReturn = structNew() /%>
		
		<%cfquery name="qRead" datasource="%variables.dsn%"%>
			SELECT	<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i">#variables.table.getColumns()[i].getname()#<cfif i neq ArrayLen(variables.table.getColumns())>,</cfif></cfloop>
			FROM #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			WHERE 0=0 <cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes">#chr(13)#			AND #column.getname()# = <%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#column.getname()#()%" cfsqltype="#column.getcfSqlType()#" /%></cfif></cfloop>
		<%/cfquery%>
	
		<%cfif qRead.recordCount%>
			<%cfset strReturn = queryRowToStruct(qRead)%>
			<%cfset arguments.#variables.table.getComponentName()#.init(argumentCollection=strReturn)%>
		<%/cfif%>
	<%/cffunction%>
	
	<%cffunction name="update" access="public" output="false" returntype="#variables.table.getComponentName()#"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>

		<%cfset var qUpdate = "" /%>
		<%cfquery name="qUpdate" datasource="%variables.dsn%"%>
			UPDATE #variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			SET <cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() neq "Yes" and NOT variables.table.getColumns()[i].getidentity()>
				#chr(13)##chr(9)##chr(9)##chr(9)##chr(9)##variables.table.getColumns()[i].getname()# = <%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getname()#()%" cfsqltype="#variables.table.getColumns()[i].getcfSqlType()#" <cfif ListFindNoCase("cf_sql_decimal,cf_sql_numeric","#variables.table.getColumns()[i].getcfSqlType()#") and val(variables.table.getColumns()[i].getNumeric_Scale())>scale="#variables.table.getColumns()[i].getNumeric_Scale()#" </cfif><cfif variables.table.getColumns()[i].getrequired() neq "Yes">null="%not len(arguments.#variables.table.getComponentName()#.get#variables.table.getColumns()[i].getname()#())%"</cfif> /%><cfif i neq ArrayLen(variables.table.getColumns())>,</cfif>
						</cfif></cfloop>
			WHERE 0=0 <cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes">#chr(13)#			AND #column.getname()# = <%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#column.getname()#()%" cfsqltype="#column.getcfSqlType()#" /%></cfif></cfloop>
		<%/cfquery%>
		<%cfreturn arguments.#variables.table.getComponentName()# /%>
	<%/cffunction%>
	
	<%cffunction name="delete" access="public" output="false" returntype="boolean"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>

		<%cfset var qDelete = ""%>
		<%cfquery name="qDelete" datasource="%variables.dsn%"%>
			DELETE FROM	#variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			WHERE 0=0 <cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes">#chr(13)#			AND #column.getname()# = <%cfqueryparam value="%arguments.#variables.table.getTableName()#.get#column.getname()#()%" cfsqltype="#column.getcfSqlType()#" /%></cfif></cfloop>
		<%/cfquery%>
		<%cfreturn true /%>
	<%/cffunction%>
	
	<%cffunction name="save" access="public" output="false" returntype="#variables.table.getComponentName()#" %>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" %>
	<cfif ArrayLen(arrPKs) EQ 1> <!--- Only one PK --->
		<cfset identityExist = false>
		<cfset uuidExist = false>
		<cfset pkName = "">
		<cfloop array="#variables.table.getColumns()#" index="column">
			<cfif column.getPrimaryKey() EQ "Yes">
				<cfif column.getIdentity()>
					<cfset identityExist = true>
					<cfset pkName = column.getName()>
					<cfbreak>
				<cfelseif column.getDataType() EQ "uuid">
					<cfset uuidExist = true>
					<cfset pkName = column.getName()>
					<cfbreak>
				<cfelse>
					<cfset pkName = column.getName()>
					<cfbreak>
				</cfif>
			</cfif>
		</cfloop>
		<cfif identityExist>
		<%cfif len(arguments.#variables.table.getComponentName()#.get#pkName#()) AND arguments.#variables.table.getComponentName()#.get#pkName#() NEQ 0 %>
			<%cfreturn update(arguments.#variables.table.getComponentName()#) %>
		<%cfelse%>
			<%cfset arguments.#variables.table.getComponentName()#.set#pkName#(0) %>
			<%cfreturn create(arguments.#variables.table.getComponentName()#) %>
		<%/cfif%>
		<cfelseif uuidExist>
		<%cfif len(arguments.#variables.table.getComponentName()#.get#pkName#()) %>
			<%cfreturn update(arguments.#variables.table.getComponentName()#) %>
		<%cfelse%>
			<%cfset arguments.#variables.table.getComponentName()#.set#pkName#(CreateUUID()) %>
			<%cfreturn create(arguments.#variables.table.getComponentName()#) %>
		<%/cfif%>
		<cfelse>
		<%cfif exists(argumentCollection=arguments) %>
			<%cfreturn update(arguments.#variables.table.getComponentName()#) %>
		<%cfelse%>
			<%cfset arguments.#variables.table.getComponentName()#.set#pkName#(CreateUUID()) %>
			<%cfreturn create(arguments.#variables.table.getComponentName()#) %>
		<%/cfif%>
		</cfif>
	<cfelse> <!--- More than one PK, we are not considering a table without PK! --->
		<%cfif exists(argumentCollection=arguments) %>
			<%cfreturn update(arguments.#variables.table.getComponentName()#) %>
		<%cfelse%>
			<%cfreturn create(arguments.#variables.table.getComponentName()#) %>
		<%/cfif%>
	</cfif>
	<%/cffunction%>
	
	<%cffunction name="exists" access="public" output="false" returntype="boolean"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>

		<%cfset var qExists = ""%>
		<%cfquery name="qExists" datasource="%variables.dsn%" maxrows="1"%>
			SELECT count(1) as idexists
			FROM	#variables.dbCharStart##variables.table.getTableName()##variables.dbCharEnd#
			WHERE		0=0<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes">#chr(13)#			AND #column.getname()# = <%cfqueryparam value="%arguments.#variables.table.getComponentName()#.get#column.getname()#()%" cfsqltype="#column.getcfSqlType()#" /%></cfif></cfloop>
		<%/cfquery%>

		<%cfif qExists.idexists%>
			<%cfreturn true /%>
		<%cfelse%>
			<%cfreturn false /%>
		<%/cfif%>
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