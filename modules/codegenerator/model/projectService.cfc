<cfcomponent output="false">
	<cffunction name="init" access="public" returntype="projectService" output="false">
		<cfargument name="moduleSetting" required="true" inject="coldbox:setting:modules">
		<cfargument name="appName" required="true" inject="coldbox:setting:appName">
		<cfset variables.setting = arguments.moduleSetting>
		<cfset variables.appname = arguments.appname>
		<cfreturn this />
	</cffunction>

	<cffunction name="createProject" access="public" output="false" returntype="Project">
		<cfargument name="projectName" default="" required="false" />
		<cfargument name="datasource" default="" required="false" type="string" />
		<cfargument name="databaseType" required="false" default="" type="string" />
		<cfargument name="tables" required="false" default="#arrayNew(1)#" type="array" />
		<cfset var Project = createObject("component","Project").init(argumentCollection=arguments) />
		<cfreturn Project />
	</cffunction>

	<cffunction name="getProjectList" access="public" output="false" returntype="Array">
		<!--- TODO: Get All project list  --->
		<cfset var projects = arrayNew(1)>
		<cfset var fileList = "">
		<cfset var projectConfig = structNew()>
		<cfdirectory action="list" recurse="false" directory="#variables.projectPhysicalPath#" name="fileList" type="file" filter="*.cfg">
		<cfloop query="fileList">
			<!--- TODO: Need to change logic to get proper file name without extension --->
			<cfset projectConfig.name = listFirst(fileList.name,".")>
			<cfset projectConfig.path = fileList.directory & "" & fileList.name>
			<cfset arrayappend(projects,duplicate(projectConfig))>
		</cfloop>
		<cfreturn projects>
	</cffunction>

	<cffunction name="saveProject" access="public" output="false" returntype="boolean">
		<cfargument name="Project" type="Project" required="true" />
		<cfargument name="overwrite" type="boolean" required="true" default="false"/>
		<!--- TODO: Serialize object and store into file. --->
		<cfset var configPath = variables.projectPhysicalPath & arguments.project.getProjectName() & '_' & variables.appVersion & '.cfg'>
		<cfset var projectExport = expandPath(variables.exportPath & "/" & arguments.project.getProjectName())>
		<cfif not fileExists(configPath) or arguments.overwrite>
			<cffile action="write" file="#configPath#" output="#serializeCFC(arguments.project)#">
			<cfif not directoryExists(projectExport)>
				<cfset copyFolderRecurse(expandpath(variables.skeletonPath & "/" & arguments.project.getSkeleton()),projectExport)>
			</cfif>
			<cfreturn true>
		<cfelse>
			<cfthrow type="user" message="Project already exists.">
		</cfif>
	</cffunction>

	<cffunction name="deleteProject" access="public" output="false" returntype="boolean">
		<cfargument name="projectName" type="numeric" required="true" />
		<!--- TODO: Delete project folder from export list and setting list. --->
	</cffunction>

	<cffunction name="convertProjectConfigVersion" access="public" output="false" returntype="boolean">
		<cfargument name="projectName" required="true" >
		<cfargument name="currentVersion" required="true" >
		<cfscript>
			var configPath = variables.projectPhysicalPath & arguments.ProjectName & '_' & arguments.currentVersion & '.cfg';
			var newPath = variables.projectPhysicalPath & arguments.ProjectName & '_' & variables.appVersion & '.cfg';
			var local = structNew();
		</cfscript>
		<cffile action="read" file="#configPath#" variable="local.fileContent">
		<cfset local.Project =  deserializeCFC(local.fileContent)/>
		<cfset local.newProject = createObject("component","Project")>
		<cfset local.newProject = copyMe(local.Project,local.newProject)>
		<cffile action="write" file="#newPath#" output="#serializeCFC(local.newProject)#">
		<cffile action="delete" file="#configPath#">
		<cfreturn true>
	</cffunction>

	<cffunction name="serializeCFC" access="public" output="false" returntype="String">
	   <cfargument name="cfc" type="component" required="true">

	   <cfset var byteOut = CreateObject("java", "java.io.ByteArrayOutputStream") />
	   <cfset var objOut = CreateObject("java", "java.io.ObjectOutputStream") />

	   <cfset byteOut.init() />
	   <cfset objOut.init(byteOut) />
	   <cfset objOut.writeObject(arguments.cfc) />
	   <cfset objOut.close() />

	   <cfreturn ToBase64(byteOut.toByteArray()) />
	</cffunction>

	<cffunction name="deserializeCFC" access="public" output="false" returntype="any">
	   <cfargument name="base64cfc" type="string" required="true" />

	   <cfset var inputStream = CreateObject("java", "java.io.ByteArrayInputStream") />
	   <cfset var objIn = CreateObject("java", "java.io.ObjectInputStream") />
	   <cfset var com = "" />

	   <cfset inputStream.init(toBinary(arguments.base64cfc)) />
	   <cfset objIn.init(inputStream) />
	   <cfset com = objIn.readObject() />
	   <cfset objIn.close()>

	   <cfreturn com />
	</cffunction>

	<cffunction name="copyMe" access="private" output="false">
		<cfargument name="source" type="any" required="true" >
		<cfargument name="destination" type="any" required="true" > 
		<cfset var i = 0>
		<cfset var lc = "">
		<cfset var componentName = "">
		<cftry>
		<cfif isSimpleValue(arguments.source)>
			<cfset arguments.destination = arguments.source>
		<cfelseif isArray(arguments.source)>
			<cfset arguments.destination = arrayNew(1)>
			<cfloop from="1" to="#arrayLen(arguments.source)#" index="i">
				<cfset arguments.destination[i] = copyMe(arguments.source[i],"")>
			</cfloop>
		<cfelseif isObject(arguments.source)>
			<cfset componentName = arguments.source.getMeta().FullName>
			<cfset arguments.destination = createObject("component",componentName).init()>
			<cfset arguments.destination.setMemento(copyMe(arguments.source.getMemento(),arguments.destination.getMemento()))>
		<cfelseif isStruct(arguments.source)>
			<cfloop list="#structKeyList(arguments.source)#" index="lc">
				<cfif structKeyExists(arguments.destination,lc)>
					<cfset arguments.destination[lc] = copyMe(arguments.source[lc],arguments.destination[lc])>
				</cfif>
			</cfloop> 
		</cfif>
		<cfcatch>
			<cfdump var="#cfcatch#">
			<cfdump var="#arguments#"><cfabort>		
		</cfcatch>
		</cftry>
		<cfreturn arguments.destination>
	</cffunction>
</cfcomponent>