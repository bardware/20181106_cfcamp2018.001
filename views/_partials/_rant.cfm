<cfoutput>
    <div class="card mb-3">
        <div class="card-header">
            <strong><a href="#event.buildLink( "users.#args.rant.getUser().getUsername()#" )#">#args.rant.getUser().getUsername()#</a></strong>
            said at #dateTimeFormat( args.rant.getCreatedDate(), "h:nn:ss tt" )#
            on #dateFormat( args.rant.getCreatedDate(), "mmm d, yyyy")#
        </div>
        <div class="panel card-body">
            #args.rant.getBody()#
		</div>
		<div class="card-footer">
            <button class="btn btn-outline-dark">
                #args.rant.getBumps().len()# 👊
            </button>
            <button class="btn btn-outline-dark">
                #args.rant.getPoops().len()# 💩
            </button>
        </div>
    </div>
</cfoutput>
