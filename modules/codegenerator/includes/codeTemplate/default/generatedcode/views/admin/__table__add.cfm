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
<div class="content_header">
	<div class="content_options">
		<a href="%event.buildlink(rc.xehList)%" class="button">Back To Listing</a>
	</div>
	<h1>#variables.table.getComponentName()#</h1>
</div>
<%/cfoutput%>
<%cfoutput%>
<form name="editor_form" id="editor_form" action="%event.buildlink(rc.xehSave)%" method="post" >
%getMyPlugin("ErrorBox").renderIt("#variables.table.getComponentName()#Error")%
<div id="#variables.table.getComponentName()#JSError" class="errorbox" style="display:none">
	<ul id="#variables.table.getComponentName()#ULError"></ul>
</div>
<cfloop array="#variables.table.getColumns()#" index="column">
<cfif column.getIdentity() EQ "Yes" and column.getprimaryKey() EQ "Yes"><input type="hidden" name="#column.getName()#" value="%rc.#column.getName()#%" /></cfif>
</cfloop>
<fieldset>
<legend><%cfif <cfloop from="1" to="#ArrayLen(arrPKs)#" index="i">rc.#arrPKs[i]# eq 0 <cfif i neq ArrayLen(arrPKs)>AND </cfif></cfloop>%>Add<%cfelse%>Edit<%/cfif%> Record</legend>

<ul class="formLayout"><cfloop array="#variables.table.getColumns()#" index="column">
<cfif NOT column.getIdentity() AND column.getDisplayOnForm()>
	<li>
		<div class="field-container">
			<div class="required-container">
				<cfif column.getRequired() eq "Yes" and NOT (column.getDataType() EQ "uuid" OR column.getIdentity() EQ "Yes")><em>*</em>
				<cfelse>
					&nbsp;
				</cfif></div>
			<div class="label-container">
				<label for="#column.getName()#">#column.getName()#:</label>
			</div>
			<div class="input-container">
				<cfset maxLengthVal = 10>
				<cfloop array="#column.getValidators()#" index="validator">
					<cfif validator.getNAME() eq "maxlength">
						<cfset maxLengthVal = validator.getValue()>
					</cfif>
				</cfloop>

				<cfswitch expression="#column.getInputType()#">
		<cfcase value="date">
				<input id="#column.getName()#" name="#column.getName()#" type="text" value="%dateFormat(rc.#column.getName()#,'MM/DD/YYYY')%" maxlength="#maxLengthVal#" size="32" />
		</cfcase>
		<cfcase value="datetime">
				<input id="#column.getName()#" name="#column.getName()#" type="text" value="<%cfif len(trim(rc.#column.getname()#))>%dateFormat(rc.#column.getname()#,'MM/DD/YYYY')% %TimeFormat(rc.#column.getname()#,'hh:mm:ss tt')%<%/cfif%>" maxlength="#maxLengthVal#" size="32" />
		</cfcase>
		<cfcase value="time">
				<input id="#column.getName()#" name="#column.getName()#" type="text" value="%TimeFormat(rc.#column.getName()#,'hh:mm:ss tt')%" maxlength="#maxLengthVal#" size="32"  />
		</cfcase>
		<cfcase value="text">
				<input id="#column.getName()#" name="#column.getName()#" type="text" value="%rc.#column.getName()#%" maxlength="#maxLengthVal#" size="32"  />
		</cfcase>
		<cfcase value="password">
				<input id="#column.getName()#" name="#column.getName()#" type="password" maxlength="#column.getLength()#" maxlength="#maxLengthVal#" size="32" />
		</cfcase>
		<cfcase value="select">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
				<select name="#column.getName()#" id="#column.getName()#">
					<cfloop list="#structkeylist(myStruct)#" index="key"><option value="#key#" <%cfif trim(rc.#column.getName()#) EQ "#key#" %>selected="selected"<%/cfif%> >#myStruct[key]#</option></cfloop>
				</select>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<select name="#column.getName()#" id="#column.getName()#">
					<cfset prop = Deserializejson(column.getInputSourceProperty()) >
					<%cfloop query="rc.q#prop['pktable']#.query"%>
						<option value="%#prop['value']#%" <%cfif trim(rc.#column.getName()#) EQ "%#prop['value']#%" %>selected="selected"<%/cfif%> >%#prop['label']#%</option>
					<%/cfloop%>
				</select>
			</cfif>
			</cfif>
		</cfcase>
		<cfcase value="checkbox">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
				<cfloop list="#structkeylist(myStruct)#" index="key">
				<input type="checkbox" name="#column.getName()#" id="#column.getName()##key#" value="#key#" <%cfif ListFindNoCase(trim(rc.#column.getName()#), "#key#") %>checked="checked"<%/cfif%>/>#myStruct[key]#<!--- <input type="checkbox" name="#column.getName()#" id="#column.getName()#" value="#column.getInputSourceProperty()#" <%cfif trim(rc.#column.getName()) EQ "#column.getInputSourceProperty()#" %>checked="checked"<%/cfif%>/> --->
				</cfloop>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<cfset prop = Deserializejson(column.getInputSourceProperty()) >
				<%cfloop query="rc.q#prop['pktable']#.query"%>
				<input type="checkbox" name="#column.getName()#" id="#column.getName()##prop['value']#" value="%#prop['value']#%" <%cfif trim(rc.#column.getName()#) EQ "%#prop['value']#%" %>checked="checked"<%/cfif%>/>%#prop['label']#%
				<%/cfloop%>
			</cfif>
			</cfif>
		</cfcase>
		<cfcase value="radio">
			<cfif len(column.getInputSourceProperty())>
			<cfif column.getInputSourceType() EQ "array">
				<cfset myStruct = DeserializeJSON(column.getInputSourceProperty())>
				<cfloop list="#structkeylist(myStruct)#" index="key">
				<input type="radio" name="#column.getName()#" id="#column.getName()##key#" value="#key#" <%cfif trim(rc.#column.getName()#) EQ "#key#" %>checked="checked"<%/cfif%>/>#myStruct[key]#
				</cfloop>
			<cfelseif column.getInputSourceType() EQ "cfc">
				<cfset prop = Deserializejson(column.getInputSourceProperty()) >
				<%cfloop query="rc.q#prop['pktable']#.query"%>
				<input type="radio" name="#column.getName()#" id="#column.getName()##prop['value']#" value="%#prop['value']#%" <%cfif trim(rc.#column.getName()#) EQ "%#prop['value']#%" %>checked="checked"<%/cfif%>/>%#prop['label']#%
				<%/cfloop%>
			</cfif>
			</cfif>
		</cfcase>
		<cfcase value="file">
				<input type="file" name="#column.getName()#" id="#column.getName()#" />
		</cfcase>
		<cfcase value="textarea">
				<textarea name="#column.getName()#" id="#column.getName()#" >%rc.#column.getName()#%</textarea>
		</cfcase>
		<cfcase value="editor">
				<textarea name="#column.getName()#" id="#column.getName()#" >%rc.#column.getName()#%</textarea>
		</cfcase>
		<cfcase value="hidden">
				<input type="hidden" name="#column.getName()#" id="#column.getName()#" value="%rc.#column.getName()#%" />
		</cfcase>
		<cfcase value="label">
				%rc.#column.getName#()%
		</cfcase></cfswitch></div>
		</div>
	</li></cfif></cfloop>
</ul>
<div class="requiredText"><em>*</em> Indicates required field</div>
<input type="submit" value="Submit" class="button" />
</fieldset>
</form>
<%/cfoutput%>
</cfoutput>