<cfcomponent>
	<cfproperty name="name" default="" type="string">
	<cfproperty name="errorMessage" default="" type="string">
	<cfproperty name="value" type="string">

	<cfset variables.instance = structNew()>
	<cffunction name="init" access="public" output="false" returntype="Validator">
		<cfargument name="name" default="" required="false" type="string" />
		<cfargument name="errorMessage" default="" required="false" type="string" />
		<cfargument name="value" default="" required="false" type="string" />
		<cfscript>
			variables.instance.name = arguments.name;
			variables.instance.errorMessage = arguments.errorMessage;
			variables.instance.value = arguments.value;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getMeta" access="public" returntype="struct" output="false" >
		<cfreturn  getMetaData(this)/>
	</cffunction>
	
	<cffunction name="setMemento" access="public" returntype="Validator" output="false">
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

	<cffunction name="getErrorMessage" access="public" output="false" returntype="string">
		<cfreturn variables.instance.ErrorMessage>
	</cffunction>

	<cffunction name="setErrorMessage" access="public" output="false" returntype="void">
		<cfargument name="mErrorMessage" type="string">
		<cfset variables.instance.ErrorMessage = arguments.mErrorMessage>
	</cffunction>

	<cffunction name="getApplicableDataType" access="public" output="false" returntype="string">
		<cfreturn variables.instance.ApplicableDataType>
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Value>
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="void">
		<cfargument name="mValue" type="string">
		<cfset variables.instance.Value = arguments.mValue>
	</cffunction>
</cfcomponent>