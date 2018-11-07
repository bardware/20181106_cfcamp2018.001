component{

	function configure(){
		setFullRewrites( true );

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
