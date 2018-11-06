<cfoutput>
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<title>SoapBox</title>
			<base href="#event.getHTMLBaseURL()#" />
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
			<link rel="stylesheet" href="/includes/css/app.css">
			<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
		</head>
		<body>
			<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top main-navbar">
				<a class="navbar-brand" href="#event.buildLink( url = "/" )#">
					<i class="fas fa-bullhorn mr-2"></i>
					SoapBox
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ml-auto">
						<a href="#event.buildLink( "/registration/new" )#" class="nav-link">Register</a>
					</ul>
				</div>

			</nav>
			<main role="main" class="container">

				#getInstance( "messagebox@cbMessageBox" ).renderit()#

				#renderView()#
			</main>

			#renderView("footer")#

		</body>
	</html>
	</cfoutput>
