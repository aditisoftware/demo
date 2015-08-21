
<cfcomponent name="usermaster" extends="coldbox.system.eventhandler" output="false">
	<cfproperty name="ousermasterService" inject="model:usermasterService" scope="instance" />
	
	
	<cffunction name="init" access="public" returntype="usermaster" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
		//set The exit handlers
		rc.xehEditor = "admin.usermaster.dspEditor";
		rc.xehDelete = "admin.usermaster.doDelete";
		rc.xehList = "admin.usermaster.list";
		
		event.paramValue("page", "1");
		event.paramValue("pageSize", getSetting("PagingMaxRows"));
		event.paramValue("bandSize", getSetting("PagingBandGap"));
		
		//Sorting Logic.
		event.paramValue("sortBy", "Id");
		if ( event.getValue("sortOrder","") neq ""){
			if (rc.sortOrder eq "asc")
				rc.sortOrder = "desc";
			else
				rc.sortOrder = "asc";
		}
		else{
			rc.sortOrder = "asc";
		}
		
		//Get the listing
		rc.qusermaster = instance.ousermasterService.getByPage(Page=rc.page, pagesize=rc.pageSize,gridsortcolumn=rc.sortBy,gridstartdirection=rc.sortOrder);		
		
		//Set the view to render
		event.setView("admin/usermasterList");
		</cfscript>
	</cffunction>
	
	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var ousermasterBean = "";
		
		//set the exit handlers
		rc.xehSave = "admin.usermaster.doSave";
		rc.xehList = "admin.usermaster.list";
		
		if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
			ousermasterBean = instance.ousermasterService.getusermaster(rc.Id);
		} else {
			ousermasterBean = instance.ousermasterService.createusermaster(argumentCollection=rc);
		}
		StructAppend(rc, ousermasterBean.getMemento(), true);
		
		
		
		//Set view to render
		event.setView("admin/usermasterAdd");
		</cfscript>		
	</cffunction>
	
	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var ousermasterBean = "";
		
		//set the exit handlers
		rc.xehList = "admin.usermaster.list";
		
		if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
			ousermasterBean = instance.ousermasterService.getusermaster(rc.Id);
		} else {
			ousermasterBean = instance.ousermasterService.createusermaster(argumentCollection=rc);
		}
		StructAppend(rc, ousermasterBean.getMemento(), true);
		
		//Set view to render
		event.setView("admin/usermasterview");
		</cfscript>		
	</cffunction>
	
	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var ousermasterBean = "";
		var result = "";
		
		
		//get a new usermaster bean if primary keys are blank
		if (StructKeyExists(rc, 'Id') AND len(rc.Id)) {
			ousermasterBean = instance.ousermasterService.getusermaster(rc.Id);
		} else {
			ousermasterBean = instance.ousermasterService.createusermaster(argumentCollection=rc);
		}
		
		if (StructKeyExists(rc, 'Id'))
			ousermasterBean.setId(rc.Id);
		if (StructKeyExists(rc, 'firstname'))
			ousermasterBean.setfirstname(rc.firstname);
		if (StructKeyExists(rc, 'lastname'))
			ousermasterBean.setlastname(rc.lastname);
		if (StructKeyExists(rc, 'address1'))
			ousermasterBean.setaddress1(rc.address1);
		if (StructKeyExists(rc, 'address2'))
			ousermasterBean.setaddress2(rc.address2);
		if (StructKeyExists(rc, 'city'))
			ousermasterBean.setcity(rc.city);
		if (StructKeyExists(rc, 'state'))
			ousermasterBean.setstate(rc.state);
		if (StructKeyExists(rc, 'country'))
			ousermasterBean.setcountry(rc.country);
		if (StructKeyExists(rc, 'username'))
			ousermasterBean.setusername(rc.username);
		if (StructKeyExists(rc, 'password'))
			ousermasterBean.setpassword(rc.password);
		if (StructKeyExists(rc, 'usertype'))
			ousermasterBean.setusertype(rc.usertype);
		if (StructKeyExists(rc, 'createddate'))
			ousermasterBean.setcreateddate(rc.createddate);
		if (StructKeyExists(rc, 'createdby'))
			ousermasterBean.setcreatedby(rc.createdby);
		
		//Send to service for saving
		result = instance.ousermasterService.saveusermaster(ousermasterBean);
		
		setNextRoute("admin/usermaster/list");
		/*
		if (!result.success){
			getMyPlugin("ErrorBox").error(result.errors);
			setNextEvent(event="admin.usermaster.dspEditor",persistStruct=rc);
		}
		else {
			setNextRoute("admin/usermaster/list");
		}*/
		</cfscript>		
	</cffunction>
	
	<cffunction name="doDelete" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var result = "";
		
		//Remove via the incoming id
		result = instance.ousermasterService.deleteusermaster(rc.Id);
		
		if (!result.success) {
			getMyPlugin("ErrorBox").error(result.errors);
		}
		else {
			getMyPlugin("ErrorBox").info("The record was successfully deleted");
		}
		//Set redirect
		setNextRoute("admin/usermaster/list");
		</cfscript>		
	</cffunction>	
	
</cfcomponent>

