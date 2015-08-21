<cfset rc = event.getCollection()>
<cfset selectedTable = event.getValue("table","")>
<cfoutput>
<cfsavecontent variable="headertext">
	<script type="text/javascript">
		var stackCount = 0;
		var maxCount = 0;
		var arrTables = "#ArrayToList(rc.arrTables)#";
		function saveColumns(){
			stackCount = $("form", $("##divContent")).length;
			maxCount = $("form", $("##divContent")).length;
			$("##progressbar").progressbar({
				value: 0
			});
			$('form', $("##divContent")).each(function(){
				var _this = this;
				$.ajax({
					type: "POST",
					url: _this.action,
					data: $(this).serialize(),
					beforeSend: function(){
						$("div.msg",_this).removeClass().addClass("msg info").text("Saving settings...").show();
					},
					success: function(obj) {
						if(obj.SUCCESS)
							$("div.msg",_this).removeClass().addClass("msg success").text("Saved").show();
						else
							$("div.msg",_this).removeClass().addClass("msg error").text("Error").show();
						resetLoading();
					},
					error: function(obj){
						$("div.msg",_this).removeClass().addClass("msg error").text("error").show();
						resetLoading();
					}
				 });
			});
		}
		function resetLoading(){
			stackCount--;
			if(stackCount != 0){
				var value = (maxCount - stackCount) * 100 / maxCount;
				$("##progressbar").progressbar('value', value);
			} else {
				$("##progressbar").hide('slow');
			}
			if(stackCount == 0 && $(".error",$("##divContent")).length == 0){
				var arrTbl = arrTables.split(",");
				for(var i=0; i<arrTbl.length; i++) {
					if (arrTbl[i].toLowerCase() == $("##table").val().toLowerCase()) {
						if ((i+1) != arrTbl.length){
							$("##globel_mesages").removeClass().addClass("success").text("All columns saved successfully, loading next table...").show();
							loadTable(arrTbl[i+1]);
						} else {
							$("##globel_mesages").removeClass().addClass("success").text("All table setup").show();
						}
						break;
					}
				}
			}
			else if(stackCount == 0){
				//alert("Error Occured");
				$("##globel_mesages").removeClass().addClass("error").text("Error Occured").show();
			}
		}
		function loadTable(tableName){
			window.location.href = "#event.buildLink(rc.xehLoadSettings)#/table/" + tableName;
		}
		function showInputProperty(inputtype,columnname)
		{
			if(inputtype == 'select' || inputtype == 'radio' || inputtype == 'checkbox')
			{
				$("##inputProperty_"+columnname).show();<!--- $("##checkboxValue_"+columnname).hide(); --->
				$("##array_"+columnname).show();
			}
			else
			{
				$("##inputProperty_"+columnname).hide();
				$("##checkboxValue_"+columnname).hide();
				$("##array_"+columnname).hide();
				$("##cfc_"+columnname).hide();
			}
		}
		function showArraycfc(inputtype,columnname)
		{
			if(inputtype == 'array')
			{
				$("##array_"+columnname).show();
				$("##cfc_"+columnname).hide();
			}else
			{
				$("##array_"+columnname).hide();
				$("##cfc_"+columnname).show();
			}
		}
		function scanNewTable(){
			var $dialog = $('<div></div>').html('Scanning table changes...')
							.dialog({
								modal: true,
								title: 'Please wait'
							});
			window.location = "#event.buildlink(rc.xehScanTablesChanges)#";
		}
		function generateCode(value){
			var $dialog = $('<div></div>').html('Generating code...')
							.dialog({
								modal: true,
								title: 'Please wait'
							});
			if (value.length > 0)
				window.location = "#event.buildlink(rc.xehgenerateCode)#/generateCode/" + value;
			else
				window.location = "#event.buildlink(rc.xehgenerateCode)#";
		}
		function scanColumnChanges(table){
			var $dialog = $('<div></div>').html('Scanning column changes...')
							.dialog({
								modal: true,
								title: 'Please wait'
							});
			window.location = "#event.buildlink(rc.xehScanColumnChanges)#/table/" + table;
		}
		function changeSelect(LabelColumn, ValueColumn, table){
			$.get("#event.buildlink(rc.xehLoadColumn)#/table/" + table, function(data) {
				var arrColumn = data.split(',');
				var output = [];
				for(var i=0; i<arrColumn.length; i++){
					output.push('<option value="'+ arrColumn[i] +'">'+ arrColumn[i] +'</option>');
				}
				$("##"+LabelColumn).find('option').remove();
				$("##"+LabelColumn).html(output.join(''));
				$("##"+ValueColumn).find('option').remove();
				$("##"+ValueColumn).html(output.join(''));
			});
		}
		function saveProject(){
			var $dialog = $('<div></div>').html('Saving project in configuration file...')
							.dialog({
								modal: true,
								title: 'Please wait'
							});
			window.location = "#event.buildlink(rc.xehSaveProject)#";
		}
		function reloadCodeGenerator(){
			var $dialog = $('<div></div>').html('Reloading code generator...')
							.dialog({
								modal: true,
								title: 'Please wait'
							});
			window.location = "#event.buildlink(rc.xehReLoad)#";
		}
	</script>
</cfsavecontent>
<cfhtmlhead text="#headertext#">
<div class="divMain">
	<div class="header">
		<h1>One Click code generator</h1>
	</div>
	#getMyPlugin(plugin="ErrorBox", module="codegenerator").renderIt()#
	<div id="globel_mesages"></div>
	<div id="progressbar"></div>
	<div class="divColumnLeft">
		<button type="button" onclick="scanNewTable()" class="btnSubmit">Scan Table Changes</button>
		<ul class="bmenu">
		<cfloop array="#rc.arrtables#" index="tbl">
			<li><a href="#event.buildlink(rc.xehLoadSettings)#/table/#tbl#" <cfif tbl eq selectedTable>class="selected"</cfif>>#tbl#</a></li>
		</cfloop>
		</ul>
		<button type="button" onclick="generateCode('$$ALL')" class="btnSubmit">Generate Code</button>
		<button type="button" onclick="generateCode('$$STATIC')" class="btnSubmit">Generate Static Code</button>
	</div>
	<div id="divContent" class="divContent">
		<cfset column = rc.currentTable.getcolumns()>
		<form name="frmTableSetting" method="post" action="#event.buildLink(rc.xehSaveTable)#">
			<input type="hidden" id="table" name="table" value="#selectedTable#" />
			<label for="componentName">Component Name: </label>
			<input type="text" name="componentName" id="componentName" value="<cfif len(rc.currentTable.getComponentName())>#rc.currentTable.getComponentName()#<cfelse>#rc.table#</cfif>" />
			<label for="ComponentUserFriendlyName"> User Friendly Name: </label>
			<input type="text" name="ComponentUserFriendlyName" id="ComponentUserFriendlyName" value="<cfif len(rc.currentTable.getComponentUserFriendlyName())>#rc.currentTable.getComponentUserFriendlyName()#<cfelse>#rc.table#</cfif>" />
		</form>
		<cfloop from="1" to="#ArrayLen(column)#" index="i">
			<div class="divColumn">
				<h2>Column: #column[i].getName()#</h2>
				<form name="#column[i].getName()#" id="#column[i].getName()#" method="post" action="#event.buildLink(rc.xehSaveColumn)#">
					<div class="msg"></div>
					<input type="hidden" name="table" value="#selectedTable#" />
					<input type="hidden" name="fieldName" id="fieldName" value="#column[i].getName()#" />
					<div class="divColumnSettings">
						<input type="checkbox" name="isSubmit" id="col#column[i].getName()#isSubmit" value="1" checked="true"/>
						<label for="col#column[i].getName()#isSubmit">Enabled</label>
						<ul>
							<li>
								<label for="col#column[i].getName()#label">Label</label>
								<input type="text" name="label" id="col#column[i].getName()#label" value="#column[i].getFormLabel()#" />
							</li>
							<li>
								<label for="col#column[i].getName()#displayForm">Display On Form</label>
								 <select name="displayForm" id="col#column[i].getName()#displayForm">
									<option value="true" <cfif column[i].getDisplayOnForm() >selected="selected"</cfif>>true</option>
									<option value="false" <cfif not column[i].getDisplayOnForm()>selected="selected"</cfif>>false</option>
								</select>
							</li>
							<li>
								<label for="col#column[i].getName()#displayInGrid">Display On List</label>
								<select name="displayInGrid" id="col#column[i].getName()#displayInGrid">
									<option value="true" <cfif column[i].getDisplayInGrid() >selected="selected"</cfif>>true</option>
									<option value="false" <cfif not column[i].getDisplayInGrid()>selected="selected"</cfif>>false</option>
								</select>
							</li>
							<li>
								<label for="col#column[i].getName()#inputtype">Input Type</label>
								<select name="inputtype" id="col#column[i].getName()#inputtype" onchange="showInputProperty(this.value,'#column[i].getName()#')">
									<option value="text" <cfif column[i].getInputType() Eq 'text'>selected="selected"</cfif>>text</option>
									<option value="password" <cfif column[i].getInputType() Eq 'password'>selected="selected"</cfif>>password</option>
									<option value="select" <cfif column[i].getInputType() Eq 'select'>selected="selected"</cfif>>select</option>
									<option value="date" <cfif column[i].getInputType() Eq 'date'>selected="selected"</cfif>>date</option>
									<option value="datetime" <cfif column[i].getInputType() Eq 'datetime'>selected="selected"</cfif>>datetime</option>
									<option value="time" <cfif column[i].getInputType() Eq 'time'>selected="selected"</cfif>>time</option>
									<option value="file" <cfif column[i].getInputType() Eq 'file'>selected="selected"</cfif>>file</option>
									<option value="checkbox" <cfif column[i].getInputType() Eq 'checkbox'>selected="selected"</cfif>>checkbox</option>
									<option value="radio" <cfif column[i].getInputType() Eq 'radio'>selected="selected"</cfif>>radio</option>
									<option value="textarea" <cfif column[i].getInputType() Eq 'textarea'>selected="selected"</cfif>>textarea</option>
									<option value="editor" <cfif column[i].getInputType() Eq 'editor'>selected="selected"</cfif>>editor</option>
									<option value="hidden"  <cfif column[i].getIdentity() or column[i].getInputType() Eq 'hidden'>selected="selected"</cfif>>hidden</option>
									<option value="label" <cfif column[i].getInputType() Eq 'label'>selected="selected"</cfif>>label</option>
								</select>
							</li>
							<li id="inputProperty_#column[i].getName()#" <cfif NOT ListFindNoCase("checkbox,radio,select", column[i].getInputType())>style="display:none"</cfif>>
								<label for="col#column[i].getName()#inputProperty">Input Property</label>
								<select name="inputProperty" id="col#column[i].getName()#inputProperty" onchange="showArraycfc(this.value,'#column[i].getName()#')">
									<option value="array" <cfif column[i].getinputSourceType() EQ "array">selected</cfif>>Array</option>
									<option value="cfc" <cfif column[i].getinputSourceType() EQ "cfc">selected</cfif>>Component</option>
								</select>
								<div id="array_#column[i].getName()#" <cfif NOT (ListFindNoCase("checkbox,radio,select", column[i].getInputType()) AND column[i].getinputSourceType() EQ "array")>style="display:none"</cfif>>
									<ul>
										<li>
											<label for="col#column[i].getName()#txtVal">Val:</label>
											<input type="text" name="txtVal" id="col#column[i].getName()#txtVal" value='#column[i].getinputSourceProperty()#' />
										</li>
										<li>
											<b>e.g: Radio type for bit:</b><br/>
											{"No":"No","Yes":"Yes"}<br/>
											<b>Checkbox:</b> {"1":""} OR<br/>
											{"1":"Red","2":"Blue"}<br/>
											<b>Select:</b> {"1":"One","2":"Two"}
										</li>
									</ul>
								</div>
								<div id="cfc_#column[i].getName()#" <cfif NOT (ListFindNoCase("checkbox,radio,select", column[i].getInputType()) AND column[i].getinputSourceType() EQ "cfc")>style="display:none"</cfif>>
									<cfif column[i].getInputSourceType() EQ "cfc" AND len(column[i].getInputSourceProperty())>
										<cfset Prop = deserializejson(column[i].getInputSourceProperty())>
										<cfset PKTable = Prop['PKTable']>
										<cfset Value = Prop['Value']>
										<cfset Label = Prop['Label']>
									<cfelseif column[i].getInputSourceType() EQ "cfc" AND len(column[i].getPKTable())>
										<cfset PKTable = column[i].getPKTable()>
										<cfset Value = column[i].getPKTableColumn()>
										<cfset Label = column[i].getPKTableColumn()>
									<cfelse>
										<cfset PKTable = "">
										<cfset Value = "">
										<cfset Label = "">
									</cfif>
									<ul>
										<li>
											<label for="col#column[i].getName()#PKTable">Component:</label>
											<select name="PKTable" id="col#column[i].getName()#PKTable" onchange="changeSelect('col#column[i].getName()#PKTableLabelColumn', 'col#column[i].getName()#PKTableValueColumn',this.value)" <cfif len(column[i].getPKTable())>readonly="readonly"</cfif>>
												<option value=""></option>
												<cfloop array="#rc.arrTables#" index="c">
												<option value="#c#" <cfif c EQ PKTable>selected="selected"</cfif>>#c#</option>
												</cfloop>
											</select>
										</li>
										<li>
											<label for="col#column[i].getName()#PKTableValueColumn">Value column:</label>
											<select name="PKTableValueColumn" id="col#column[i].getName()#PKTableValueColumn" <cfif len(column[i].getPKTable())>readonly="readonly"</cfif>>
												<!--- <option value=""></option> --->
												<cfif len(PKTable)>
													<cfloop array="#event.getValue(PKTable).getColumns()#" index="c">
												<option value="#c.getName()#" <cfif c.getName() EQ Value>selected="selected"</cfif>>#c.getName()#</option>
													</cfloop>
												</cfif>
											</select>
										</li>
										<li>
											<label for="col#column[i].getName()#PKTableLabelColumn">Label column:</label>
											<select name="PKTableLabelColumn" id="col#column[i].getName()#PKTableLabelColumn">
												<!--- <option value=""></option> --->
												<cfif len(PKTable)>
													<cfloop array="#event.getValue(PKTable).getColumns()#" index="c">
												<option value="#c.getName()#" <cfif c.getName() EQ Label>selected="selected"</cfif>>#c.getName()#</option>
													</cfloop>
												</cfif>
											</select>
										</li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
					<div class="divValidation">
						<cfset columnValidators = column[i].getValidators()>
						<cfset validatorList = "">
						<cfloop from="1" to="#ArrayLen(columnValidators)#" index="index">
							<cfset validatorList = listAppend(validatorList,columnValidators[index].getName())>
						</cfloop>
						<div class="validationformlayout">
							<ul>
							<cfloop from="1" to="#ArrayLen(rc.validators)#" index="iv">
								<cfset validatorIndex = listFindNoCase(validatorList,rc.validators[iv].getName())>
								<li>
								<input type="checkbox" name="chkValidation" id="#column[i].getName()##iv#chkValidation" value="#rc.validators[iv].getName()#" <cfif validatorIndex>checked="checked"</cfif>>
								<label for="#column[i].getName()##iv#chkValidation">#rc.validators[iv].getName()#</label>
								<cfif validatorIndex>
									<cfset validatorMsg = Replacenocase(columnValidators[validatorIndex].getErrorMessage(),"this field", column[i].getFormLabel())>
									<label for="#rc.validators[iv].getName()#Msg#i#">Error Msg: </label>
									<input type="text" name="#rc.validators[iv].getName()#Msg" id="#rc.validators[iv].getName()#Msg#i#" value="#validatorMsg#" size="30" />
									<label for="#rc.validators[iv].getName()#Value#i#" style="width:40px;">Value: </label>
									<input type="text" name="#rc.validators[iv].getName()#Value" id="#rc.validators[iv].getName()#Value#i#" value="#columnValidators[validatorIndex].getValue()#" size="5" style="width:30px" />
								<cfelse>
									<cfset validatorMsg = Replacenocase(rc.validators[iv].getErrorMessage(),"this field", column[i].getFormLabel())>
									<label for="#rc.validators[iv].getName()#Msg#i#">Error Msg: </label>
									<input type="text" name="#rc.validators[iv].getName()#Msg" id="#rc.validators[iv].getName()#Msg#i#" value="#validatorMsg#" size="30"/>
									<label for="#rc.validators[iv].getName()#Value#i#" style="width:40px;">Value: </label>
									<input type="text" name="#rc.validators[iv].getName()#Value" id="#rc.validators[iv].getName()#Value#i#" value="#rc.validators[iv].getValue()#" size="5" style="width:30px" />
								</cfif>
								</li>
							</cfloop>
							</ul>
						</div>
						<br/>
						<br/>
					</div>
				</form>
			</div>
		</cfloop>
	</div>
	<div class="divColumnRight">
		<button type="button" onclick="scanColumnChanges('#selectedTable#');" class="btnSubmit">Scan column changes</button>
		<button type="button" onclick="saveColumns();" class="btnSubmit">Save table changes</button>
		<button type="button" onclick="generateCode('#selectedTable#');" class="btnSubmit">Generate code for this table</button>
		<button type="button" onclick="saveProject();" class="btnSubmit">Save Project</button>
		<button type="button" onclick="reloadCodeGenerator();" class="btnSubmit">Reload code generator</button>
	</div>
	<div class="footer">
		© <cfoutput>#year(now())#</cfoutput> iSummation Technologies
	</div>
</div>
</cfoutput>