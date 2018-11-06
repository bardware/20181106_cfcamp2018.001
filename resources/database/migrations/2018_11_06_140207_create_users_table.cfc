component {

    function up( schema ) {
		/*
        queryExecute( "
            CREATE TABLE `users` (
                `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
                `username` VARCHAR(255) NOT NULL UNIQUE,
                `email` VARCHAR(255) NOT NULL UNIQUE,
                `password` VARCHAR(255) NOT NULL,
                `createdDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                `modifiedDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                CONSTRAINT `pk_users_id` PRIMARY KEY (`id`)
            )
		" );
		*/

         schema.create( "users", function( table ) {
             table.increments( "id" );
             table.string( "username" ).unique();
             table.string( "email" ).unique();
             table.string( "password" );
             table.timestamp( "createdDate" );
             table.timestamp( "modifiedDate" );
         } );
    }

    function down( schema ) {
        // queryExecute( "DROP TABLE `users`" );

        schema.drop( "users" );
    }

}
