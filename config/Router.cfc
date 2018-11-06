component{

	function configure(){
		setFullRewrites( true );

		resources( "registration" );

		route( "/login" )
        	.withAction( { "POST" = "create", "GET" = "new" } )
        	.toHandler( "sessions" );

    	delete( "/logout" ).to( "sessions.delete" );

		route( ":handler/:action?" ).end();
	}

}
