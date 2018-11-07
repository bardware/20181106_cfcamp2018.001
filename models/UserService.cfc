/**
* I am a new Model Object
*/
component singleton accessors="true"{

	// Properties
	property name="bcrypt" inject="@bcrypt";
    property name="wirebox" inject="wirebox";
	property name="populator" inject="wirebox:populator";

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

	/**
     * Undocumented function
     */
    numeric function create( required email, required username, required password ){
        queryExecute(
            "
            INSERT INTO `users` ( `email`, `username`, `password` )
                VALUES ( ?, ?, ? )
            ",
            [
                arguments.email,
                arguments.username,
                bcrypt.hashPassword( arguments.password )
            ],
            {
                result : "local.result"
            }
        );

        return result.generatedKey;

    }

}
