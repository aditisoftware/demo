
<cfcomponent name="inqueryService" output="false" cache="true" cachetimeout="30" extends="inqueryServiceBase">
	<cffunction name="getTourType" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getTourType() />
	</cffunction>

	<cffunction name="getYesterdayInquiryCount" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getYesterdayInquiryCount() />
	</cffunction>
	<cffunction name="getLastMonthInquiryCount" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getLastMonthInquiryCount() />
	</cffunction>
	<cffunction name="getCurrentYearInquiryCount" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getCurrentYearInquiryCount() />
	</cffunction>
	<cffunction name="getTotalInquiryCount" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getTotalInquiryCount() />
	</cffunction>
	<cffunction name="getRecentInqList" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getReventInqList() />
	</cffunction>
	<cffunction name="getTop10AgentInquery" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getTop10AgentInquery() />
	</cffunction>
	<cffunction name="getqLast5MonthInquery" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getqLast5MonthInquery() />
	</cffunction>
	<cffunction name="getAgentLast5DayInquery" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getAgentLast5DayInquery() />
	</cffunction>
	<cffunction name="getAgentLast6MonthInquery" access="public" returntype="any" output="false">
		<cfreturn instance.inqueryGateway.getAgentLast6MonthInquery() />
	</cffunction>
</cfcomponent>

