﻿<!--- All methods in this helper will be available in all handlers,views & layouts --->
<cffunction name="generateToken" output="false" access="public" returntype="string" hint="Function generate token for csrf and field alter method">
	<cfargument name="include" default="#ArrayNew(1)#" type="array">
	<cfscript>
		var token = session.cfid;
		var il=arrayLen(arguments.include);
		for(var i=1; i <= il; i++){
			token = token & arguments.include[i];
		}
	</cfscript>

	<cfreturn hash(token)>
</cffunction>

<cffunction name="validateToken" output="false" access="public" returntype="boolean" hint="Validate csrf token">
	<cfargument name="requesttoken" required="true" type="string">
	<cfargument name="include" default=[] type="array">
	<cfscript>
		var token = session.cfid;
		var il=arrayLen(arguments.include);
		for(var i=1; i <= il; i++){
			token = token & arguments.include[i];
		}
	</cfscript>
	<cfreturn hash(token) eq arguments.requesttoken>
</cffunction>

<cffunction name="encryptPassword" access="public" description="generate passoword and password salt" output="false" returntype="struct">
	<cfargument name="password" required="true" type="string">

	<cfscript>
		var retStruct = {};
		var saltpass = "";
		
		retStruct.passsalt = hash(createUUID(), "SHA");
		saltpass = retStruct.passsalt & arguments.password;
		retStruct.password = hash(saltpass, "SHA");

		return retStruct;
	</cfscript>
</cffunction>