
<cfcomponent name="usermasterService" output="false" cache="true" cachetimeout="30">
	<cfproperty name="usermasterDAO" inject="model:usermasterDAO" scope="instance" />
	<cfproperty name="usermasterGateway" inject="model:usermasterGateway" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="usermasterService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createusermaster" access="public" output="false" returntype="usermaster">
		<cfargument name="Id" type="string" required="false" />
		<cfargument name="firstname" type="string" required="false" />
		<cfargument name="lastname" type="string" required="false" />
		<cfargument name="address1" type="string" required="false" />
		<cfargument name="address2" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="username" type="string" required="false" />
		<cfargument name="password" type="string" required="false" />
		<cfargument name="passwordsalt" type="string" default="" />
		<cfargument name="usertype" type="string" required="false" />
		<cfargument name="createddate" type="string" required="false" />
		<cfargument name="createdby" type="string" required="false" />
		
		<cfset var musermaster = createObject("component","usermaster").init(argumentCollection=arguments) />
		<cfreturn musermaster />
	</cffunction>
	
	<cffunction name="deleteusermaster" access="public" output="false" returntype="struct">
		<cfargument name="Id" type="numeric" required="true" />
		
		<cfset var retStruct = structNew()>
		<cfset var structErr = structNew()>
		<cfset var usermaster = "" >

		<cfset retStruct.success = true>
		<cfset retStruct.errors = arrayNew(1)>
		<cftry>
			<cfset usermaster = createusermaster(argumentCollection=arguments) />
			<cfset instance.usermasterDAO.delete(usermaster) />
		<cfcatch>
			<cfset retStruct.success = false>
			<cfset structErr = structNew()>
			<cfset structErr["errorCode"] = "dbException">
			<cfset structErr["message"] = cfcatch.message>
			<cfset arrayAppend(retStruct.errors,duplicate(structErr))>
		</cfcatch>
		</cftry>
		<cfreturn retStruct />
	</cffunction>
	
	<cffunction name="getusermaster" access="public" output="false" returntype="usermaster">
		<cfargument name="Id" type="numeric" required="true" />
		
		<cfset var usermaster = createusermaster(argumentCollection=arguments) />
		<cfset instance.usermasterDAO.read(usermaster) />
		<cfreturn usermaster />
	</cffunction>
	
	<cffunction name="getusermasters" access="public" output="false" returntype="any">
		<cfargument name="datatype" type="string" required="false" default="query" hint="query or array" >
		<cfargument name="Id" type="numeric" required="false" />
		<cfargument name="firstname" type="string" required="false" />
		<cfargument name="lastname" type="string" required="false" />
		<cfargument name="address1" type="string" required="false" />
		<cfargument name="address2" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="username" type="string" required="false" />
		<cfargument name="password" type="string" required="false" />
		<cfargument name="passwordsalt" type="string" default="" />
		<cfargument name="usertype" type="string" required="false" />
		<cfargument name="createddate" type="date" required="false" />
		<cfargument name="createdby" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfif arguments.datatype eq "query">
			<cfreturn instance.usermasterGateway.getByAttributesQuery(argumentCollection=arguments) />
		<cfelse>
			<cfreturn instance.usermasterGateway.getByAttributes(argumentCollection=arguments) />
		</cfif>
	</cffunction>
	
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
	    <cfargument name="pagesize" default="30">
	    <cfargument name="gridsortcolumn" default="Id">
	    <cfargument name="gridstartdirection" default="">
		
		<cfreturn instance.usermasterGateway.getBypage(argumentCollection=arguments) />
		
	</cffunction>
	
	<cffunction name="saveusermaster" access="public" output="false" returntype="struct">
		<cfargument name="usermaster" type="usermaster" required="true" />
		<cfset var retStruct = structNew()>
		<cfset var structErr = structNew()>
		<cfset var retArray = "">

		<cfset retStruct.success = true>
		<cfset retStruct.errors = arrayNew(1)>
		<cfset retArray = arguments.usermaster.validate()>
		<cfif arrayIsEmpty(retArray)>
			<cfset retStruct.usermaster = instance.usermasterDAO.save(usermaster) />
		<cfelse>
			<cfset retStruct.success = false> 
			<cfset retStruct.errors = retArray />
		</cfif>
		<cfreturn retStruct />
		
	</cffunction>
</cfcomponent>

