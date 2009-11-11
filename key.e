indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "A class that represents guesses in a Mastermind game."
class
	KEY
creation
	from_number, from_string, random
feature
	game: GAME
	digits: ARRAY[INTEGER]

	from_string(given_game: GAME; string: STRING) is
		require
			string.for_all(agent valid_digit_for_base(?, given_game.base))
			string.count = given_game.length
		local
			i: INTEGER
		do
			game := given_game
			create digits.make(1, game.length)
			from
				i := 1
			until
				i > game.length
			loop
				digits.put(digit_to_integer(string @ i), i)
				i := i + 1
			end
		end

	from_number(given_game: GAME; number: INTEGER) is
		require
			0 <= number and number < given_game.max
		local
			i, n: INTEGER
		do
			game := given_game
			create digits.make(1, game.length)
			from
				i := game.length
				n := number
			until
				i < 1
			loop
				digits.put(n \\ game.base, i)
				n := n // game.base
				i := i - 1
			end
		end

	random(given_game: GAME) is
		local
			randoms: PRESS_RANDOM_NUMBER_GENERATOR
		do
			create randoms.make
			randoms.next
			from_number(given_game, randoms.last_integer(given_game.max - 1))
		end

	diff(other: like Current): KEY_DIFF is
		require
			game = other.game
		do
			create Result.make(Current, other)
		end

	to_string: STRING is
		local
			i: INTEGER
		do
			create Result.make_filled('0', game.length)
			from
				i := 1
			until
				i > game.length
			loop
				Result.put(integer_to_digit(digits @ i), i)
				i := i + 1
			end
		end

feature {}
	valid_digit_for_base(digit: CHARACTER; given_base: INTEGER): BOOLEAN is
		do
			Result := digit_to_integer(digit) < given_base
		end

	digit_to_integer(digit: CHARACTER): INTEGER is
		require
			'0' <= digit and digit <= '9' or
				'A' <= digit.to_upper and digit.to_upper <= 'Z'
		do
			if
				digit >= '0' and digit <= '9'
			then
				Result := digit.code - '0'.code
			else
				Result := 10 + (digit.to_upper.code - 'A'.code)
			end
		end

	integer_to_digit(n: INTEGER): CHARACTER is	
		require
			0 <= n and n < 36
		do
			if
				n < 10
			then
				Result := ('0'.code + n).to_character
			else
				Result := ('A'.code + (n - 10)).to_character
			end
		end
invariant
	game = Void and digits = Void or else (game.length = digits.count)
end
