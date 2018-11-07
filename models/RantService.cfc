/**
* I am a new Model Object
*/
component singleton accessors="true"{

	// Properties
	property name="wirebox" inject="wirebox";
	property name="populator" inject="wirebox:populator";

	/**
	 * Constructor
	 */
	RantService function init(){

		return this;
	}

	Rant function new() provider="Rant"{}

	/**
	* getAll
	*/
	array function getAll(){
		return queryExecute(
			"SELECT * from rants order by createdDate DESC",
			[],
			{ returnType = "array" }
		).map( function( rant ){
			return populator.populateFromStruct(
				new(),
				rant
			);
		} );
	}

	/**
	 * Create a new rant
	 *
	 * @rant The rant object
	 */
	Rant function create( required rant ){
		rant.setModifiedDate( now() );
		queryExecute(
			"
                INSERT INTO `rants` (`body`, `modifiedDate`, `userId`)
                VALUES (?, ?, ?)
			",
			[
				rant.getBody(),
				{ value=rant.getModifiedDate(), cfsqltype="TIMESTAMP" },
				rant.getUserID()
			],
			{ result = "local.result" }
		);
		rant.setID( result.generatedKey );

		return rant;
	}

	array function getForUserId( required userId ){
        return queryExecute(
            "select * from rants where userId = ? order By createdDate DESC",
            [ arguments.userId ],
            { returnType = "array" }
        ).map( function( rant ){
            return populator.populateFromStruct(
                new(),
                rant
            )
        } );
    }

}
