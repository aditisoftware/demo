<cfcomponent>
	<cfproperty name="name" default="" type="string">
	<cfproperty name="value" default="" type="string">

	<cfset variables.instance = structNew()>
	<cffunction name="init" access="public" output="false" returntype="FilePath">
		<cfargument name="name" default="" required="false" type="string" />
		<cfargument name="value" default="" required="false" type="string" />
		<cfscript>
			variables.instance.name = arguments.name;
			variables.instance.value = arguments.value;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="cfc.Contractor_Access" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>

	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Name>
	</cffunction>

	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="mName" type="string">
		<cfset variables.instance.Name = arguments.mName>
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Value>
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="void">
		<cfargument name="mValue" type="string">
		<cfset variables.instance.Value = arguments.mValue>
	</cffunction>
</cfcomponent>