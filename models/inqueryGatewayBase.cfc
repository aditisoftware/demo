
<cfcomponent displayname="inqueryGateway" output="false">
	
	<cffunction name="init" access="public" output="false" returntype="inqueryGateway">
		<cfargument name="dsn" required="true" inject="coldbox:datasource:demo" />
		<cfset variables.dsn = arguments.dsn.Name >
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="Id" type="numeric" required="false" />
		<cfargument name="companyname" type="string" required="false" />
		<cfargument name="contactperson" type="string" required="false" />
		<cfargument name="address" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="zipcode" type="string" required="false" />
		<cfargument name="phone1" type="string" required="false" />
		<cfargument name="phone2" type="string" required="false" />
		<cfargument name="mobile" type="string" required="false" />
		<cfargument name="email" type="string" required="false" />
		<cfargument name="tourtype" type="string" required="false" />
		<cfargument name="destination" type="string" required="false" />
		<cfargument name="totalpassenger" type="string" required="false" />
		<cfargument name="adult" type="string" required="false" />
		<cfargument name="child" type="string" required="false" />
		<cfargument name="child511year" type="string" required="false" />
		<cfargument name="child11plus" type="string" required="false" />
		<cfargument name="hotelcategory" type="string" required="false" />
		<cfargument name="roomsharing" type="string" required="false" />
		<cfargument name="vehicletype" type="string" required="false" />
		<cfargument name="departuredate" type="date" required="false" />
		<cfargument name="transporttype" type="string" required="false" />
		<cfargument name="traintype" type="string" required="false" />
		<cfargument name="foodtype" type="string" required="false" />
		<cfargument name="mealplan" type="string" required="false" />
		<cfargument name="soundsystem" type="string" required="false" />
		<cfargument name="project" type="string" required="false" />
		<cfargument name="amt_pmt" type="string" required="false" />
		<cfargument name="stagedecoration" type="string" required="false" />
		<cfargument name="B2B" type="string" required="false" />
		<cfargument name="DJParty" type="string" required="false" />
		<cfargument name="cocktailparty" type="string" required="false" />
		<cfargument name="artist" type="string" required="false" />
		<cfargument name="cultureparty" type="string" required="false" />
		<cfargument name="productlaunching" type="string" required="false" />
		<cfargument name="sitevisit" type="string" required="false" />
		<cfargument name="remark" type="string" required="false" />
		<cfargument name="createddate" type="date" required="false" />
		<cfargument name="createdby" type="numeric" required="false" />
		<cfargument name="tourid" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="infant" type="string" required="false" />
		<cfargument name="tourname" type="string" required="false" />
		<cfargument name="tourcode" type="string" required="false" />
		<cfargument name="schoolname" type="string" required="false" />
		<cfargument name="totaldays" type="string" required="false" />
		<cfargument name="entryfees" type="string" required="false" />
		<cfargument name="hotelrooms" type="string" required="false" />
		<cfargument name="extramatress" type="string" required="false" />
		<cfargument name="mealplan" type="string" required="false" />
		<cfargument name="vehicle" type="string" required="false" />

		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","inquery").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="Id" type="numeric" required="false" />
		<cfargument name="companyname" type="string" required="false" />
		<cfargument name="contactperson" type="string" required="false" />
		<cfargument name="address" type="string" required="false" />
		<cfargument name="city" type="string" required="false" />
		<cfargument name="state" type="string" required="false" />
		<cfargument name="country" type="string" required="false" />
		<cfargument name="zipcode" type="string" required="false" />
		<cfargument name="phone1" type="string" required="false" />
		<cfargument name="phone2" type="string" required="false" />
		<cfargument name="mobile" type="string" required="false" />
		<cfargument name="email" type="string" required="false" />
		<cfargument name="tourtype" type="string" required="false" />
		<cfargument name="destination" type="string" required="false" />
		<cfargument name="totalpassenger" type="string" required="false" />
		<cfargument name="adult" type="string" required="false" />
		<cfargument name="child" type="string" required="false" />
		<cfargument name="child511year" type="string" required="false" />
		<cfargument name="child11plus" type="string" required="false" />
		<cfargument name="hotelcategory" type="string" required="false" />
		<cfargument name="roomsharing" type="string" required="false" />
		<cfargument name="vehicletype" type="string" required="false" />
		<cfargument name="departuredate" type="date" required="false" />
		<cfargument name="transporttype" type="string" required="false" />
		<cfargument name="traintype" type="string" required="false" />
		<cfargument name="foodtype" type="string" required="false" />
		<cfargument name="mealplan" type="string" required="false" />
		<cfargument name="soundsystem" type="string" required="false" />
		<cfargument name="project" type="string" required="false" />
		<cfargument name="amt_pmt" type="string" required="false" />
		<cfargument name="stagedecoration" type="string" required="false" />
		<cfargument name="B2B" type="string" required="false" />
		<cfargument name="DJParty" type="string" required="false" />
		<cfargument name="cocktailparty" type="string" required="false" />
		<cfargument name="artist" type="string" required="false" />
		<cfargument name="cultureparty" type="string" required="false" />
		<cfargument name="productlaunching" type="string" required="false" />
		<cfargument name="sitevisit" type="string" required="false" />
		<cfargument name="remark" type="string" required="false" />
		<cfargument name="createddate" type="date" required="false" />
		<cfargument name="createdby" type="numeric" required="false" />
		<cfargument name="tourid" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="infant" type="string" required="false" />
		<cfargument name="tourname" type="string" required="false" />
		<cfargument name="tourcode" type="string" required="false" />
		<cfargument name="schoolname" type="string" required="false" />
		<cfargument name="totaldays" type="string" required="false" />
		<cfargument name="entryfees" type="string" required="false" />
		<cfargument name="hotelrooms" type="string" required="false" />
		<cfargument name="extramatress" type="string" required="false" />
		<cfargument name="mealplan" type="string" required="false" />
		<cfargument name="vehicle" type="string" required="false" />

		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#">
			SELECT	
				inquery.Id,
				inquery.companyname,
				inquery.contactperson,
				inquery.address,
				inquery.city,
				inquery.state,
				inquery.country,
				inquery.zipcode,
				inquery.phone1,
				inquery.phone2,
				inquery.mobile,
				inquery.email,
				inquery.tourtype,
				inquery.destination,
				inquery.totalpassenger,
				inquery.adult,
				inquery.child,
				inquery.child511year,
				inquery.child11plus,
				inquery.hotelcategory,
				inquery.roomsharing,
				inquery.vehicletype,
				inquery.departuredate,
				inquery.transporttype,
				inquery.traintype,
				inquery.foodtype,
				inquery.mealplan,
				inquery.soundsystem,
				inquery.project,
				inquery.amt_pmt,
				inquery.stagedecoration,
				inquery.B2B,
				inquery.DJParty,
				inquery.cocktailparty,
				inquery.artist,
				inquery.cultureparty,
				inquery.productlaunching,
				inquery.sitevisit,
				inquery.remark,
				inquery.createddate,
				inquery.createdby,
				inquery.tourid,
				inquery.infant,
				inquery.tourname,
				inquery.tourcode,
				inquery.schoolname,
				inquery.totaldays,
				inquery.entryfees,
				inquery.hotelrooms,
				inquery.extramatress,
				inquery.mealplan,
				inquery.vehicle
			FROM `inquery`
			WHERE 0=0
			<cfif structKeyExists(arguments,"Id") and len(arguments.Id)>
				AND	inquery.Id = <cfqueryparam value="#arguments.Id#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"companyname") and len(arguments.companyname)>
				AND	inquery.companyname = <cfqueryparam value="#arguments.companyname#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"contactperson") and len(arguments.contactperson)>
				AND	inquery.contactperson = <cfqueryparam value="#arguments.contactperson#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"address") and len(arguments.address)>
				AND	inquery.address = <cfqueryparam value="#arguments.address#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"city") and len(arguments.city)>
				AND	inquery.city = <cfqueryparam value="#arguments.city#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"state") and len(arguments.state)>
				AND	inquery.state = <cfqueryparam value="#arguments.state#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"country") and len(arguments.country)>
				AND	inquery.country = <cfqueryparam value="#arguments.country#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"zipcode") and len(arguments.zipcode)>
				AND	inquery.zipcode = <cfqueryparam value="#arguments.zipcode#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"phone1") and len(arguments.phone1)>
				AND	inquery.phone1 = <cfqueryparam value="#arguments.phone1#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"phone2") and len(arguments.phone2)>
				AND	inquery.phone2 = <cfqueryparam value="#arguments.phone2#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"mobile") and len(arguments.mobile)>
				AND	inquery.mobile = <cfqueryparam value="#arguments.mobile#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"email") and len(arguments.email)>
				AND	inquery.email = <cfqueryparam value="#arguments.email#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"tourtype") and len(arguments.tourtype)>
				AND	inquery.tourtype = <cfqueryparam value="#arguments.tourtype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"destination") and len(arguments.destination)>
				AND	inquery.destination = <cfqueryparam value="#arguments.destination#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"totalpassenger") and len(arguments.totalpassenger)>
				AND	inquery.totalpassenger = <cfqueryparam value="#arguments.totalpassenger#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"adult") and len(arguments.adult)>
				AND	inquery.adult = <cfqueryparam value="#arguments.adult#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"child") and len(arguments.child)>
				AND	inquery.child = <cfqueryparam value="#arguments.child#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"child511year") and len(arguments.child511year)>
				AND	inquery.child511year = <cfqueryparam value="#arguments.child511year#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"child11plus") and len(arguments.child11plus)>
				AND	inquery.child11plus = <cfqueryparam value="#arguments.child11plus#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"hotelcategory") and len(arguments.hotelcategory)>
				AND	inquery.hotelcategory = <cfqueryparam value="#arguments.hotelcategory#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"roomsharing") and len(arguments.roomsharing)>
				AND	inquery.roomsharing = <cfqueryparam value="#arguments.roomsharing#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"vehicletype") and len(arguments.vehicletype)>
				AND	inquery.vehicletype = <cfqueryparam value="#arguments.vehicletype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"departuredate") and len(arguments.departuredate)>
				AND	inquery.departuredate = <cfqueryparam value="#arguments.departuredate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<cfif structKeyExists(arguments,"transporttype") and len(arguments.transporttype)>
				AND	inquery.transporttype = <cfqueryparam value="#arguments.transporttype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"traintype") and len(arguments.traintype)>
				AND	inquery.traintype = <cfqueryparam value="#arguments.traintype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"foodtype") and len(arguments.foodtype)>
				AND	inquery.foodtype = <cfqueryparam value="#arguments.foodtype#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"mealplan") and len(arguments.mealplan)>
				AND	inquery.mealplan = <cfqueryparam value="#arguments.mealplan#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"soundsystem") and len(arguments.soundsystem)>
				AND	inquery.soundsystem = <cfqueryparam value="#arguments.soundsystem#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"project") and len(arguments.project)>
				AND	inquery.project = <cfqueryparam value="#arguments.project#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"amt_pmt") and len(arguments.amt_pmt)>
				AND	inquery.amt_pmt = <cfqueryparam value="#arguments.amt_pmt#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"stagedecoration") and len(arguments.stagedecoration)>
				AND	inquery.stagedecoration = <cfqueryparam value="#arguments.stagedecoration#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"B2B") and len(arguments.B2B)>
				AND	inquery.B2B = <cfqueryparam value="#arguments.B2B#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"DJParty") and len(arguments.DJParty)>
				AND	inquery.DJParty = <cfqueryparam value="#arguments.DJParty#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"cocktailparty") and len(arguments.cocktailparty)>
				AND	inquery.cocktailparty = <cfqueryparam value="#arguments.cocktailparty#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"artist") and len(arguments.artist)>
				AND	inquery.artist = <cfqueryparam value="#arguments.artist#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"cultureparty") and len(arguments.cultureparty)>
				AND	inquery.cultureparty = <cfqueryparam value="#arguments.cultureparty#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"productlaunching") and len(arguments.productlaunching)>
				AND	inquery.productlaunching = <cfqueryparam value="#arguments.productlaunching#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"sitevisit") and len(arguments.sitevisit)>
				AND	inquery.sitevisit = <cfqueryparam value="#arguments.sitevisit#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"remark") and len(arguments.remark)>
				AND	inquery.remark = <cfqueryparam value="#arguments.remark#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"createddate") and len(arguments.createddate)>
				AND	inquery.createddate = <cfqueryparam value="#arguments.createddate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<cfif structKeyExists(arguments,"createdby") and len(arguments.createdby)>
				AND	inquery.createdby = <cfqueryparam value="#arguments.createdby#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"tourid") and len(arguments.tourid)>
				AND	inquery.tourid = <cfqueryparam value="#arguments.tourid#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"infant") and len(arguments.infant)>
				AND inquery.infant = <cfqueryparam value="#arguments.infant#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"tourname") and len(arguments.tourname)>
				AND inquery.tourname = <cfqueryparam value="#arguments.tourname#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"tourcode") and len(arguments.tourcode)>
				AND inquery.tourcode = <cfqueryparam value="#arguments.tourcode#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"schoolname") and len(arguments.schoolname)>
				AND inquery.schoolname = <cfqueryparam value="#arguments.schoolname#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"totaldays") and len(arguments.totaldays)>
				AND inquery.totaldays = <cfqueryparam value="#arguments.totaldays#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"entryfees") and len(arguments.entryfees)>
				AND inquery.entryfees = <cfqueryparam value="#arguments.entryfees#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"hotelrooms") and len(arguments.hotelrooms)>
				AND inquery.hotelrooms = <cfqueryparam value="#arguments.hotelrooms#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"extramatress") and len(arguments.extramatress)>
				AND inquery.extramatress = <cfqueryparam value="#arguments.extramatress#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"mealplan") and len(arguments.mealplan)>
				AND inquery.mealplan = <cfqueryparam value="#arguments.mealplan#" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"vehicle") and len(arguments.vehicle)>
				AND inquery.vehicle = <cfqueryparam value="#arguments.vehicle#" CFSQLType="cf_sql_varchar" />
			</cfif>

			<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
				ORDER BY #arguments.orderby#
			</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>
	
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
		<cfargument name="pagesize" default="30">
		<cfargument name="gridsortcolumn" default="Id">
		<cfargument name="gridstartdirection" default="">
		<cfargument name="searchname" default="" >
		<cfargument name="searchcity" default="" >
		<cfargument name="searchcreatedby" default="" >
		<cfset var startrow = (arguments.page-1) * arguments.pagesize>		
		<cfset var gridstruct = structNew()>
		
		<cfquery name="gridstruct.query" datasource="#variables.dsn#">
			SELECT 
				inquery.Id,
				inquery.companyname,
				inquery.contactperson,
				inquery.address,
				inquery.city,
				inquery.state,
				inquery.country,
				inquery.zipcode,
				inquery.phone1,
				inquery.phone2,
				inquery.mobile,
				inquery.email,
				inquery.tourtype,
				inquery.destination,
				inquery.totalpassenger,
				inquery.adult,
				inquery.child,
				inquery.child511year,
				inquery.child11plus,
				inquery.hotelcategory,
				inquery.roomsharing,
				inquery.vehicletype,
				inquery.departuredate,
				inquery.transporttype,
				inquery.traintype,
				inquery.foodtype,
				inquery.mealplan,
				inquery.soundsystem,
				inquery.project,
				inquery.amt_pmt,
				inquery.stagedecoration,
				inquery.B2B,
				inquery.DJParty,
				inquery.cocktailparty,
				inquery.artist,
				inquery.cultureparty,
				inquery.productlaunching,
				inquery.sitevisit,
				inquery.remark,
				inquery.createddate,
				(SELECT CONCAT(firstName," ",lastname) FROM usermaster WHERE id = inquery.createdby) as created,
				inquery.createdby,
				inquery.tourid
			FROM `inquery` where 1 = 1 
			<cfif structKeyExists(arguments,"searchname") and len(arguments.searchname)>
				AND	inquery.contactperson like <cfqueryparam value="%#arguments.searchname#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"searchcity") and len(arguments.searchcity)>
				AND	inquery.city like <cfqueryparam value="%#arguments.searchcity#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"createddate") and len(arguments.createddate)>
				AND	inquery.createddate = <cfqueryparam value="#arguments.createddate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<cfif structKeyExists(arguments,"searchcreatedby") and len(arguments.searchcreatedby)>
				AND	inquery.createdby = <cfqueryparam value="#arguments.searchcreatedby#" CFSQLType="cf_sql_integer" />
			</cfif>
			ORDER BY #arguments.gridsortcolumn# #arguments.gridstartdirection#
			LIMIT #StartRow#, #pagesize#
		</cfquery>
		
		<cfquery name="qTotalRecord" datasource="#variables.dsn#">
			SELECT COUNT(*) AS CountAll FROM `inquery` where 1 = 1 
			<cfif structKeyExists(arguments,"searchname") and len(arguments.searchname)>
				AND	inquery.contactperson like <cfqueryparam value="%#arguments.searchname#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"searchcity") and len(arguments.searchcity)>
				AND	inquery.city like <cfqueryparam value="%#arguments.searchcity#%" CFSQLType="cf_sql_varchar" />
			</cfif>
			<cfif structKeyExists(arguments,"createddate") and len(arguments.createddate)>
				AND	inquery.createddate = <cfqueryparam value="#arguments.createddate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<cfif structKeyExists(arguments,"searchcreatedby") and len(arguments.searchcreatedby)>
				AND	inquery.createdby = <cfqueryparam value="#arguments.searchcreatedby#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		
		<cfset gridstruct.totalrowcount=qTotalRecord.countall>
          
		<cfreturn gridstruct>
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			var row = 1;
			var ii = 1;
			var cols = listToArray(qry.columnList);
			var stReturn = structnew();
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			return stReturn;
		</cfscript>
	</cffunction>
	
</cfcomponent>

