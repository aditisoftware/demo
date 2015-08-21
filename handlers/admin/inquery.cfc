
<cfcomponent name="inquery" extends="coldbox.system.eventhandler" output="false">
	<cfproperty name="oinqueryService" inject="model:inqueryService" scope="instance" />
	
	
	<cffunction name="init" access="public" returntype="inquery" output="false">
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
		rc.xehEditor = "inquery.dspEditor";
		rc.xehDelete = "inquery.doDelete";
		rc.xehList = "inquery.list";
		
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
		rc.qinquery = instance.oinqueryService.getByPage(Page=rc.page, pagesize=rc.pageSize,gridsortcolumn=rc.sortBy,gridstartdirection=rc.sortOrder);		
		
		//Set the view to render
		event.setView("inqueryList");
		</cfscript>
	</cffunction>
	
	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var oinqueryBean = "";
		
		//set the exit handlers
		rc.xehSave = "inquery.doSave";
		rc.xehList = "inquery.list";
		
		if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
			oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
		} else {
			oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
		}
		StructAppend(rc, oinqueryBean.getMemento(), true);
		
		
		
		//Set view to render
		//event.setView("inqueryAdd");
		event.setView("inqueryform");
		</cfscript>		
	</cffunction>
	
	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var oinqueryBean = "";
		
		//set the exit handlers
		rc.xehList = "inquery.list";
		
		if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
			oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
		} else {
			oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
		}
		StructAppend(rc, oinqueryBean.getMemento(), true);
		
		//Set view to render
		event.setView("inqueryview");
		</cfscript>		
	</cffunction>
	
	<cffunction name="doSave" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var oinqueryBean = "";
		var result = "";
		
		
		//get a new inquery bean if primary keys are blank
		if (StructKeyExists(rc, 'Id') AND len(rc.Id)) {
			oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
		} else {
			oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
		}
		
		if (StructKeyExists(rc, 'Id'))
			oinqueryBean.setId(rc.Id);
		if (StructKeyExists(rc, 'companyname'))
			oinqueryBean.setcompanyname(rc.companyname);
		if (StructKeyExists(rc, 'contactperson'))
			oinqueryBean.setcontactperson(rc.contactperson);
		if (StructKeyExists(rc, 'address'))
			oinqueryBean.setaddress(rc.address);
		if (StructKeyExists(rc, 'city'))
			oinqueryBean.setcity(rc.city);
		if (StructKeyExists(rc, 'state'))
			oinqueryBean.setstate(rc.state);
		if (StructKeyExists(rc, 'country'))
			oinqueryBean.setcountry(rc.country);
		if (StructKeyExists(rc, 'zipcode'))
			oinqueryBean.setzipcode(rc.zipcode);
		if (StructKeyExists(rc, 'phone1'))
			oinqueryBean.setphone1(rc.phone1);
		if (StructKeyExists(rc, 'phone2'))
			oinqueryBean.setphone2(rc.phone2);
		if (StructKeyExists(rc, 'mobile'))
			oinqueryBean.setmobile(rc.mobile);
		if (StructKeyExists(rc, 'email'))
			oinqueryBean.setemail(rc.email);
		if (StructKeyExists(rc, 'tourtype'))
			oinqueryBean.settourtype(rc.tourtype);
		if (StructKeyExists(rc, 'destination'))
			oinqueryBean.setdestination(rc.destination);
		if (StructKeyExists(rc, 'totalpassenger'))
			oinqueryBean.settotalpassenger(rc.totalpassenger);
		if (StructKeyExists(rc, 'adult'))
			oinqueryBean.setadult(rc.adult);
		if (StructKeyExists(rc, 'child'))
			oinqueryBean.setchild(rc.child);
		if (StructKeyExists(rc, 'child511year'))
			oinqueryBean.setchild511year(rc.child511year);
		if (StructKeyExists(rc, 'child11plus'))
			oinqueryBean.setchild11plus(rc.child11plus);
		if (StructKeyExists(rc, 'hotelcategory'))
			oinqueryBean.sethotelcategory(rc.hotelcategory);
		if (StructKeyExists(rc, 'roomsharing'))
			oinqueryBean.setroomsharing(rc.roomsharing);
		if (StructKeyExists(rc, 'vehicletype'))
			oinqueryBean.setvehicletype(rc.vehicletype);
		if (StructKeyExists(rc, 'allss'))
			oinqueryBean.setallss(rc.allss);
		if (StructKeyExists(rc, 'allentry'))
			oinqueryBean.setallentry(rc.allentry);
		if (StructKeyExists(rc, 'departuredate'))
			oinqueryBean.setdeparturedate(rc.departuredate);
		if (StructKeyExists(rc, 'transporttype'))
			oinqueryBean.settransporttype(rc.transporttype);
		if (StructKeyExists(rc, 'traintype'))
			oinqueryBean.settraintype(rc.traintype);
		if (StructKeyExists(rc, 'foodtype'))
			oinqueryBean.setfoodtype(rc.foodtype);
		if (StructKeyExists(rc, 'mealplan'))
			oinqueryBean.setmealplan(rc.mealplan);
		if (StructKeyExists(rc, 'noofPassenger'))
			oinqueryBean.setnoofPassenger(rc.noofPassenger);
		if (StructKeyExists(rc, 'soundsystem'))
			oinqueryBean.setsoundsystem(rc.soundsystem);
		if (StructKeyExists(rc, 'project'))
			oinqueryBean.setproject(rc.project);
		if (StructKeyExists(rc, 'amt_pmt'))
			oinqueryBean.setamt_pmt(rc.amt_pmt);
		if (StructKeyExists(rc, 'stagedecoration'))
			oinqueryBean.setstagedecoration(rc.stagedecoration);
		if (StructKeyExists(rc, 'B2B'))
			oinqueryBean.setB2B(rc.B2B);
		if (StructKeyExists(rc, 'DJParty'))
			oinqueryBean.setDJParty(rc.DJParty);
		if (StructKeyExists(rc, 'cocktailparty'))
			oinqueryBean.setcocktailparty(rc.cocktailparty);
		if (StructKeyExists(rc, 'artist'))
			oinqueryBean.setartist(rc.artist);
		if (StructKeyExists(rc, 'cultureparty'))
			oinqueryBean.setcultureparty(rc.cultureparty);
		if (StructKeyExists(rc, 'productlaunching'))
			oinqueryBean.setproductlaunching(rc.productlaunching);
		if (StructKeyExists(rc, 'sitevisit'))
			oinqueryBean.setsitevisit(rc.sitevisit);
		if (StructKeyExists(rc, 'remark'))
			oinqueryBean.setremark(rc.remark);
		if (StructKeyExists(rc, 'createddate'))
			oinqueryBean.setcreateddate(rc.createddate);
		if (StructKeyExists(rc, 'createdby'))
			oinqueryBean.setcreatedby(rc.createdby);
		
		//Send to service for saving
		result = instance.oinqueryService.saveinquery(oinqueryBean);
		
		setNextRoute("inquery/list");
		/*
		if (!result.success){
			getMyPlugin("ErrorBox").error(result.errors);
			setNextEvent(event="inquery.dspEditor",persistStruct=rc);
		}
		else {
			setNextRoute("inquery/list");
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
		result = instance.oinqueryService.deleteinquery(rc.Id);
		
		if (!result.success) {
			getMyPlugin("ErrorBox").error(result.errors);
		}
		else {
			getMyPlugin("ErrorBox").info("The record was successfully deleted");
		}
		//Set redirect
		setNextRoute("inquery/list");
		</cfscript>		
	</cffunction>	
	
</cfcomponent>

