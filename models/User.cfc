component accessors="true"{

	property name="rantService" inject;
	property name="userService" inject;

	// Properties
	property name="id" type="string";
	property name="username" type="string";
	property name="email" type="string";
	property name="password" type="string";

	// Relations
	property name="bumps" type='array';
	property name="poops" type='array';

	/**
	 * Constructor
	 */
	User function init(){
		return this;
	}

	boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	array function getRants(){
		return rantService.getForUserId( variables.id );
	}

	array function getBumps(){
		if( isNull( variables.bumps ) ){
			variables.bumps = userService.getBumpsForUser( this );
		}
		return variables.bumps;
	}

	array function getPoops(){
		if( isNull( variables.poops ) ){
			variables.poops = userService.getPoopsForUser( this );
		}
		return variables.poops;
	}

	function hasBumped( rant ){
		return !getBumps().filter( function( bump ){
			return bump.getRantId() == rant.getId();
		} ).isEmpty();
	}

	array function getPoops(){
		if( isNull( variables.poops ) ){
			variables.poops = userService.getPoopsForUser( this );
		}
		return variables.poops;
	}

	function hasPooped( rant ){
		return !getPoops().filter( function( poop ){
			return poop.getRantId() == rant.getId();
		} ).isEmpty();
	}

}
