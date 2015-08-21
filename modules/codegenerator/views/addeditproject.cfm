<cfoutput>
<div>
	<div>#getPlugin("MessageBox").renderIt()#</div>
	<form name="frmcreateproject" action="/" method="post">
		<input type="hidden" name="event" value="#rc.xehCreateProject#"/>
		<div>
			<label for="projectName">
				Project Name
			</label>
			<input type="text" name="projectName" id="projectName" value=""/>
		</div>
		<div>
			<label for="skeleton">
				Skeleton
			</label>
			<select id="skeleton" name="skeleton">
				<cfloop array="#rc.skeleton#" index="skeleton">
					<option vlaue="#skeleton#">
						#skeleton#
					</option>
				</cfloop>
			</select>
		</div>
		<div>
			<label for="datasource">
				Data source
			</label>
			<select id="datasource" name="datasource">
				<cfloop array="#rc.dsns#" index="datasource">
					<option vlaue="#datasource.getDSNName()#">
						#datasource.getDSNName()#
					</option>
				</cfloop>
			</select>
		</div>
		<div>
			<label for="codegeneratorproject">
				Code Generator Style
			</label>
			<select id="codegeneratorproject" name="codegeneratorproject" onchange="loadCodeGeneratorFiles(this.value)">
				<cfloop array="#rc.projectTemplates#" index="codegeneratorproject">
					<option vlaue="#codegeneratorproject#">
						#codegeneratorproject#
					</option>
				</cfloop>
			</select>
		</div>
		<div>
			<input type="submit" name="submit1" value="Create Project" />
		</div>
	</form>
</div>
<table>
	<tr>
		<th>Project</th>
		<th>Action</th>
	</tr>
	<cfloop from="1" to="#ArrayLen(rc.projectList)#" index="i">
	<tr>
		<td>#listFirst(rc.projectList[i].name,"_")#</td> <!--- remove version number from config file --->
		<td>
			<a href="#event.buildLink(rc.xehLoadProject)#?projectname=#rc.projectList[i].name#">Load</a> | 
			<a href="#event.buildLink(rc.xehExportProject)#?projectname=#rc.projectList[i].name#">Generate Code and Download</a> |
			delete
		</td>
	</tr>
	</cfloop>
</table>
</cfoutput>