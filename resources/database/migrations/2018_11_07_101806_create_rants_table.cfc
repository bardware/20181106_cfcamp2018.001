component {

    function up( schema ) {
		queryExecute( "
			CREATE TABLE `rants` (
				`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
				`body` TEXT NOT NULL,
				`createdDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
				`modifiedDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
				`userId` INTEGER UNSIGNED NOT NULL,
				CONSTRAINT `pk_rants_id` PRIMARY KEY (`id`),
				CONSTRAINT `fk_rants_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
			)
		" );
    }

    function down( schema ) {
		schema.drop( "rants" );
    }

}
