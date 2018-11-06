/**
* I am a new Model Object
*/
component accessors="true"{

	// Properties
	property name="id" type="string";
	property name="username" type="string";
	property name="email" type="string";
	property name="password" type="string";


	/**
	 * Constructor
	 */
	User function init(){

		return this;
	}

	boolean function isLoaded(){
        return ( !isNull( variables.id ) && len( variables.id ) );
	}

}
