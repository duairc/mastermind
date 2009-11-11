indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "A class which represents a game of Mastermind."
class
	GAME
creation
	make
feature
	base: INTEGER
	length: INTEGER
	guesses: INTEGER
	player: PLAYER

	make (given_base, given_length, given_guesses: INTEGER; given_player: PLAYER) is
		require
			2 <= given_base and given_base <= 36
			given_length > 0
			given_guesses > 0
			given_player /= Void
		do
			base := given_base
			length := given_length
			guesses := given_guesses
			player := given_player
			player.set_game(Current)
			create key.random(Current)
		end

	max: INTEGER is
		do
			Result := (base ^ length).to_integer_32
		end

	play: BOOLEAN is
		local
			i: INTEGER
			guess: KEY
			diff: KEY_DIFF
		do
			io.put_string("You have " + guesses.to_string + " guesses to find ")
			io.put_string("the number, go!")
			io.put_new_line
			from
				i := 1
			until
				i > guesses or Result
			loop
				io.put_string(">> ")
				guess := player.make_guess
				diff := key.diff(guess)
				if
					diff.is_all_black
				then
					io.put_string("Congratulations, you win!")
					io.put_new_line
					Result := True
				else
					io.put_string("=> ")
					io.put_string(diff.to_string)
					io.put_new_line
					player.update(guess, diff)
				end
				i := i + 1
			end
			if
				not Result
			then
				io.put_string("Sorry, you lose. The correct answer was ")
				io.put_string(key.to_string)
				io.put_string(".")
				io.put_new_line
			end
		end
feature
	key: KEY
end
