local helpers = require("luasnip-helper-functions")
local get_visual = helpers.get_visual

return {
    -- Examples of complete snippets using fmt and fmta

    -- \texttt
    s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
        fmta(
            "\\texttt{<>}",
            { i(1) }
        )
    ),
    -- Equation
    s({trig="eq", dscr="Expands 'eq' into an equation environment"},
        fmta(
            [[
                \begin{equation*}
                    <>
                \end{equation*}
            ]],
            { i(1) }
        )
    ),
    -- Inline Math
    s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
        fmta(
            "<>$<>$",
            {
                f( function(_, snip) return snip.captures[1] end ),
                d(1, get_visual),
            }
        )
    ),
    -- Euler's number
    s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
        fmta(
            "<>e^{<>}",
            {
                f( function(_, snip) return snip.captures[1] end ),
                d(1, get_visual)
            }
        )
    ),
    -- Fractions
    s({trig = '([^%a])ff', regTrig = true, wordTrig = false},
        fmta(
            [[<>\frac{<>}{<>}]],
            {
                f( function(_, snip) return snip.captures[1] end ),
                i(1),
                i(2)
            }
        )
    ),
    -- Zero Subscript
    s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta(
            "<>_{<>}",
            {
                f( function(_, snip) return snip.captures[1] end ),
                t("0")
            }
        )
    ),
}
