<cfset rc = event.getCollection() >
<cfoutput>
<cfsavecontent variable="AddScript">
<cfoutput>
	<script type="text/javascript">
		$(function() {

			$("##departuredate").datetimepicker({
				showSecond: true,
				ampm: true,
				timeFormat: 'hh:mm:ss tt'
			});
		
			$("##createddate").datetimepicker({
				showSecond: true,
				ampm: true,
				timeFormat: 'hh:mm:ss tt'
			});
		
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
	<div class="content_options">
		<a href="#event.buildlink(rc.xehList)#" class="button">Back To Listing</a>
	</div>
	<h1>inquery</h1>
</div>
</cfoutput>
<cfoutput>
<form name="editor_form" id="editor_form" action="#event.buildlink(rc.xehSave)#" method="post" >
<!--- #getInstance("ErrorBox").renderIt("inqueryError")# --->
<div id="inqueryJSError" class="errorbox" style="display:none">
	<ul id="inqueryULError"></ul>
</div>
<input type="hidden" name="Id" value="#rc.Id#" /> 
<fieldset>
<legend><cfif rc.Id eq 0 >Add<cfelse>Edit</cfif> Record</legend>

<ul class="formLayout"> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="companyname">companyname:</label>
			</div>
			<div class="input-container">
				
				<input id="companyname" name="companyname" type="text" value="#rc.companyname#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="contactperson">contactperson:</label>
			</div>
			<div class="input-container">
				
				<input id="contactperson" name="contactperson" type="text" value="#rc.contactperson#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="address">address:</label>
			</div>
			<div class="input-container">
				
				<input id="address" name="address" type="text" value="#rc.address#" maxlength="250" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="city">city:</label>
			</div>
			<div class="input-container">
				
				<input id="city" name="city" type="text" value="#rc.city#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="state">state:</label>
			</div>
			<div class="input-container">
				
				<input id="state" name="state" type="text" value="#rc.state#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="country">country:</label>
			</div>
			<div class="input-container">
				
				<input id="country" name="country" type="text" value="#rc.country#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="zipcode">zipcode:</label>
			</div>
			<div class="input-container">
				
				<input id="zipcode" name="zipcode" type="text" value="#rc.zipcode#" maxlength="10" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="phone1">phone1:</label>
			</div>
			<div class="input-container">
				
				<input id="phone1" name="phone1" type="text" value="#rc.phone1#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="phone2">phone2:</label>
			</div>
			<div class="input-container">
				
				<input id="phone2" name="phone2" type="text" value="#rc.phone2#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="mobile">mobile:</label>
			</div>
			<div class="input-container">
				
				<input id="mobile" name="mobile" type="text" value="#rc.mobile#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="email">email:</label>
			</div>
			<div class="input-container">
				
				<input id="email" name="email" type="text" value="#rc.email#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="tourtype">tourtype:</label>
			</div>
			<div class="input-container">
				
				<input id="tourtype" name="tourtype" type="text" value="#rc.tourtype#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="destination">destination:</label>
			</div>
			<div class="input-container">
				
				<input id="destination" name="destination" type="text" value="#rc.destination#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="totalpassenger">totalpassenger:</label>
			</div>
			<div class="input-container">
				
				<input id="totalpassenger" name="totalpassenger" type="text" value="#rc.totalpassenger#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="adult">adult:</label>
			</div>
			<div class="input-container">
				
				<input id="adult" name="adult" type="text" value="#rc.adult#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="child">child:</label>
			</div>
			<div class="input-container">
				
				<input id="child" name="child" type="text" value="#rc.child#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="child511year">child511year:</label>
			</div>
			<div class="input-container">
				
				<input id="child511year" name="child511year" type="text" value="#rc.child511year#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="child11plus">child11plus:</label>
			</div>
			<div class="input-container">
				
				<input id="child11plus" name="child11plus" type="text" value="#rc.child11plus#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="hotelcategory">hotelcategory:</label>
			</div>
			<div class="input-container">
				
				<input id="hotelcategory" name="hotelcategory" type="text" value="#rc.hotelcategory#" maxlength="5" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="roomsharing">roomsharing:</label>
			</div>
			<div class="input-container">
				
				<input id="roomsharing" name="roomsharing" type="text" value="#rc.roomsharing#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="vehicletype">vehicletype:</label>
			</div>
			<div class="input-container">
				
				<input id="vehicletype" name="vehicletype" type="text" value="#rc.vehicletype#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="allss">allss:</label>
			</div>
			<div class="input-container">
				
				<input id="allss" name="allss" type="text" value="#rc.allss#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="allentry">allentry:</label>
			</div>
			<div class="input-container">
				
				<input id="allentry" name="allentry" type="text" value="#rc.allentry#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="departuredate">departuredate:</label>
			</div>
			<div class="input-container">
				
				<input id="departuredate" name="departuredate" type="text" value="<cfif len(trim(rc.departuredate))>#dateFormat(rc.departuredate,'MM/DD/YYYY')# #TimeFormat(rc.departuredate,'hh:mm:ss tt')#</cfif>" maxlength="10" size="32" />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="transporttype">transporttype:</label>
			</div>
			<div class="input-container">
				
				<input id="transporttype" name="transporttype" type="text" value="#rc.transporttype#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="traintype">traintype:</label>
			</div>
			<div class="input-container">
				
				<input id="traintype" name="traintype" type="text" value="#rc.traintype#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="foodtype">foodtype:</label>
			</div>
			<div class="input-container">
				
				<input id="foodtype" name="foodtype" type="text" value="#rc.foodtype#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="mealplan">mealplan:</label>
			</div>
			<div class="input-container">
				
				<input id="mealplan" name="mealplan" type="text" value="#rc.mealplan#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="noofPassenger">noofPassenger:</label>
			</div>
			<div class="input-container">
				
				<input id="noofPassenger" name="noofPassenger" type="text" value="#rc.noofPassenger#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="soundsystem">soundsystem:</label>
			</div>
			<div class="input-container">
				
				<input id="soundsystem" name="soundsystem" type="text" value="#rc.soundsystem#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="project">project:</label>
			</div>
			<div class="input-container">
				
				<input id="project" name="project" type="text" value="#rc.project#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="amt_pmt">amt_pmt:</label>
			</div>
			<div class="input-container">
				
				<input id="amt_pmt" name="amt_pmt" type="text" value="#rc.amt_pmt#" maxlength="5" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="stagedecoration">stagedecoration:</label>
			</div>
			<div class="input-container">
				
				<input id="stagedecoration" name="stagedecoration" type="text" value="#rc.stagedecoration#" maxlength="3" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="B2B">B2B:</label>
			</div>
			<div class="input-container">
				
				<input id="B2B" name="B2B" type="text" value="#rc.B2B#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="DJParty">DJParty:</label>
			</div>
			<div class="input-container">
				
				<input id="DJParty" name="DJParty" type="text" value="#rc.DJParty#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="cocktailparty">cocktailparty:</label>
			</div>
			<div class="input-container">
				
				<input id="cocktailparty" name="cocktailparty" type="text" value="#rc.cocktailparty#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="artist">artist:</label>
			</div>
			<div class="input-container">
				
				<input id="artist" name="artist" type="text" value="#rc.artist#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="cultureparty">cultureparty:</label>
			</div>
			<div class="input-container">
				
				<input id="cultureparty" name="cultureparty" type="text" value="#rc.cultureparty#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="productlaunching">productlaunching:</label>
			</div>
			<div class="input-container">
				
				<input id="productlaunching" name="productlaunching" type="text" value="#rc.productlaunching#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="sitevisit">sitevisit:</label>
			</div>
			<div class="input-container">
				
				<input id="sitevisit" name="sitevisit" type="text" value="#rc.sitevisit#" maxlength="1" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="remark">remark:</label>
			</div>
			<div class="input-container">
				
				<input id="remark" name="remark" type="text" value="#rc.remark#" maxlength="250" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="createddate">createddate:</label>
			</div>
			<div class="input-container">
				
				<input id="createddate" name="createddate" type="text" value="<cfif len(trim(rc.createddate))>#dateFormat(rc.createddate,'MM/DD/YYYY')# #TimeFormat(rc.createddate,'hh:mm:ss tt')#</cfif>" maxlength="10" size="32" />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="createdby">createdby:</label>
			</div>
			<div class="input-container">
				
				<input id="createdby" name="createdby" type="text" value="#rc.createdby#" maxlength="10" size="32"  />
		</div>
		</div>
	</li>
</ul>
<div class="requiredText"><em>*</em> Indicates required field</div>
<input type="submit" value="Submit" class="button" />
</fieldset>
</form>
</cfoutput>

