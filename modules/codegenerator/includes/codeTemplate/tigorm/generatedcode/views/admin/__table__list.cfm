<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getprimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getname())>
	</cfif>
</cfloop>
<cfoutput>
<cfloop array="#variables.table.getColumns()#" index="column"><cfif ListFindNoCase("checkbox,radio,select",column.getInputType()) AND column.getInputSourceType() EQ "array" AND Len(column.getInputSourceProperty())><%cfset list#column.getName()# = DeserializeJSON('#column.getInputSourceProperty()#') %></cfif></cfloop><%cfoutput%>
<%cfsavecontent variable="ListScript"%>
<%cfoutput%>
	<script type="text/javascript">
		function callSearch(sortBy){
			var frm = window.document.frm#variables.table.getTableName()#;
			frm.page.value = 1;
			frm.sortBy.value = sortBy;
			frm.sortOrder.value = '%IIF( rc.sortOrder eq "asc", DE("desc"), DE("asc") )%';
			frm.submit();
		}
		function callPaging(pageno){
			var frm = document.frm#variables.table.getTableName()#;
			frm.page.value = pageno;
			frm.submit();
		}
		function updatePageSize(size){
			$("%%pageSize").val(size);
			$("%%frm#variables.table.getTableName()#").submit();
		}
	</script>
<%/cfoutput%>
<%/cfsavecontent%>
<%cfhtmlhead text="%ListScript%" /%>
<div class="content_header">
	<div class="content_options">
		<a href="%event.buildlink(linkTo=rc.xehEditor)%" class="btn btn-success">Add</a>
	</div>
	<h2>#variables.table.GetComponentUserFriendlyName()#</h2>
</div>

%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div id="#variables.table.getComponentName()#JSError" class="alert alert-danger" style="display:none;">
	<ul id="#variables.table.getComponentName()#ULError"></ul>
</div>
<form name="frm#variables.table.getTableName()#" id="frm#variables.table.getTableName()#" action="%event.buildLink(linkTo=rc.xehList)%" method="post">
	<input type="hidden" name="page" id="page" value="%val(rc.page)%"/>
	<input type="hidden" name="pageSize" id="pageSize" value="%val(rc.pageSize)%"/>
	<input type="hidden" name="bandSize" id="bandSize" value="%val(rc.bandSize)%"/>
	<input type="hidden" name="sortBy" id="sortBy" value="%encodeForHTMLAttribute(rc.sortBy)%"/>
	<input type="hidden" name="sortOrder" id="sortOrder" value="%encodeForHTMLAttribute(rc.sortOrder)%"/>
	<div class="panel panel-default">
		<table class="table table-striped">
			<thead>
			<tr>
				<cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid()><th>
					<a href="javascript:callSearch('#column.getname()#');">#column.getFormLabel()#</a>
				</th>
				</cfif></cfloop><th>Actions</th>
			</tr>
			</thead>
			<tbody>
			<%cfloop query="rc.q#variables.table.getComponentName()#.query"%>
			<tr><cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getDisplayInGrid()>
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
					%#column.getName()#%</cfif>
				</td></cfif></cfloop>
				<td>
					<a href="%event.buildlink(linkTo=rc.xehView<cfif listLen(listPKs)>,queryString='<cfloop list="#listPKs#" index="pk">#pk#=%#pk#%<cfif ListLen(listPKs) gt 1 AND i neq ListLen(listPKs)>,</cfif></cfloop>'</cfif>)%"><img src="/includes/images/admin/view.png" width="20" height="20" alt="View" title="View" class="noBorder"/></a>&nbsp;
					<a href="%event.buildlink(linkTo=rc.xehEditor<cfif listLen(listPKs)>,queryString='<cfloop list="#listPKs#" index="pk">#pk#=%#pk#%<cfif ListLen(listPKs) gt 1 AND i neq ListLen(listPKs)>,</cfif></cfloop>'</cfif>)%"><i class="icon-edit icon-large"></i></a>&nbsp;
					<a onclick="javascript:return confirm('Are you sure you wish to delete? This action cannot be undone.')" href="%event.buildlink(linkTo=rc.xehDelete<cfif listLen(listPKs)>,queryString='<cfloop list="#listPKs#" index="pk">#pk#=%#pk#%<cfif ListLen(listPKs) gt 1 AND i neq ListLen(listPKs)>,</cfif></cfloop>'</cfif>)%"><i class="icon-remove icon-large"></i></a>
				</td>
			</tr>
			<%/cfloop%>
			</tbody>
		</table>
	</div>
	<%cfif rc.q#variables.table.getComponentName()#.totalrowcount eq 0%>
		<h4>No records found</h4>
	<%/cfif%>
	%getMyPlugin("Paging").renderit(rc.q#variables.table.getComponentName()#.totalrowcount,"javascript:callPaging(@page@)", rc.pageSize, rc.bandSize, rc.pageSize,getSetting("PageSizes"), "updatePageSize")%
</form>
<%/cfoutput%>
</cfoutput>