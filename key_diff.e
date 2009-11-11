indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "A class that represents the difference between two keys; i.e., a number of black pegs and white pegs."
class
	KEY_DIFF
insert
	ANY
		redefine
			is_equal
		end
creation
	make, with_black_white
feature
	black: INTEGER
	white: INTEGER
	game: GAME

	make(a, b: KEY) is
		require
			a.game = b.game
		local
			i, index: INTEGER
			a_digits, b_digits: ARRAY[INTEGER]
		do
			black := 0
			white := 0
			game := a.game
			create a_digits.from_collection(a.digits)
			create b_digits.from_collection(b.digits)
			from
				i := 1
			until
				i > game.length
			loop
				if
					a_digits @ i = b_digits @ i
				then
					black := black + 1
					a_digits.put(-1, i)
					b_digits.put(-1, i)
				end
				i := i + 1
			end
			from
				i := 1
			until
				i > game.length
			loop
				index := b_digits.fast_index_of(a_digits @ i, 1)
				if
					b_digits.valid_index(index) and then
						(a_digits @ i >= 0 and b_digits @ index >= 0)
				then
					white := white + 1
					a_digits.put(-1, i)
					b_digits.put(-1, index)
				end
				i := i + 1
			end
		end

	with_black_white(given_game: GAME; given_black, given_white: INTEGER) is
		do
			black := given_black
			white := given_white
			game := given_game
		end

	is_equal(other: like Current): BOOLEAN is
		require else
			game = other.game
		do
			Result := black = other.black and white = other.white
		end

	is_all_black: BOOLEAN is
		do
			Result := game.length = black
		end

	to_string: STRING is
		do
			Result := black.to_string + " Black, " + white.to_string + " White"
		end
invariant
	0 <= white + black and white + black <= game.length
end
