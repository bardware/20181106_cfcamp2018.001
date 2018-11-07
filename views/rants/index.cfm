<cfoutput>
    <cfif prc.aRants.isEmpty()>
        <h3>No rants yet</h3>
        <a href="#event.buildLink( "rants.new" )#" class="btn btn-primary">Start one now!</a>
    <cfelse>
        <a href="#event.buildLink( "rants.new" )#" class="btn btn-primary">Start a new rant!</a>
        <cfloop array="#prc.aRants#" item="rant">
            <div class="card mb-3">
                <div class="card-header">
                    <strong>#rant.getUser().getUsername()#</strong> said at #dateTimeFormat( rant.getCreatedDate(), "h:nn:ss tt" )# on #dateFormat( rant.getCreatedDate(), "mmm d, yyyy")#
                </div>
                <div class="panel card-body">
                    #rant.getBody()#
                </div>
            </div>
        </cfloop>
    </cfif>
</cfoutput>
