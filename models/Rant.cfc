/**
* I am a new Model Object
*/
component accessors="true"{

	//DI
	property name="userService" inject;
	property name="reactionService" inject;

	// Properties
	property name="id" type="string";
	property name="body" type="string";
	property name="createdDate" type="date";
	property name="modifiedDate" type="date";
	property name="userID" type="string";

	/**
	 * Constructor
	 */
	Rant function init(){

		return this;
	}

	/**
	* getUser
	*/
	function getUser(){
		return userService.retrieveUserByID( variables.userID );
	}

	/**
	* isLoaded
	*/
	function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	array function getBumps(){
        return reactionService.getBumpsForRant( this );
    }

    array function getPoops(){
        return reactionService.getPoopsForRant( this );
	}

}
