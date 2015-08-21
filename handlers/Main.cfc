component{
	property name="logger" inject="logbox:logger:{this}";
	// Default Action
	function index(event,rc,prc){
		prc.welcomeMessage = "Welcome to ColdBox!";
		abort;
		event.setView("main/index");
	}

	// Do something
	function doSomething(event,rc,prc){
		setNextEvent("main.index");
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){

	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		var additionalInfo = {
			CGI = CGI,
			exception = prc.exception.getMemento()
		};

		logger.error(message = prc.exception.getMessage(), extraInfo = additionalInfo);
		event.setHTTPHeader(statusCode = "500", statusText = "Error occurred");
        //location url="/" statuscode=302 addtoken="false";
	}

	function onMissingTemplate(event,rc,prc){
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");

	}

}