<cfcomponent name="inqueryGateway" output="false" cache="true" cachetimeout="30" extends="inqueryGatewayBase">
	<cffunction name="getTourtype" access="public" returntype="any" output="false">
		<cfquery name="list" datasource="#variables.dsn#">
			SELECT * FROM tourtype 
		</cfquery>
		<cfreturn list>
	</cffunction>
</cfcomponent>

