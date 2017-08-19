
function flip()
  Screen.flip()
end

function clip(--[[optional]]x, --[[optional]]y, --[[optional]]w, --[[optional]]h)
end

-- Get or set the colour (c) of a pixel at x, y.
function pget(x, y)
end
function pset(x, y, --[[optional]]c)
end

-- Get or set the colour (c) of a spritesheet pixel.
function sget(x, y)
end
function sset(x, y, --[[optional]]c)
end

--[[ Get or set the value (v) of a sprite's flag
		f is the flag index 0..7
		v is boolean and can be true or false
--]]
function fget(n, --[[optional]]f)
end
function fset(n, --[[optional]]f, v)
end

--[[ Print a string
		If only str is supplied, and the cursor reaches the end of the screen,
		a carriage return and vertical scroll is automatically applied.
		(terminal-like behaviour)
--]]
-- TODO: Requires patching code to accept sugar syntax 'print str'
function print(str, x, y)
end

-- Set the cursor position and carriage return margin
function cursor(x, y)
end

-- Set the default color to be used by drawing functions
function color(col)
end

-- Clear the screen
function cls()
end

--[[Set a screen offset of -x, -y for all drawing operations
		camera() to reset
--]]
function camera(--[[optional]]x, --[[optional]]y)
end

-- Draw a circle or filled circle at x,y with radius r
function circ(x, y, r, --[[optional]]col)
end
function circfill(x, y, r, --[[optional]]col)
end

-- Draw a line
function line(x0, y0, x1, y1)
end

-- Draw a rectangle or filled rectangle
function rect(x0, y0, x1, y1, --[[optional]]col)
end
function rectfill(x0, y0, x1, y1, --[[optional]]col)
end

-- Draw all instances of colour c0 as c1 in subsequent draw calls
--[[pal() to reset to system defaults (including transparency values)
		Two types of palette (p; defaults to 0)
			0 draw palette   : colours are remapped on draw    // e.g. to re-colour sprites
			1 screen palette : colours are remapped on display // e.g. for fades
		c0 colour index 0..15
		c1 colour index to map to
--]]
function pal(c0, c1, --[[optional]]p)
end

--[[Set transparency for colour index to t (boolean)
		Transparency is observed by spr(), sspr() and map()
		e.g. palt(8, true) -- red pixels not drawn
		palt() resets to default: all colours opaque except colour 0
--]]
function palt(c, t)
end

--[[Draw sprite n (0..255) at position x,y
		width and height are 1,1 by default and specify how many sprites wide to blit.
		Colour 0 drawn as transparent by default (see palt())
		flip_x=true to flip horizontally
		flip_y=true to flip vertically
--]]
function spr(n, x, y, --[[optional]]w, --[[optional]]h, --[[optional]]flip_x, --[[optional]]flip_y)
end

--[[Stretch rectangle from sprite sheet (sx, sy, sw, sh) // given in pixels
		and draw in rectangle (dx, dy, dw, dh)
		Colour 0 drawn as transparent by default (see palt())
		dw, dh defaults to sw, sh
		flip_x=true to flip horizontally
		flip_y=true to flip vertically

--]]
function sspr(sx, sy, sw, sh, dx, dy, --[[optional]]dw, --[[optional]]dh, --[[optional]]flip_x, --[[optional]]flip_y)
end

--[[ Tables ]]

--[[Add value v to the end of table t.
		Equivalent to t[#t+1] = v

			FOO={}        -- create empty table
			ADD(FOO, 11)
			ADD(FOO, 22)
			PRINT(FOO[2]) -- 22
]]
function add(t, v)
  t[#t+1] = v
end

--[[Delete the first instance of value v in table t
		The remaining entries are shifted left one index to avoid holes.
		Note that v is the value of the item to be deleted, not the index into the table!
		del() can be called safely on a table's item while iterating over that table.

			A={1,10,2,11,3,12}
			FOR ITEM IN ALL(A) DO
				IF (ITEM < 10) THEN DEL(A, ITEM) END
			END
			FOREACH(A, PRINT) -- 10,11,12
			PRINT(A[3])       -- 12
]]
function del(t, v)
end

--[[Used in FOR loops to iterate over all items in a table (that have a 1-based integer index),
		in the order they were added.

			T = {11,12,13};
			ADD(T,14)
			ADD(T,"HI")
			FOR V IN ALL(T) DO PRINT(V) END -- 11 12 13 14 HI
			PRINT(#T) -- 5
]]
function all(t)
end

--[[For each item in table t, call function f with the item as a single parameter.

			FOREACH(T, PRINT)
]]
function foreach(t, f)
end

--[[Used in FOR loops to iterate over table t, providing both the key and value for each item.
		Unlike all(), pairs() iterates over every item regardless of indexing scheme.
		Order is not guaranteed.

			T = {["HELLO"]=3, [10]="BLAH"}
			T.BLUE = 5;
			FOR K,V IN PAIRS(T) DO
				PRINT("K: "..K.."  V:"..V)
			END

		Output:

			K: 10  v:BLAH
			K: HELLO  v:3
			K: BLUE  v:5
]]
function pairs(t)
end

--[[ Input ]]

--[[get button i state for player p (default 0)
  i: 0..5: left right up down button_o button_x
  p: player index 0..7

  If no parameters supplied, returns a bitfield of all 12 button states for player 0 & 1
    // P0: bits 0..5  P1: bits 8..13

  Default keyboard mappings to player buttons:
    player 0: cursors, Z,X / C,V / N,M
    player 1: ESDF, LSHIFT,A / TAB,Q,E
]]
function btn(--[[optional]]i, --[[optional]]p)
end

--[[Same as btn() but only true when the button was not pressed the last frame
  		btnp() also returns true every 4 frames after the button is held for 15 frames.

  		Useful for things like 'press a button to continue' or menu item movement.
]]
function btnp(--[[optional]]i, --[[optional]]p)
end

--[[ Audio ]]

-- TODO: Not sure if n is optional or not

--[[play sfx n on channel (0..3) from note offset (0..31)
		n -1 to stop sound on that channel
		n -2 to release sound on that channel from looping
		any music playing on the channel will be halted
		offset in notes (0..31)

		channel -1 (default) to automatically choose a channel that is not being used
			// if nothing plays, check you gave music() a channel_mask so that music
			// playback doesn't hog all channels. (e.g. 1+2 for the first two channels)
]]
function sfx(n, --[[optional]]channel, --[[optional]]offset)
end

-- TODO: Not sure if n is optional or not

--[[play music starting from pattern n (0..63)
		n -1 to stop music
		fade_len in ms (default: 0)
		channel_mask specifies which channels to reserve for music only
			e.g. to play on channels 0..2: 1+2+4 = 7

		Reserved channels can still be used to play sound effects on, but only when that
		channel index is explicitly requested by sfx().
]]
function music()
end

--[[ Map ]]

-- Get or set map value (v) at x,y
function mget(x, y)
end
function mset(x, y, v)
end

--[[Draw section of map (in cels) at screen position sx, sy (pixels)
		if layer is specified, only cels with the same flag number set are drawn
			// Bitfield. So 0x5 means draw sprites with bit 0 and bit 2 set.
			// defaults to all sprites

		exception: sprite 0 is always taken to mean empty.

		e.g. map(0,0, 20,20, 4,2)
		-> draws a 4x2 blocks of cels starting from 0,0 in the map, to the screen at 20,20
]]
function map(cel_x, cel_y, sx, sy, cel_w, cel_h, --[[optional]]layer)
end

--[[ Memory ]]
--TODO
--[[ Math ]]
--TODO
--[[ Custom Menu Items ]]
--TODO

--[[ Strings ]]
--TODO

--[[ Cartridge Data ]]
--TODO

--[[ GPIO ]]
--NOTE: PSVita has no user accessible GPIO, so no need to implement here
