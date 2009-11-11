indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "A concrete subclass of PLAYER representing computer players."
class
	COMPUTER_PLAYER
inherit
	PLAYER
		redefine
			set_game, update
		end
feature
	possible_keys: ARRAY[KEY]

	set_game(given_game: GAME) is
		local
			i: INTEGER
			key: KEY
		do
			Precursor(given_game)
			create possible_keys.make(1, game.max)
			from
				i := 1
			until
				i > game.max
			loop
				create key.from_number(game, i - 1)
				possible_keys.put(key, i)
				i := i + 1
			end
		end

	update(key: KEY; diff: KEY_DIFF) is
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > possible_keys.upper
			loop
				if
					not key.diff(possible_keys @ i).is_equal(diff)
				then
					possible_keys.put(Void, i)
				end
				i := i + 1
			end
			compact_voids
		end

	make_guess: KEY is
		local
			n: INTEGER
			randoms: PRESS_RANDOM_NUMBER_GENERATOR
		do
			create randoms.make
			randoms.next
			n := randoms.last_integer(possible_keys.count)
			Result := possible_keys @ n
			io.put_string(Result.to_string)
			io.put_new_line
		end

feature {}
	compact_voids is
		local
			i, v: INTEGER
		do
			from
				v := possible_keys.upper
			until
				v < 1 or else (possible_keys @ v /= Void)
			loop
				v := v - 1
			end
			from
				i := 1
			until
				i > v
			loop
				if
					possible_keys @ i = Void
				then
					possible_keys.swap(i, v)
					from
					until
						possible_keys @ v /= Void
					loop
						v := v - 1
					end
				end
				i := i + 1
			end
			possible_keys.resize(1, v)
		end
end
