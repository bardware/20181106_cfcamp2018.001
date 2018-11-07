/**
* I am a new handler
*/
component{

	property name="auth" inject="authenticationService@cbauth";
	property name="messagebox" inject="messagebox@cbmessagebox";

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
	* new
	*/
	function new( event, rc, prc ){
		event.setView( "sessions/new" );
	}

	/**
	* create
	*/
	/**
	* create
	*/
	function create( event, rc, prc ){
		event.paramValue( "username", "" )
			.paramValue( "password", "" )
		try{
			auth.authenticate( rc.username, rc.password );
			messagebox.success( "You are in!" );
			relocate( uri="/" );
		}catch( InvalidCredentials e ){
			messagebox.warn( e.message );
			relocate( uri = "/login" );
		}
	}

	/**
	* delete
	*/
	function delete( event, rc, prc ){
		auth.logout();
		messagebox.info( "bye bye!" );
		relocate( uri = "/" );
	}

}
