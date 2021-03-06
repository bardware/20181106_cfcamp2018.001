/**
* I am a new handler
*/
component{

    property name="reactionService" inject="id";

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
    * Executes before all handler actions
    */
    any function preHandler( event, rc, prc, action, eventArguments ){
        event.paramValue( "id", "" );
        if( !len( rc.id ) ){
            messagebox.warn( "No rant ID located" );
            relocate( "rants" );
        }
    }

	/**
	* create
	*/
    function create( event, rc, prc ){
        reactionService.poop( rc.id, auth().getUserId() );
        relocate( "rants" );
    }

    /**
    * delete
    */
    function delete( event, rc, prc ){
        reactionService.unpoop( rc.id, auth().getUserId() );
        relocate( "rants" );
    }

}
