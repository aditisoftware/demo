<cfset arrPKs = ArrayNew(1)><cfloop array="#variables.table.getColumns()#" index="column"><cfif column.getprimaryKey() eq "Yes"><cfset ArrayAppend(arrPKs, column.getname())></cfif></cfloop>
<cfoutput><%cfset rc = event.getCollection() %>
<%cfoutput%>
<%cfsavecontent variable="AddScript"%>
<%cfoutput%>
	<script type="text/javascript">
		$(function() {
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfswitch expression="#column.getInputType()#">
		<cfcase value="date">
			$("%%#column.getNAME()#").datepicker();
		</cfcase>
		<cfcase value="datetime">
			$("%%#column.getNAME()#").datetimepicker({
				showSecond: true,
				ampm: true,
				timeFormat: 'hh:mm:ss tt'
			});
		</cfcase>
		<cfcase value="time">
			$("%%#column.getNAME()#").timepicker({
				showSecond: true,
				ampm: true,
				timeFormat: 'hh:mm:ss tt'
			});
		</cfcase>
		<cfcase value="editor">
			CKEDITOR.replace('#column.getNAME()#');
		</cfcase>
	</cfswitch>
</cfloop>
			$("%%editor_form").validate({
				rules: {
					<cfset strrules = "">
					<cfset strmsgs = "">
					<cfloop array="#variables.table.getColumns()#" index="column">
					<cfif ArrayLen(column.getValidators())>
						<cfset valstr = "">
						<cfset msgstr = "">
						<cfloop array="#column.getValidators()#" index="validator">
							<cfswitch expression="#validator.getNAME()#">
								<cfcase value="required">
									<cfif NOT (column.getPrimaryKey() EQ "Yes" AND (column.getIdentity() EQ "Yes" OR column.getDataType() EQ "uuid"))>
									<cfset valstr = ListAppend(valstr, "required: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "required: """ & validator.getErrorMessage()) & """">
									</cfif>
								</cfcase>
								<cfcase value="maxlength">
									<cfset valstr = ListAppend(valstr, "maxlength: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "maxlength: """ & replace(validator.getErrorMessage(),'{0}', validator.getValue()) & """")>
								</cfcase>
								<cfcase value="minlength">
									<cfset valstr = ListAppend(valstr, "minlength: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "minlength: """ & replace(validator.getErrorMessage(),'{0}', validator.getValue()) & """")>
								</cfcase>
								<cfcase value="max">
									<cfset valstr = ListAppend(valstr, "max: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "max: """ & replace(validator.getErrorMessage(),'{0}', validator.getValue()) & """")>
								</cfcase>
								<cfcase value="min">
									<cfset valstr = ListAppend(valstr, "min: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "min: """ & replace(validator.getErrorMessage(),'{0}', validator.getValue()) & """")>
								</cfcase>
								<cfcase value="email">
									<cfset valstr = ListAppend(valstr, "email: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "email: """ & validator.getErrorMessage() & """")>
								</cfcase>
								<cfcase value="url">
									<cfset valstr = ListAppend(valstr, "url: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "url: """ & validator.getErrorMessage() & """")>
								</cfcase>
								<cfcase value="creditcard">
									<cfset valstr = ListAppend(valstr, "creditcard: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "creditcard: """ & validator.getErrorMessage() & """")>
								</cfcase>
								<cfcase value="date">
									<cfset valstr = ListAppend(valstr, "date: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "date: """ & validator.getErrorMessage() & """")>
								</cfcase>
								<cfcase value="number">
									<cfset valstr = ListAppend(valstr, "number: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "number: """ & validator.getErrorMessage() & """")>
								</cfcase>
								<cfcase value="digits">
									<cfset valstr = ListAppend(valstr, "digits: " & validator.getValue())>
									<cfset msgstr = ListAppend(msgstr, "digits: """ & validator.getErrorMessage() & """")>
								</cfcase>
							</cfswitch>
						</cfloop>
						<cfset strrules = strrules & column.getName() & ": {" & valstr & "}," & Chr(13) & Chr(10) & chr(9) & chr(9) & chr(9) & chr(9) & chr(9)>
						<cfset strmsgs = strmsgs & column.getName() & ": {" & msgstr & "}," & Chr(13) & Chr(10) & chr(9) & chr(9) & chr(9) & chr(9) & chr(9)>
					</cfif>
					</cfloop>
					<cfif len(strrules)>
						<cfset strrules = Left(strrules, Len(strrules) - 8) >
						<cfset strmsgs = Left(strmsgs, Len(strmsgs) - 8) >
						#strrules#
					</cfif>
				},
				messages:{
					<cfif len(strrules)>#strmsgs#</cfif>
				},
				highlight: function(element, errorClass) {
					if (this.numberOfInvalids() > 0) {
						$("%%#variables.table.getComponentName()#JSError").hide();
					}
					$(element).addClass(errorClass);
				},
				errorClass:"error",
				errorElement:"li",
				errorContainer: $("%%#variables.table.getComponentName()#JSError"),
				errorLabelContainer: $("%%#variables.table.getComponentName()#ULError")
			});
		});
	</script>
<%/cfoutput%>
<%/cfsavecontent%>
<%cfhtmlhead text="%AddScript%" /%>
<form name="editor_form" id="editor_form" action="%event.buildlink(linkTo=rc.xehSave)%" method="post" >
%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div id="#variables.table.getComponentName()#JSError" class="alert alert-danger" style="display:none;">
	<ul id="#variables.table.getComponentName()#ULError"></ul>
</div>
<cfloop array="#variables.table.getColumns()#" index="column">
<cfif column.getIdentity() EQ "Yes" and column.getprimaryKey() EQ "Yes"><input type="hidden" name="#column.getName()#" value="%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%" /></cfif>
</cfloop>
<fieldset>
<legend><%cfif <cfloop from="1" to="#ArrayLen(arrPKs)#" index="i">val(rc.o#variables.table.getComponentName()#Bean.get#arrPKs[i]#()) eq 0 <cfif i neq ArrayLen(arrPKs)>AND </cfif></cfloop>%>Add<%cfelse%>Edit<%/cfif%> #variables.table.getComponentUserFriendlyName()#</legend>

<div class="row">
	<div class="col-sm-6">
		<cfloop array="#variables.table.getColumns()#" index="column"><cfif NOT column.getIdentity() AND column.getDisplayOnForm()>
		<div class="input-group">
			<span class="input-group-addon">
				<cfif column.getRequired() eq "Yes" and NOT (column.getDataType() EQ "uuid" OR column.getIdentity() EQ "Yes")><span class="required"><em>*</em></span></cfif>
				#column.getFormLabel()#:
			</span>
				<cfset maxLengthVal = 10>
				<cfloop array="#column.getValidators()#" index="validator">
					<cfif validator.getNAME() eq "maxlength">
						<cfset maxLengthVal = validator.getValue()>
					</cfif>
				</cfloop>
				<cfswitch expression="#column.getInputType()#">
			<cfcase value="date"><input id="#column.getName()#" name="#column.getName()#" class="form-control" type="text" value="%dateFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),'MM/DD/YYYY')%" maxlength="#maxLengthVal#" size="32" /></cfcase>
			<cfcase value="datetime"><input id="#column.getName()#" name="#column.getName()#" class="form-control" type="text" value="<%cfif len(trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()))>%dateFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),'MM/DD/YYYY')% %TimeFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),'hh:mm:ss tt')%<%/cfif%>" maxlength="#maxLengthVal#" size="32" /></cfcase>
			<cfcase value="time"><input id="#column.getName()#" name="#column.getName()#" class="form-control" type="text" value="%TimeFormat(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#(),'hh:mm:ss tt')%" maxlength="#maxLengthVal#" size="32"  /></cfcase>
			<cfcase value="text"><input id="#column.getName()#" name="#column.getName()#" class="form-control" type="text" value="%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%" maxlength="#maxLengthVal#" size="32"  /></cfcase>
			<cfcase value="password"><input id="#column.getName()#" name="#column.getName()#" class="form-control" type="password" maxlength="#column.getLength()#" maxlength="#maxLengthVal#" size="32" /></cfcase>
		<cfcase value="select">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
				<select name="#column.getName()#" id="#column.getName()#" class="form-control" ><cfloop list="#structkeylist(myStruct)#" index="key">
					<option value="#key#" <%cfif trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()) EQ "#key#" %>selected="selected"<%/cfif%> >#myStruct[key]#</option></cfloop>
				</select>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<select name="#column.getName()#" id="#column.getName()#" class="form-control" >
					<cfset prop = Deserializejson(column.getInputSourceProperty()) >
					<%cfloop query="rc.q#prop['pktable']#.query"%>
						<option value="%#prop['value']#%" <%cfif trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()) EQ "%#prop['value']#%" %>selected="selected"<%/cfif%> >%#prop['label']#%</option>
					<%/cfloop%>
				</select>
			</cfif>
			</cfif>
		</cfcase>
		<cfcase value="checkbox">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
			<span class="form-control">
				<cfloop list="#structkeylist(myStruct)#" index="key"><input type="checkbox" name="#column.getName()#" id="#column.getName()##key#" value="#key#" <%cfif ListFindNoCase(trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()), "#key#") %>checked="checked"<%/cfif%>/>#myStruct[key]#
				</cfloop>
			</span>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<cfset prop = Deserializejson(column.getInputSourceProperty()) >
			<span class="form-control">
				<%cfloop query="rc.q#prop['pktable']#.query"%>
				<input type="checkbox" name="#column.getName()#" id="#column.getName()##prop['value']#" value="%#prop['value']#%" <%cfif trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()) EQ "%#prop['value']#%" %>checked="checked"<%/cfif%>/>%#prop['label']#%
				<%/cfloop%>
			</span>
			</cfif>
			</cfif>
		</cfcase>
		<cfcase value="radio">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
			<span class="form-control"><cfloop list="#structkeylist(myStruct)#" index="key">
				<input type="radio" name="#column.getName()#" id="#column.getName()##key#" value="#key#" <%cfif trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()) EQ "#key#" %>checked="checked"<%/cfif%> /> <label for="#column.getName()##key#">#myStruct[key]#</label> &nbsp;</cfloop>
			</span>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<cfset prop = Deserializejson(column.getInputSourceProperty()) >
			<span class="form-control">
				<%cfloop query="rc.q#prop['pktable']#.query"%>
				<input type="radio" name="#column.getName()#" id="#column.getName()##prop['value']#" value="%#prop['value']#%" <%cfif trim(rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()) EQ "%#prop['value']#%" %>checked="checked"<%/cfif%> /> %#prop['label']#% 
				<%/cfloop%>
			</span>
			</cfif>
			</cfif>
		</cfcase>
			<cfcase value="file"><input type="file" name="#column.getName()#" id="#column.getName()#" class="form-control" /></cfcase>
			<cfcase value="textarea"><textarea name="#column.getName()#" id="#column.getName()#" class="form-control" >%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%</textarea></cfcase>
			<cfcase value="editor"><textarea name="#column.getName()#" id="#column.getName()#" class="form-control" >%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%</textarea></cfcase>
			<cfcase value="hidden"><input type="hidden" name="#column.getName()#" id="#column.getName()#" value="%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%" /></cfcase>
			<cfcase value="label">%rc.o#variables.table.getComponentName()#Bean.get#column.getName()#()%</cfcase></cfswitch>
		</div></cfif></cfloop>
	</div>
</div><br />
<div class="row">
	<div class="col-sm-2">
		<input type="submit" value="Submit" class="btn btn-primary" /> &nbsp;
		<a href="%event.buildlink(linkTo=rc.xehList)%" class="btn btn-info">Cancel</a>
	</div>
	<div class="col-sm-4">
		<span class="required"><em>*</em></span> Indicates required field
	</div>
</div>
</fieldset>
</form>
<%/cfoutput%>
</cfoutput>