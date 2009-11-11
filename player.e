indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "An abstract class representing a player in a Mastermind game."
deferred class
	PLAYER
feature
	game: GAME

	set_game(given_game: GAME) is
		require
			given_game /= Void
		do
			game := given_game
		end

	update(key: KEY; diff: KEY_DIFF) is
		require
			key /= Void
			diff /= Void
		do
		end

	make_guess: KEY is
		deferred
		end
end
