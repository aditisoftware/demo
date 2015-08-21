<cfset listPKs = "">
<cfset listFKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getPrimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getName())>
	</cfif>
	<cfif column.getInputSourceType() EQ 'cfc' AND len(column.getInputSourceProperty())>
		<cfset Prop = deserializejson(column.getInputSourceProperty())>
		<cfif NOT listFindNoCase(listFKs, Prop['PKTable'])>
			<cfset listFKs = ListAppend(listFKs, Prop['PKTable'])>
		</cfif>
	</cfif>
</cfloop>
<cfoutput>
<%cfcomponent name="#variables.table.getComponentName()#" extends="coldbox.system.eventhandler" output="false"%>
	<%cfproperty name="o#variables.table.getComponentName()#Service" inject="model:#variables.table.getComponentName()#Service" scope="instance" /%>
	<cfloop list="#listFKs#" index="t"><cfif variables.table.getComponentName() NEQ t><%cfproperty name="o#t#Service" inject="model:#t#Service" scope="instance" /%></cfif>
	</cfloop>
	
	<%cffunction name="init" access="public" returntype="#variables.table.getComponentName()#" output="false"%>
		<%cfargument name="controller" type="any" required="true"%>
		<%cfset super.init(arguments.controller)%>
		<!--- Any constructor code here --->
		<%cfreturn this%>
	<%/cffunction%>
	
	<%cffunction name="list" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>
		
		<%cfscript%>
		//set The exit handlers
		rc.xehEditor = "admin.#variables.table.getComponentName()#.dspEditor";
		rc.xehDelete = "admin.#variables.table.getComponentName()#.doDelete";
		rc.xehList = "admin.#variables.table.getComponentName()#.list";
		
		event.paramValue("page", "1");
		event.paramValue("pageSize", getSetting("PagingMaxRows"));
		event.paramValue("bandSize", getSetting("PagingBandGap"));
		
		//Sorting Logic.
		event.paramValue("sortBy", "#listPKs#");
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
		rc.q#variables.table.getComponentName()# = instance.o#variables.table.getComponentName()#Service.getByPage(Page=rc.page, pagesize=rc.pageSize,gridsortcolumn=rc.sortBy,gridstartdirection=rc.sortOrder);		
		
		//Set the view to render
		event.setView("admin/#variables.table.getComponentName()#List");
		<%/cfscript%>
	<%/cffunction%>
	
	<%cffunction name="dspEditor" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		var o#variables.table.getComponentName()#Bean = "";
		
		//set the exit handlers
		rc.xehSave = "admin.#variables.table.getComponentName()#.doSave";
		rc.xehList = "admin.#variables.table.getComponentName()#.list";
		
		if (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">StructKeyExists(rc,'#variables.table.getColumns()[i].getName()#') AND len(rc.#variables.table.getColumns()[i].getName()#)<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.get#variables.table.getComponentName()#(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} else {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.create#variables.table.getComponentName()#(argumentCollection=rc);
		}
		StructAppend(rc, o#variables.table.getComponentName()#Bean.getMemento(), true);
		
		<cfloop list="#listFKs#" index="t">event.setValue("q#t#", instance.o#t#Service.getByPage(1, 1000));
		</cfloop>
		
		//Set view to render
		event.setView("admin/#variables.table.getComponentName()#Add");
		<%/cfscript%>		
	<%/cffunction%>
	
	<%cffunction name="view" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		var o#variables.table.getComponentName()#Bean = "";
		
		//set the exit handlers
		rc.xehList = "admin.#variables.table.getComponentName()#.list";
		
		if (<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">StructKeyExists(rc,'#variables.table.getColumns()[i].getName()#') AND len(rc.#variables.table.getColumns()[i].getName()#)<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.get#variables.table.getComponentName()#(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} else {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.create#variables.table.getComponentName()#(argumentCollection=rc);
		}
		StructAppend(rc, o#variables.table.getComponentName()#Bean.getMemento(), true);
		
		//Set view to render
		event.setView("admin/#variables.table.getComponentName()#view");
		<%/cfscript%>		
	<%/cffunction%>
	
	<%cffunction name="doSave" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		var o#variables.table.getComponentName()#Bean = "";
		var result = "";
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif ListFindNoCase("select,checkbox,radio", column.getInputType())>event.paramValue("#column.getName()#", "");</cfif></cfloop>
		
		//get a new #variables.table.getComponentName()# bean if primary keys are blank
		if (<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">StructKeyExists(rc, '#variables.table.getColumns()[i].getName()#') AND len(rc.#variables.table.getColumns()[i].getName()#)<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.get#variables.table.getComponentName()#(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} else {
			o#variables.table.getComponentName()#Bean = instance.o#variables.table.getComponentName()#Service.create#variables.table.getComponentName()#(argumentCollection=rc);
		}
		<cfloop array="#variables.table.getColumns()#" index="column">
		if (StructKeyExists(rc, '#column.getName()#'))
			o#variables.table.getComponentName()#Bean.set#column.getName()#(rc.#column.getName()#);</cfloop>
		
		//Send to service for saving
		result = instance.o#variables.table.getComponentName()#Service.save#variables.table.getComponentName()#(o#variables.table.getComponentName()#Bean);
		
		setNextRoute("admin/#variables.table.getComponentName()#/list");
		/*
		if (!result.success){
			getMyPlugin("ErrorBox").error(result.errors);
			setNextEvent(event="admin.#variables.table.getComponentName()#.dspEditor",persistStruct=rc);
		}
		else {
			setNextRoute("admin/#variables.table.getComponentName()#/list");
		}*/
		<%/cfscript%>		
	<%/cffunction%>
	
	<%cffunction name="doDelete" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		var result = "";
		
		//Remove via the incoming id
		result = instance.o#variables.table.getComponentName()#Service.delete#variables.table.getComponentName()#(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		
		if (!result.success) {
			getMyPlugin("ErrorBox").error(result.errors);
		}
		else {
			getMyPlugin("ErrorBox").info("The record was successfully deleted");
		}
		//Set redirect
		setNextRoute("admin/#variables.table.getComponentName()#/list");
		<%/cfscript%>		
	<%/cffunction%>	
	
<%/cfcomponent%>
</cfoutput>