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
		<cfscript>
			rc.qusermaster = instance.ousermasterService.getusermasters(username=rc.username,password=rc.password);
			if(rc.qusermaster.recordcount){
				session.username=rc.qusermaster.username;
				session.userid=rc.qusermaster.id;
				session.usertype=rc.qusermaster.usertype;
				event.setView("admin/home").setLayout('layout.admin');
			}
			else{
				session.clear();
				event.setView("login").NoLayout();
			}
		</cfscript>
	</cffunction>
	


	<cffunction name="errorpage" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfset event.setView("errorpage").noLayout()>
	</cffunction>

</cfcomponent>