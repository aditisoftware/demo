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
	            <option>Agent</option>
	            <option>Admin</option>
	            <option>Staff</option>
	        </select>
	       <!---  <select ID="usertype" name="usertype"  class="form-control">
	            <option <cfif session.usertype eq "Agent">selected</cfif>>Agent</option>
	            <option <cfif session.usertype eq "Admin">selected</cfif>>Admin</option>
	            <option <cfif session.usertype eq "Staff">selected</cfif>>Staff</option>
	        </select> --->
	    </div>
	    <div class="form-group">
	    	<input type="submit" value="Submit" class="btn btn-primary" />
			<a href="#event.buildlink(rc.xehList)#" class="btn btn-default"> << Back</a>
	    </div>
	</div>
</form>
</cfoutput>

