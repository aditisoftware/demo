<cfset rc = event.getCollection() >

<cfoutput>
<div>
[<a href="#event.buildlink(rc.xehList)#">Back To Listing</a>]
</div>
<br/>
#getMyPlugin("ErrorBox").renderIt("usermasterError")#
<div id="usermasterError">
</div>
<fieldset>
<ul>
	<li>
		Id: #rc.Id#
	</li>
	<li>
		firstname: #rc.firstname#
	</li>
	<li>
		lastname: #rc.lastname#
	</li>
	<li>
		address1: #rc.address1#
	</li>
	<li>
		address2: #rc.address2#
	</li>
	<li>
		city: #rc.city#
	</li>
	<li>
		state: #rc.state#
	</li>
	<li>
		country: #rc.country#
	</li>
	<li>
		username: #rc.username#
	</li>
	<li>
		password: #rc.password#
	</li>
	<li>
		usertype: #rc.usertype#
	</li>
	<li>
		createddate: #dateFormat(rc.createddate,"MM-DD-YYYY")# #TimeFormat(rc.createddate,"hh:mm:ss tt")#
	</li>
	<li>
		createdby: #rc.createdby#
	</li>
</ul>
</fieldset>
</cfoutput>

