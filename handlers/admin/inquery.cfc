
<cfcomponent name="inquery" extends="coldbox.system.eventhandler" output="false">
	<cfproperty name="oinqueryService" inject="model:inqueryService" scope="instance" />
	<cfproperty name="ousermasterService" inject="model:usermasterService" scope="instance" />

	<cffunction name="init" access="public" returntype="inquery" output="false">
		<cfargument name="controller" type="any" required="true">
		<cfset super.init(arguments.controller)>
		<cfif not (StructKeyExists(session,"username") and len(trim(SESSION.username)))>
			<cfset setNextEvent(event="general.login") />
		</cfif>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="list" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
		//set The exit handlers
		rc.xehEditor = "admin.inquery.dspEditor";
		rc.xehDelete = "admin.inquery.doDelete";
		rc.xehList = "admin.inquery.list";
		
		event.paramValue("page", "1");
		event.paramValue("pageSize", getSetting("PagingMaxRows"));
		event.paramValue("bandSize", getSetting("PagingBandGap"));
		event.paramValue("searchname","");
		event.paramValue("searchcity","");
		event.paramValue("searchcreatedby","#session.userid#");
		
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

		rc.qinquery = instance.oinqueryService.getByPage(
			Page=rc.page, 
			pagesize=rc.pageSize,
			gridsortcolumn=rc.sortBy,
			gridstartdirection=rc.sortOrder,
			searchname=rc.searchname,
			searchcity=rc.searchcity,
			searchcreatedby=rc.searchcreatedby
			);

		rc.qusermaster = instance.ousermasterService.getusermasters();
		//Set the view to render
		event.setView("admin/inqueryList");
		</cfscript>
	</cffunction>
	
	<cffunction name="dspEditor" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";

			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/inqueryAdd");
		</cfscript>
	</cffunction>
	
	<cffunction name="view" access="public" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">

		<cfscript>
		var oinqueryBean = "";
		
		//set the exit handlers
		rc.xehList = "admin.inquery.list";
		
		if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
			oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
		} else {
			oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
		}
		StructAppend(rc, oinqueryBean.getMemento(), true);
		
		//Set view to render
		event.setView("admin/inqueryview");
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
			oinqueryBean.setcreateddate(now());
			oinqueryBean.setcreatedby(session.userid);

		}
		if (StructKeyExists(rc, 'tourid'))
			oinqueryBean.settourid(rc.tourid);

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

		if (StructKeyExists(rc, 'infant'))
			oinqueryBean.setinfant(rc.infant);
		if (StructKeyExists(rc, 'tourname'))
			oinqueryBean.settourname(rc.tourname);
		if (StructKeyExists(rc, 'tourcode'))
			oinqueryBean.settourcode(rc.tourcode);
		if (StructKeyExists(rc, 'schoolname'))
			oinqueryBean.setschoolname(rc.schoolname);
		if (StructKeyExists(rc, 'totaldays'))
			oinqueryBean.settotaldays(rc.totaldays);
		if (StructKeyExists(rc, 'entryfees'))
			oinqueryBean.setentryfees(rc.entryfees);
		if (StructKeyExists(rc, 'hotelrooms'))
			oinqueryBean.sethotelrooms(rc.hotelrooms);
		if (StructKeyExists(rc, 'extramatress'))
			oinqueryBean.setextramatress(rc.extramatress);
		if (StructKeyExists(rc, 'mealplan'))
			oinqueryBean.setmealplan(rc.mealplan);
		if (StructKeyExists(rc, 'vehicle'))
			oinqueryBean.setvehicle(rc.vehicle);

		//Send to service for saving
		result = instance.oinqueryService.saveinquery(oinqueryBean);
		
		
		if (!result.success){
			getInstance("ErrorBox").error(renderto="inqueryError",message = result.errors);
			if(rc.tourtype eq 1)
				rc.event = "admin.inquery.escortedtour";
			else if(rc.tourtype eq 2)
				rc.event = "admin.inquery.bhaktiyatra";
			else if(rc.tourtype eq 3)
				rc.event = "admin.inquery.educationaltour";
			else if(rc.tourtype eq 4)
				rc.event = "admin.inquery.adventuretour";
			else if(rc.tourtype eq 5)
				rc.event = "admin.inquery.corporatetour";
			else if(rc.tourtype eq 6)
				rc.event = "admin.inquery.individualtour";

			setNextEvent(event=rc.event,persistStruct=rc);
		}
		else {
			rc.event = "admin.inquery.list";
			setNextEvent(event=rc.event);
		}
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
			getInstance("ErrorBox").error(renderto="inqueryError",message = result.errors);
		}
		else {
			getInstance("ErrorBox").info(renderto="inqueryError",message = "The record was successfully deleted");
		}
		//Set redirect
		rc.event = "admin.inquery.list";
		setNextEvent(event=rc.event);
		</cfscript>		
	</cffunction>	

	<cffunction name="escortedtour" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.infant = "";
			rc.tourname = "";
			rc.tourcode = "";*/

			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/escortedtour");
		</cfscript>
	</cffunction>

	<cffunction name="bhaktiyatra" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.infant = "";
			rc.tourname = "";
			rc.tourcode = "";*/

			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/bhaktiyatra");
		</cfscript>
	</cffunction>

	<cffunction name="educationaltour" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.tourtype = "";
			rc.tourname = "";
			rc.tourcode = "";
			rc.schoolname = "";
			rc.totaldays = "";
			rc.entryfees = "";*/
			
			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			
			//Set view to render
			event.setView("admin/educationaltour");
		</cfscript>
	</cffunction>

	<cffunction name="adventuretour" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.tourtype = "";
			rc.tourname = "";
			rc.tourcode = "";
			rc.schoolname = "";
			rc.totaldays = "";
			rc.entryfees = "";*/
			
			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			
			//Set view to render
			event.setView("admin/adventuretour");
		</cfscript>
	</cffunction>

	<cffunction name="corporatetour" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.infant = "";
			rc.tourname = "";
			rc.tourcode = "";
			rc.entryfees = "";
			rc.b2b = "";*/
			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/corporatetour");
		</cfscript>
	</cffunction>

	<cffunction name="xhotelbooking" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />
		<cfabort />
		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";

			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/hotelbooking");
		</cfscript>
	</cffunction>

	<cffunction name="individualtour" access="public" returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />

		<cfscript>
			var oinqueryBean = "";
			
			//set the exit handlers
			rc.xehSave = "admin.inquery.doSave";
			rc.xehList = "admin.inquery.list";
			/*rc.infant = "";
			rc.tourname = "";
			rc.tourcode = "";
			rc.entryfees = "";
			rc.totaldays = "";
			rc.hotelrooms = "";
			rc.extramatress = "";
			rc.mealplan = "";
			rc.vehicle = "";*/
			if (StructKeyExists(rc,'Id') AND len(rc.Id)) {
				oinqueryBean = instance.oinqueryService.getinquery(rc.Id);
			} else {
				oinqueryBean = instance.oinqueryService.createinquery(argumentCollection=rc);
			}
			StructAppend(rc, oinqueryBean.getMemento(), true);
			rc.tourtype = instance.oinqueryService.getTourtype();
			
			//Set view to render
			event.setView("admin/individualtour");
		</cfscript>
	</cffunction>

	<cffunction name="home" access='public' returntype="void" output="false">
		<cfargument name="rc" />
		<cfargument name="prc" />
		<cfargument name="event" />
		<cfscript>
			event.paramValue("datefrom", "");
			event.paramValue("dateto", "");
			event.paramValue("createdby", "");

			rc.qYesterdayInquiryCount = instance.oinqueryService.getYesterdayInquiryCount();
			rc.qLastMonthInquiryCount = instance.oinqueryService.getLastMonthInquiryCount();
			rc.qCurrentYearInquiryCount = instance.oinqueryService.getCurrentYearInquiryCount();
			rc.qTotalInquiryCount = instance.oinqueryService.getTotalInquiryCount();
			rc.qRecentInqList = instance.oinqueryService.getRecentInqList();
			if((StructKeyExists(session,"username") and len(trim(SESSION.username)) and session.usertype eq "superadmin")){
				rc.qTop10AgentInquery = instance.oinqueryService.getTop10AgentInquery();
				rc.qLast5MonthInquery = instance.oinqueryService.getqLast5MonthInquery();
			}
			else{
				rc.qAgentLast5DayInquery = instance.oinqueryService.getAgentLast5DayInquery();
				rc.qAgentLast6MonthInquery = instance.oinqueryService.getAgentLast6MonthInquery();
			}

		</cfscript>	
		<cfset event.setView("admin/home") />
	</cffunction>
</cfcomponent>

