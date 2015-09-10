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
				<cfdump var="#hash(local.qusermaster.passwordsalt & trim(rc.password), "SHA")#" />
			    <cfif hash(local.qusermaster.passwordsalt & trim(rc.password), "SHA") EQ trim(local.qusermaster.password) >
				    <CFLOCK SCOPE="Session" TIMEOUT="30" TYPE="Exclusive">
				        <CFSET session.username=local.qusermaster.username>
						<CFSET session.userid=local.qusermaster.id>
						<CFSET session.usertype=local.qusermaster.usertype>
				    </CFLOCK>
				    <cflogin idletimeout="54000">
				        <cfloginuser name = "#local.qusermaster.firstname#" password = "#local.qusermaster.id#" roles = "#lcase(local.qusermaster.usertype)#"/>
				    </cflogin>
				    <cfset event.setView("admin/home").setLayout('layout.admin')>
				<cfelse>
					<cfset getInstance("ErrorBox").error(renderto="loginError",message = "Please enter correct login information.")>
					<cfset setNextEvent(event= rc.backevent)>
				</cfif>
			<cfelse>
				<cfset getInstance("ErrorBox").error(renderto="loginError",message = "Please enter correct login information.")>
				<cfset setNextEvent(event= rc.backevent)>
			</cfif>
		<cfelse>
			<cfset getInstance("ErrorBox").error(renderto="loginError",message = "Please enter correct login information.")>
			<cfset setNextEvent(event= rc.backevent)>
		</cfif>
	</cffunction>
	
	<cffunction name="logout" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />
		<cfset structClear(session) />
		<cfset event.paramValue("backevent","general.login") />
		<cfset setnextevent(event=rc.backevent)/>
	</cffunction>

	<cffunction name="errorpage" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfset event.setView("errorpage").noLayout()>
	</cffunction>

</cfcomponent>