<!-----------------------------------------------------------------------

	This plugin is used displaying alert message boxes.
	The user has four types of messages: 1) Error 2) Warning 2) Information 3) success
	Message argument can have four kind of data
	1. String : Simple string
	2. Array of String : Bunch of string messages
	3. Structure : Structure with following parameter
					1. message	(Mandator)
					2. errorCode	(Optional) - this error code will use to customize message based on code
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
			 extends="coldbox.system.Plugin"
			 output="false"
			 cache="true">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" returntype="ErrorBox" output="false" hint="Constructor">
		<!--- ************************************************************* --->
		<cfargument name="controller" type="any" required="true" hint="coldbox.system.web.Controller">
		<!--- ************************************************************* --->
		<cfscript>	
			super.Init(arguments.controller);
			
			// Plugin Properties
			setpluginName("ErrorBox");
			setpluginVersion("1.0");
			setpluginDescription("This is a visual plugin that creates message boxes.");
			setpluginAuthor("iSummation");
			setpluginAuthorURL("http://www.isummation.com");
			
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
	
	<!--- info --->
    <cffunction name="info" output="false" access="public" returntype="void" hint="Facade to setmessage with info type">
   		<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="info">
		<cfset setMessage(argumentCollection=arguments)> 
	</cffunction>
	
	<!--- warn --->
    <cffunction name="warn" output="false" access="public" returntype="void" hint="Facade to setmessage with warning type">
    	<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="warning">
		<cfset setMessage(argumentCollection=arguments)>
	</cffunction>
	
	<!--- success --->
    <cffunction name="success" output="false" access="public" returntype="void" hint="Facade to setmessage with success type">
    	<!--- ************************************************************* --->
		<cfargument name="message"  	required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  	required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfset arguments.type="success">
		<cfset setMessage(argumentCollection=arguments)>
	</cffunction>
	

	<!--- Set a message --->
	<cffunction name="setMessage" access="public" hint="Create a new ErrorBox. Look at types." output="false" returntype="void">
		<!--- ************************************************************* --->
		<cfargument name="type"     			required="true"   type="string" hint="The message type.Available types [error][warning][info][success]">
		<cfargument name="message"  			required="false"  type="any" default="" hint="The message to show.">
		<cfargument name="renderTo"  			required="false"  type="any" default="" hint="Specify text to render it on particular place">
		<!--- ************************************************************* --->
		<cfscript>
			var newMessage = ArrayNew(1);
			var currentMessage = ArrayNew(1);
			var structMessage = StructNew();
			var i = 1;
			var length = 0;
			// check message type
			if( refindnocase("(error|warning|info|success)", trim(arguments.type)) ){
				if (isArray(arguments.message)) {
					length = ArrayLen(arguments.message);
					for(i=1; i<=length; i++) {
						structMessage = StructNew();
						structMessage.type 	= arguments.type;
						structMessage.renderTo = arguments.renderTo;
						if (isStruct(arguments.message[i]))
							structMessage.message = customMessage(arguments.message[i]);
						else
							structMessage.message = arguments.message[i];
						ArrayAppend(newMessage, structMessage);
					}
				}
				else if (isSimpleValue(arguments.message) OR isStruct(arguments.message)){
					structMessage.type 	= arguments.type;
					structMessage.renderTo = arguments.renderTo;
					if (isStruct(arguments.message))
						structMessage.message = customMessage(arguments.message);
					else
						structMessage.message = arguments.message;
					ArrayAppend(newMessage, structMessage);
				}
				else {
					throw("Invalid message type");	
				}
				
				if ( isMsgEmpty() ){
					currentMessage = newMessage;
				}
				else {
					currentMessage = getMessage();
					currentMessage = concatArray(currentMessage, newMessage);
				}
				
				// Flash it
				flash.put(name=instance.flashKey,value=currentMessage,inflateToRC=false,saveNow=true,autoPurge=false);
				
			}
			else{
				$throw("The message type is invalid: #arguments.type#","Valid types are info,error,warning or success","ErrorBox.InvalidMessageType");
			}
		</cfscript>
	</cffunction>
	
	<!--- Get a Message --->
	<cffunction name="getMessage" access="public" hint="Returns array of a structure of the message if it exists, else array with a blank structure." returntype="any" output="false">
		<cfscript>
			var msgArray = ArrayNew(1);
			var msg = structnew();
			
			// Check flash
			if( flash.exists(instance.flashKey) ){
				return flash.get(instance.flashKey);
			}
			
			// return empty ErrorBox.
			msg.type = "";
			msg.renderTo = "";
			msg.message = arrayNew(1);
			msgArray[1] = msg;
			
			return msgArray;
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
			var msgArray = getMessage();
			if( len(msgArray[1].type) eq 0 and arrayLen(msgArray[1].message) eq 0 ){
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

		<cfset var results = "">
		<cfset var i = "">
		<cfset var cnt = 0>
		<cfset var msgArray = getMessage()>
		<cfset var leftmsgArray = ArrayNew(1)>

		<cfif NOT isMsgEmpty() AND arrayLen(msgArray)>
			<cfsavecontent variable="results"><cfoutput><div class="errorbox">
				<ul><cfloop array="#msgArray#" index="msg">
					<cfif msg.renderTo eq arguments.renderTo><cfset cnt = cnt+1><li class="#msg.type#">#msg.message#</li><cfelse><cfset ArrayAppend(leftmsgArray, msg)></cfif></cfloop></ul>
			</div></cfoutput>
			</cfsavecontent>
		</cfif>
		
		<cfif arguments.clearMessage>
			<cfscript>
				if (ArrayLen(leftmsgArray))
					flash.put(name=instance.flashKey,value=leftmsgArray,inflateToRC=false,saveNow=true,autoPurge=false);
				else
					flash.remove(name=instance.flashKey,saveNow=true);
			</cfscript>
		</cfif>
		
		<!--- Return Message --->
		<cfif cnt gt 0>
			<cfreturn results>
		<cfelse>
			<cfreturn "">
		</cfif>
	</cffunction>
	
<!------------------------------------------- PRIVATE ------------------------------------------>
    
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