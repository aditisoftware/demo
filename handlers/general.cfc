<cfcomponent output="false">

	<cfproperty name="MailService" inject="MailService@cbmailservices" scope="variables"/>
	<cfproperty name="ousermasterService" inject="model:usermasterService" scope="instance" />
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
		<cfset event.paramValue("xehDoLogin","general.dologin") />
		<cfset event.paramValue("backevent","general.login") />

		<cfif structKeyExists(rc,"username") AND len(rc.username)>
			<cfset local.qusermaster = instance.ousermasterService.getusermasters(username=rc.username)>
			<cfif local.qusermaster.recordCount GT 0>
			    <cfif hash(local.qusermaster.passwordsalt & trim(rc.password), "SHA") EQ trim(local.qusermaster.password) >
				    <CFLOCK SCOPE="Session" TIMEOUT="30" TYPE="Exclusive">
				        <CFSET session.username=rc.qusermaster.username>
						<CFSET session.userid=rc.qusermaster.id>
						<CFSET session.usertype=rc.qusermaster.usertype>
				    </CFLOCK>
				    <cflogin idletimeout="54000">
				        <cfloginuser name = "#local.qusermaster.firstname#" password = "#local.qusermaster.id#" roles = "#lcase(local.qusermaster.usertype)#"/>
				    </cflogin>
				    <cfset event.setView("admin/home").setLayout('layout.admin')>
				<cfelse>
					<CFSET rc.msg="Please enter correct login information.">
					<cfset setNextEvent(event= rc.backevent,persistStruct=rc)>
				</cfif>
			<cfelse>
				<CFSET rc.msg="Please enter correct login information.">
				<cfset setNextEvent(event= rc.backevent,persistStruct=rc)>
			</cfif>
		<cfelse>
			<CFSET rc.msg="Please enter correct login information.">
			<cfset setNextEvent(event= rc.backevent,persistStruct=rc)>
		</cfif>
	</cffunction>
	


	<cffunction name="errorpage" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfset event.setView("errorpage").noLayout()>
	</cffunction>

</cfcomponent>