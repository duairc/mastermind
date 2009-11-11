indexing
	author: "Shane <duairc@netsoc.tcd.ie>"
	description: "A concrete subclass of PLAYER representing human players."
class
	HUMAN_PLAYER
inherit
	PLAYER
feature
	make_guess: KEY is
		local
			string: STRING
		do
			io.read_line
			string := io.last_string
			create Result.from_string(game, string)
		rescue
			io.put_string("Invalid guess, try again: ")
			retry
		end
end
