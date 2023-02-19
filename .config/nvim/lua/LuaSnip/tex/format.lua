local helpers = require("luasnip-helper-functions")
local get_visual = helpers.get_visual

return {
    -- Example: italic font implementing visual selection
    s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
        fmta("\\textit{<>}",
            {
                d(1, get_visual),
            }
        )
    ),
}
