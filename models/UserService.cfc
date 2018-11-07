/**
* I am a new Model Object
*/
component singleton accessors="true"{

	// Properties
	property name="bcrypt" inject="@bcrypt";
    property name="wirebox" inject="wirebox";
	property name="populator" inject="wirebox:populator";
	property name="authenticationService"     inject="AuthenticationService@cbauth";
	property name="messagebox"                 inject="messagebox@cbmessagebox";
	property name="reactionService"             inject;

	/**
	 * Constructor
	 */
	UserService function init(){

		return this;
	}

	array function list(){
		return queryExecute(
			"select * from users",
			{},
			{ returnType = "array" }
		)
	}

	User function new() provider="User"{}

	function userValidator( rule, controller ){
        var isLoggedIn = authenticationService.isLoggedIn();
        // Validate the rule roles, permissions, etc

        if( !isLoggedIn ){
            messagebox.warn( "You cannot access this buddy! Try again!" );
        }

        return isLoggedIn;
    }

    User function retrieveUserByID( required id ){
        return populator.populateFromQuery(
            new(),
            queryExecute( "SELECT * FROM `users` WHERE `id` = ?", [ id ] ),
            1
        );
    }

    User function retrieveUserByUsername( required username ){
        return populator.populateFromQuery(
            new(),
            queryExecute( "SELECT * FROM `users` WHERE `username` = ?", [ username ] ),
            1
        );
    }

    boolean function isValidCredentials( required username, required password ){
        var oUser = retrieveUserByUsername( username );
        if( !oUser.isLoaded() ){
            return false;
        }

        return bcrypt.checkPassword( password, oUser.getPassword() );
	}

	function create( required user ){
		queryExecute(
			"
				INSERT INTO `users` (`email`, `username`, `password`)
				VALUES (?, ?, ?)
			",
			[
				user.getEmail(),
				user.getUsername(),
				bcrypt.hashPassword( user.getPassword() )
			],
			{ result = "local.result" }
		);
		user.setId( result.generatedKey );
		return user;
	}

	function getBumpsForUser( required user ){
        return queryExecute(
            "select * from bumps where userId = ?",
            [ user.getId() ],
            { returnType = "array" }
        ).map( function( bump ){
            return populator.populateFromStruct(
                reactionService.newBump(),
                bump
            )
        } );
    }

    function getPoopsForUser( required user ){
        return queryExecute(
            "select * from poops where userId = ?",
            [ user.getId() ],
            { returnType = "array" }
        ).map( function( poop ){
            return populator.populateFromStruct(
                reactionService.newPoop(),
                poop
            )
        } );
	}

}
