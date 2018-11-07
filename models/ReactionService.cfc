/**
* I am a new Model Object
*/
component accessors="true"{

	// Properties
	property name="wirebox"               	inject="wirebox";
	property name="populator"             	inject="wirebox:populator";

	/**
	 * Constructor
	 */
	ReactionService function init(){

		return this;
	}

	function newBump() provider='Bump'{}
	function newPoop() provider='Poop'{}

	/**
	* getBumpsForRant
	*/
	function getBumpsForRant( required rant ){
		return queryExecute(
			"select * from bumps where rantId = ?",
			[ rant.getId() ],
			{ returnType = "array" }
		).map( function( bump ){
			return populator.populateFromStruct(
				newBump(),
				bump
			)
		} );
	}

	/**
	* getPoopsForRant
	*/
	function getPoopsForRant( required rant ){
		return queryExecute(
			"select * from poops where rantId = ?",
			[ rant.getId() ],
			{ returnType = "array" }
		).map( function( poop ){
			return populator.populateFromStruct(
				newPoop(),
				poop
			)
		} );
	}

	function bump( rantId, userId ){
		queryExecute(
			"INSERT INTO bumps values (?,?)",
			[ arguments.userId, arguments.rantId ]
		);
	}

	function unbump( rantId, userId ){
		queryExecute(
			"DELETE FROM bumps where userId = ? and rantId = ?",
			[ arguments.userId, arguments.rantId ]
		);
	}

	function poop( rantId, userId ){
		queryExecute(
			"INSERT INTO poops values (?,?)",
			[ arguments.userId, arguments.rantId ]
		);
	}

	function unpoop( rantId, userId ){
		queryExecute(
			"DELETE FROM poops where userId = ? and rantId = ?",
			[ arguments.userId, arguments.rantId ]
		);
	}

}
