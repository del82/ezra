$(document).ready ->
	Mousetrap.bind "ctrl+left", (e) ->
		seeker -1

	Mousetrap.bind "ctrl+right", (e) ->
		seeker 1

	Mousetrap.bind "ctrl+down", (e) ->
		setWindowBound $("#end-now")
		no

	Mousetrap.bind "ctrl+up", (e) ->
		setWindowBound $("#start-now")
		no

	Mousetrap.bind "ctrl+space", (e) ->
		togglePlayer()
		no

	Mousetrap.bind "ctrl+enter", (e) ->
		$("#hit-now").click()

	Mousetrap.bind "ctrl+1", (e) ->
		setStatus 1

	Mousetrap.bind "ctrl+2", (e) ->
		setStatus 0
	
	Mousetrap.bind "ctrl+3", (e) ->
		setStatus -1

	Mousetrap.bind "ctrl+4", (e) ->
		setStatus -2

	Mousetrap.bind "ctrl+0", (e) ->
		$("#hit_flagged").click()
