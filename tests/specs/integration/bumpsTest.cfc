/*******************************************************************************
*	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
*
*	Extends the integration class: coldbox.system.testing.BaseTestCase
*
*	so you can test your ColdBox application headlessly. The 'appMapping' points by default to
*	the '/root' mapping created in the test folder Application.cfc.  Please note that this
*	Application.cfc must mimic the real one in your root, including ORM settings if needed.
*
*	The 'execute()' method is used to execute a ColdBox event, with the following arguments
*	* event : the name of the event
*	* private : if the event is private or not
*	* prePostExempt : if the event needs to be exempt of pre post interceptors
*	* eventArguments : The struct of args to pass to the event
*	* renderResults : Render back the results of the event
*******************************************************************************/
component extends="tests.resources.BaseIntegrationSpec" appMapping="/"{

	property name="query" 		inject="provider:queryBuilder@qb";
	property name="bcrypt" 		inject="@BCrypt";
	property name="auth"		inject="authenticationService@cbauth";

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		// do your own stuff here
		query.from( "users" )
			.insert( values = {
				username : "testuser",
				email : "testuser@tests.com",
				password : bcrypt.hashPassword( "password" )
			} );
	}

	function afterAll(){
		// do your own stuff here
		super.afterAll();
		query.from( "users" )
			.where( "username", "=", "testuser" )
			.delete();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "bumps Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "can bump a rant", function(){
				auth.authenticate( "testuser", "password" );
				query.from( "rants" )
					.insert( values = {
						body : "Test Rant",
						userId : "1"
					} );
				var event = post( route="/rants/1/bumps");
				// expectations go here.
				var targetUser = getInstance( "userService" ).retrieveUserByUsername( "testuser" );
				var targetRant = getInstance( "rantService" ).get( 1 );
				// Validate the bump was recored
				expect( targetUser.hasBumped( targetRant ) ).toBeTrue();
				expect( event.getValue( "relocate_event" ) ).toBe( "rants" );
			});

			// Depends on the :point-up test
			it( "unbump a rant", function(){
				var event = delete( route="/rants/1/bumps");

				// expectations go here.
				var targetUser = getInstance( "userService" ).retrieveUserByUsername( "testuser" );
				var targetRant = getInstance( "rantService" ).get( 1 );

				// Validate the bump was recored
				expect( targetUser.hasBumped( targetRant ) ).toBeFalse();
				expect( event.getValue( "relocate_event" ) ).toBe( "rants" );
			});

		});

	}

}
