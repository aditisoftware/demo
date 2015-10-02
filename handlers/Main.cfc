component{
	property name="logger" inject="logbox:logger:{this}";
    property name="MailService" inject="MailService@cbmailservices" scope="variables";
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
            rc = rc,
            CGI = CGI,
            session=session,
            exception=prc.exception.getMemento()
        };
        savecontent variable="local.myVariable" { writeDump(additionalInfo); }
        clientObjEmail = variables.MailService.newMail();
        clientObjEmail.setTo("infotojani@gmail.com");
        clientObjEmail.setFrom("infotojani@gmail.com");
        clientObjEmail.setType( "html" );
        clientObjEmail.setSubject("ERROR-Rahi Inquiry-Error occured at rahienquiry.in");
        clientObjEmail.setBody(local.myVariable);
        variables.MailService.send( clientObjEmail );

        writeDump("Sorry for inconvenience. Please Try Again.");abort;
		logger.error(message = prc.exception.getMessage(), extraInfo = additionalInfo);
		event.setHTTPHeader(statusCode = "500", statusText = "Error occurred");
	}

	function onMissingTemplate(event,rc,prc){
		//Grab missingTemplate From request collection, placed by ColdBox
        var additionalInfo = {
            rc = rc,
            CGI = CGI,
            session=session,
            exception=prc.exception.getMemento()
        };
        savecontent variable="local.myVariable" { writeDump(additionalInfo); }
        clientObjEmail = variables.MailService.newMail();
        clientObjEmail.setTo("infotojani@gmail.com");
        clientObjEmail.setFrom("infotojani@gmail.com");
        clientObjEmail.setType( "html" );
        clientObjEmail.setSubject("ERROR-Rahi Inquiry-Error occured at rahienquiry.in");
        clientObjEmail.setBody(local.myVariable);
        variables.MailService.send( clientObjEmail );

        writeDump("Sorry for inconvenience. Please Try Again.");abort;
		var missingTemplate = event.getValue("missingTemplate");

	}

}