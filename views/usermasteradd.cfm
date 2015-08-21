<cfset rc = event.getCollection() >
<cfoutput>
<cfsavecontent variable="AddScript">
<cfoutput>
	<script type="text/javascript">
		$(function() {

			$("##createddate").datetimepicker({
				showSecond: true,
				ampm: true,
				timeFormat: 'hh:mm:ss tt'
			});
		
			$("##editor_form").validate({
				rules: {
					Id: {digits: true},
					firstname: {required: true,maxlength: 50},
					lastname: {required: true,maxlength: 50},
					address1: {maxlength: 50},
					address2: {maxlength: 50},
					city: {maxlength: 50},
					state: {maxlength: 50},
					country: {maxlength: 50},
					username: {required: true,maxlength: 15},
					password: {required: true,maxlength: 128},
					usertype: {maxlength: 10},
					createddate: {required: true,date: true},
					createdby: {required: true,digits: true} 
				},
				messages:{
					Id: {digits: "Id must be numeric"},
					firstname: {required: "firstname is required",maxlength: "firstname no more than 50 characters"},
					lastname: {required: "lastname is required",maxlength: "lastname no more than 50 characters"},
					address1: {maxlength: "address1 no more than 50 characters"},
					address2: {maxlength: "address2 no more than 50 characters"},
					city: {maxlength: "city no more than 50 characters"},
					state: {maxlength: "state no more than 50 characters"},
					country: {maxlength: "country no more than 50 characters"},
					username: {required: "username is required",maxlength: "username no more than 15 characters"},
					password: {required: "password is required",maxlength: "password no more than 128 characters"},
					usertype: {maxlength: "usertype no more than 10 characters"},
					createddate: {required: "createddate is required",date: "createddate is not a valid date"},
					createdby: {required: "createdby is required",digits: "createdby must be numeric"}
				},
				highlight: function(element, errorClass) {
					if (this.numberOfInvalids() > 0) {
						$("##usermasterJSError").hide();
					}
					$(element).addClass(errorClass);
				},
				errorClass:"error",
				errorElement:"li",
				errorContainer: $("##usermasterJSError"),
				errorLabelContainer: $("##usermasterULError")
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
	<h1>usermaster</h1>
</div>
</cfoutput>
<cfoutput>
<form name="editor_form" id="editor_form" action="#event.buildlink(rc.xehSave)#" method="post" >
#getMyPlugin("ErrorBox").renderIt("usermasterError")#
<div id="usermasterJSError" class="errorbox" style="display:none">
	<ul id="usermasterULError"></ul>
</div>
<input type="hidden" name="Id" value="#rc.Id#" /> 
<fieldset>
<legend><cfif rc.Id eq 0 >Add<cfelse>Edit</cfif> Record</legend>

<ul class="formLayout"> 
	<li>
		<div class="field-container">
			<div class="required-container">
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="firstname">firstname:</label>
			</div>
			<div class="input-container">
				
				<input id="firstname" name="firstname" type="text" value="#rc.firstname#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="lastname">lastname:</label>
			</div>
			<div class="input-container">
				
				<input id="lastname" name="lastname" type="text" value="#rc.lastname#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="address1">address1:</label>
			</div>
			<div class="input-container">
				
				<input id="address1" name="address1" type="text" value="#rc.address1#" maxlength="50" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="address2">address2:</label>
			</div>
			<div class="input-container">
				
				<input id="address2" name="address2" type="text" value="#rc.address2#" maxlength="50" size="32"  />
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
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="username">username:</label>
			</div>
			<div class="input-container">
				
				<input id="username" name="username" type="text" value="#rc.username#" maxlength="15" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				<em>*</em>
				</div>
			<div class="label-container">
				<label for="password">password:</label>
			</div>
			<div class="input-container">
				
				<input id="password" name="password" type="text" value="#rc.password#" maxlength="128" size="32"  />
		</div>
		</div>
	</li> 
	<li>
		<div class="field-container">
			<div class="required-container">
				
					&nbsp;
				</div>
			<div class="label-container">
				<label for="usertype">usertype:</label>
			</div>
			<div class="input-container">
				
				<input id="usertype" name="usertype" type="text" value="#rc.usertype#" maxlength="10" size="32"  />
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

