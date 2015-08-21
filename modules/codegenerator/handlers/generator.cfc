<cfcomponent output="false">

	<!--- Dependencies --->
	<!--- <cfproperty name="ServiceLocator" inject="model:GeneratorService" scope="instance">--->
 
	<cfproperty name="projectService" inject="model:projectService" scope="instance">
	<cfproperty name="tables" inject="model:TableService" scope="instance">
	<cfproperty name="validatorService" inject="model:ValidatorService" scope="instance">
	<cfproperty name="datasource" inject="model:Datasource" scope="instance">
	<!--- Default Action --->

	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var local = structNew()>
		<cfset local.configFilePath = getConfigPath(arguments.event)>
		<!--- Check for object already setup. --->
		<cfif fileExists(expandPath(local.configFilePath))>
			<cffile action="read" file="#expandPath(local.configFilePath)#" variable="local.fileContent">
			<cfset local.Project =  instance.projectService.deserializeCFC(local.fileContent)/>
			<cfset getPlugin("ApplicationStorage").setVar("_codeConfig", local.Project)>
			<cfset setNextEvent("codegenerator.generator.loadSettings")>
		<cfelse>
			<cfset local.setting = getModuleSettings(event.getCurrentModule()).settings>
			<cfset local.project = instance.projectService.createProject(getSetting("appName"),local.setting.datasource,instance.datasource.getDSNType())>
			<cfset getPlugin("ApplicationStorage").setVar("_codeConfig", local.Project)>
			<cfset runEvent("codegenerator:generator.saveProject")>
		</cfif>
	</cffunction>
	
	<cffunction name="loadSettings" returntype="void" output="false" hint="New screen for create/update changes">
		<cfargument name="event" required="true">
		<cfscript>
			var rc = event.getCollection();
			var local = StructNew();
			var arrTables = ArrayNew(1);
			var tables = "";
			var i = 1;
			var columns = ArrayNew(1);
			var clen = 0;
			var pos = 0;
			var prop = "";
			
			local.configPath = getConfigPath(arguments.event);
			local.project = getPlugin("ApplicationStorage").getVar("_codeConfig");
			if (not isDefined("local.project.getTables"))
				setNextEvent("codegenerator.generator.index");
			//writedump(local.project);abort;
			if(ArrayLen(local.project.getTables()) eq 0){
				local.project.setTables(instance.datasource.getDbms().getTables());
			}
			tables = local.project.getTables();
			event.paramValue("table",tables[i].getTableName());
			for(i=1; i<=ArrayLen(local.project.getTables()); i++) {
				ArrayAppend(arrTables, local.project.getTables()[i].getTableName());
				if (local.project.getTables()[i].getTableName() eq rc.table){
					rc.currentTable = tables[i];
					if(not ArrayLen( local.project.getTables()[i].getColumns())){
						tables[i].setColumns(instance.datasource.getDbms().getTableColumns(rc.table));
					}
				}
			}
			columns = rc.currentTable.getColumns();
			clen = ArrayLen(columns);
			for(i=1; i<=clen; i++){
				if (len(columns[i].getPKTable())){
					pos = ArrayFindNoCase(arrTables,columns[i].getPKTable());
					if (NOT ArrayLen(tables[pos].getColumns())){
						tables[pos].setColumns(instance.datasource.getDbms().getTableColumns(tables[pos].getTableName()));
					}
					event.setValue(tables[pos].getTableName(), tables[pos]);
				} else if(columns[i].getInputSourceType() EQ "cfc" AND len(columns[i].getInputSourceProperty())){
					prop = deserializejson(columns[i].getInputSourceProperty());
					pos = ArrayFindNoCase(arrTables,prop['PKTable']);
					if (NOT ArrayLen(tables[pos].getColumns())){
						tables[pos].setColumns(instance.datasource.getDbms().getTableColumns(tables[pos].getTableName()));
					}
					event.setValue(tables[pos].getTableName(), tables[pos]);
				}
			}
			
			rc.arrTables = arrTables;
			
			//Load all supported validators
			rc.validators = instance.validatorService.getAllValidators();
			
			rc.xehSaveColumn = "codegenerator.generator.saveColumn";
			rc.xehLoadSettings = "codegenerator.generator.loadSettings";
			rc.xehSaveProject = "codegenerator.generator.saveProject";
			rc.xehSaveTable = "codegenerator.generator.saveTable";
			rc.xehScanTablesChanges = "codegenerator.generator.scanTablesChanges";
			rc.xehgenerateCode = "codegenerator.generator.generateCode";
			rc.xehScanColumnChanges = "codegenerator.generator.scanColumnChanges";
			rc.xehLoadColumn = "codegenerator.generator.loadColumn";
			rc.xehReLoad = "codegenerator.generator.index";
			//set view
			event.setView("settings");
		</cfscript>
	</cffunction>
	
	<cffunction name="scanTablesChanges" returntype="void" output="false" hint="Scan database to find new tables">
		<cfargument name="event" required="true">
		<cfscript>
			var rc = event.getCollection();
			var local = structNew();
			var i=1;
			var j=1;
			var tables = ArrayNew(1);
			var newTables = ArrayNew(1);
			var lstNewTable = "";
			
			local.configPath = getConfigPath(arguments.event);
			local.project = getPlugin("ApplicationStorage").getVar("_codeConfig");
			
			tables = local.project.getTables();
			newTables = instance.datasource.getDbms().getTables();
			
			lstNewTable = "";
			for(i=1; i<=arrayLen(newTables); i++) {
				lstNewTable = listAppend(lstNewTable, newTables[i].getTableName());
				
				for(j=1; j<=arrayLen(tables); j++){
					if(tables[j].getTableName() == newTables[i].getTableName())
						break;
				}
				if(j == (arrayLen(tables)+1)) {
					//Table doesn't exist please add
					ArrayAppend(tables, newTables[i]);
					getMyPlugin(plugin="ErrorBox", module="codegenerator").info("Table " & newTables[i].getTableName() & " has been added.");
				}
			}
			for(i=1; i<=arrayLen(tables); i++){
				if(not listFindnocase(lstNewTable, tables[i].getTableName()))
				{
					getMyPlugin(plugin="ErrorBox", module="codegenerator").info("Table " & tables[i].getTableName() & " has been deleted.");
					//Delete record from position i.
					ArrayDeleteat(tables, i);
					i = i - 1;
				}
			}
			local.project.setTables(tables);
		</cfscript>
		<cfset setNextEvent("codegenerator.generator.loadSettings")>
	</cffunction>
	
	<cffunction name="scanColumnChanges" returntype="void" output="false" hint="Scan database table to find new changes">
		<cfargument name="event" required="true">
		<cfscript>
			var rc = event.getCollection();
			var local = structNew();
			var tables = ArrayNew(1);
			var dbtables = ArrayNew(1);
			var cTable = ""; //current config table
			var cDBTable = ""; //current db table
			var cCol = ""; //current config column
			var cDBCol = ""; //current db column
			var cValidators = "";
			var i=1;
			var j=1;
			var lstNewColumn = "";
			
			event.paramValue("table", ""); //table name should be in request collection
			
			if (len(rc.table)){
				local.configPath = getConfigPath(arguments.event);
				local.project = getPlugin("ApplicationStorage").getVar("_codeConfig");
				
				tables = local.project.getTables();
				
				for(i=1; i<=arrayLen(tables); i++){
					if(tables[i].getTableName() == rc.table)
						break;
				}
				if(i == (arrayLen(tables)+1)) {
					//Table doesn't exist
					getMyPlugin(plugin="ErrorBox", module="codegenerator").error("Table doesn't exist in project config file");
					setNextEvent("codegenerator.generator.loadSettings");
				} else {
					dbtables = instance.datasource.getDbms().getTables();
					for(j=1; i<=arrayLen(dbtables); j++){
						if(dbtables[j].getTableName() == rc.table)
							break;
					}
					if(j == (arrayLen(dbtables)+1)) {
						//Table doesn't exist
						getMyPlugin(plugin="ErrorBox", module="codegenerator").error("Table doesn't exist in database");
						setNextEvent("codegenerator.generator.loadSettings");
					} else {
						dbtables[j].setColumns(instance.datasource.getDbms().getTableColumns(rc.table));
						
						cTable = tables[i];
						cDBTable = dbtables[j];
						for(i=1; i<=arrayLen(cDBTable.getColumns()); i++) {
							lstNewColumn = listAppend(lstNewColumn, cDBTable.getColumns()[i].getName());
							for(j=1; j<=arrayLen(cTable.getColumns()); j++){
								if(cTable.getColumns()[j].getName() == cDBTable.getColumns()[i].getName())
									break;
							}
							if(j == (arrayLen(cTable.getColumns())+1)) {
								//Column doesn't exist please add
								ArrayAppend(cTable.getColumns(), cDBTable.getColumns()[i]);
								getMyPlugin(plugin="ErrorBox", module="codegenerator").info(cDBTable.getColumns()[i].getName() & ' has been added!<br/>');
							} else {
								cCol = cTable.getColumns()[j];
								cDBCol = cDBTable.getColumns()[i];
								// To check column changes, you need to match all metadata of each column aprart from it's name
								// e.g. As of now we have: DataType, Length, Identity, PrimaryKey, Required, Numeric_scale
								
								if (cCol.getDataType() == cDBCol.getDataType() AND cCol.getLength() == cDBCol.getLength() AND cCol.getIdentity() == cDBCol.getIdentity() AND cCol.getRequired() == cDBCol.getRequired() AND cCol.getPrimaryKey() == cDBCol.getPrimaryKey() AND cCol.getNumeric_scale() == cDBCol.getNumeric_scale()) {
									//No need to change anything for this column
								} else {
									//override column structure
									cTable.getColumns()[j] = cDBCol;
									getMyPlugin(plugin="ErrorBox", module="codegenerator").info(cCol.getName() & ' has been chnaged!<br/>');
								}
							}
						}
						for(i=1; i<=arrayLen(cTable.getColumns()); i++){
							if(not listFindnocase(lstNewColumn, cTable.getColumns()[i].getName())) {
								//Delete record from position i.
								getMyPlugin(plugin="ErrorBox", module="codegenerator").info(cTable.getColumns()[i].getName() & ' has been deleted!<br/>');
								ArrayDeleteat(cTable.getColumns(), i);
								i = i - 1;
							}
						}
					}
				}
			} else {
				getMyPlugin(plugin="ErrorBox", module="codegenerator").error("Table parameter is not passed in the argument");
				setNextEvent("codegenerator.generator.loadSettings");
			}
		</cfscript>
	
		<!--- <cffile action="write" file="#expandPath(local.configPath)#" output="#instance.projectService.serializeCFC(local.project)#"> --->
		<cfset setNextEvent(event="codegenerator.generator.loadSettings", queryString="table=" & rc.table)>
		
	</cffunction>
	
	<cffunction name="loadColumnSetting" access="public" output="false" returntype="void">
		<cfargument name="event" required="true" />
		<cfscript>
			var rc = event.getCollection();
			var objProject = getPlugin("ApplicationStorage").getVar("_codeconfig");
			var i=1;
			var arrTables = arrayNew(1);
			//Get all tables from database and set it.
			if(arrayLen(objProject.getTables()) eq 0){
				objProject.setTables(instance.datasource.getDbms().getTables());
			}
			rc.tables = objProject.getTables();
			event.paramValue("table",rc.tables[i].getTableName());

			//Get current table index
			for(i=1;i<=arrayLen(rc.tables);i=i+1){
				if(rc.tables[i].getTableName() eq rc.table){
					break;	//table exist and break loop
				}
			}
			rc.currentTable = rc.tables[i];
			if(not arrayLen( rc.tables[i].getColumns())){
				 rc.tables[i].setColumns(instance.datasource.getDbms().getTableColumns(rc.table));
			}

			//Load all supported validators
			rc.validators = instance.validatorService.getAllValidators();

			//Define exit events
			rc.xehSaveColumn = "codegenerator.generator.saveColumn";
			rc.xehLoadColumnSetting = "codegenerator.generator.loadColumnSetting";
			rc.xehSaveProject = "codegenerator.generator.saveProject";
			rc.xehSaveTable = "codegenerator.generator.saveTable";
			rc.xehGenerateCode = "codegenerator.generator.generateCode";
			//set view
			event.setView("columnsetting");
		</cfscript>
	</cffunction>
	
	<cffunction name="loadColumn" access="public" output="false" returntype="void">
		<cfargument name="event" required="true" />
		<cfscript>
			var rc = event.getCollection();
			var objProject = getPlugin("ApplicationStorage").getVar("_codeconfig");
			var tables = ArrayNew(1);
			var listColumnName = "";
			var i=1;
			var configPath = "";
			
			configPath = getConfigPath(arguments.event);
			tables = objProject.getTables();
			event.paramValue("table",tables[i].getTableName());

			//Get current table index
			for(i=1;i<=arrayLen(tables);i=i+1){
				if(tables[i].getTableName() eq table){
					break;	//table exist and break loop
				}
			}
			if(not arrayLen(tables[i].getColumns())){
				 tables[i].setColumns(instance.datasource.getDbms().getTableColumns(rc.table));
				 objProject.setTables(tables);
			}
			for(j=1; j<=arrayLen(tables[i].getColumns()); j++){
				listColumnName = ListAppend(listColumnName, tables[i].getColumns()[j].getName());
			}
		</cfscript>
		<cfset event.renderData(type='plain', data=listColumnName)>		
	</cffunction>

	<cffunction name="saveTable" access="public" output="false" returntype="void">
		<cfargument name="event" required="true">
		<cfscript>
			var rc = event.getCollection();
			var local = structNew();
			var objProject = "";
			lock scope="application" timeout="5" type="exclusive" {
				objProject = getPlugin("ApplicationStorage").getVar("_codeConfig");
				local.arrTables = objProject.getTables();
				for(i=1;i<=arrayLen(local.arrTables);i=i+1){
					if(local.arrTables[i].getTableName() eq rc.table){
						break;	//table exist and break loop
					}
				}
				rc.objTable = local.arrTables[i];
				rc.objTable.setComponentName(rc.ComponentName);
				rc.objTable.setComponentUserFriendlyName(rc.ComponentUserFriendlyName);
				local.returnStruct.success=true;
				local.returnStruct.message="Saved";
			}
		</cfscript>
		<cfset event.renderData(type='JSON', data=local.returnStruct)>
	</cffunction>

	<cffunction name="saveColumn" access="public" output="false" returntype="void">
		<cfargument name="event" required="true">
		<cfscript>
			var rc = event.getCollection();
			var local = structNew();
			var objProject = "";
			lock scope="application" timeout="5" type="exclusive" {
				objProject = getPlugin("ApplicationStorage").getVar("_codeConfig");
				local.arrTables = objProject.getTables();
				
				for(i=1;i<=arrayLen(local.arrTables);i=i+1){
					if(local.arrTables[i].getTableName() eq rc.table){
						break;	//table exist and break loop
					}
				}
				rc.objTable = local.arrTables[i];

				//set column data.
				local.columns = rc.objTable.getColumns();
				for(i=1;i<=arrayLen(local.columns);i++){
					if(rc.fieldName eq local.columns[i].getName())
						break;
				}
				//check for column exist
				if(i lte arrayLen(local.columns)){
					local.column = local.columns[i];		//get column object and set value from request
					local.column.setFormLabel(rc.label);
					local.column.setDisplayOnForm(rc.displayForm);
					local.column.setInputType(rc.inputtype);
					local.column.setDisplayInGrid(rc.displayInGrid);
					if(ListFindNoCase('select,radio,checkbox',rc.inputtype)){
						local.column.setInputSourceType(rc.inputproperty);
						if(rc.inputProperty Eq 'array'){
							local.column.setInputSourceProperty(rc.txtVal);
						}
						else if(rc.inputProperty Eq 'cfc'){
							local.inputProperty = '{"pktable":"#rc.PKTable#","label":"#rc.PKTableLabelColumn#","value":"#rc.PKTableValueColumn#"}';
							local.column.setInputSourceProperty(local.inputProperty);
						}
					}
					local.column.setValidators(arrayNew(1));
					event.paramValue('chkValidation',"");
					for(i=1;i<=listLen(rc.chkValidation);i=i+1){
						local.validatorType = listGetAt(rc.chkValidation,i);
						local.validator = instance.validatorService.createValidator(validatorType=local.validatorType,
										validatorValue=rc[local.validatorType & "Value"],
										validatorMsg = rc[local.validatorType & "Msg"]
										);
						local.column.addValidator(local.Validator);
					}
					local.returnStruct.success=true;
					local.returnStruct.message="Saved";
				}
				else{
					local.returnStruct.success=false;
					local.returnStruct.message="Column doesn't exist";
				}
			}
		</cfscript>
		<cfset event.renderData(type='JSON', data=local.returnStruct)>
	</cffunction>

	<cffunction name="saveProject" access="public" output="false" returntype="void">
		<cfargument name="event" required="true" />
		<cfset var rc = event.getCollection()>
		<cfset var local = structNew()>
		<cfset local.configPath = getConfigPath(arguments.event)>
		<cfset local.project =  getPlugin("ApplicationStorage").getVar("_codeConfig")>
		<cffile action="write" file="#expandPath(local.configPath)#" output="#instance.projectService.serializeCFC(local.project)#">
		<cfset getMyPlugin(plugin="ErrorBox", module="codegenerator").info("Project saved in configuration file successfully.")>
		<cfset setNextEvent("codegenerator.generator.loadSettings")>
	</cffunction>

	<cffunction name="generateCode" access="public" output="false" returntype="void">
		<cfargument name="event" required="true" />
		<cfset var local = structNew()>
		<cfset var moduleSetting = getModuleSettings(event.getCurrentModule())>
		<cfset var objProject = getPlugin("ApplicationStorage").getVar("_codeconfig")>
		<cfset var tableNames = "">
		<cfset event.paramValue("generateCode","$$ALL")> <!--- Possible value '$$STATIC' or any existing table name--->
		<cfset local.templatePath = expandPath(event.getModuleRoot() & "/includes/codetemplate/" & moduleSetting.settings.codeTemplate)>
		<cfset local.tables = objProject.getTables()>
		
		<!--- Check all tables are configured or not --->
		<cfif rc.generateCode eq "$$ALL">
			<cfloop array="#local.tables#" index="local.table">
				<cfif NOT len(local.table.getComponentName())>
					<cfset tableNames = listappend(tableNames,local.table.getTableName())>
				</cfif>
			</cfloop>
			<cfif len(tableNames)>
				<cfset getMyPlugin(plugin="ErrorBox", module="codegenerator").error("Following tables are not configured.<br/>" & tableNames)>
				<cfset setNextEvent("codegenerator.generator.loadSettings")>
			</cfif>
		</cfif>

		<cfset local.rootPath = "">
		<cfset local.fileseperateor = moduleSetting.settings.fileseperateor>
		<!--- Get template directory --->
		<cfdirectory action="list" directory="#local.templatePath#" recurse="true" name="qList" type="file" sort="directory">
		<cfloop query="qList">
			<!--- Get logical path of source --->
			<cfset local.source = event.getModuleRoot() & "/includes/codetemplate/"  & moduleSetting.settings.codeTemplate & replaceNoCase(replaceNocase(qList.directory,local.templatePath,""),local.fileseperateor,"/","all")>
			<cfset local.sourceFile = qList.Name>
			<cfset local.sourceFilePath = local.source & "/" & local.sourceFile>
			<cfset local.pSourceFilePath = expandPath(local.sourceFilePath)>
			
			<cfif local.sourceFile EQ "thumbs.db" >
				<cfcontinue/>
			</cfif>
			
			<cfset local.destination =local.rootPath & replaceNoCase(replaceNocase(qList.directory,local.templatePath,""),local.fileseperateor,"/","all")>
			<cfset local.destinationFile =  qList.name>
			<cfset local.destinationFilePath = local.destination & "/" & local.destinationFile>
			<cfset local.pDestinationFilePath = expandPath(local.destinationFilePath)>
			<!--- Create directory if not exists --->
			<cfif len(local.destination) and not directoryExists(expandPath(local.destination))>
				<cfdirectory action="create" directory="#expandPath(local.destination)#">
			</cfif>
			
			<cfif (findNoCase("__table__",qlist.name) or findNoCase("$$table$$",qlist.name) or findNoCase("__NOTABLE__",qlist.name) or findNoCase("$$NOTABLE$$",qlist.name)) and rc.generateCode neq "$$STATIC">
				<cfloop array="#local.tables#" index="local.table">
					<cfif rc.generateCode eq "$$ALL" or rc.generateCode eq local.table.getTableName()>
						<!--- Check if component is configured or not --->
						<cfif NOT len(local.table.getComponentName())>
							<cfset getMyPlugin(plugin="ErrorBox", module="codegenerator").error("Table " & rc.generateCode & " is not configured!<br/>Please save table and then generate code.")>
							<cfset setNextEvent(event="codegenerator.generator.loadSettings", queryString="table=" & rc.generateCode)>
						<cfelse>
							<cfset local.overwrite = true>
							<cfif findNoCase("__table__",qlist.name)>
								<cfset local.destinationFile = replacenocase(qlist.name,"__table__",local.table.getComponentName(),"all")>
							<cfelseif findNoCase("__NOTABLE__",qlist.name) eq 1>
								<cfset local.destinationFile = replacenocase(qlist.name,"__NOTABLE__","")>
							<cfelseif findNoCase("$$NOTABLE$$",qlist.name) eq 1> <!--- $$NOTABLE$$ file will not overwrite if already exists. --->
								<cfset local.destinationFile = replacenocase(qlist.name,"$$NOTABLE$$","")>
								<cfif fileexists(expandPath(local.destination & "/" & local.destinationFile))>
									<cfset local.overwrite = false>
								</cfif>
							<cfelseif findNoCase("$$table$$",qlist.name) eq 1> <!--- $$table$$ file will not overwrite if already exists. --->
								<cfset local.destinationFile = replacenocase(qlist.name,"$$table$$",local.table.getTableName(),"all")>
								<cfif fileexists(expandPath(local.destination & "/" & local.destinationFile))>
									<cfset local.overwrite = false>
								</cfif>
							</cfif>
							<cfset local.destinationFilePath = local.destination & "/" & local.destinationFile>
							<cfset local.pDestinationFilePath = expandPath(local.destinationFilePath)>
							<cfif local.overwrite>
								<cfset variables.table = local.table>
								<cfset variables.project = local.objProject>
								<cfsavecontent variable="local.fileContent">
									<cfinclude template="#local.sourceFilePath#">
								</cfsavecontent>
								<cfset local.fileContent = replaceNocase(local.fileContent,"<%","<","all")>
								<cfset local.fileContent = replaceNocase(local.fileContent,"%>",">","all")>
								<cfset local.fileContent = replaceNocase(local.fileContent,"%","##","all")>
								<cffile action="write" file="#local.pDestinationFilePath#" output="#local.fileContent#">
							</cfif>
						</cfif>
					</cfif>
				</cfloop>
			<cfelseif (rc.generateCode eq "$$STATIC" or rc.generateCode eq "$$ALL") AND NOT (findNoCase("__table__",qlist.name) or findNoCase("$$table$$",qlist.name) or findNoCase("__NOTABLE__",qlist.name) or findNoCase("$$NOTABLE$$",qlist.name))>
				<cffile action="copy" source="#local.pSourceFilePath#" destination="#local.pDestinationFilePath#">
			</cfif>
		</cfloop>
		<cfif rc.generateCode neq "$$ALL" AND rc.generateCode neq "$$STATIC">
			<cfset getMyPlugin(plugin="ErrorBox", module="codegenerator").success("Code generated successfully for this table.")>
			<cfset setNextEvent(event="codegenerator.generator.loadSettings", queryString="table=" & rc.generateCode)>
		<cfelse>
			<cfset getMyPlugin(plugin="ErrorBox", module="codegenerator").success("Code generated successfully.")>
			<cfset setNextEvent("codegenerator.generator.loadSettings")>
		</cfif>
		<cfabort>

	</cffunction>

	<cffunction name="getConfigPath" access="private" output="false" returntype="string">
		<cfargument name="event" required="true" />
		<cfscript>
			var settings = getModuleSettings(event.getCurrentModule());
			rc.configFileName = hash(getSetting("appName")) & "_" & settings.version & ".cfg";	
			return event.getModuleRoot() & "/includes/projects/" & rc.configFileName;
		</cfscript>
	</cffunction>	
</cfcomponent>
