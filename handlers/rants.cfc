/**
* I am a new handler
*/
component{

	property name="rantService" inject;
	property name="messagebox" 	inject="messagebox@cbMessageBox";
	property name="auth" 		inject="authenticationService@cbauth";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

	/**
	* index
	*/
	function index( event, rc, prc ){
		prc.aRants = rantService.getAll();
		event.setView( "rants/index" );
	}

	/**
	* new
	*/
	function new( event, rc, prc ){
		event.setView( "rants/new" );
	}

	/**
	* create
	*/
	function create( event, rc, prc ){
		event.paramValue( "body", "" );

		var oRant = populateModel( "Rant" );
		oRant.setUserID( auth.getUserID() );
		rantService.create( oRant );

		messagebox.success( "Rant created! Woot Woot!" );

		relocate( uri="/rants" );
	}

}
