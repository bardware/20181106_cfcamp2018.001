component{

	function configure(){
		setFullRewrites( true );

		resources( "registration" );

		route( ":handler/:action?" ).end();
	}

}
