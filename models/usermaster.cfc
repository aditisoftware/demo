
<cfcomponent displayname="usermaster" output="false">
	<cfproperty name="Id" type="numeric" default="" />
	<cfproperty name="firstname" type="string" default="" />
	<cfproperty name="lastname" type="string" default="" />
	<cfproperty name="address1" type="string" default="" />
	<cfproperty name="address2" type="string" default="" />
	<cfproperty name="city" type="string" default="" />
	<cfproperty name="state" type="string" default="" />
	<cfproperty name="country" type="string" default="" />
	<cfproperty name="username" type="string" default="" />
	<cfproperty name="password" type="string" default="" />
	<cfproperty name="passwordsalt" type="string" default="" />
	<cfproperty name="usertype" type="string" default="" />
	<cfproperty name="createddate" type="date" default="" />
	<cfproperty name="createdby" type="numeric" default="" />
	
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="usermaster" output="false">
		<cfargument name="Id" type="string" default="" />
		<cfargument name="firstname" type="string" default="" />
		<cfargument name="lastname" type="string" default="" />
		<cfargument name="address1" type="string" default="" />
		<cfargument name="address2" type="string" default="" />
		<cfargument name="city" type="string" default="" />
		<cfargument name="state" type="string" default="" />
		<cfargument name="country" type="string" default="" />
		<cfargument name="username" type="string" default="" />
		<cfargument name="password" type="string" default="" />
		<cfargument name="passwordsalt" type="string" default="" />		
		<cfargument name="usertype" type="string" default="" />
		<cfargument name="createddate" type="string" default="" />
		<cfargument name="createdby" type="string" default="" />
		
		<!--- run setters --->
		<cfset setId(arguments.Id) />
		<cfset setfirstname(arguments.firstname) />
		<cfset setlastname(arguments.lastname) />
		<cfset setaddress1(arguments.address1) />
		<cfset setaddress2(arguments.address2) />
		<cfset setcity(arguments.city) />
		<cfset setstate(arguments.state) />
		<cfset setcountry(arguments.country) />
		<cfset setusername(arguments.username) />
		<cfset setpassword(arguments.password) />
		<cfset setpasswordsalt(arguments.passwordsalt) />
		<cfset setusertype(arguments.usertype) />
		<cfset setcreateddate(arguments.createddate) />
		<cfset setcreatedby(arguments.createdby) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="usermaster" output="false">
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
		
		<cfif (NOT len(trim(getfirstname())))>
			<cfset thisError.field = "firstname" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "firstname is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getfirstname())) AND (len(trim(getfirstname())) GT 50) >
			<cfset thisError.field = "firstname" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "firstname no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif (NOT len(trim(getlastname())))>
			<cfset thisError.field = "lastname" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "lastname is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getlastname())) AND (len(trim(getlastname())) GT 50) >
			<cfset thisError.field = "lastname" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "lastname no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getaddress1())) AND (len(trim(getaddress1())) GT 50) >
			<cfset thisError.field = "address1" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "address1 no more than 50 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getaddress2())) AND (len(trim(getaddress2())) GT 50) >
			<cfset thisError.field = "address2" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "address2 no more than 50 characters" />
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
		
		<cfif (NOT len(trim(getusername())))>
			<cfset thisError.field = "username" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "username is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getusername())) AND (len(trim(getusername())) GT 15) >
			<cfset thisError.field = "username" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "username no more than 15 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif (NOT len(trim(getpassword())))>
			<cfset thisError.field = "password" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "password is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getpassword())) AND (len(trim(getpassword())) GT 128) >
			<cfset thisError.field = "password" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "password no more than 128 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<cfif (NOT len(trim(getpasswordsalt())))>
			<cfset thisError.field = "passwordsalt" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "passwordsalt is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> 
		<cfif len(trim(getpasswordsalt())) AND (len(trim(getpasswordsalt())) GT 128) >
			<cfset thisError.field = "passwordsalt" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "passwordsalt no more than 128 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfif len(trim(getusertype())) AND (len(trim(getusertype())) GT 10) >
			<cfset thisError.field = "usertype" />
			<cfset thisError.type = "maxlength" />
			<cfset thisError.message = "usertype no more than 10 characters" />
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

	<cffunction name="setfirstname" access="public" returntype="void" output="false">
		<cfargument name="firstname" type="string" required="true" />
		<cfset variables.instance.firstname = arguments.firstname />
	</cffunction>
	<cffunction name="getfirstname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.firstname />
	</cffunction>

	<cffunction name="setlastname" access="public" returntype="void" output="false">
		<cfargument name="lastname" type="string" required="true" />
		<cfset variables.instance.lastname = arguments.lastname />
	</cffunction>
	<cffunction name="getlastname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lastname />
	</cffunction>

	<cffunction name="setaddress1" access="public" returntype="void" output="false">
		<cfargument name="address1" type="string" required="true" />
		<cfset variables.instance.address1 = arguments.address1 />
	</cffunction>
	<cffunction name="getaddress1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.address1 />
	</cffunction>

	<cffunction name="setaddress2" access="public" returntype="void" output="false">
		<cfargument name="address2" type="string" required="true" />
		<cfset variables.instance.address2 = arguments.address2 />
	</cffunction>
	<cffunction name="getaddress2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.address2 />
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

	<cffunction name="setusername" access="public" returntype="void" output="false">
		<cfargument name="username" type="string" required="true" />
		<cfset variables.instance.username = arguments.username />
	</cffunction>
	<cffunction name="getusername" access="public" returntype="string" output="false">
		<cfreturn variables.instance.username />
	</cffunction>

	<cffunction name="setpassword" access="public" returntype="void" output="false">
		<cfargument name="password" type="string" required="true" />
		<cfset variables.instance.password = arguments.password />
	</cffunction>
	<cffunction name="getpassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.password />
	</cffunction>

	<cffunction name="setpasswordsalt" access="public" returntype="void" output="false">
		<cfargument name="passwordsalt" type="string" required="true" />
		<cfset variables.instance.passwordsalt = arguments.passwordsalt />
	</cffunction>
	<cffunction name="getpasswordsalt" access="public" returntype="string" output="false">
		<cfreturn variables.instance.passwordsalt />
	</cffunction>	

	<cffunction name="setusertype" access="public" returntype="void" output="false">
		<cfargument name="usertype" type="string" required="true" />
		<cfset variables.instance.usertype = arguments.usertype />
	</cffunction>
	<cffunction name="getusertype" access="public" returntype="string" output="false">
		<cfreturn variables.instance.usertype />
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

