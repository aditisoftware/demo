<!-----------------------------------------------------------------------

	This plugin is used displaying alert message boxes.
	The user has three types of messages: 1) Warning 2) Error 3) Information
	Message argument can have four kind of data
	1. String : Simple string
	2. Array of String : Bunch of strign messages
	3. Structure : Structure with following parameter
					1. message	(Mandator)
					2. errorCode	(Optional) - this error code will use to customize message based on storeproce name
					3. storeProcName (Optional) - this storeProcName will use to customize message based on storeproce name
	
	The message is stored in the session scope. It can be changed to client
	The look can be altered by by creating class.

Below are test cases

//test 1
var msg = "hello";

//test 2
var msg = structNew();
msg.message = "Hello Strcut";

//test 3
var msg = structNew();
msg.message = "Hello Strcut";
msg.errorCode = "123";
msg.storeprocname ="";

//test 4
var msg = structNew();
msg.message = "Hello Strcut";
msg.errorCode = "010";
msg.storeprocname ="getCards";

//test 4
var msg = arrayNew(1);
msg[1] = "Frist Message";
msg[2] = StructNew();
msg[2].message = "Hello Strcut";
msg[2].errorCode = "010";
msg[2].storeprocname ="getCards";
msg[3] = StructNew();
msg[3].message = "Hello Strcut Mesg";
----------------------------------------------------------------------->
<cfcomponent hint="This is the ErrorBox plugin. It uses the session/client scope to save messages."
			 output="false"
			 cache="true">
<!--- Flash Scope --->
	<cfproperty name="flash" inject="coldbox:flash">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" returntype="ErrorBox" output="false" hint="Constructor">
		<cfscript>	
			// static constant save key
			instance.flashKey = "coldbox_plugin_ErrorBox";

			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->
	
	<!--- error --->
    <cffunction name="error" output="false" access="public" returntype="void" hint="Facade to setmessage with error type">
   		<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="Argument can be string,array of string, structure,array of structure ">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="error">
		<cfset setMessage(argumentCollection=arguments)>
	 </cffunction>
	
	<!--- error --->
    <cffunction name="info" output="false" access="public" returntype="void" hint="Facade to setmessage with info type">
   		<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="info">
		<cfset setMessage(argumentCollection=arguments)> 
	</cffunction>
	
	<!--- error --->
    <cffunction name="warn" output="false" access="public" returntype="void" hint="Facade to setmessage with warning type">
    	<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="warning">
		<cfset setMessage(argumentCollection=arguments)>
	</cffunction>
	

	<!--- Set a message --->
	<cffunction name="setMessage" access="public" hint="Create a new ErrorBox. Look at types." output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="type"     			required="true"   type="string" hint="The message type.Available types [error][warning][info]">
		<cfargument name="message"  			required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  			required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfscript>
			var msg = structnew();
			// check message type
			if( refindnocase("(error|warning|info)", trim(arguments.type)) ){
				// Populate message
				msg.type 	= arguments.type;
				msg.renderTo = arguments.renderTo;
				msg.message = processMessage(arguments.message);
				
				// Flash it
				flash.put(name=instance.flashKey,value=msg,inflateToRC=false,saveNow=true,autoPurge=false);
				
			}
			else{
				$throw("The message type is invalid: #arguments.type#","Valid types are info,error or warning","ErrorBox.InvalidMessageType");
			}
		</cfscript>
	</cffunction>
	
	<!--- Append A message --->			
	<cffunction name="append" access="public" returntype="void" hint="Append a message to the ErrorBox. If there is no message, then it sets the type to information." output="false" >
		<!--- ************************************************************* --->
		<cfargument name="message"  	required="true"  type="any" hint="The message to append, it does not include any breaks or delimiters. You must send that.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfscript>
			var currentMessage = "";
			var newMessage = "";
			// Do we have a message?
			if( isMsgEmpty() ){
				// Set default message
				setMessage('error',arguments.message,arguments.renderTo);
			}
			else{
				// Get Current Message
				currentMessage = getMessage();
				// Append
				newMessage = concatArray(currentMessage.message,processMessage(arguments.message));
				// Set it back
				setMessage(currentMessage.type,newMessage);				
			}
		</cfscript>
	</cffunction>
	
	<!--- Get a Message --->
	<cffunction name="getMessage" access="public" hint="Returns a structure of the message if it exists, else a blank structure." returntype="any" output="false">
		<cfscript>
			var msg = structnew();
			
			// Check flash
			if( flash.exists(instance.flashKey) ){
				return flash.get(instance.flashKey);
			}
			
			// return empty ErrorBox.
			msg.type = "";
			msg.renderTo = "";
			msg.message = arrayNew(1);
			
			return msg;
		</cfscript>
	</cffunction>
	
	<!--- Clear the message --->
	<cffunction name="clearMessage" access="public" hint="Clears the message structure by deleting it from the session scope." output="false" returntype="void">
		<cfscript>
			flash.remove(name=instance.flashKey,saveNow=true);
		</cfscript>
	</cffunction>

	<!--- Is Empty --->
	<cffunction name="isMsgEmpty" access="public" hint="Checks wether the ErrorBox is empty or not." returntype="boolean" output="false">
		<cfscript>
			var msgStruct = getMessage();
			if( len(msgStruct.type) eq 0 and arrayLen(msgStruct.message) eq 0 ){
				return true;
			}
			return false;
		</cfscript>
	</cffunction>

	<!--- Render It --->
	<cffunction name="renderit" access="public" hint="Renders the message box and clears the message structure by default." output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="renderTo"  	required="false"  type="string" default="" hint="Specify text to render it on particular place">
		<cfargument name="clearMessage" type="boolean" required="false" default="true" hint="Flag to clear the message structure or not after rendering. Default is true.">
		<!--- ************************************************************* --->
		<cfset var msgStruct = getMessage()>
		<cfset var results = "">
		
		<cfif msgStruct.renderTo eq arguments.renderTo>
			<cfset results = generateMessage(msgStruct)>
		
			<!--- Test to clear message structure from flash? --->
			<cfif arguments.clearMessage>
				<cfset flash.remove(name=instance.flashKey,saveNow=true)>
			</cfif>
		</cfif>
		<!--- Return Message --->
		<cfreturn results>
	</cffunction>
	
	<!--- renderMessage --->
	<cffunction name="renderMessage" access="public" hint="Renders a ErrorBox immediately for you with the passed in arguments" output="false" returntype="any">
		<!--- ************************************************************* --->
		<cfargument name="type"     			required="true"   type="string" hint="The message type.Available types [error][warning][info]">
		<cfargument name="message"  			required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset var msgStruct = structnew()>
		<cfset var i = 0>
		<cfset var results = "">
		
		<!--- Verify Message Type --->
		<cfif refindnocase("(error|warning|info)", trim(arguments.type))>
			<!--- Populate message struct --->
			<cfset msgStruct.type = arguments.type>
			<cfset msgStruct.renderTo = arguments.renderTo>
			<cfset msgStruct.message = processMessage(arguments.message)>			
		<cfelse>
			<cfthrow message="Invalid message type: #arguments.type#" detail="Valid types are info,warning,error" type="ErrorBox.InvalidMessageType">
		</cfif>
		
		<cfreturn generateMessage(msgStruct)>		
	</cffunction>
	
<!------------------------------------------- PRIVATE ------------------------------------------>

	<cffunction name="processMessage" output="false" access="private" returntype="array">
    	<cfargument name="message" required="true"  type="any" hint="message">
		<cfscript>
			var i =1;
			var retMsg = arrayNew(1);
			var msg = "";
			if(isArray(arguments.message)){
				for(i=1;i<=arrayLen(arguments.message);i=i+1){
					retMsg = concatArray(retMsg,processMessage(arguments.message[i]));
				}
			}
			else if(isStruct(arguments.message)){
				arrayAppend(retmsg,customMessage(arguments.message));
			}
			else if(isSimpleValue(arguments.message)){
				arrayAppend(retmsg,arguments.message);
			}
			else{
				throw("Invalid message type");
			}
		</cfscript>
		<cfreturn retMsg>
    </cffunction>
    
    <cffunction name="generateMessage" output="false" access="private" returntype="string">
		<cfargument name="msgStruct" required="true" type="struct">
		<cfset var i = "">
		<cfset var errClass = "">
		<cfset local.retMsg = "">
		<cfif arrayLen(msgStruct.message)>
			<cfswitch expression="#msgStruct.type#">
				<cfcase value="error">
					<cfset errClass = "alert-danger">
				</cfcase>
				<cfcase value="info">
					<cfset errClass = "alert-success">
				</cfcase>
				<cfcase value="warn">
					<cfset errClass = "alert-warning">
				</cfcase>
			</cfswitch>
			<cfsavecontent variable="local.retMsg"><cfoutput><div class="alert #errClass#"><ul><cfloop from="1" to="#arrayLen(msgStruct.message)#" index="i"><li><strong>#msgStruct.message[i]#</strong></li></cfloop></ul></div></cfoutput></cfsavecontent>
			<cfif msgStruct.renderto eq "dialog">
				<cfsavecontent variable="local.dialog"><cfoutput><script type="text/javascript">
					$(function(){
					$("#jsStringFormat(local.retMsg)#").dialog({modal:true,resizable:false,closeText:'Close',title:'#ucase(msgStruct.type)#',buttons: [
    				{			
				        text: "Close",
				        click: function() { $(this).dialog("close"); }
				    }]});});</script></cfoutput>		
				</cfsavecontent>
				<cfhtmlhead text="#local.dialog#" >
				<cfreturn "">
			</cfif>
		</cfif>
		<cfreturn local.retMsg>
	</cffunction> 
    
    <cffunction name="concatArray" output="false" access="private" returntype="array">
		<cfargument name="array1" required="true" type="array">
		<cfargument name="array2" required="true" type="array">
		<cfscript>
			var i = 1;
			for(i=1;i<=arrayLen(array2);i=i+1){
				arrayAppend(array1,array2[i]);
			}
			return array1;
		</cfscript>
	</cffunction>
	<!--- flattenMessageArray --->
    <cffunction name="flattenMessageArray" output="false" access="private" returntype="any">
    	<cfargument name="messageArray" required="true"  type="Array" hint="Array of messages to flatten">
		<cfset var i = 1>
		<cfset var message = "">
		
		<cfloop from="1" to="#arrayLen(arguments.messageArray)#" index="i">
			<cfset message = message & arguments.messageArray[i]>
			<cfif i neq ArrayLen(arguments.messageArray)>
				<cfset message = message & "<br/>">	
			</cfif>
		</cfloop>
		
		<cfreturn message>
    </cffunction>
	
	<cffunction name="customMessage" output="false" access="private" returntype="string" hint="">
		<cfargument name="messageStruct" required="true"  type="struct" hint="Single error structure">
		
		<cfscript>
			//Example of customizing the error message
			if(structKeyExists(arguments.messagestruct,"storeprocname") && structKeyExists(arguments.messagestruct,"errorcode")){
				switch (messageStruct.storeprocname) {
					case "getCards": 
						if (messageStruct.errorCode EQ "010")
							return "My custom message for code 010";
						else if (messageStruct.errorCode EQ "020")
							return "My custom message for code 020";
						else
							return messageStruct.message; //if no match, then return default or black
						break;
					case "AddCards":
						if (messageStruct.errorCode EQ "010")
							return "My custom message for code 010";
						else if (messageStruct.errorCode EQ "020")
							return "My custom message for code 020";
						else
							return messageStruct.message; //if no match, then return default or black
						break;
					default:
						return messageStruct.message; //if no match, then return default or black
				}
			}
			else
				return messageStruct.message;
		</cfscript>
	</cffunction>
	
</cfcomponent>




