
<cfcomponent name="usermasterService" output="false" cache="true" cachetimeout="30" extends="usermasterServiceBase">
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
	    <cfargument name="pagesize" default="30">
	    <cfargument name="gridsortcolumn" default="id">
	    <cfargument name="gridstartdirection" default="">
		<cfargument name="searchname" default="" />
		<cfargument name="searchcity" default="" />
		<cfargument name="searchusertype" default="" />
		
		<cfreturn instance.usermasterGateway.getBypage(argumentCollection=arguments) />
		
	</cffunction>
</cfcomponent>

