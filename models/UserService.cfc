/**
* I am a new Model Object
*/
component singleton accessors="true"{

	// Properties
	property name="bcrypt" inject="@bcrypt";

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
