component{

	function configure(){
		setFullRewrites( true );

		route( "rants/:id/bumps" )
			.withAction( {
				"POST" : "create",
				"DELETE" : "delete"
			} )
			.toHandler( "bumps" );

		route( "rants/:id/poops" )
			.withAction( {
				"POST" : "create",
				"DELETE" : "delete"
			} )
			.toHandler( "poops" );

		resources( "registration" )
			.resources( "rants" );

		get( "/users/:username" ).to( "users.show" );

		route( "/login" )
        	.withAction( { "POST" = "create", "GET" = "new" } )
        	.toHandler( "sessions" );

		delete( "/logout" ).to( "sessions.delete" );

		route( ":handler/:action?" ).end();
	}

}
