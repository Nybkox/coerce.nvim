local cc = require("coerce.conversion")
local cco = require("coerce.coroutine")
local region = require("coerce.region")
local test_helpers = require("tests.helpers")

describe("coerce.conversion", function()
	describe("substitute", function()
		it("converts text", function()
			local buf = test_helpers.create_buf({ "Hello, world!" })

			cc.substitute({
				mode = region.modes.CHAR,
				start_row = 0,
				start_col = 7,
				end_row = 1,
				end_col = 12,
			}, function()
				return "Albert"
			end)

			local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, true)
			assert.are.same({ "Hello, Albert!" }, lines)
		end)
	end)
	describe("select_with_motion", function()
		it("select the word", function()
			test_helpers.create_buf({ "Hello, world!" })

			local selected_region = nil
			cco.fire_and_forget(function()
				selected_region = cc.select_with_motion()
			end)
			test_helpers.execute_keys("e", "x")

			assert.are.same(region.region(region.modes.CHAR, { 0, 0 }, { 0, 4 }), selected_region)
		end)
	end)
	describe("coerce_current_word", function()
		it("coerces the current word", function()
			local buf = test_helpers.create_buf({ "Hello, world!" })
			vim.api.nvim_win_set_cursor(0, { 1, 8 })

			cco.fire_and_forget(cc.coerce_current_word, function()
				return "Bob"
			end)

			local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, true)
			assert.are.same({ "Hello, Bob!" }, lines)
		end)
	end)
end)
