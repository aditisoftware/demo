
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
	<div class="content_options">
		<a href="#event.buildlink(rc.xehEditor)#" class="button">Add</a>
	</div>
	<h1>inquery</h1>
</div>

#getInstance("ErrorBox").renderIt("inqueryError")#
<div id="inqueryJSError" class="errorbox" style="display:none">
	<ul id="inqueryULError"></ul>
</div>
<form name="frminquery" id="frminquery" action="#event.buildLink(rc.xehList)#" method="post">
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
				<a href="#event.buildlink(rc.xehList)#?sortBy=companyname&sortOrder=#rc.sortOrder#">companyname</a>&nbsp;<span <cfif rc.sortBy eq 'companyname'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=contactperson&sortOrder=#rc.sortOrder#">contactperson</a>&nbsp;<span <cfif rc.sortBy eq 'contactperson'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=address&sortOrder=#rc.sortOrder#">address</a>&nbsp;<span <cfif rc.sortBy eq 'address'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
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
				<a href="#event.buildlink(rc.xehList)#?sortBy=zipcode&sortOrder=#rc.sortOrder#">zipcode</a>&nbsp;<span <cfif rc.sortBy eq 'zipcode'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=phone1&sortOrder=#rc.sortOrder#">phone1</a>&nbsp;<span <cfif rc.sortBy eq 'phone1'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=phone2&sortOrder=#rc.sortOrder#">phone2</a>&nbsp;<span <cfif rc.sortBy eq 'phone2'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=mobile&sortOrder=#rc.sortOrder#">mobile</a>&nbsp;<span <cfif rc.sortBy eq 'mobile'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=email&sortOrder=#rc.sortOrder#">email</a>&nbsp;<span <cfif rc.sortBy eq 'email'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=tourtype&sortOrder=#rc.sortOrder#">tourtype</a>&nbsp;<span <cfif rc.sortBy eq 'tourtype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=destination&sortOrder=#rc.sortOrder#">destination</a>&nbsp;<span <cfif rc.sortBy eq 'destination'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=totalpassenger&sortOrder=#rc.sortOrder#">totalpassenger</a>&nbsp;<span <cfif rc.sortBy eq 'totalpassenger'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=adult&sortOrder=#rc.sortOrder#">adult</a>&nbsp;<span <cfif rc.sortBy eq 'adult'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=child&sortOrder=#rc.sortOrder#">child</a>&nbsp;<span <cfif rc.sortBy eq 'child'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=child511year&sortOrder=#rc.sortOrder#">child511year</a>&nbsp;<span <cfif rc.sortBy eq 'child511year'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=child11plus&sortOrder=#rc.sortOrder#">child11plus</a>&nbsp;<span <cfif rc.sortBy eq 'child11plus'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=hotelcategory&sortOrder=#rc.sortOrder#">hotelcategory</a>&nbsp;<span <cfif rc.sortBy eq 'hotelcategory'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=roomsharing&sortOrder=#rc.sortOrder#">roomsharing</a>&nbsp;<span <cfif rc.sortBy eq 'roomsharing'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=vehicletype&sortOrder=#rc.sortOrder#">vehicletype</a>&nbsp;<span <cfif rc.sortBy eq 'vehicletype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=allss&sortOrder=#rc.sortOrder#">allss</a>&nbsp;<span <cfif rc.sortBy eq 'allss'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=allentry&sortOrder=#rc.sortOrder#">allentry</a>&nbsp;<span <cfif rc.sortBy eq 'allentry'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=departuredate&sortOrder=#rc.sortOrder#">departuredate</a>&nbsp;<span <cfif rc.sortBy eq 'departuredate'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=transporttype&sortOrder=#rc.sortOrder#">transporttype</a>&nbsp;<span <cfif rc.sortBy eq 'transporttype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=traintype&sortOrder=#rc.sortOrder#">traintype</a>&nbsp;<span <cfif rc.sortBy eq 'traintype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=foodtype&sortOrder=#rc.sortOrder#">foodtype</a>&nbsp;<span <cfif rc.sortBy eq 'foodtype'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=mealplan&sortOrder=#rc.sortOrder#">mealplan</a>&nbsp;<span <cfif rc.sortBy eq 'mealplan'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=noofPassenger&sortOrder=#rc.sortOrder#">noofPassenger</a>&nbsp;<span <cfif rc.sortBy eq 'noofPassenger'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=soundsystem&sortOrder=#rc.sortOrder#">soundsystem</a>&nbsp;<span <cfif rc.sortBy eq 'soundsystem'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=project&sortOrder=#rc.sortOrder#">project</a>&nbsp;<span <cfif rc.sortBy eq 'project'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=amt_pmt&sortOrder=#rc.sortOrder#">amt_pmt</a>&nbsp;<span <cfif rc.sortBy eq 'amt_pmt'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=stagedecoration&sortOrder=#rc.sortOrder#">stagedecoration</a>&nbsp;<span <cfif rc.sortBy eq 'stagedecoration'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=B2B&sortOrder=#rc.sortOrder#">B2B</a>&nbsp;<span <cfif rc.sortBy eq 'B2B'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=DJParty&sortOrder=#rc.sortOrder#">DJParty</a>&nbsp;<span <cfif rc.sortBy eq 'DJParty'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=cocktailparty&sortOrder=#rc.sortOrder#">cocktailparty</a>&nbsp;<span <cfif rc.sortBy eq 'cocktailparty'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=artist&sortOrder=#rc.sortOrder#">artist</a>&nbsp;<span <cfif rc.sortBy eq 'artist'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=cultureparty&sortOrder=#rc.sortOrder#">cultureparty</a>&nbsp;<span <cfif rc.sortBy eq 'cultureparty'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=productlaunching&sortOrder=#rc.sortOrder#">productlaunching</a>&nbsp;<span <cfif rc.sortBy eq 'productlaunching'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=sitevisit&sortOrder=#rc.sortOrder#">sitevisit</a>&nbsp;<span <cfif rc.sortBy eq 'sitevisit'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
			</th> 
			<th>
				<a href="#event.buildlink(rc.xehList)#?sortBy=remark&sortOrder=#rc.sortOrder#">remark</a>&nbsp;<span <cfif rc.sortBy eq 'remark'>class="#rc.sortOrder#"<cfelse>class="asc_desc"</cfif>>&nbsp;</span>
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
		
		<cfoutput query="rc.qinquery.query">
		<tr <cfif currentrow mod 2 eq 0>class="even"</cfif>>
			<td>
				#Id#&nbsp;
			</td>
			<td>
				#companyname#&nbsp;
			</td>
			<td>
				#contactperson#&nbsp;
			</td>
			<td>
				#address#&nbsp;
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
				#zipcode#&nbsp;
			</td>
			<td>
				#phone1#&nbsp;
			</td>
			<td>
				#phone2#&nbsp;
			</td>
			<td>
				#mobile#&nbsp;
			</td>
			<td>
				#email#&nbsp;
			</td>
			<td>
				#tourtype#&nbsp;
			</td>
			<td>
				#destination#&nbsp;
			</td>
			<td>
				#totalpassenger#&nbsp;
			</td>
			<td>
				#adult#&nbsp;
			</td>
			<td>
				#child#&nbsp;
			</td>
			<td>
				#child511year#&nbsp;
			</td>
			<td>
				#child11plus#&nbsp;
			</td>
			<td>
				#hotelcategory#&nbsp;
			</td>
			<td>
				#roomsharing#&nbsp;
			</td>
			<td>
				#vehicletype#&nbsp;
			</td>
			<td>
				#allss#&nbsp;
			</td>
			<td>
				#allentry#&nbsp;
			</td>
			<td>
				#dateFormat(departuredate,"MM-DD-YYYY")# #TimeFormat(departuredate,"hh:mm:ss tt")#&nbsp;
			</td>
			<td>
				#transporttype#&nbsp;
			</td>
			<td>
				#traintype#&nbsp;
			</td>
			<td>
				#foodtype#&nbsp;
			</td>
			<td>
				#mealplan#&nbsp;
			</td>
			<td>
				#noofPassenger#&nbsp;
			</td>
			<td>
				#soundsystem#&nbsp;
			</td>
			<td>
				#project#&nbsp;
			</td>
			<td>
				#amt_pmt#&nbsp;
			</td>
			<td>
				#stagedecoration#&nbsp;
			</td>
			<td>
				#B2B#&nbsp;
			</td>
			<td>
				#DJParty#&nbsp;
			</td>
			<td>
				#cocktailparty#&nbsp;
			</td>
			<td>
				#artist#&nbsp;
			</td>
			<td>
				#cultureparty#&nbsp;
			</td>
			<td>
				#productlaunching#&nbsp;
			</td>
			<td>
				#sitevisit#&nbsp;
			</td>
			<td>
				#remark#&nbsp;
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
<cfif rc.qinquery.totalrowcount eq 0>
<h3>No records found</h3>
</cfif>
<cfoutput>
#getInstance("Paging").renderit(rc.qinquery.totalrowcount,"javascript:callPaging(@page@)", rc.pageSize, rc.bandSize, rc.pageSize,getSetting("PageSizes"), "updatePageSize")#
</cfoutput>
</form>

