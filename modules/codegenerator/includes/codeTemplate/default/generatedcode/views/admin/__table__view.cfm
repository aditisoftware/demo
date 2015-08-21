<cfoutput><%cfset rc = event.getCollection() %>
<cfloop array="#variables.table.getColumns()#" index="column"><cfif ListFindNoCase("checkbox,radio,select",column.getInputType()) AND column.getInputSourceType() EQ "array" AND Len(column.getInputSourceProperty())>
<%cfset list#column.getName()# = DeserializeJSON('#column.getInputSourceProperty()#') %></cfif></cfloop>
<%cfoutput%>
<div>
[<a href="%event.buildlink(rc.xehList)%">Back To Listing</a>]
</div>
<br/>
%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div id="#variables.table.getComponentName()#Error">
</div>
<fieldset>
<ul><cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayOnForm()>
	<li>
		#column.getName()#: <cfif column.getInputtype() eq "date">%dateFormat(rc.#column.getName()#,"MM-DD-YYYY")%<cfelseif column.getInputType() eq "time">%TimeFormat(rc.#column.getname()#,"hh:mm:ss tt")%<cfelseif column.getInputType() eq "datetime">%dateFormat(rc.#column.getname()#,"MM-DD-YYYY")% %TimeFormat(rc.#column.getname()#,"hh:mm:ss tt")%<cfelseif column.getInputType() EQ "checkbox" and column.getInputSourceType() EQ "array">
			<%cfloop list="%trim(#column.getName()#)%" index="c"%>
				<%cfif StructKeyExists(list#column.getName()#, c)%>
					%list#column.getName()#[c]%
				<%cfelse%>
					%c%
				<%/cfif%>
			<%/cfloop%><cfelseif ListFindNoCase("select,radio", column.getInputType()) and column.getInputSourceType() EQ "cfc">
			<!--- %#DeserializeJSON('#column.getInputSourceProperty()#')['label']#% --->  <!--- cannot get FK label value from object --->
			%rc.#column.getname()#%
			<cfelse>%rc.#column.getname()#%</cfif>
	</li></cfif></cfloop>
</ul>
</fieldset>
<%/cfoutput%>
</cfoutput>