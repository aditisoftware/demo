<cfcomponent output="false">

	<cfproperty name="MailService" inject="MailService@cbmailservices" scope="variables"/>

	<cffunction name="preHandler" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" />
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfset event.paramValue("miles",'100') />
		<cfset event.paramValue("listingtype",1) />
		<cfset event.paramValue("featuredbanner","") />

	</cffunction>
	<cffunction name="login" returntype="void" output="false">
		<cfargument name="event" />
		<cfargument name="rc" />
		<cfargument name="prc" />

		<cfset event.paramValue("xehDoLogin","general.dologin") />

		<cfset event.setView("login").NoLayout()>
	</cffunction>

	<cffunction name="dologin" returntype="void" output="false">
		<cfargument name="event" />
		<cfargument name="rc" />
		<cfargument name="prc" />

		<cfset event.setView("home").setLayout('layout.admin')>
	</cffunction>
	


	<cffunction name="errorpage" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfset event.setView("errorpage").noLayout()>
	</cffunction>

</cfcomponent>