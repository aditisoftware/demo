
<cfsavecontent variable="ListScript">
<cfoutput>
	<script type="text/javascript">
		function callPaging(pageno){
			$("##page").val(pageno);
			$("##frminquery").submit();
		}
		function updatePageSize(size){
			$("##pageSize").val(size);
			$("##frminquery").submit();
		}
	</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#ListScript#" />
<cfoutput>
	<div class="content_header">
		<h1>Inquery</h1>
	</div>
	#getInstance("ErrorBox").renderIt("inqueryError")#
	<div id="inqueryJSError" class="errorbox" style="display:none">
		<ul id="inqueryULError"></ul>
	</div>
	<form name="frminquery" id="frminquery" action="#event.buildLink(rc.xehList)#" method="post">
		<input type="hidden" name="page" id="page" value="#rc.page#"/>
		<input type="hidden" name="pageSize" id="pageSize" value="#rc.pageSize#"/>
		<input type="hidden" name="bandSize" id="bandSize" value="#rc.bandSize#"/>
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
				<td width="10%" class="lbl" valign="top"><label for="searchusertype">Created By</label></td>
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
				</td>
			</tr>
		</table>

		<div class="table_container">
			<table border="0" cellpadding="0" cellspacing="0" class="table table-hover table-bordered">
				<cfoutput>
					<tr class="active">
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=tourid&sortOrder=#rc.sortOrder#">Tour</a>&nbsp;<span <cfif rc.sortBy eq 'tourid'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th>
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=contactperson&sortOrder=#rc.sortOrder#">Contact person</a>&nbsp;<span <cfif rc.sortBy eq 'contactperson'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=city&sortOrder=#rc.sortOrder#">City</a>&nbsp;<span <cfif rc.sortBy eq 'city'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=phone1&sortOrder=#rc.sortOrder#">Phone</a>&nbsp;<span <cfif rc.sortBy eq 'phone1'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=mobile&sortOrder=#rc.sortOrder#">Mobile</a>&nbsp;<span <cfif rc.sortBy eq 'mobile'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=email&sortOrder=#rc.sortOrder#">Email</a>&nbsp;<span <cfif rc.sortBy eq 'email'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=createddate&sortOrder=#rc.sortOrder#">Created on</a>&nbsp;<span <cfif rc.sortBy eq 'createddate'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th> 
						<th>
							<a href="#event.buildlink(rc.xehList)#?sortBy=createdby&sortOrder=#rc.sortOrder#">Created by</a>&nbsp;<span <cfif rc.sortBy eq 'createdby'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
						</th>
						<th>&nbsp;&nbsp;actions&nbsp;&nbsp;</th>
					</tr>
				</cfoutput>
				
				<cfoutput query="rc.qinquery.query">
				<tr <cfif currentrow mod 2 eq 0>class="even"</cfif>>
					<td>
						<cfif tourid eq 1>
							Escorted tour
						<cfelseif tourid eq 2>
							Bhakti yatra
						<cfelseif tourid eq 3>
							Educational tour
						<cfelseif tourid eq 4>
							Adventure tour
						<cfelseif tourid eq 5>
							Corporate tour
						<cfelseif tourid eq 6 >
							Individual tour
						</cfif>	
						&nbsp;
					</td>
					<td>
						#contactperson#&nbsp;
					</td>
					<td>
						#city#&nbsp;
					</td>
					<td>
						#phone1#&nbsp;
					</td>
					<td>
						#mobile#&nbsp;
					</td>
					<td>
						#email#&nbsp;
					</td>
					<td>
						#dateFormat(createddate,"MM-DD-YYYY")# #TimeFormat(createddate,"hh:mm:ss tt")#&nbsp;
					</td>
					<td>
						#createdby#&nbsp;
					</td>
					<td>
						<cfif tourid eq 1>
							<cfset rc.event = "admin.inquery.escortedtour">
						<cfelseif tourid eq 2>
							<cfset rc.event = "admin.inquery.bhaktiyatra">
						<cfelseif tourid eq 3>
							<cfset rc.event = "admin.inquery.educationaltour">
						<cfelseif tourid eq 4>
							<cfset rc.event = "admin.inquery.adventuretour">
						<cfelseif tourid eq 5>
							<cfset rc.event = "admin.inquery.corporatetour">							
						<cfelseif tourid eq 6 >
							<cfset rc.event = "admin.inquery.individualtour">
						</cfif>	
						<a href="#event.buildlink(rc.event)#?Id=#Id#&">
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
		<cfif rc.qinquery.totalrowcount eq 0>
		<h3>No records found</h3>
		</cfif>
		#getInstance("Paging").renderit(rc.qinquery.totalrowcount,"javascript:callPaging(@page@)", rc.pageSize, rc.bandSize, rc.pageSize,getSetting("PageSizes"), "updatePageSize")#
	</form>
</cfoutput>

