<!--- All methods in this helper will be available in all handlers,plugins,views & layouts --->

<cffunction name="getOSFileSeparator" access="public" returntype="any" output="false" hint="Get the operating system's file separator character">
	<cfscript>
		var objFile = createObject("java", "java.lang.System");
		return objFile.getProperty("file.separator");
	</cfscript> 
</cffunction>
