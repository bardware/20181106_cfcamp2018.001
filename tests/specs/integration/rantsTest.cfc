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
	property name="auth" 		inject="authenticationService@cbauth";

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

		describe( "rants Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			it( "can display all rants", function(){
				var event = get( route="/rants" );
				// expectations go here.
				expect( event.getPrivateValue( "aRants" ) ).toBeArray();
				expect( event.getRenderedContent() ).toinclude( "Start one" );
			});

			it( "can display the rant form", function(){
                auth.authenticate( "testuser", "password" );
                var event = get( route="/rants/new" );
                // expectations go here.
                expect( event.getRenderedContent() ).toinclude( "Rant About It" );
            });

            it( "can stop a rant from being created from an invalid user", function(){
                auth.logout();
                var event = post( route="/rants/create", params={
                    body = "Testing Rant!"
                });
                expect( event.getValue( "setnextevent_event" ) ).toBe( "login" );
			});

			it( "can create a rant from a valid user", function(){
				auth.authenticate( "testuser", "password" );
				var event = post( route="/rants/create", params={
					body = "Testing Rant!"
				});
				auth.logout();

				// Use the 	`query` to test if the rant was created

				expect( event.getValue( "relocate_URI" ) ).toBe( "/rants" );
			});

			xit( "can show one rant", function(){

			});

			xit( "delete a rant", function(){

			});

			xit( "can show the modify rant form", function(){

			});

			xit( "can edit a rant", function(){

			});

		});

	}

}
