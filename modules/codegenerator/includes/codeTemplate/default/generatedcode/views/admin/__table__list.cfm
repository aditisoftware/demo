<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getprimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getname())>
	</cfif>
</cfloop>
<cfoutput>
<cfloop array="#variables.table.getColumns()#" index="column"><cfif ListFindNoCase("checkbox,radio,select",column.getInputType()) AND column.getInputSourceType() EQ "array" AND Len(column.getInputSourceProperty())><%cfset list#column.getName()# = DeserializeJSON('#column.getInputSourceProperty()#') %></cfif></cfloop>
<%cfsavecontent variable="ListScript"%>
<%cfoutput%>
	<script type="text/javascript">
		function callPaging(pageno){
			$("%%page").val(pageno);
			$("%%frm#variables.table.getTableName()#").submit();
		}
		function updatePageSize(size){
			$("%%pageSize").val(size);
			$("%%frm#variables.table.getTableName()#").submit();
		}
	</script>
<%/cfoutput%>
<%/cfsavecontent%>
<%cfhtmlhead text="%ListScript%" /%>
<%cfoutput%>
<div class="content_header">
	<div class="content_options">
		<a href="%event.buildlink(rc.xehEditor)%" class="button">Add</a>
	</div>
	<h1>#variables.table.GetComponentUserFriendlyName()#</h1>
</div>

%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div id="#variables.table.getComponentName()#JSError" class="errorbox" style="display:none">
	<ul id="#variables.table.getComponentName()#ULError"></ul>
</div>
<form name="frm#variables.table.getTableName()#" id="frm#variables.table.getTableName()#" action="%event.buildLink(rc.xehList)%" method="post">
	<input type="hidden" name="page" id="page" value="%rc.page%"/>
	<input type="hidden" name="pageSize" id="pageSize" value="%rc.pageSize%"/>
	<input type="hidden" name="bandSize" id="bandSize" value="%rc.bandSize%"/>
<%/cfoutput%>

<div class="table_container">
	<table border="0" cellpadding="0" cellspacing="0" class="tablelisting">
		<%cfoutput%>
		<tr>
			<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid()> 
			<th>
				<a href="%event.buildlink(rc.xehList)%?sortBy=#column.getname()#&sortOrder=%rc.sortOrder%">#column.getFormLabel()#</a>&nbsp;<span <%cfif rc.sortBy eq '#column.getFormLabel()#'%>class="%rc.sortOrder%"<%cfelse%>class="asc_desc"<%/cfif%>>&nbsp;</span>
			</th></cfif></cfloop>
			<th>&nbsp;&nbsp;actions&nbsp;&nbsp;</th>
		</tr>
		<%/cfoutput%>
		
		<%cfoutput query="rc.q#variables.table.getComponentName()#.query"%>
		<tr <%cfif currentrow mod 2 eq 0%>class="even"<%/cfif%>><cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid()>
			<td><cfif column.getInputType() eq "date">
				%dateFormat(#column.getname()#,"MM-DD-YYYY")%<cfelseif column.getInputType() eq "time">
				%TimeFormat(#column.getname()#,"hh:mm:ss tt")%<cfelseif column.getInputType() eq "datetime">
				%dateFormat(#column.getname()#,"MM-DD-YYYY")% %TimeFormat(#column.getname()#,"hh:mm:ss tt")%<cfelseif ListFindNoCase("select,radio", column.getInputType()) and column.getInputSourceType() EQ "array">
				<%cfif len(trim(#column.getName()#)) AND StructKeyExists(list#column.getName()#,trim(#column.getName()#))%>
					%list#column.getName()#[trim(#column.getName()#)]%
				<%cfelse%>
					%#column.getName()#%
				<%/cfif%><cfelseif column.getInputType() EQ "checkbox" and column.getInputSourceType() EQ "array">
				<%cfloop list="%trim(#column.getName()#)%" index="c"%>
					<%cfif StructKeyExists(list#column.getName()#, c)%>
						%list#column.getName()#[c]%
					<%cfelse%>
						%c%
					<%/cfif%>
				<%/cfloop%><cfelseif ListFindNoCase("select,radio", column.getInputType()) and column.getInputSourceType() EQ "cfc"><cfset prop = deserializejson(column.getInputSourceProperty())><cfif prop['label'] NEQ prop['value']>
				%#column.getname()#_#prop['label']#%<cfelse>
				%#column.getName()#%</cfif>
				<cfelse>
				%#column.getName()#%</cfif>&nbsp;
			</td></cfif></cfloop>
			<td>
				<a href="%event.buildlink(rc.xehEditor)%?<cfloop list="#listPKs#" index="pk">#pk#=%#pk#%<cfif i neq ListLen(listPKs)>&</cfif></cfloop>">
					<img src="/includes/images/admin/edit.png" width="20" height="20" alt="Edit" title="Edit" class="noBorder"/>
				</a>&nbsp;
				<a onclick="javascript:return confirm('Are you sure you wish to delete? This action cannot be undone.')" href="%event.buildlink(rc.xehDelete)%?<cfloop list="#listPKs#" index="pk">#pk#=%#pk#%<cfif i neq ListLen(listPKs)>&</cfif></cfloop>">
					<img src="/includes/images/admin/delete.png" width="20" height="20" alt="Delete" title="Delete" class="noBorder"/>
				</a>
			</td>
		</tr>
		<%/cfoutput%>
	</table>
</div>
<%cfif rc.q#variables.table.getComponentName()#.totalrowcount eq 0%>
<h3>No records found</h3>
<%/cfif%>
<%cfoutput%>
%getMyPlugin("Paging").renderit(rc.q#variables.table.getComponentName()#.totalrowcount,"javascript:callPaging(@page@)", rc.pageSize, rc.bandSize, rc.pageSize,getSetting("PageSizes"), "updatePageSize")%
<%/cfoutput%>
</form>
</cfoutput>