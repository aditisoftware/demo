<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getprimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getname())>
	</cfif>
</cfloop>
<cfoutput><cfloop array="#variables.table.getColumns()#" index="column"><cfif ListFindNoCase("checkbox,radio,select",column.getInputType()) AND column.getInputSourceType() EQ "array" AND Len(column.getInputSourceProperty())>
<%cfset list#column.getName()# = DeserializeJSON('#column.getInputSourceProperty()#') %></cfif></cfloop>
<%cfoutput%>
<div>
	<a class="btn btn-success" href="%event.buildlink(linkTo=rc.xehEditor<cfif listLen(listPKs)>,queryString='<cfloop list="#listPKs#" index="pk">#pk#=%rc.#pk#%<cfif ListLen(listPKs) gt 1 AND i neq ListLen(listPKs)>,</cfif></cfloop>'</cfif>)%">Edit</a>&nbsp;
	<a class="btn btn-info" href="%event.buildLink(linkTo=rc.xehList)%">Cancel</a>
</div>
<br />
%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div class="row">
	<div class="form-horizontal col-sm-12">
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayOnForm()><div class="form-group">
			<label class="col-sm-2 control-label">#column.getFormLabel()#:</label>
			<div class="col-sm-10">
				<p class="form-control-static"><cfif column.getInputtype() eq "date">%dateFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),"MM-DD-YYYY")%<cfelseif column.getInputType() eq "time">%TimeFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),"hh:mm:ss tt")%<cfelseif column.getInputType() eq "datetime">%dateFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),"MM-DD-YYYY")% %TimeFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),"hh:mm:ss tt")%<cfelseif column.getInputType() EQ "checkbox" and column.getInputSourceType() EQ "array">
			<%cfloop list="%trim(#column.getName()#)%" index="c"%>
				<%cfif StructKeyExists(list#column.getName()#, c)%>
					%list#column.getName()#[c]%
				<%cfelse%>
					%c%
				<%/cfif%>
			<%/cfloop%><cfelseif ListFindNoCase("select,radio", column.getInputType()) and column.getInputSourceType() EQ "cfc">
			%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%
			<cfelse>%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%</cfif></p>
			</div>
		</div>
		</cfif></cfloop>
	</div>
</div>
<%/cfoutput%>
</cfoutput>