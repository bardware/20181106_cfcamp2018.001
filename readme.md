# Advanced Script Template

An advanced template with all the bells and whistles in script format

## License
Apache License, Version 2.0.

## Important Links

Source Code
- https://github.com/coldbox-templates/advanced-script
- https://github.com/Ortus-Solutions/coldbox-zero-to-hero/blob/wip/PREREQUISITES.md
- https://www.ortussolutions.com/blog/coldbox-and-testbox-microsoft-visual-studio-code-support-released
- https://commandbox.ortusbooks.com/ide-integrations/visual-studio-code
- https://github.com/Ortus-Solutions/coldbox-zero-to-hero/blob/wip/STEPS.md
- https://apidocs.ortussolutions.com/coldbox/5.2.0/index.html

## Quick Installation

Each application templates contains a `box.json` so it can leverage [CommandBox](http://www.ortussolutions.com/products/commandbox) for its dependencies.
Just go into each template directory and type:

```
box install
```

This will setup all the needed dependencies for each application template.  You can then type:

```
box server start
```

And run the application.

## Commands

- install commandbox-dotenv,commandbox-migrations
- start cfengine=lucee@5 port=42518 --rewritesEnable
- testbox run "http://localhost:42518/tests/runner.cfm"
- package set testbox.runner="http://localhost:42518/tests/runner.cfm"
- package show
- testbox run```
- testbox watch **.cfc
- coldbox reinit
- coldbox create view about/index
- coldbox create handler name="about" actions="index" views=false
- echo ${DB_USER}
- reload
- migrate install
- migrate create create_users_table
- migrate up
- migrate down
- migrate fresh
- install commandbox-migrations
- install commandbox-dotenv
- migrate init
- server restart
- install cfmigrations --saveDev
- coldbox create model name="UserService" persistence="singleton"
- coldbox create handler name="registration" actions="new,create"
- install route-visualizer --saveDev
- coldbox reinit
- Browser: http://127.0.0.1:42518/route-visualizer
- install bcrypt
- install cbmessagebox && coldbox reinit
- coldbox create handler name="sessions" actions="new,create,delete"
- install cbauth && coldbox reinit
- coldbox create model name="User" properties="id,username,email,password"
- migrate create create_rants_table
- migrate up
- coldbox create model name="Rant" properties="id,body,createdDate:date,modifiedDate:date,userID" methods="getUser,isLoaded"
- coldbox create model name="RantService" persistence="singleton" methods="getAll,create,new"
- coldbox create handler name="rants" actions="index,new,create"

---

###THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12