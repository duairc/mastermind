indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "The root class for an interactive Mastermind game."
class
	MASTERMIND
insert
	ARGUMENTS
creation
	main
feature
	main is
		local
			game: GAME
			player: HUMAN_PLAYER
			won: BOOLEAN
		do
			create player
			create game.make(6, 4, 6, player)
			won := game.play
		end
end
