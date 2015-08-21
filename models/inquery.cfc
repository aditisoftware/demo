
<cfcomponent displayname="inquery" output="false">
	<cfproperty name="Id" type="numeric" default="" />
	<cfproperty name="companyname" type="string" default="" />
	<cfproperty name="contactperson" type="string" default="" />
	<cfproperty name="address" type="string" default="" />
	<cfproperty name="city" type="string" default="" />
	<cfproperty name="state" type="string" default="" />
	<cfproperty name="country" type="string" default="" />
	<cfproperty name="zipcode" type="string" default="" />
	<cfproperty name="phone1" type="string" default="" />
	<cfproperty name="phone2" type="string" default="" />
	<cfproperty name="mobile" type="string" default="" />
	<cfproperty name="email" type="string" default="" />
	<cfproperty name="tourtype" type="string" default="" />
	<cfproperty name="destination" type="string" default="" />
	<cfproperty name="totalpassenger" type="string" default="" />
	<cfproperty name="adult" type="string" default="" />
	<cfproperty name="child" type="string" default="" />
	<cfproperty name="child511year" type="string" default="" />
	<cfproperty name="child11plus" type="string" default="" />
	<cfproperty name="hotelcategory" type="string" default="" />
	<cfproperty name="roomsharing" type="string" default="" />
	<cfproperty name="vehicletype" type="string" default="" />
	<cfproperty name="allss" type="string" default="" />
	<cfproperty name="allentry" type="string" default="" />
	<cfproperty name="departuredate" type="date" default="" />
	<cfproperty name="transporttype" type="string" default="" />
	<cfproperty name="traintype" type="string" default="" />
	<cfproperty name="foodtype" type="string" default="" />
	<cfproperty name="mealplan" type="string" default="" />
	<cfproperty name="noofPassenger" type="string" default="" />
	<cfproperty name="soundsystem" type="string" default="" />
	<cfproperty name="project" type="string" default="" />
	<cfproperty name="amt_pmt" type="string" default="" />
	<cfproperty name="stagedecoration" type="string" default="" />
	<cfproperty name="B2B" type="string" default="" />
	<cfproperty name="DJParty" type="string" default="" />
	<cfproperty name="cocktailparty" type="string" default="" />
	<cfproperty name="artist" type="string" default="" />
	<cfproperty name="cultureparty" type="string" default="" />
	<cfproperty name="productlaunching" type="string" default="" />
	<cfproperty name="sitevisit" type="string" default="" />
	<cfproperty name="remark" type="string" default="" />
	<cfproperty name="createddate" type="date" default="" />
	<cfproperty name="createdby" type="numeric" default="" />
	
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="inquery" output="false">
		<cfargument name="Id" type="string" default="" />
		<cfargument name="companyname" type="string" default="" />
		<cfargument name="contactperson" type="string" default="" />
		<cfargument name="address" type="string" default="" />
		<cfargument name="city" type="string" default="" />
		<cfargument name="state" type="string" default="" />
		<cfargument name="country" type="string" default="" />
		<cfargument name="zipcode" type="string" default="" />
		<cfargument name="phone1" type="string" default="" />
		<cfargument name="phone2" type="string" default="" />
		<cfargument name="mobile" type="string" default="" />
		<cfargument name="email" type="string" default="" />
		<cfargument name="tourtype" type="string" default="" />
		<cfargument name="destination" type="string" default="" />
		<cfargument name="totalpassenger" type="string" default="" />
		<cfargument name="adult" type="string" default="" />
		<cfargument name="child" type="string" default="" />
		<cfargument name="child511year" type="string" default="" />
		<cfargument name="child11plus" type="string" default="" />
		<cfargument name="hotelcategory" type="string" default="" />
		<cfargument name="roomsharing" type="string" default="" />
		<cfargument name="vehicletype" type="string" default="" />
		<cfargument name="allss" type="string" default="" />
		<cfargument name="allentry" type="string" default="" />
		<cfargument name="departuredate" type="string" default="" />
		<cfargument name="transporttype" type="string" default="" />
		<cfargument name="traintype" type="string" default="" />
		<cfargument name="foodtype" type="string" default="" />
		<cfargument name="mealplan" type="string" default="" />
		<cfargument name="noofPassenger" type="string" default="" />
		<cfargument name="soundsystem" type="string" default="" />
		<cfargument name="project" type="string" default="" />
		<cfargument name="amt_pmt" type="string" default="" />
		<cfargument name="stagedecoration" type="string" default="" />
		<cfargument name="B2B" type="string" default="" />
		<cfargument name="DJParty" type="string" default="" />
		<cfargument name="cocktailparty" type="string" default="" />
		<cfargument name="artist" type="string" default="" />
		<cfargument name="cultureparty" type="string" default="" />
		<cfargument name="productlaunching" type="string" default="" />
		<cfargument name="sitevisit" type="string" default="" />
		<cfargument name="remark" type="string" default="" />
		<cfargument name="createddate" type="string" default="" />
		<cfargument name="createdby" type="string" default="" />
		
		<!--- run setters --->
		<cfset setId(arguments.Id) />
		<cfset setcompanyname(arguments.companyname) />
		<cfset setcontactperson(arguments.contactperson) />
		<cfset setaddress(arguments.address) />
		<cfset setcity(arguments.city) />
		<cfset setstate(arguments.state) />
		<cfset setcountry(arguments.country) />
		<cfset setzipcode(arguments.zipcode) />
		<cfset setphone1(arguments.phone1) />
		<cfset setphone2(arguments.phone2) />
		<cfset setmobile(arguments.mobile) />
		<cfset setemail(arguments.email) />
		<cfset settourtype(arguments.tourtype) />
		<cfset setdestination(arguments.destination) />
		<cfset settotalpassenger(arguments.totalpassenger) />
		<cfset setadult(arguments.adult) />
		<cfset setchild(arguments.child) />
		<cfset setchild511year(arguments.child511year) />
		<cfset setchild11plus(arguments.child11plus) />
		<cfset sethotelcategory(arguments.hotelcategory) />
		<cfset setroomsharing(arguments.roomsharing) />
		<cfset setvehicletype(arguments.vehicletype) />
		<cfset setallss(arguments.allss) />
		<cfset setallentry(arguments.allentry) />
		<cfset setdeparturedate(arguments.departuredate) />
		<cfset settransporttype(arguments.transporttype) />
		<cfset settraintype(arguments.traintype) />
		<cfset setfoodtype(arguments.foodtype) />
		<cfset setmealplan(arguments.mealplan) />
		<cfset setnoofPassenger(arguments.noofPassenger) />
		<cfset setsoundsystem(arguments.soundsystem) />
		<cfset setproject(arguments.project) />
		<cfset setamt_pmt(arguments.amt_pmt) />
		<cfset setstagedecoration(arguments.stagedecoration) />
		<cfset setB2B(arguments.B2B) />
		<cfset setDJParty(arguments.DJParty) />
		<cfset setcocktailparty(arguments.cocktailparty) />
		<cfset setartist(arguments.artist) />
		<cfset setcultureparty(arguments.cultureparty) />
		<cfset setproductlaunching(arguments.productlaunching) />
		<cfset setsitevisit(arguments.sitevisit) />
		<cfset setremark(arguments.remark) />
		<cfset setcreateddate(arguments.createddate) />
		<cfset setcreatedby(arguments.createdby) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="inquery" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<cfif len(trim(getId())) AND (NOT isvalid("numeric",trim(getId())))>
			<cfset thisError.field = "Id" />
			<cfset thisError.type = "digits" />
			<cfset thisError.message = "Id must be numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcompanyname())) AND (len(trim(getcompanyname())) GT 50) >
			<cfset thisError.field = "companyname" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "companyname no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcontactperson())) AND (len(trim(getcontactperson())) GT 50) >
			<cfset thisError.field = "contactperson" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "contactperson no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getaddress())) AND (len(trim(getaddress())) GT 250) >
			<cfset thisError.field = "address" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "address no more than 250 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcity())) AND (len(trim(getcity())) GT 50) >
			<cfset thisError.field = "city" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "city no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getstate())) AND (len(trim(getstate())) GT 50) >
			<cfset thisError.field = "state" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "state no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcountry())) AND (len(trim(getcountry())) GT 50) >
			<cfset thisError.field = "country" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "country no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getzipcode())) AND (len(trim(getzipcode())) GT 10) >
			<cfset thisError.field = "zipcode" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "zipcode no more than 10 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getphone1())) AND (len(trim(getphone1())) GT 15) >
			<cfset thisError.field = "phone1" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "phone1 no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getphone2())) AND (len(trim(getphone2())) GT 15) >
			<cfset thisError.field = "phone2" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "phone2 no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getmobile())) AND (len(trim(getmobile())) GT 15) >
			<cfset thisError.field = "mobile" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "mobile no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getemail())) AND (len(trim(getemail())) GT 50) >
			<cfset thisError.field = "email" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "email no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(gettourtype())) AND (len(trim(gettourtype())) GT 50) >
			<cfset thisError.field = "tourtype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "tourtype no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getdestination())) AND (len(trim(getdestination())) GT 50) >
			<cfset thisError.field = "destination" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "destination no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(gettotalpassenger())) AND (len(trim(gettotalpassenger())) GT 3) >
			<cfset thisError.field = "totalpassenger" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "totalpassenger no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getadult())) AND (len(trim(getadult())) GT 3) >
			<cfset thisError.field = "adult" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "adult no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getchild())) AND (len(trim(getchild())) GT 3) >
			<cfset thisError.field = "child" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "child no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getchild511year())) AND (len(trim(getchild511year())) GT 3) >
			<cfset thisError.field = "child511year" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "child511year no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getchild11plus())) AND (len(trim(getchild11plus())) GT 3) >
			<cfset thisError.field = "child11plus" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "child11plus no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(gethotelcategory())) AND (len(trim(gethotelcategory())) GT 5) >
			<cfset thisError.field = "hotelcategory" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "hotelcategory no more than 5 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getroomsharing())) AND (len(trim(getroomsharing())) GT 3) >
			<cfset thisError.field = "roomsharing" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "roomsharing no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getvehicletype())) AND (len(trim(getvehicletype())) GT 1) >
			<cfset thisError.field = "vehicletype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "vehicletype no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getallss())) AND (len(trim(getallss())) GT 1) >
			<cfset thisError.field = "allss" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "allss no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getallentry())) AND (len(trim(getallentry())) GT 1) >
			<cfset thisError.field = "allentry" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "allentry no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getdeparturedate())) AND (NOT isvalid("date",trim(getdeparturedate()))) >
			<cfset thisError.field = "departuredate" />
			<cfset thisError.type = "date" />
			<cfset thisError.message = "departuredate is not a valid date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(gettransporttype())) AND (len(trim(gettransporttype())) GT 1) >
			<cfset thisError.field = "transporttype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "transporttype no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(gettraintype())) AND (len(trim(gettraintype())) GT 1) >
			<cfset thisError.field = "traintype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "traintype no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getfoodtype())) AND (len(trim(getfoodtype())) GT 1) >
			<cfset thisError.field = "foodtype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "foodtype no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getmealplan())) AND (len(trim(getmealplan())) GT 1) >
			<cfset thisError.field = "mealplan" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "mealplan no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getnoofPassenger())) AND (len(trim(getnoofPassenger())) GT 3) >
			<cfset thisError.field = "noofPassenger" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "noofPassenger no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getsoundsystem())) AND (len(trim(getsoundsystem())) GT 3) >
			<cfset thisError.field = "soundsystem" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "soundsystem no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getproject())) AND (len(trim(getproject())) GT 3) >
			<cfset thisError.field = "project" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "project no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getamt_pmt())) AND (len(trim(getamt_pmt())) GT 5) >
			<cfset thisError.field = "amt_pmt" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "amt_pmt no more than 5 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getstagedecoration())) AND (len(trim(getstagedecoration())) GT 3) >
			<cfset thisError.field = "stagedecoration" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "stagedecoration no more than 3 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getB2B())) AND (len(trim(getB2B())) GT 15) >
			<cfset thisError.field = "B2B" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "B2B no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getDJParty())) AND (len(trim(getDJParty())) GT 15) >
			<cfset thisError.field = "DJParty" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "DJParty no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcocktailparty())) AND (len(trim(getcocktailparty())) GT 1) >
			<cfset thisError.field = "cocktailparty" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "cocktailparty no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getartist())) AND (len(trim(getartist())) GT 50) >
			<cfset thisError.field = "artist" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "artist no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getcultureparty())) AND (len(trim(getcultureparty())) GT 50) >
			<cfset thisError.field = "cultureparty" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "cultureparty no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getproductlaunching())) AND (len(trim(getproductlaunching())) GT 50) >
			<cfset thisError.field = "productlaunching" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "productlaunching no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getsitevisit())) AND (len(trim(getsitevisit())) GT 1) >
			<cfset thisError.field = "sitevisit" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "sitevisit no more than 1 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getremark())) AND (len(trim(getremark())) GT 250) >
			<cfset thisError.field = "remark" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "remark no more than 250 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif (NOT len(trim(getcreateddate())))>
			<cfset thisError.field = "createddate" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "createddate is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getcreateddate())) AND (NOT isvalid("date",trim(getcreateddate()))) >
			<cfset thisError.field = "createddate" />
			<cfset thisError.type = "date" />
			<cfset thisError.message = "createddate is not a valid date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif (NOT len(trim(getcreatedby())))>
			<cfset thisError.field = "createdby" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "createdby is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getcreatedby())) AND (NOT isvalid("numeric",trim(getcreatedby())))>
			<cfset thisError.field = "createdby" />
			<cfset thisError.type = "digits" />
			<cfset thisError.message = "createdby must be numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="Id" type="string" required="true" />
		<cfset variables.instance.Id = arguments.Id />
	</cffunction>
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Id />
	</cffunction>

	<cffunction name="setcompanyname" access="public" returntype="void" output="false">
		<cfargument name="companyname" type="string" required="true" />
		<cfset variables.instance.companyname = arguments.companyname />
	</cffunction>
	<cffunction name="getcompanyname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.companyname />
	</cffunction>

	<cffunction name="setcontactperson" access="public" returntype="void" output="false">
		<cfargument name="contactperson" type="string" required="true" />
		<cfset variables.instance.contactperson = arguments.contactperson />
	</cffunction>
	<cffunction name="getcontactperson" access="public" returntype="string" output="false">
		<cfreturn variables.instance.contactperson />
	</cffunction>

	<cffunction name="setaddress" access="public" returntype="void" output="false">
		<cfargument name="address" type="string" required="true" />
		<cfset variables.instance.address = arguments.address />
	</cffunction>
	<cffunction name="getaddress" access="public" returntype="string" output="false">
		<cfreturn variables.instance.address />
	</cffunction>

	<cffunction name="setcity" access="public" returntype="void" output="false">
		<cfargument name="city" type="string" required="true" />
		<cfset variables.instance.city = arguments.city />
	</cffunction>
	<cffunction name="getcity" access="public" returntype="string" output="false">
		<cfreturn variables.instance.city />
	</cffunction>

	<cffunction name="setstate" access="public" returntype="void" output="false">
		<cfargument name="state" type="string" required="true" />
		<cfset variables.instance.state = arguments.state />
	</cffunction>
	<cffunction name="getstate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.state />
	</cffunction>

	<cffunction name="setcountry" access="public" returntype="void" output="false">
		<cfargument name="country" type="string" required="true" />
		<cfset variables.instance.country = arguments.country />
	</cffunction>
	<cffunction name="getcountry" access="public" returntype="string" output="false">
		<cfreturn variables.instance.country />
	</cffunction>

	<cffunction name="setzipcode" access="public" returntype="void" output="false">
		<cfargument name="zipcode" type="string" required="true" />
		<cfset variables.instance.zipcode = arguments.zipcode />
	</cffunction>
	<cffunction name="getzipcode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.zipcode />
	</cffunction>

	<cffunction name="setphone1" access="public" returntype="void" output="false">
		<cfargument name="phone1" type="string" required="true" />
		<cfset variables.instance.phone1 = arguments.phone1 />
	</cffunction>
	<cffunction name="getphone1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.phone1 />
	</cffunction>

	<cffunction name="setphone2" access="public" returntype="void" output="false">
		<cfargument name="phone2" type="string" required="true" />
		<cfset variables.instance.phone2 = arguments.phone2 />
	</cffunction>
	<cffunction name="getphone2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.phone2 />
	</cffunction>

	<cffunction name="setmobile" access="public" returntype="void" output="false">
		<cfargument name="mobile" type="string" required="true" />
		<cfset variables.instance.mobile = arguments.mobile />
	</cffunction>
	<cffunction name="getmobile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mobile />
	</cffunction>

	<cffunction name="setemail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.instance.email = arguments.email />
	</cffunction>
	<cffunction name="getemail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.email />
	</cffunction>

	<cffunction name="settourtype" access="public" returntype="void" output="false">
		<cfargument name="tourtype" type="string" required="true" />
		<cfset variables.instance.tourtype = arguments.tourtype />
	</cffunction>
	<cffunction name="gettourtype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.tourtype />
	</cffunction>

	<cffunction name="setdestination" access="public" returntype="void" output="false">
		<cfargument name="destination" type="string" required="true" />
		<cfset variables.instance.destination = arguments.destination />
	</cffunction>
	<cffunction name="getdestination" access="public" returntype="string" output="false">
		<cfreturn variables.instance.destination />
	</cffunction>

	<cffunction name="settotalpassenger" access="public" returntype="void" output="false">
		<cfargument name="totalpassenger" type="string" required="true" />
		<cfset variables.instance.totalpassenger = arguments.totalpassenger />
	</cffunction>
	<cffunction name="gettotalpassenger" access="public" returntype="string" output="false">
		<cfreturn variables.instance.totalpassenger />
	</cffunction>

	<cffunction name="setadult" access="public" returntype="void" output="false">
		<cfargument name="adult" type="string" required="true" />
		<cfset variables.instance.adult = arguments.adult />
	</cffunction>
	<cffunction name="getadult" access="public" returntype="string" output="false">
		<cfreturn variables.instance.adult />
	</cffunction>

	<cffunction name="setchild" access="public" returntype="void" output="false">
		<cfargument name="child" type="string" required="true" />
		<cfset variables.instance.child = arguments.child />
	</cffunction>
	<cffunction name="getchild" access="public" returntype="string" output="false">
		<cfreturn variables.instance.child />
	</cffunction>

	<cffunction name="setchild511year" access="public" returntype="void" output="false">
		<cfargument name="child511year" type="string" required="true" />
		<cfset variables.instance.child511year = arguments.child511year />
	</cffunction>
	<cffunction name="getchild511year" access="public" returntype="string" output="false">
		<cfreturn variables.instance.child511year />
	</cffunction>

	<cffunction name="setchild11plus" access="public" returntype="void" output="false">
		<cfargument name="child11plus" type="string" required="true" />
		<cfset variables.instance.child11plus = arguments.child11plus />
	</cffunction>
	<cffunction name="getchild11plus" access="public" returntype="string" output="false">
		<cfreturn variables.instance.child11plus />
	</cffunction>

	<cffunction name="sethotelcategory" access="public" returntype="void" output="false">
		<cfargument name="hotelcategory" type="string" required="true" />
		<cfset variables.instance.hotelcategory = arguments.hotelcategory />
	</cffunction>
	<cffunction name="gethotelcategory" access="public" returntype="string" output="false">
		<cfreturn variables.instance.hotelcategory />
	</cffunction>

	<cffunction name="setroomsharing" access="public" returntype="void" output="false">
		<cfargument name="roomsharing" type="string" required="true" />
		<cfset variables.instance.roomsharing = arguments.roomsharing />
	</cffunction>
	<cffunction name="getroomsharing" access="public" returntype="string" output="false">
		<cfreturn variables.instance.roomsharing />
	</cffunction>

	<cffunction name="setvehicletype" access="public" returntype="void" output="false">
		<cfargument name="vehicletype" type="string" required="true" />
		<cfset variables.instance.vehicletype = arguments.vehicletype />
	</cffunction>
	<cffunction name="getvehicletype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.vehicletype />
	</cffunction>

	<cffunction name="setallss" access="public" returntype="void" output="false">
		<cfargument name="allss" type="string" required="true" />
		<cfset variables.instance.allss = arguments.allss />
	</cffunction>
	<cffunction name="getallss" access="public" returntype="string" output="false">
		<cfreturn variables.instance.allss />
	</cffunction>

	<cffunction name="setallentry" access="public" returntype="void" output="false">
		<cfargument name="allentry" type="string" required="true" />
		<cfset variables.instance.allentry = arguments.allentry />
	</cffunction>
	<cffunction name="getallentry" access="public" returntype="string" output="false">
		<cfreturn variables.instance.allentry />
	</cffunction>

	<cffunction name="setdeparturedate" access="public" returntype="void" output="false">
		<cfargument name="departuredate" type="string" required="true" />
		<cfset variables.instance.departuredate = arguments.departuredate />
	</cffunction>
	<cffunction name="getdeparturedate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.departuredate />
	</cffunction>

	<cffunction name="settransporttype" access="public" returntype="void" output="false">
		<cfargument name="transporttype" type="string" required="true" />
		<cfset variables.instance.transporttype = arguments.transporttype />
	</cffunction>
	<cffunction name="gettransporttype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.transporttype />
	</cffunction>

	<cffunction name="settraintype" access="public" returntype="void" output="false">
		<cfargument name="traintype" type="string" required="true" />
		<cfset variables.instance.traintype = arguments.traintype />
	</cffunction>
	<cffunction name="gettraintype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.traintype />
	</cffunction>

	<cffunction name="setfoodtype" access="public" returntype="void" output="false">
		<cfargument name="foodtype" type="string" required="true" />
		<cfset variables.instance.foodtype = arguments.foodtype />
	</cffunction>
	<cffunction name="getfoodtype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.foodtype />
	</cffunction>

	<cffunction name="setmealplan" access="public" returntype="void" output="false">
		<cfargument name="mealplan" type="string" required="true" />
		<cfset variables.instance.mealplan = arguments.mealplan />
	</cffunction>
	<cffunction name="getmealplan" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mealplan />
	</cffunction>

	<cffunction name="setnoofPassenger" access="public" returntype="void" output="false">
		<cfargument name="noofPassenger" type="string" required="true" />
		<cfset variables.instance.noofPassenger = arguments.noofPassenger />
	</cffunction>
	<cffunction name="getnoofPassenger" access="public" returntype="string" output="false">
		<cfreturn variables.instance.noofPassenger />
	</cffunction>

	<cffunction name="setsoundsystem" access="public" returntype="void" output="false">
		<cfargument name="soundsystem" type="string" required="true" />
		<cfset variables.instance.soundsystem = arguments.soundsystem />
	</cffunction>
	<cffunction name="getsoundsystem" access="public" returntype="string" output="false">
		<cfreturn variables.instance.soundsystem />
	</cffunction>

	<cffunction name="setproject" access="public" returntype="void" output="false">
		<cfargument name="project" type="string" required="true" />
		<cfset variables.instance.project = arguments.project />
	</cffunction>
	<cffunction name="getproject" access="public" returntype="string" output="false">
		<cfreturn variables.instance.project />
	</cffunction>

	<cffunction name="setamt_pmt" access="public" returntype="void" output="false">
		<cfargument name="amt_pmt" type="string" required="true" />
		<cfset variables.instance.amt_pmt = arguments.amt_pmt />
	</cffunction>
	<cffunction name="getamt_pmt" access="public" returntype="string" output="false">
		<cfreturn variables.instance.amt_pmt />
	</cffunction>

	<cffunction name="setstagedecoration" access="public" returntype="void" output="false">
		<cfargument name="stagedecoration" type="string" required="true" />
		<cfset variables.instance.stagedecoration = arguments.stagedecoration />
	</cffunction>
	<cffunction name="getstagedecoration" access="public" returntype="string" output="false">
		<cfreturn variables.instance.stagedecoration />
	</cffunction>

	<cffunction name="setB2B" access="public" returntype="void" output="false">
		<cfargument name="B2B" type="string" required="true" />
		<cfset variables.instance.B2B = arguments.B2B />
	</cffunction>
	<cffunction name="getB2B" access="public" returntype="string" output="false">
		<cfreturn variables.instance.B2B />
	</cffunction>

	<cffunction name="setDJParty" access="public" returntype="void" output="false">
		<cfargument name="DJParty" type="string" required="true" />
		<cfset variables.instance.DJParty = arguments.DJParty />
	</cffunction>
	<cffunction name="getDJParty" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DJParty />
	</cffunction>

	<cffunction name="setcocktailparty" access="public" returntype="void" output="false">
		<cfargument name="cocktailparty" type="string" required="true" />
		<cfset variables.instance.cocktailparty = arguments.cocktailparty />
	</cffunction>
	<cffunction name="getcocktailparty" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cocktailparty />
	</cffunction>

	<cffunction name="setartist" access="public" returntype="void" output="false">
		<cfargument name="artist" type="string" required="true" />
		<cfset variables.instance.artist = arguments.artist />
	</cffunction>
	<cffunction name="getartist" access="public" returntype="string" output="false">
		<cfreturn variables.instance.artist />
	</cffunction>

	<cffunction name="setcultureparty" access="public" returntype="void" output="false">
		<cfargument name="cultureparty" type="string" required="true" />
		<cfset variables.instance.cultureparty = arguments.cultureparty />
	</cffunction>
	<cffunction name="getcultureparty" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cultureparty />
	</cffunction>

	<cffunction name="setproductlaunching" access="public" returntype="void" output="false">
		<cfargument name="productlaunching" type="string" required="true" />
		<cfset variables.instance.productlaunching = arguments.productlaunching />
	</cffunction>
	<cffunction name="getproductlaunching" access="public" returntype="string" output="false">
		<cfreturn variables.instance.productlaunching />
	</cffunction>

	<cffunction name="setsitevisit" access="public" returntype="void" output="false">
		<cfargument name="sitevisit" type="string" required="true" />
		<cfset variables.instance.sitevisit = arguments.sitevisit />
	</cffunction>
	<cffunction name="getsitevisit" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitevisit />
	</cffunction>

	<cffunction name="setremark" access="public" returntype="void" output="false">
		<cfargument name="remark" type="string" required="true" />
		<cfset variables.instance.remark = arguments.remark />
	</cffunction>
	<cffunction name="getremark" access="public" returntype="string" output="false">
		<cfreturn variables.instance.remark />
	</cffunction>

	<cffunction name="setcreateddate" access="public" returntype="void" output="false">
		<cfargument name="createddate" type="string" required="true" />
		<cfset variables.instance.createddate = arguments.createddate />
	</cffunction>
	<cffunction name="getcreateddate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.createddate />
	</cffunction>

	<cffunction name="setcreatedby" access="public" returntype="void" output="false">
		<cfargument name="createdby" type="string" required="true" />
		<cfset variables.instance.createdby = arguments.createdby />
	</cffunction>
	<cffunction name="getcreatedby" access="public" returntype="string" output="false">
		<cfreturn variables.instance.createdby />
	</cffunction>

</cfcomponent>

