<cfset rc = event.getCollection()>
<cfset selectedTable = event.getValue("table","")>
<cfoutput>
	<cfsavecontent variable="headertext">
	<script type="text/javascript">
		var stackCount=0;
		function saveColumns(){
			stackCount = $("form").length;
			$('form').each(function(){
				var _this = this;
				$.ajax({
				   type: "POST",
				   url: _this.action,
				   data: $(this).serialize(),
				   success: function(obj) {
				   		if(obj.SUCCESS)
							$(_this).parent().addClass("success").removeClass("errorsubmitted");
						else
							$(_this).parent().addClass("errorsubmitted").removeClass("success");
						resetLoading();
				   },
				   error: function(obj){
				   		$(_this).parent().addClass("errorsubmitted").removeClass("success");
				   		resetLoading();
				   }
				 });
			});
		}
		function resetLoading(){
			stackCount--;
			if(stackCount == 0 && $(".errorsubmitted").length == 0){
				if($("##table").children(":selected").index()+1 != $("##table").children().length){
					$("##table").children()[$("##table").children(":selected").index()+1].selected = true;
					//loadTable($("##table").val());
				}
				else{
					alert("All table setup");
				}
			}
			else if(stackCount == 0){
				alert("Error Occured");
			}
		}
		function loadTable(tableName){
			window.location.href = "#event.buildLink(rc.xehLoadColumnSetting)#?table=" + tableName;
		}
		function showInputProperty(inputtype,columnname)
		{
			if(inputtype == 'checkbox' || inputtype == 'select' || inputtype == 'radio')
			{
				$("##inputProperty_"+columnname).show();
				$("##static_"+columnname).show();
			}else
			{
				$("##inputProperty_"+columnname).hide();
				$("##static_"+columnname).hide();
				$("##cfc_"+columnname).hide();
			}
		}
		function showLocacolumnfc(inputtype,columnname)
		{
			if(inputtype == 'static')
			{
				$("##static_"+columnname).show();
				$("##cfc_"+columnname).hide();
			}else
			{
				$("##static_"+columnname).hide();
				$("##cfc_"+columnname).show();
			}
		}
	</script>
	<style>
		.errorsubmitted{
			background-color:##fdb9cd;
		}
		.success{
			background-color:##c6ffc6;
		}
	</style>
	</cfsavecontent>
	<cfhtmlhead text="#headertext#">
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td width="100%" class="box">
				<div class="inside_box">
					<table border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td class="data_content">Tables</td>
							<td>
								<select name="table" id="table" onchange="loadTable(this.value)">
									<cfloop from="1" to="#ArrayLen(rc.tables)#" index="i">
										<option value="#trim(rc.tables[i].gettablename())#" <cfif selectedTable Eq rc.tables[i].gettablename()>selected</cfif>>#rc.tables[i].gettablename()#</option>
									</cfloop>
								</select>
							</td>
							<td>
								<input type="button" name="saveProject" value="Save Project Changes" onclick="window.location.href='#event.buildLink(rc.xehSaveProject)#'">
								<input type="button" name="saveProject" value="Generate Code" onclick="window.location.href='#event.buildLink(rc.xehGenerateCode)#'">
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<br />
	<cfset columns = rc.currentTable.getColumns()>
	<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td width="100%" class="box">
				<div class="inside_box">
					<div>
					<form name="frmTableSetting" method="post" action="#event.buildLink(rc.xehSaveTable)#">
						<input type="hidden" id="table" name="table" value="#selectedTable#" />
					<table>
						<tr>
							<td>Table : #rc.table#</td>
							<td>Component Name: <input type="text" name="componentName" value="<cfif len(rc.currentTable.getComponentName())>#rc.currentTable.getComponentName()#<cfelse>#rc.table#</cfif>" /></td>							
						</tr>						
					</table>
					</form>
					</div>
					<cfloop from="1" to="#ArrayLen(columns)#" index="i">
						<cfif ListFindNoCase("checkbox,radio,select", columns[i].getInputType()) AND columns[i].getinputSourceType() EQ "static">
							<cfset flgStatic = true>
						<cfelse>
							<cfset flgStatic = false>
						</cfif>
						<cfif (NOT flgStatic) AND len(columns[i].getinputSourceProperty()) gt 0>
							<cfset objQuery = DeserializeJSON(columns[i].getinputSourceProperty())>
						<cfelse>
							<cfset objQuery.queryname="">
							<cfset objQuery.label="">
							<cfset objQuery.value="">
						</cfif>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td width="100%" id="col#columns[i].getName()#">
									<form name="#columns[i].getName()#" id="#columns[i].getName()#" method="post" action="#event.buildLink(rc.xehSaveColumn)#">
										<input type="hidden" id="table" name="table" value="#selectedTable#" />
										<input type="hidden" name="fieldName" id="fieldName" value="#columns[i].getName()#" />
										<table border="0" cellpadding="3" cellspacing="0" width="100%">
											<tr>
												<td colspan="2" class="content_cap">
													<input type="checkbox" name="isSubmit" value="1" checked="true"/> #columns[i].getName()#
												</td>
											</tr>
											<tr>
												<td width="20%" class="data_content">Label</td>
												<td width="80%" class="data_content_right"><input type="text" name="label" value="#columns[i].getFormLabel()#" class="my_txtfield" /></td>
											</tr>
											<tr>
												<td class="data_content">Display On Form</td>
												<td class="data_content_right">
													<select name="displayForm" id="displayForm">
														<option value="true" <cfif columns[i].getDisplayOnForm() >selected="selected"</cfif>>true</option>
														<option value="false" <cfif not columns[i].getDisplayOnForm()>selected="selected"</cfif>>false</option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="data_content">Display On List</td>
												<td class="data_content_right">
													<select name="displayInGrid" id="displayInGrid">
														<option value="true" <cfif columns[i].getDisplayInGrid() >selected="selected"</cfif>>true</option>
														<option value="false" <cfif not columns[i].getDisplayInGrid()>selected="selected"</cfif>>false</option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="data_content">Input Type</td>
												<td class="data_content_right">
													<select name="inputtype" id="#columns[i].getName()#" onchange="showInputProperty(this.value,'#columns[i].getName()#')">
														<option value="text" <cfif columns[i].getInputType() Eq 'text'>selected="selected"</cfif>>text</option>
														<option value="password" <cfif columns[i].getInputType() Eq 'password'>selected="selected"</cfif>>password</option>
														<option value="select" <cfif columns[i].getInputType() Eq 'select'>selected="selected"</cfif>>select</option>
														<option value="date" <cfif columns[i].getInputType() Eq 'date'>selected="selected"</cfif>>date</option>
														<option value="datetime" <cfif columns[i].getInputType() Eq 'datetime'>selected="selected"</cfif>>datetime</option>
														<option value="time" <cfif columns[i].getInputType() Eq 'time'>selected="selected"</cfif>>time</option>
														<option value="file" <cfif columns[i].getInputType() Eq 'file'>selected="selected"</cfif>>file</option>
														<option value="checkbox" <cfif columns[i].getInputType() Eq 'checkbox'>selected="selected"</cfif>>checkbox</option>
														<option value="radio" <cfif columns[i].getInputType() Eq 'radio'>selected="selected"</cfif>>radio</option>
														<option value="textarea" <cfif columns[i].getInputType() Eq 'textarea'>selected="selected"</cfif>>textarea</option>
														<option value="editor" <cfif columns[i].getInputType() Eq 'editor'>selected="selected"</cfif>>editor</option>
														<option value="hidden"  <cfif columns[i].getIdentity() or columns[i].getInputType() Eq 'hidden'>selected="selected"</cfif>>hidden</option>
														<option value="label" <cfif columns[i].getInputType() Eq 'label'>selected="selected"</cfif>>label</option>
													</select>
												</td>
											</tr>
											<tr id="inputProperty_#columns[i].getName()#" <cfif NOT ListFindNoCase("checkbox,radio,select", columns[i].getInputType())>style="display:none"</cfif>>
												<td class="data_content">Input Property</td>
												<td class="data_content_right">
													<select name="inputProperty" onchange="showLocacolumnfc(this.value,'#columns[i].getName()#')">
														<option value="static" <cfif columns[i].getinputSourceType() EQ "static">selected</cfif>>Array</option>
														<option value="queryobject" <cfif columns[i].getinputSourceType() EQ "queryobject">selected</cfif>>Query Object</option>
													</select>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<div id="static_#columns[i].getName()#" <cfif NOT (ListFindNoCase("checkbox,radio,select", columns[i].getInputType()) AND columns[i].getinputSourceType() EQ "static")>style="display:none"</cfif>>
														<table cellspacing="0" cellpadding="0" border="0" width="100%">
													    	<tr>
														    	<td width="20%">&nbsp;</td>
																<td width="80%">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td class="data_content_right">Val : </td>
																			<td class="data_content_right"><input type="text" name="txtVal" value='<cfif flgStatic>#columns[i].getinputSourceProperty()#</cfif>' class="my_txtfield" />&nbsp;&nbsp; EX : {"0":"No","1":"Yes"}</td>
																		</tr>
																	</table>
																</td>
													         </tr>
														</table>
													</div>
													<div id="cfc_#columns[i].getName()#" <cfif NOT (ListFindNoCase("checkbox,radio,select", columns[i].getInputType()) AND columns[i].getinputSourceType() EQ "queryobject")>style="display:none"</cfif>>
														<table cellspacing="0" cellpadding="0" border="0" width="100%">
															<tr>
														    	<td width="20%">&nbsp;</td>
																<td width="80%">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td class="data_content_right"> Query Name :</td>
																			<td class="data_content_right"><input type="text" name="txtQueryName" value="<cfif NOT flgStatic>#objQuery['queryname']#</cfif>" class="my_txtfield" /></td>
																		</tr>
																		<tr>
																			<td class="data_content_right"> Lable :</td>
																			<td class="data_content_right"><input type="text" name="txtQueryLable" value="<cfif NOT flgStatic>#objQuery['label']#</cfif>" class="my_txtfield" /></td>
																		</tr>
																		<tr>
																			<td class="data_content_right">Value : </td>
																			<td class="data_content_right"><input type="text" name="txtQueryValue" value="<cfif NOT flgStatic>#objQuery['value']#</cfif>" class="my_txtfield" /></td>
																		</tr>
																	</table>
																</td>
														    </tr>
														</table>
													</div>
													<cfset columnValidators = columns[i].getValidators()>
													<cfset validatorList = "">
													<cfloop from="1" to="#ArrayLen(columnValidators)#" index="index">
														<cfset validatorList = listAppend(validatorList,columnValidators[index].getName())>
													</cfloop>

													<table border="0" cellpadding="2" cellspacing="0" width="100%" id="tbl_#columns[i].getName()#">
														<cfloop from="1" to="#ArrayLen(rc.validators)#" index="iv">
															<cfset validatorIndex = listFindNoCase(validatorList,rc.validators[iv].getName())>
															<tr class="clsall">
																<td class="data_content_right" width="20%"><input type="checkbox" name="chkValidation" value="#rc.validators[iv].getName()#" <cfif validatorIndex>checked="checked"</cfif>> #rc.validators[iv].getName()#</td>
																<td class="data_content_right" width="80%">
																	<cfif validatorIndex>
																		Error Msg: <input type="text" name="#rc.validators[iv].getName()#Msg" value="#columnValidators[validatorIndex].getErrorMessage()#" class="my_txtfield" />
																		Value: <input type="text" name="#rc.validators[iv].getName()#Value" value="#columnValidators[validatorIndex].getValue()#" class="my_txtfield" />
																	<cfelse>
																		Error Msg: <input type="text" name="#rc.validators[iv].getName()#Msg" value="#rc.validators[iv].getErrorMessage()#" class="my_txtfield" />
																		Value: <input type="text" name="#rc.validators[iv].getName()#Value" value="#rc.validators[iv].getValue()#" class="my_txtfield" />
																	</cfif>
																</td>
															</tr>
														</cfloop>
													</table>
												</td>
											</tr>
										</table>
									</form>
								</td>
							</tr>
						</table>

					</cfloop>

					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="100%">
								<input type="button" name="btnSubmit" value="Click Here To Submit" onclick="saveColumns();" class="buta" />&nbsp;&nbsp;&nbsp;
								<input type="button" name="btnSubmit" value="Click Here To Next Table" onclick="saveColumns();" class="buta" />
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</cfoutput>