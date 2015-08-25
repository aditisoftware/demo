<cfsavecontent variable="ListScript">
<cfoutput>
	<script type="text/javascript">
		function callPaging(pageno){
			$("##pageno").val(pageno);
			$("##frmusermaster").submit();
		}
		function updatePageSize(size){
			$("##pageSize").val(size);
			$("##frmusermaster").submit();
		}
		function sortGrid(sortBy,sortOrder){

			$("##sortBy").val(sortBy);

			if($("##sortOrder").val() == "desc")
				$("##sortOrder").val("asc");
			else
				$("##sortOrder").val("desc");

			$("##frmhw_city").submit();
		}
		$(function() {

			$("##Reset").bind("click",function(){
				$("##searchTable :input").each(function() {
					var type = this.type;
					var tag = this.tagName.toLowerCase(); // normalize case
					if (type == 'text' || type == 'password' || tag == 'textarea')
					this.value = "";
					else if (type == 'checkbox' || type == 'radio')
					this.checked = false;
					else if (tag == 'select')
					this.selectedIndex = 0;
				});
				$("##page").val(1);
				$("##sortBy").val("cityname");
				$("##sortOrder").val("asc");
				$("##frmhw_city").submit();
			});
		});
	</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#ListScript#" />
<cfoutput>
<div class="content_header">
	<h1>Usermaster</h1>
</div>

#getInstance("ErrorBox").renderIt("usermasterError")#
<div id="usermasterJSError" class="errorbox" style="display:none">
	<ul id="usermasterULError"></ul>
</div>
<form name="frmusermaster" id="frmusermaster" action="#event.buildLink(rc.xehList)#" method="post">
	<input type="hidden" name="pageno" id="pageno" value="#rc.pageno#"/>
	<input type="hidden" name="pageSize" id="pageSize" value="#rc.pageSize#"/>
	<input type="hidden" name="bandSize" id="bandSize" value="#rc.bandSize#"/>
</cfoutput>

<cfoutput>
	<table border="0" cellpadding="5" cellspacing="5" width="50%" class="table" id="searchTable">
		<tr>
			<td width="10%" class="lbl" valign="top"><label for="searchname">Name</label></td>
			<td width="40%" valign="top">
				<input type="text" name="searchname" id="searchname" value="#rc.searchname#" class="form-control" size="60" />
			</td>
			<td width="10%" class="lbl" valign="top"><label for="searchcity">City</label></td>
			<td width="40%" valign="top">
				<input type="text" name="searchcity" id="searchcity" value="#rc.searchcity#" class="form-control" size="60" />
			</td>
		</tr>
		<tr>
			<td width="10%" class="lbl" valign="top"><label for="searchusertype">Usertype</label></td>
			<td valign="top">
				 <select ID="searchusertype" name="searchusertype"  class="form-control">
				 	<option value="">Select Type</option>
				 	<option <cfif rc.searchusertype eq "SuperAdmin">selected</cfif>value="SuperAdmin">Super Admin</option>
		            <option <cfif rc.searchusertype eq "Admin">selected</cfif>value="Admin">Admin</option>
		            <option <cfif rc.searchusertype eq "Agent">selected</cfif>value="Agent">Agent</option>
		            <option <cfif rc.searchusertype eq "Staff">selected</cfif>value="Staff">Staff</option>
		        </select>
			</td>
			<td>&nbsp;</td>
			<td >
				<button type="submit" name="Search" id="Search" class="btn btn-info"><i class="icon-search"></i> Search</button> 
				<button type="button" name="Reset" id="Reset" class="btn btn-default"><i class="icon-refresh"></i> Reset</button>
				<a href="#event.buildlink(rc.xehEditor)#" class="btn btn-warning">Add</a> 
			</td>
		</tr>
	</table>
</cfoutput>	
<div class="table_container">
	<table border="0" cellpadding="0" cellspacing="0" class="table table-hover table-bordered">
		<cfoutput>
		<tr class="active">
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=firstname&sortOrder=#rc.sortOrder#">Firstname</a>&nbsp;<span <cfif rc.sortBy eq 'firstname'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=lastname&sortOrder=#rc.sortOrder#">Lastname</a>&nbsp;<span <cfif rc.sortBy eq 'lastname'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=city&sortOrder=#rc.sortOrder#">City</a>&nbsp;<span <cfif rc.sortBy eq 'city'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=state&sortOrder=#rc.sortOrder#">State</a>&nbsp;<span <cfif rc.sortBy eq 'state'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=username&sortOrder=#rc.sortOrder#">Username</a>&nbsp;<span <cfif rc.sortBy eq 'username'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=usertype&sortOrder=#rc.sortOrder#">Usertype</a>&nbsp;<span <cfif rc.sortBy eq 'usertype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=createddate&sortOrder=#rc.sortOrder#">Createddate</a>&nbsp;<span <cfif rc.sortBy eq 'createddate'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=createdby&sortOrder=#rc.sortOrder#">Createdby</a>&nbsp;<span <cfif rc.sortBy eq 'createdby'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th>
			<th>&nbsp;&nbsp;Actions&nbsp;&nbsp;</th>
		</tr>
		</cfoutput>
		
		<cfoutput query="rc.qusermaster.query">
		<tr <cfif currentrow mod 2 eq 0>class="even"</cfif>>
			<td>
				#firstname#&nbsp;
			</td>
			<td>
				#lastname#&nbsp;
			</td>
			<td>
				#city#&nbsp;
			</td>
			<td>
				#state#&nbsp;
			</td>
			<td>
				#username#&nbsp;
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
					<span class="fa fa-edit"></span>
				</a>&nbsp;
				<a onclick="javascript:return confirm('Are you sure you wish to delete? This action cannot be undone.')" href="#event.buildlink(rc.xehDelete)#?Id=#Id#&">
					<span class="fa fa-close"></span>
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
#getInstance("Paging").renderit(val(rc.qusermaster.totalrowcount),"javascript:callPaging(@page@)", rc.pageSize,rc.pageno)#
</cfoutput>
</form>

