
<cfcomponent name="yp_hauntblogs" extends="coldbox.system.eventhandler" output="false">
	<cfproperty name="oyp_hauntblogsService" inject="model:yp_hauntblogsService" scope="instance" />
	<cfproperty name="oyp_listingService" inject="model:yp_listingService" scope="instance" />
	
	<cffunction name="init" access="public" returntype="yp_hauntblogs" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="preHandler" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" />
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfif not (structKeyExists(SESSION, "cbstorage") and structKeyExists(SESSION.cbstorage, "userid") and val(SESSION.cbstorage.userid))>
			<cfset getMyPlugin("ErrorBox").error('Session timeout. Please Enter Login Information. Please try again')>
			<cfset setNextEvent(event='general.login')>
		</cfif>

		<cfif (StructKeyExists(rc,'LISTINGID') AND len(rc.LISTINGID))>
			<cfset event.paramValue("id",rc.LISTINGID)>
		<cfelse>
			<cfset event.paramValue("listingid",'')>
			<cfset event.paramValue("id",'')>
		</cfif>
		<cfset event.paramValue("currenttab",'4')>
		<cfcookie name="menu" value="sites"/>
	</cffunction>

	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		//Get references
		rc = event.getCollection();
		//set The exit handlers
		rc.xehBlogEditor = "admin.yp_hauntblogs.dspEditor";
		rc.xehBlogDelete = "admin.yp_hauntblogs.doDelete";
		rc.xehBlogList = "admin.yp_hauntblogs.list";
		
		event.paramValue("page", "1");
		event.paramValue("pageSize", getSetting("PagingMaxRows"));
		event.paramValue("bandSize", getSetting("PagingBandGap"));
		event.paramValue("sortBy", "listingid");
		event.paramValue("sortOrder","asc")

		rc.bloglist = instance.oyp_hauntblogsService.getyp_hauntblogss(listingid=rc.id,orderby=rc.sortBy,orderdirection=rc.sortOrder);		
		//Set the view to render

		event.setView("admin/yp_hauntblog");
		</cfscript>
	</cffunction>
	
	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		//References
		rc = event.getCollection();
		var oyp_hauntblogsBean = "";
		
		//set the exit handlers
		rc.xehSave = "admin.yp_hauntblogs.doSave";
		rc.xehList = "admin.yp_hauntblogs.list";
		
		if (StructKeyExists(rc,'blogid') AND len(rc.blogid)) {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.getyp_hauntblogs(rc.blogid);
		} else {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.createyp_hauntblogs(argumentCollection=rc);
		}
		StructAppend(rc, oyp_hauntblogsBean.getMemento(), true);
		event.setLayout('Layout.Window');
		//Set view to render
		event.setView("admin/yp_hauntblogsAdd");
		</cfscript>		
	</cffunction>
	
	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		//References
		rc = event.getCollection();
		var oyp_hauntblogsBean = "";
		
		//set the exit handlers
		rc.xehList = "admin.yp_hauntblogs.list";
		
		if (StructKeyExists(rc,'blogid') AND len(rc.blogid)) {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.getyp_hauntblogs(rc.blogid);
		} else {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.createyp_hauntblogs(argumentCollection=rc);
		}
		StructAppend(rc, oyp_hauntblogsBean.getMemento(), true);
		
		//Set view to render
		event.setView("admin/yp_hauntblogsview");
		</cfscript>		
	</cffunction>
	
	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		//References
		rc = event.getCollection();
		var oyp_hauntblogsBean = "";
		var result = "";
		event.paramValue("infoMessage","Blog added successfully.");
		event.paramValue("isactive",0);
		//get a new yp_hauntblogs bean if primary keys are blank
		if (StructKeyExists(rc, 'blogid') AND val(rc.blogid)) {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.getyp_hauntblogs(rc.blogid);
			rc.infoMessage = 'Blog updated successfully.';
		} else {
			oyp_hauntblogsBean = instance.oyp_hauntblogsService.createyp_hauntblogs(argumentCollection=rc);
			oyp_hauntblogsBean.setcreateddate(now());
		}
		
		if (StructKeyExists(rc, 'blogid'))
			oyp_hauntblogsBean.setblogid(rc.blogid);
		if (StructKeyExists(rc, 'listingid'))
			oyp_hauntblogsBean.setlistingid(rc.listingid);
		if (StructKeyExists(rc, 'blogname'))
			oyp_hauntblogsBean.setblogname(rc.blogname);
		if (StructKeyExists(rc, 'blogcontent'))
			oyp_hauntblogsBean.setblogcontent(rc.blogcontent);
		if (StructKeyExists(rc, 'isactive'))
			oyp_hauntblogsBean.setisactive(rc.isactive);
		if (StructKeyExists(rc, 'blogtitle'))
			oyp_hauntblogsBean.setblogtitle(rc.blogtitle);
		
		//Send to service for saving
		result = instance.oyp_hauntblogsService.saveyp_hauntblogs(oyp_hauntblogsBean);
		getMyPlugin("ErrorBox").info(rc.infoMessage);
		setNextEvent(event="admin.yp_hauntblogs.dspEditor",queryString='listingid=#rc.listingid#&currenttab=#rc.currenttab#&OPERATION=true');
		/*
		if (!result.success){
			getMyPlugin("ErrorBox").error(result.errors);
			setNextEvent(event="admin.yp_hauntblogs.dspEditor",persistStruct=rc);
		}
		else {
			setNextRoute("admin/yp_hauntblogs/list");
		}*/
		</cfscript>		
	</cffunction>
	
	<cffunction name="doDelete" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		//References
		rc = event.getCollection();
		var result = "";
		
		//Remove via the incoming id
		result = instance.oyp_hauntblogsService.deleteyp_hauntblogs(rc.blogid);
		
		if (!result.success) {
			getMyPlugin("ErrorBox").error(result.errors);
		}
		else {
			getMyPlugin("ErrorBox").info("The record was successfully deleted");
		}

		result.message = "The record was successfully deleted";
		
		event.renderData("text",result.message);
		//Set redirect
		//setNextEvent(event="admin.yp_listing.dspEditor",queryString='id=#rc.id#&currenttab=#rc.currenttab#');
		</cfscript>		
	</cffunction>	
	
</cfcomponent>

