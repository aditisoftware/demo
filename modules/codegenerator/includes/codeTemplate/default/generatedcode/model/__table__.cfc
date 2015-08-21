<cfoutput>
<%cfcomponent displayname="#variables.table.getComponentName()#" output="false"%>
	<cfloop array="#variables.table.getColumns()#" index="column"><%cfproperty name="#column.getName()#" type="<cfif column.getDataType() EQ "uuid">string<cfelse>#column.getDataType()#</cfif>" default="<cfif column.getdefaultValue() neq "CURRENT_TIMESTAMP">#column.getdefaultValue()#</cfif>" /%>
	</cfloop>
	<%!---
	PROPERTIES
	---%>
	<%cfset variables.instance = StructNew() /%>

	<%!---
	INITIALIZATION / CONFIGURATION
	---%>
	<%cffunction name="init" access="public" returntype="#variables.table.getComponentName()#" output="false"%>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfargument name="#column.getName()#" type="string" default="<cfif column.getdefaultValue() neq "CURRENT_TIMESTAMP">#column.getdefaultValue()#<cfelse>##Now()##</cfif>" /%>
		</cfloop>
		<%!--- run setters ---%>
		<cfloop array="#variables.table.getColumns()#" index="column"><%cfset set#column.getName()#(arguments.#column.getName()#) /%>
		</cfloop>
		<%cfreturn this /%>
 	<%/cffunction%>

	<%!---
	PUBLIC FUNCTIONS
	---%>
	<%cffunction name="setMemento" access="public" returntype="#variables.table.getComponentName()#" output="false"%>
		<%cfargument name="memento" type="struct" required="yes"/%>
		<%cfset variables.instance = arguments.memento /%>
		<%cfreturn this /%>
	<%/cffunction%>
	<%cffunction name="getMemento" access="public" returntype="struct" output="false" %>
		<%cfreturn variables.instance /%>
	<%/cffunction%>
	
	<%cffunction name="validate" access="public" returntype="array" output="false"%>
		<%cfset var errors = arrayNew(1) /%>
		<%cfset var thisError = structNew() /%>
		<cfloop array="#variables.table.getColumns()#" index="column">
			<cfloop array="#column.getValidators()#" index="validator">
				<cfswitch expression="#validator.getNAME()#">
		<cfcase value="required"><cfif #column.getIdentity()# NEQ true>
		<%cfif (NOT len(trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "required" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%></cfif>
		</cfcase>
		<cfcase value="email">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("email",trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "email" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="url">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("url",trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "url" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="creditcard">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("creditcard",trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "creditcard" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="maxlength">
		<%cfif len(trim(get#column.getName()#())) AND (len(trim(get#column.getName()#())) GT #validator.getValue()#) %>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "maxlength" /%>
			<%cfset thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="minlength">
		<%cfif len(trim(get#column.getName()#())) AND (len(trim(get#column.getName()#())) LT #validator.getValue()#) %>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "minlength" /%>
			<%cfset thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="number">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("float",trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "number" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="digits">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#())))%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "digits" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="max">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#()))) AND (trim(get#column.getName()#()) GT #validator.getValue()#)%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "max" /%>
			<%cfset thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="min">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#()))) AND (trim(get#column.getName()#()) LT #validator.getValue()#)%>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "min" /%>
			<%cfset thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		<cfcase value="date">
		<%cfif len(trim(get#column.getName()#())) AND (NOT isvalid("date",trim(get#column.getName()#()))) %>
			<%cfset thisError.field = "#column.getName()#" /%>
			<%cfset thisError.type = "date" /%>
			<%cfset thisError.message = "#validator.getErrorMessage()#" /%>
			<%cfset arrayAppend(errors,duplicate(thisError)) /%>
		<%/cfif%>
		</cfcase>
		
				</cfswitch>
			</cfloop>
		</cfloop>
		<%cfreturn errors /%>
	<%/cffunction%>
	
	<%!---
	ACCESSORS
	---%><cfloop array="#variables.table.getColumns()#" index="column">
	<%cffunction name="set#column.getName()#" access="public" returntype="void" output="false"%>
		<%cfargument name="#column.getName()#" type="string" required="true" /%>
		<%cfset variables.instance.#column.getName()# = arguments.#column.getName()# /%>
	<%/cffunction%>
	<%cffunction name="get#column.getName()#" access="public" returntype="string" output="false"%>
		<%cfreturn variables.instance.#column.getName()# /%>
	<%/cffunction%>
</cfloop>
<%/cfcomponent%>
</cfoutput>