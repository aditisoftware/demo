<cfoutput>
<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes"><cfset listPKs = ListAppend(listPKs, column.getname())></cfif></cfloop>
<%cfcomponent name="#variables.table.getComponentName()#Service" output="false" cache="true" cachetimeout="30">
	<%cfproperty name="#variables.table.getComponentName()#DAO" inject="model:#variables.table.getComponentName()#DAO" scope="instance" /%>
	<%cfproperty name="#variables.table.getComponentName()#Gateway" inject="model:#variables.table.getComponentName()#Gateway" scope="instance" /%>
	
	<%cffunction name="init" access="public" output="false" returntype="#variables.table.getComponentName()#Service"%>
		<%cfreturn this/%>
	<%/cffunction%>

	<%cffunction name="create#variables.table.getComponentName()#" access="public" output="false" returntype="#variables.table.getComponentName()#"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfargument name="#column.getName()#" type="string" required="false" /%>
		</cfloop>
		<%cfset var m#variables.table.getComponentName()# = createObject("component","#variables.table.getComponentName()#").init(argumentCollection=arguments) /%>
		<%cfreturn m#variables.table.getComponentName()# /%>
	<%/cffunction%>
	
	<%cffunction name="delete#variables.table.getComponentName()#" access="public" output="false" returntype="struct"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes"><%cfargument name="#column.getName()#" type="#column.getDataType()#" required="true" /%>
		</cfif></cfloop>
		<%cfset var retStruct = structNew()%>
		<%cfset var structErr = structNew()%>
		<%cfset var #variables.table.getComponentName()# = "" %>

		<%cfset retStruct.success = true%>
		<%cfset retStruct.errors = arrayNew(1)%>
		<%cftry%>
			<%cfset #variables.table.getComponentName()# = create#variables.table.getComponentName()#(argumentCollection=arguments) /%>
			<%cfset instance.#variables.table.getComponentName()#DAO.delete(#variables.table.getComponentName()#) /%>
		<%cfcatch%>
			<%cfset retStruct.success = false%>
			<%cfset structErr = structNew()%>
			<%cfset structErr["errorCode"] = "dbException"%>
			<%cfset structErr["message"] = cfcatch.message%>
			<%cfset arrayAppend(retStruct.errors,duplicate(structErr))%>
		<%/cfcatch%>
		<%/cftry%>
		<%cfreturn retStruct /%>
	<%/cffunction%>
	
	<%cffunction name="get#variables.table.getComponentName()#" access="public" output="false" returntype="#variables.table.getComponentName()#"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes"><%cfargument name="#column.getName()#" type="<cfif column.getDataType() EQ "uuid">string<cfelse>#column.getDataType()#</cfif>" required="true" /%>
		</cfif></cfloop>
		<%cfset var #variables.table.getComponentName()# = create#variables.table.getComponentName()#(argumentCollection=arguments) /%>
		<%cfset instance.#variables.table.getComponentName()#DAO.read(#variables.table.getComponentName()#) /%>
		<%cfreturn #variables.table.getComponentName()# /%>
	<%/cffunction%>
	
	<%cffunction name="get#variables.table.getComponentName()#s" access="public" output="false" returntype="any"%>
		<%cfargument name="datatype" type="string" required="false" default="query" hint="query or array" %>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfargument name="#column.getName()#" type="#column.getDataType()#" required="false" /%>
		</cfloop>
		<%cfif arguments.datatype eq "query"%>
			<%cfreturn instance.#variables.table.getComponentName()#Gateway.getByAttributesQuery(argumentCollection=arguments) /%>
		<%cfelse%>
			<%cfreturn instance.#variables.table.getComponentName()#Gateway.getByAttributes(argumentCollection=arguments) /%>
		<%/cfif%>
	<%/cffunction%>
	
	<%cffunction name="getBypage" access="public" returntype="any" output="false"%>
		<%cfargument name="page" default="1"%>
	    <%cfargument name="pagesize" default="30"%>
	    <%cfargument name="gridsortcolumn" default="#listPKs#"%>
	    <%cfargument name="gridstartdirection" default=""%>
		
		<%cfreturn instance.#variables.table.getComponentName()#Gateway.getBypage(argumentCollection=arguments) /%>
		
	<%/cffunction%>
	
	<%cffunction name="save#variables.table.getComponentName()#" access="public" output="false" returntype="struct"%>
		<%cfargument name="#variables.table.getComponentName()#" type="#variables.table.getComponentName()#" required="true" /%>
		<%cfset var retStruct = structNew()%>
		<%cfset var structErr = structNew()%>
		<%cfset var retArray = ""%>

		<%cfset retStruct.success = true%>
		<%cfset retStruct.errors = arrayNew(1)%>
		<%cfset retArray = arguments.#variables.table.getComponentName()#.validate()%>
		<%cfif arrayIsEmpty(retArray)%>
			<%cfset retStruct.#variables.table.getComponentName()# = instance.#variables.table.getComponentName()#DAO.save(#variables.table.getComponentName()#) /%>
		<%cfelse%>
			<%cfset retStruct.success = false%> 
			<%cfset retStruct.errors = retArray /%>
		<%/cfif%>
		<%cfreturn retStruct /%>
		
	<%/cffunction%>
<%/cfcomponent%>
</cfoutput>