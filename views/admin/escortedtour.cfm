<cfset rc = event.getCollection() >
<cfoutput>
<cfsavecontent variable="AddScript">
<cfoutput>
	<script type="text/javascript">
		$(function() {

			$("##departuredate").datepicker();
		
			$("##editor_form").validate({
				rules: {
					Id: {digits: true},
					companyname: {maxlength: 50},
					contactperson: {maxlength: 50},
					address: {maxlength: 250},
					city: {maxlength: 50},
					state: {maxlength: 50},
					country: {maxlength: 50},
					zipcode: {maxlength: 10},
					phone1: {maxlength: 15},
					phone2: {maxlength: 15},
					mobile: {maxlength: 15},
					email: {maxlength: 50},
					tourtype: {maxlength: 50},
					destination: {maxlength: 50},
					totalpassenger: {maxlength: 3},
					adult: {maxlength: 3},
					child: {maxlength: 3},
					child511year: {maxlength: 3},
					child11plus: {maxlength: 3},
					hotelcategory: {maxlength: 5},
					roomsharing: {maxlength: 3},
					vehicletype: {maxlength: 1},
					allss: {maxlength: 1},
					allentry: {maxlength: 1},
					departuredate: {date: true},
					transporttype: {maxlength: 1},
					traintype: {maxlength: 1},
					foodtype: {maxlength: 1},
					mealplan: {maxlength: 1},
					noofPassenger: {maxlength: 3},
					soundsystem: {maxlength: 3},
					project: {maxlength: 3},
					amt_pmt: {maxlength: 5},
					stagedecoration: {maxlength: 3},
					B2B: {maxlength: 15},
					DJParty: {maxlength: 15},
					cocktailparty: {maxlength: 1},
					artist: {maxlength: 50},
					cultureparty: {maxlength: 50},
					productlaunching: {maxlength: 50},
					sitevisit: {maxlength: 1},
					remark: {maxlength: 250},
					createddate: {required: true,date: true},
					createdby: {required: true,digits: true} 
				},
				messages:{
					Id: {digits: "Id must be numeric"},
					companyname: {maxlength: "companyname no more than 50 characters"},
					contactperson: {maxlength: "contactperson no more than 50 characters"},
					address: {maxlength: "address no more than 250 characters"},
					city: {maxlength: "city no more than 50 characters"},
					state: {maxlength: "state no more than 50 characters"},
					country: {maxlength: "country no more than 50 characters"},
					zipcode: {maxlength: "zipcode no more than 10 characters"},
					phone1: {maxlength: "phone1 no more than 15 characters"},
					phone2: {maxlength: "phone2 no more than 15 characters"},
					mobile: {maxlength: "mobile no more than 15 characters"},
					email: {maxlength: "email no more than 50 characters"},
					tourtype: {maxlength: "tourtype no more than 50 characters"},
					destination: {maxlength: "destination no more than 50 characters"},
					totalpassenger: {maxlength: "totalpassenger no more than 3 characters"},
					adult: {maxlength: "adult no more than 3 characters"},
					child: {maxlength: "child no more than 3 characters"},
					child511year: {maxlength: "child511year no more than 3 characters"},
					child11plus: {maxlength: "child11plus no more than 3 characters"},
					hotelcategory: {maxlength: "hotelcategory no more than 5 characters"},
					roomsharing: {maxlength: "roomsharing no more than 3 characters"},
					vehicletype: {maxlength: "vehicletype no more than 1 characters"},
					allss: {maxlength: "allss no more than 1 characters"},
					allentry: {maxlength: "allentry no more than 1 characters"},
					departuredate: {date: "departuredate is not a valid date"},
					transporttype: {maxlength: "transporttype no more than 1 characters"},
					traintype: {maxlength: "traintype no more than 1 characters"},
					foodtype: {maxlength: "foodtype no more than 1 characters"},
					mealplan: {maxlength: "mealplan no more than 1 characters"},
					noofPassenger: {maxlength: "noofPassenger no more than 3 characters"},
					soundsystem: {maxlength: "soundsystem no more than 3 characters"},
					project: {maxlength: "project no more than 3 characters"},
					amt_pmt: {maxlength: "amt_pmt no more than 5 characters"},
					stagedecoration: {maxlength: "stagedecoration no more than 3 characters"},
					B2B: {maxlength: "B2B no more than 15 characters"},
					DJParty: {maxlength: "DJParty no more than 15 characters"},
					cocktailparty: {maxlength: "cocktailparty no more than 1 characters"},
					artist: {maxlength: "artist no more than 50 characters"},
					cultureparty: {maxlength: "cultureparty no more than 50 characters"},
					productlaunching: {maxlength: "productlaunching no more than 50 characters"},
					sitevisit: {maxlength: "sitevisit no more than 1 characters"},
					remark: {maxlength: "remark no more than 250 characters"},
					createddate: {required: "createddate is required",date: "createddate is not a valid date"},
					createdby: {required: "createdby is required",digits: "createdby must be numeric"}
				},
				highlight: function(element, errorClass) {
					if (this.numberOfInvalids() > 0) {
						$("##inqueryJSError").hide();
					}
					$(element).addClass(errorClass);
				},
				errorClass:"error",
				errorElement:"li",
				errorContainer: $("##inqueryJSError"),
				errorLabelContainer: $("##inqueryULError")
			});
		});
	</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#AddScript#" />
<div class="content_header">
	<h1>ESCORTED TOUR</h1>
</div>
</cfoutput>
<cfoutput>
<form name="editor_form" id="editor_form" action="#event.buildlink(rc.xehSave)#" method="post" >
	#getInstance("ErrorBox").renderIt("inqueryError")#
	<div id="inqueryJSError" class="errorbox" style="display:none">
		<ul id="inqueryULError"></ul>
	</div>
	<input type="hidden" name="Id" value="#rc.Id#" /> 
	<input type="hidden" name="tourid" id="tourid" value="1" /> 
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">Client detail</div>
				<div class="panel-body">
					<div class="form-group">
						<label for="tourname">Tour Name</label>
						<input class="form-control" id="tourname" name="tourname" type="text" value="#rc.tourname#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="tourcode">Tour Code</label>
						<input class="form-control" id="tourcode" name="tourcode" type="text" value="#rc.tourcode#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="contactperson">Contact person</label>
						<input class="form-control" id="contactperson" name="contactperson" type="text" value="#rc.contactperson#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="address">Address</label>
						<input class="form-control" id="address" name="address" type="text" value="#rc.address#" maxlength="250" size="32"  />
					</div>
					<div class="form-group">
						<label for="city">City</label>
						<input class="form-control" id="city" name="city" type="text" value="#rc.city#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="state">State</label>
						<input class="form-control" id="state" name="state" type="text" value="#rc.state#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="country">Country</label>
						<input class="form-control" id="country" name="country" type="text" value="#rc.country#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="zipcode">Zipcode</label>
						<input class="form-control" id="zipcode" name="zipcode" type="text" value="#rc.zipcode#" maxlength="10" size="32"  />
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="phone1">Phone1</label>
							<input class="form-control" id="phone1" name="phone1" type="text" value="#rc.phone1#" maxlength="15" size="32"  />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="phone2">Phone2</label>
							<input class="form-control" id="phone2" name="phone2" type="text" value="#rc.phone2#" maxlength="15" size="32"  />
						</div>
					</div>
					<div class="form-group">
						<label for="mobile">Mobile</label>
						<input class="form-control" id="mobile" name="mobile" type="text" value="#rc.mobile#" maxlength="15" size="32"  />
					</div>
					<div class="form-group">
						<label for="email">Email</label>
						<input class="form-control" id="email" name="email" type="text" value="#rc.email#" maxlength="50" size="32"  />
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">Inquery detail</div>
				<div class="panel-body">
					<div class="form-group">
						<label for="destination">Destination</label>
						<input class="form-control" id="destination" name="destination" type="text" value="#rc.destination#" maxlength="50" size="32"  />
					</div>
					<div class="form-group">
						<label for="departuredate">Departure date</label>
						<input class="form-control" id="departuredate" name="departuredate" type="text" value="<cfif len(trim(rc.departuredate))>#dateFormat(rc.departuredate,'MM/DD/YYYY')#</cfif>" maxlength="10" size="32" />
					</div>
					<div class="form-group">
						<label for="totalpassenger">Total passenger</label>
						<input class="form-control" id="totalpassenger" name="totalpassenger" type="text" value="#rc.totalpassenger#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="adult">Couple</label>
						<input class="form-control" id="adult" name="adult" type="text" value="#rc.adult#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="child">Adult (11 above)</label>
						<input class="form-control" id="child" name="child" type="text" value="#rc.child#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="child511year">Child 5 - 11 year</label>
						<input class="form-control" id="child511year" name="child511year" type="text" value="#rc.child511year#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="child11plus">Child 2-5 year</label>
						<input class="form-control" id="child11plus" name="child11plus" type="text" value="#rc.child11plus#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="infant">Infant</label>
						<input class="form-control" id="infant" name="infant" type="text" value="#rc.infant#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="foodtype">Food type</label>
						<select class="form-control" id="foodtype" name="foodtype">
							<option value="">Selct</option>
							<option value="VEG. REGULAR"<cfif rc.foodtype eq "VEG. REGULAR">selected</cfif>>VEG. REGULAR</option>
							<option value="JAIN"<cfif rc.foodtype eq "JAIN">selected</cfif>>JAIN</option>
							<option value="SWAMINARAYAN"<cfif rc.foodtype eq "SWAMINARAYAN">selected</cfif>>SWAMINARAYAN</option>
						</select>
					</div>
					<div class="form-group">
						<label for="hotelrooms">Hotel rooms</label>
						<input class="form-control" id="hotelrooms" name="hotelrooms" type="text" value="#rc.hotelrooms#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="extramatress">Extra Matress</label>
						<input class="form-control" id="extramatress" name="extramatress" type="text" value="#rc.extramatress#" maxlength="3" size="32"  />
					</div>
					<div class="form-group">
						<label for="remark">Remark</label>
						<textarea type="textarea" class="form-control" id="remark" name="remark" maxlength="250" rows="5">#rc.remark#</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
			   	<input type="submit" value="Submit" class="btn btn-primary" />
				<a href="#event.buildlink(rc.xehList)#" class="btn btn-default"> << Back</a>
			</div>
		</div>
	</div>
</form>
</cfoutput>

