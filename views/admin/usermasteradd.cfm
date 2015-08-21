<cfset rc = event.getCollection() >
<cfoutput>
<cfsavecontent variable="AddScript">
	<cfoutput>
		<script type="text/javascript">
			$(function() {
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
						firstname: {required: "Firstname is required",maxlength: "firstname no more than 50 characters"},
						lastname: {required: "Lastname is required",maxlength: "lastname no more than 50 characters"},
						address1: {maxlength: "Address1 no more than 50 characters"},
						address2: {maxlength: "Address2 no more than 50 characters"},
						city: {maxlength: "City no more than 50 characters"},
						state: {maxlength: "State no more than 50 characters"},
						country: {maxlength: "Country no more than 50 characters"},
						username: {required: "Username is required",maxlength: "username no more than 15 characters"},
						password: {required: "Password is required",maxlength: "password no more than 128 characters"},
						usertype: {maxlength: "Usertype no more than 10 characters"}
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
	<h1>User Master</h1>
</div>
</cfoutput>
<cfoutput>
<form name="editor_form" id="editor_form" action="#event.buildlink(rc.xehSave)#" method="post" >
	#getInstance("ErrorBox").renderIt("usermasterError")#
	<div id="usermasterJSError" class="errorbox" style="display:none">
		<ul id="usermasterULError"></ul>
	</div>
	<div class="requiredText"><em>*</em> Indicates required field</div>
	<input type="hidden" name="Id" value="#rc.Id#" /> 
	<div class="col-md-6">
	    <div class="row">
	        <div class="col-md-6 margin-bottom-15">
	            <Label ID="lblStatus" Text="Label" class="alert-danger" Visible="false"></Label>
	        </div>
	    </div>
	    <div class="form-group">
	        <label>First Name</label>
	        <input type="text" ID="firstname" name="firstname" class="form-control" placeholder="First Name" value="#rc.firstname#" />
	    </div>
	    <div class="form-group">
	        <label>Last Name</label>
	        <input type="text" ID="lastname" name="lastname" class="form-control" placeholder="Last Name" value="#rc.lastname#" />
	    </div>
	    <div class="form-group">
	        <label>Address1</label>
	        <input type="text" ID="address1" name="address1" class="form-control" placeholder="Address1" value="#rc.address1#" />
	    </div>
	    <div class="form-group">
	        <label>Address2</label>
	        <input type="text" ID="address2" name="address2" class="form-control" placeholder="Address2" value="#rc.address2#" />
	    </div>
	    <div class="form-group">
	        <label>City</label>
	        <input type="text" ID="city" name="city" class="form-control" placeholder="City" value="#rc.city#" />
	    </div>
	    <div class="form-group">
	        <label>State</label>
	        <input type="text" ID="state" name="state" class="form-control" placeholder="State" value="#rc.state#" />
	    </div>
	    <div class="form-group">
	        <label>Country</label>
	        <input type="text" ID="country" name="country" class="form-control" placeholder="State" value="#rc.country#" />
	    </div>
	    <div class="form-group">
	        <label>Username</label>
	        <input type="text" ID="username" name="username" class="form-control" placeholder="Username" value="#rc.username#" />
	    </div>
	    <div class="form-group">
	        <label>Password</label>
	        <input type="text" ID="password" name="password" class="form-control" placeholder="Password" value="#rc.password#" />
	    </div>
	    <div class="form-group">
	        <label>Usertype</label>
	        <select ID="usertype" name="usertype"  class="form-control">
	            <option>Admin</option>
	            <option>Agent</option>
	            <option>Staff</option>
	        </select>
	    </div>
	    <div class="form-group">
	    	<input type="submit" value="Submit" class="btn btn-primary" />
			<a href="#event.buildlink(rc.xehList)#" class="btn btn-default"> << Back</a>
	    </div>
	</div>
	<!--- <ul class="formLayout"> 
		<li>
			<div class="field-container">
				<div class="required-container">
					<em>*</em>
					</div>
				<div class="label-container">
					<label for="firstname">Firstname:</label>
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
	</ul> --->
</form>
</cfoutput>

