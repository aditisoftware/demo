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
	<%cfproperty name="#variables.table.getComponentName()#Service" inject="model:#variables.table.getComponentName()#Service" scope="variables" /%>
	<cfloop list="#listFKs#" index="t"><cfif variables.table.getComponentName() NEQ t><%cfproperty name="#t#Service" inject="model:#t#Service" scope="variables" /%></cfif>
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
		rc.xehEditor = "admin.crm.#variables.table.getComponentName()#.dspEditor";
		rc.xehDelete = "admin.crm.#variables.table.getComponentName()#.doDelete";
		rc.xehList = "admin.crm.#variables.table.getComponentName()#.list";
		rc.xehView = "admin.crm.#variables.table.getComponentName()#.view";
		
		event.paramValue("page", 1);
		event.paramValue("pageSize", getSetting("PagingMaxRows"));
		event.paramValue("bandSize", getSetting("PagingBandGap"));
		event.paramValue("sortBy", "#listPKs#");
		event.paramValue("sortOrder", "asc");

		//Get the listing
		rc.q#variables.table.getComponentName()# = #variables.table.getComponentName()#Service.getByPage(page=rc.page, pagesize=rc.pageSize,gridsortcolumn=rc.sortBy,gridstartdirection=rc.sortOrder);
		
		//Set the view to render
		event.setView("admin/crm/#variables.table.getComponentName()#List");
		<%/cfscript%>
	<%/cffunction%>
	
	<%cffunction name="dspEditor" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes">event.paramValue("#column.getName()#",0);
		</cfif></cfloop>
		//set the exit handlers
		rc.xehSave = "admin.crm.#variables.table.getComponentName()#.doSave";
		rc.xehList = "admin.crm.#variables.table.getComponentName()#.list";
		
		if (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">val(rc.#variables.table.getColumns()[i].getName()#) gt 0<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			rc.o#variables.table.getComponentName()#Bean = #variables.table.getComponentName()#Service.get(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} 
		else {
			event.paramValue("o#variables.table.getComponentName()#Bean", #variables.table.getComponentName()#Service.new());
		}
		
		<cfloop list="#listFKs#" index="t">event.setValue("q#t#", instance.o#t#Service.getByPage(1, 1000));
		</cfloop>
		//Set view to render
		event.setView("admin/crm/#variables.table.getComponentName()#Add");
		<%/cfscript%>		
	<%/cffunction%>
	
	<%cffunction name="view" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes">event.paramValue("#column.getName()#",0);
		</cfif></cfloop>
		//set the exit handlers
		rc.xehEditor = "admin.crm.#variables.table.getComponentName()#.dspEditor";
		rc.xehList = "admin.crm.#variables.table.getComponentName()#.list";
		
		if (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">val(rc.#variables.table.getColumns()[i].getName()#) gt 0<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			rc.o#variables.table.getComponentName()#Bean = #variables.table.getComponentName()#Service.get(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} 
		else {
			event.paramValue("o#variables.table.getComponentName()#Bean", #variables.table.getComponentName()#Service.new());
		}
		
		//Set view to render
		event.setView("admin/crm/#variables.table.getComponentName()#view");
		<%/cfscript%>		
	<%/cffunction%>
	
	<%cffunction name="doSave" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		var errors = arrayNew(1);
		
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getPrimaryKey() eq "Yes">event.paramValue("#column.getName()#",0);
		</cfif></cfloop>
		if (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">val(rc.#variables.table.getColumns()[i].getName()#) gt 0<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			rc.o#variables.table.getComponentName()#Bean = #variables.table.getComponentName()#Service.get(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>);
		} 
		else {
			event.paramValue("o#variables.table.getComponentName()#Bean", #variables.table.getComponentName()#Service.new());
		}

		//Populate bean with RC
		#variables.table.getComponentName()#Service.populate(target=rc.o#variables.table.getComponentName()#Bean, memento=rc, nullEmptyInclude="*");
		
		//Assign linked tables only for new record
		if (<cfloop from="1" to="#ArrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">val(rc.#variables.table.getColumns()[i].getName()#) eq 0<cfif i neq ListLen(listPKs)> AND </cfif></cfif></cfloop>) {
			
		} 
		
		errors = arrayMerge(errors,rc.o#variables.table.getComponentName()#Bean.validate());
		
		if(arrayIsEmpty(errors)){
			#variables.table.getComponentName()#Service.save(rc.o#variables.table.getComponentName()#Bean);
			structClear(rc);
			getMyPlugin("ErrorBox").info("Record saved successfully");
		}
		else{
			getMyPlugin("ErrorBox").error(errors);
			ORMClearSession();
		}
		rc.event = "admin.crm.#variables.table.getComponentName()#.dspEditor";
		setNextEvent(event = rc.event, persistStruct = rc);
		<%/cfscript%>
	<%/cffunction%>
	
	<%cffunction name="doDelete" access="public" returntype="void" output="false"%>
		<%cfargument name="event"%>
		<%cfargument name="rc"%>
		<%cfargument name="prc"%>

		<%cfscript%>
		//Remove via the incoming id
		try{
			#variables.table.getComponentName()#Service.delete(#variables.table.getComponentName()#Service.get(<cfloop from="1" to="#arrayLen(variables.table.getColumns())#" index="i"><cfif variables.table.getColumns()[i].getprimaryKey() eq "Yes">rc.#variables.table.getColumns()[i].getName()#<cfif i neq ListLen(listPKs)>,</cfif></cfif></cfloop>));
			getMyPlugin("ErrorBox").info("The record was successfully deleted");
		}		
		catch(any e){
			getMyPlugin("ErrorBox").error(e.message);
		}

		rc.event = "admin.crm.#variables.table.getComponentName()#.list";
		setNextEvent(event = rc.event);
		<%/cfscript%>		
	<%/cffunction%>	
	
<%/cfcomponent%>
</cfoutput>