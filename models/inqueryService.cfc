
<cfcomponent name="inqueryService" output="false" cache="true" cachetimeout="30" extends="inqueryServiceBase">
	<cffunction name="getTourType" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getTourType() />
	</cffunction>
</cfcomponent>

