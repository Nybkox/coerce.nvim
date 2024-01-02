--- A region module.
--
-- A region is an area of text in a buffer. There are three types of regions:
--
-- - char represents a contiguous range of characters that can pass through zero or more rows.
-- - line represents a contiguous range of rows.
-- - block represents a rectangular block of text.
--
-- All ranges are:
--
-- - zero-indexed
-- - start-inclusive
-- - end-exclusive
--
-- @module coerce.region
local M = {}

--- Available region modes.
--
-- For now, we only support the char mode.
M.modes = {
	CHAR_MODE = "char",
	-- LINE_MODE = "line",
	-- BLOCK_MODE = "block",
}

--- An example empty region.
M.empty_char_region = {
	mode = M.modes.CHAR_MODE,
	start_row = 0,
	start_col = 0,
	end_row = 0,
	end_col = 0,
}

return M
