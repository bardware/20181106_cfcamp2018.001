component extends="tests.resources.BaseIntegrationSpec" appMapping="/"{

	property name="query" inject="provider:QueryBuilder@qb";

	/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "Registration Suite", function(){

			beforeEach(function( currentSpec ){
				// Setup as a new ColdBox request for this suite, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			});

			/*
			it( "can show the user registration form", function(){
				var event = get( route="registration.new", params={} );
				// expectations go here.
				expect( false ).toBeTrue();
            });

            it( "can register a user", function(){
				var event = post( route="registration.create", params={} );
				// expectations go here.
				expect( false ).toBeTrue();
			});
			*/

			it( "can show the user registration form", function(){
				var event = get( route="registration.new", params={} );
				// expectations go here.
				expect( event.getRenderedContent() ).toInclude( "Register for SoapBox" );
			});

			it( "can register a user", function() {
				expect(
					queryExecute(
						"select * from users where username = :username",
						{ username : "testadmin" },
						{ returntype = "array" }
					)
				).toBeEmpty();

				var event = post( "/registration", {
					"username" = "testadmin",
					"email" = "testadmin@ortussolutions.com",
					"password" = "mypass1234",
					"passwordConfirmation" = "mypass1234"
				} );

				debug( event );
				debug( event.getValue( "relocate_URI", "" ) );

				expect( event.getValue( "relocate_URI", "" ) ).toBe( "/" );

				var users = query.from( "users" ).get();
				expect( users ).toBeArray();
				expect( users[ 1 ].username ).toBe( "testadmin" );
			} );

		});

	}

}
