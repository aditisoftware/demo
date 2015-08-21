
<cfsavecontent variable="ListScript">
<cfoutput>
	<script type="text/javascript">
		function callPaging(pageno){
			$("##page").val(pageno);
			$("##frmusermaster").submit();
		}
		function updatePageSize(size){
			$("##pageSize").val(size);
			$("##frmusermaster").submit();
		}
	</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#ListScript#" />
<cfoutput>
<div class="content_header">
	<div class="content_options">
		<a href="#event.buildlink(rc.xehEditor)#" class="button">Add</a>
	</div>
	<h1>usermaster</h1>
</div>

#getMyPlugin("ErrorBox").renderIt("usermasterError")#
<div id="usermasterJSError" class="errorbox" style="display:none">
	<ul id="usermasterULError"></ul>
</div>
<form name="frmusermaster" id="frmusermaster" action="#event.buildLink(rc.xehList)#" method="post">
	<input type="hidden" name="page" id="page" value="#rc.page#"/>
	<input type="hidden" name="pageSize" id="pageSize" value="#rc.pageSize#"/>
	<input type="hidden" name="bandSize" id="bandSize" value="#rc.bandSize#"/>
</cfoutput>

<div class="table_container">
	<table border="0" cellpadding="0" cellspacing="0" class="tablelisting">
		<cfoutput>
		<tr>
			 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=Id&sortOrder=#rc.sortOrder#">Id</a>&nbsp;<span <cfif rc.sortBy eq 'Id'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=firstname&sortOrder=#rc.sortOrder#">firstname</a>&nbsp;<span <cfif rc.sortBy eq 'firstname'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=lastname&sortOrder=#rc.sortOrder#">lastname</a>&nbsp;<span <cfif rc.sortBy eq 'lastname'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=address1&sortOrder=#rc.sortOrder#">address1</a>&nbsp;<span <cfif rc.sortBy eq 'address1'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=address2&sortOrder=#rc.sortOrder#">address2</a>&nbsp;<span <cfif rc.sortBy eq 'address2'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=city&sortOrder=#rc.sortOrder#">city</a>&nbsp;<span <cfif rc.sortBy eq 'city'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=state&sortOrder=#rc.sortOrder#">state</a>&nbsp;<span <cfif rc.sortBy eq 'state'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=country&sortOrder=#rc.sortOrder#">country</a>&nbsp;<span <cfif rc.sortBy eq 'country'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=username&sortOrder=#rc.sortOrder#">username</a>&nbsp;<span <cfif rc.sortBy eq 'username'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=password&sortOrder=#rc.sortOrder#">password</a>&nbsp;<span <cfif rc.sortBy eq 'password'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=usertype&sortOrder=#rc.sortOrder#">usertype</a>&nbsp;<span <cfif rc.sortBy eq 'usertype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=createddate&sortOrder=#rc.sortOrder#">createddate</a>&nbsp;<span <cfif rc.sortBy eq 'createddate'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=createdby&sortOrder=#rc.sortOrder#">createdby</a>&nbsp;<span <cfif rc.sortBy eq 'createdby'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th>
			<th>&nbsp;&nbsp;actions&nbsp;&nbsp;</th>
		</tr>
		</cfoutput>
		
		<cfoutput query="rc.qusermaster.query">
		<tr <cfif currentrow mod 2 eq 0>class="even"</cfif>>
			<td>
				#Id#&nbsp;
			</td>
			<td>
				#firstname#&nbsp;
			</td>
			<td>
				#lastname#&nbsp;
			</td>
			<td>
				#address1#&nbsp;
			</td>
			<td>
				#address2#&nbsp;
			</td>
			<td>
				#city#&nbsp;
			</td>
			<td>
				#state#&nbsp;
			</td>
			<td>
				#country#&nbsp;
			</td>
			<td>
				#username#&nbsp;
			</td>
			<td>
				#password#&nbsp;
			</td>
			<td>
				#usertype#&nbsp;
			</td>
			<td>
				#dateFormat(createddate,"MM-DD-YYYY")# #TimeFormat(createddate,"hh:mm:ss tt")#&nbsp;
			</td>
			<td>
				#createdby#&nbsp;
			</td>
			<td>
				<a href="#event.buildlink(rc.xehEditor)#?Id=#Id#&">
					<img src="/includes/images/admin/edit.png" width="20" height="20" alt="Edit" title="Edit" class="noBorder"/>
				</a>&nbsp;
				<a onclick="javascript:return confirm('Are you sure you wish to delete? This action cannot be undone.')" href="#event.buildlink(rc.xehDelete)#?Id=#Id#&">
					<img src="/includes/images/admin/delete.png" width="20" height="20" alt="Delete" title="Delete" class="noBorder"/>
				</a>
			</td>
		</tr>
		</cfoutput>
	</table>
</div>
<cfif rc.qusermaster.totalrowcount eq 0>
<h3>No records found</h3>
</cfif>
<cfoutput>
#getMyPlugin("Paging").renderit(rc.qusermaster.totalrowcount,"javascript:callPaging(@page@)", rc.pageSize, rc.bandSize, rc.pageSize,getSetting("PageSizes"), "updatePageSize")#
</cfoutput>
</form>

