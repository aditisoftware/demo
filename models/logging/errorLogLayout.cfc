<cfcomponent output="false" extends="coldbox.system.logging.Layout">
	<cffunction name="format" output="false" access="public" returntype="string" hint="Format a logging event message into your own format">
		<cfargument name="logEvent" type="coldbox.system.logging.LogEvent"   required="true"   hint="The logging event to use to create a message.">
		<cfsavecontent variable="entry">
			<cfoutput>
			<p>TimeStamp: #logEvent.getTimeStamp()#</p>
			<p>Severity: #logEvent.getSeverity()#</p>
			<p>Category: #logEvent.getCategory()#</p>
			<hr/>
			<pre>#logEvent.getMessage()#</pre>
			<hr/>
			<p>Extra Info Dump:</p>
			<cfif isjSON(logEvent.getExtraInfo())>
				<cfdump var="#deserializeJSON(logEvent.getExtraInfo())#">
			<cfelse>
				<cfdump var="#logEvent.getExtraInfo()#">
			</cfif>
			</cfoutput>
		</cfsavecontent>
		<cfreturn entry>
	</cffunction>
</cfcomponent>