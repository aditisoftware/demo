<cfset rc = event.getCollection() >

<cfoutput>
<div>
[<a href="#event.buildlink(rc.xehList)#">Back To Listing</a>]
</div>
<br/>
#getMyPlugin("ErrorBox").renderIt("inqueryError")#
<div id="inqueryError">
</div>
<fieldset>
<ul>
	<li>
		Id: #rc.Id#
	</li>
	<li>
		companyname: #rc.companyname#
	</li>
	<li>
		contactperson: #rc.contactperson#
	</li>
	<li>
		address: #rc.address#
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
		zipcode: #rc.zipcode#
	</li>
	<li>
		phone1: #rc.phone1#
	</li>
	<li>
		phone2: #rc.phone2#
	</li>
	<li>
		mobile: #rc.mobile#
	</li>
	<li>
		email: #rc.email#
	</li>
	<li>
		tourtype: #rc.tourtype#
	</li>
	<li>
		destination: #rc.destination#
	</li>
	<li>
		totalpassenger: #rc.totalpassenger#
	</li>
	<li>
		adult: #rc.adult#
	</li>
	<li>
		child: #rc.child#
	</li>
	<li>
		child511year: #rc.child511year#
	</li>
	<li>
		child11plus: #rc.child11plus#
	</li>
	<li>
		hotelcategory: #rc.hotelcategory#
	</li>
	<li>
		roomsharing: #rc.roomsharing#
	</li>
	<li>
		vehicletype: #rc.vehicletype#
	</li>
	<li>
		allss: #rc.allss#
	</li>
	<li>
		allentry: #rc.allentry#
	</li>
	<li>
		departuredate: #dateFormat(rc.departuredate,"MM-DD-YYYY")# #TimeFormat(rc.departuredate,"hh:mm:ss tt")#
	</li>
	<li>
		transporttype: #rc.transporttype#
	</li>
	<li>
		traintype: #rc.traintype#
	</li>
	<li>
		foodtype: #rc.foodtype#
	</li>
	<li>
		mealplan: #rc.mealplan#
	</li>
	<li>
		noofPassenger: #rc.noofPassenger#
	</li>
	<li>
		soundsystem: #rc.soundsystem#
	</li>
	<li>
		project: #rc.project#
	</li>
	<li>
		amt_pmt: #rc.amt_pmt#
	</li>
	<li>
		stagedecoration: #rc.stagedecoration#
	</li>
	<li>
		B2B: #rc.B2B#
	</li>
	<li>
		DJParty: #rc.DJParty#
	</li>
	<li>
		cocktailparty: #rc.cocktailparty#
	</li>
	<li>
		artist: #rc.artist#
	</li>
	<li>
		cultureparty: #rc.cultureparty#
	</li>
	<li>
		productlaunching: #rc.productlaunching#
	</li>
	<li>
		sitevisit: #rc.sitevisit#
	</li>
	<li>
		remark: #rc.remark#
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

