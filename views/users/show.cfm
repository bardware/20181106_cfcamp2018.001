<cfoutput>
	<h4>Rants</h4>

	<cfloop array="#prc.aRants#" item="rant">
		#renderView( "_partials/_rant", { rant = rant } )#
		<!---
		<div class="card mb-3">
			<div class="card-header">
				<strong>#rant.getUser().getUsername()#</strong> said at #dateTimeFormat( rant.getCreatedDate(), "h:nn:ss tt" )# on #dateFormat( rant.getCreatedDate(), "mmm d, yyyy")#
			</div>
			<div class="panel card-body">
				#rant.getBody()#
			</div>
		</div>
	--->
	</cfloop>

</cfoutput>
