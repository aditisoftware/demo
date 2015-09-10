
<cfcomponent name="inqueryService" output="false" cache="true" cachetimeout="30">
	<cfproperty name="inqueryDAO" inject="model:inqueryDAO" scope="instance" />
	<cfproperty name="inqueryGateway" inject="model:inqueryGateway" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="inqueryService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createinquery" access="public" output="false" returntype="inquery">
		<cfargument name="Id" type="string" required="false" />
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
		<cfargument name="allss" type="string" required="false" />
		<cfargument name="allentry" type="string" required="false" />
		<cfargument name="departuredate" type="string" required="false" />
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
		<cfargument name="createddate" type="string" required="false" />
		<cfargument name="createdby" type="string" required="false" />
		<cfargument name="tourid" type="string" required="false" />
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


		<cfset var minquery = createObject("component","inquery").init(argumentCollection=arguments) />
		<cfreturn minquery />
	</cffunction>
	
	<cffunction name="deleteinquery" access="public" output="false" returntype="struct">
		<cfargument name="Id" type="numeric" required="true" />
		
		<cfset var retStruct = structNew()>
		<cfset var structErr = structNew()>
		<cfset var inquery = "" >

		<cfset retStruct.success = true>
		<cfset retStruct.errors = arrayNew(1)>
		<cftry>
			<cfset inquery = createinquery(argumentCollection=arguments) />
			<cfset instance.inqueryDAO.delete(inquery) />
		<cfcatch>
			<cfset retStruct.success = false>
			<cfset structErr = structNew()>
			<cfset structErr["errorCode"] = "dbException">
			<cfset structErr["message"] = cfcatch.message>
			<cfset arrayAppend(retStruct.errors,duplicate(structErr))>
		</cfcatch>
		</cftry>
		<cfreturn retStruct />
	</cffunction>
	
	<cffunction name="getinquery" access="public" output="false" returntype="inquery">
		<cfargument name="Id" type="numeric" required="true" />
		
		<cfset var inquery = createinquery(argumentCollection=arguments) />
		<cfset instance.inqueryDAO.read(inquery) />
		<cfreturn inquery />
	</cffunction>
	
	<cffunction name="getinquerys" access="public" output="false" returntype="any">
		<cfargument name="datatype" type="string" required="false" default="query" hint="query or array" >
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
		<cfargument name="allss" type="string" required="false" />
		<cfargument name="allentry" type="string" required="false" />
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
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="tourid" type="string" required="false" />
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

		<cfif arguments.datatype eq "query">
			<cfreturn instance.inqueryGateway.getByAttributesQuery(argumentCollection=arguments) />
		<cfelse>
			<cfreturn instance.inqueryGateway.getByAttributes(argumentCollection=arguments) />
		</cfif>
	</cffunction>
	
	<cffunction name="getBypage" access="public" returntype="any" output="false">
		<cfargument name="page" default="1">
	    <cfargument name="pagesize" default="30">
	    <cfargument name="gridsortcolumn" default="Id">
	    <cfargument name="gridstartdirection" default="">
		<cfargument name="searchname" default="" >
		<cfargument name="searchcity" default="" >
		<cfargument name="searchcreatedby" default="" >
		<cfreturn instance.inqueryGateway.getBypage(argumentCollection=arguments) />
		
	</cffunction>
	
	<cffunction name="saveinquery" access="public" output="false" returntype="struct">
		<cfargument name="inquery" type="inquery" required="true" />
		<cfset var retStruct = structNew()>
		<cfset var structErr = structNew()>
		<cfset var retArray = "">

		<cfset retStruct.success = true>
		<cfset retStruct.errors = arrayNew(1)>
		<cfset retArray = arguments.inquery.validate()>
		<cfif arrayIsEmpty(retArray)>
			<cfset retStruct.inquery = instance.inqueryDAO.save(inquery) />
		<cfelse>
			<cfset retStruct.success = false> 
			<cfset retStruct.errors = retArray />
		</cfif>
		<cfreturn retStruct />
		
	</cffunction>
</cfcomponent>

