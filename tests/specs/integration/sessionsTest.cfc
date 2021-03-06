
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

	property name="query" inject="provider:queryBuilder@qb";
	property name="bcrypt" inject="@bcrypt";

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		// do your own stuff here
		query.from( "users" )
			.insert( values = {
				username : "testuser",
				email : "testuser@test.com",
				password: bcrypt.hashPassword( "password" )
			});
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

		describe( "sessions Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "can show the login form", function(){
				var event = get( route="/login" );
				// expectations go here.
				expect( event.getRenderedContent() ).toInclude( "Log In" );
			});

			it( "can login a valid user", function(){
				var event = post( route="/login", params={ username="testuser", password="password" } );
				// expectations go here.
				expect( event.getValue( "relocate_URI" ) ).toBe( "/" );
				expect( getInstance( "authenticationService@cbauth" ).isLoggedIn() ).toBeTrue();
				getInstance( "authenticationService@cbauth" ).logout();
			});

			it( "can kick out an invalid user", function(){
				var event = post( route="/login", params={ username="bogus", password="bogus" } );
				// expectations go here.
				expect( event.getValue( "relocate_URI" ) ).toBe( "/login" );
				expect( getInstance( "authenticationService@cbauth" ).isLoggedIn() ).toBeFalse();
			});

			it( "can logout a user", function(){
				var event = delete( route="/logout" );
				// expectations go here.
				expect( event.getValue( "relocate_URI" ) ).toBe( "/" );
				expect( getInstance( "authenticationService@cbauth" ).isLoggedIn() ).toBeFalse();
			});

		});

	}

}
