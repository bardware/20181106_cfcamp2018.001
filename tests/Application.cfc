/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{

	// APPLICATION CFC PROPERTIES
	this.name 				= "ColdBoxTestingSuite" & hash(getCurrentTemplatePath());
	this.sessionManagement 	= true;
	this.sessionTimeout 	= createTimeSpan( 0, 0, 15, 0 );
	this.applicationTimeout = createTimeSpan( 0, 0, 15, 0 );
	this.setClientCookies 	= true;

	// Create testing mapping
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	// Map back to its root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings["/root"]   = rootPath;

	variables.util = new coldbox.system.core.util.Util();

	this.datasources = {
		"soapbox" = {
			"class" = util.getSystemSetting( "DB_CLASS" ),
			"connectionString" = util.getSystemSetting( "DB_CONNECTIONSTRING" ),
			"username" = util.getSystemSetting( "DB_USER" ),
			"password" = util.getSystemSetting( "DB_PASSWORD" )
		}
	};
	this.datasource = "soapbox";

	public void function onRequestEnd() {
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );
	}
}
