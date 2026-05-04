-- auto, in-word, plain text
local basic = function(desc, trig, output)
  return s(
    { trig = trig, dscr = desc, wordTrig = false, snippetType = "autosnippet" },
    { t(output) }
  )
end

local bracket = function(desc, trig, left, right)
  return ms(
    {
      common = {
        trig = trig,
        dscr = desc,
      },
      { wordTrig = false },
      { snippetType = "autosnippet" },
    },
    fmt(left .. "{inner}" .. right, {
      inner = i(1),
    })
  )
end

local capture = function(idx)
  return function(_, snip)
    return snip.captures[idx]
  end
end

-- return {
--   bracket("angle brackets", "ark", "<", ">"),  -- todo: does not expand fprs
--   bracket("parentheses", "prs", "(", ")"),
--   bracket("parentheses", "Prs", "(", ")"),
--   bracket("brackets", "brk", "[", "]"),
--   bracket("brackets", "Brk", "[", "]"),
--   bracket("braces", "brs", "{{", "}}"),
--   bracket("braces", "Brs", "{{", "}}"),
--   bracket("double quotes", "Qts", '"', '"'),
--   bracket("single quotes", "qts", "'", "'"),
--   bracket("backtick quotes", "icb", "`", "`"),
--   basic("backslash", "lkj", "\\"),
--   -- s(
--   --   {
--   --     trig = "lkj(.)",
--   --     trigEngine = "ecma",
--   --     dscr = "backslash",
--   --     wordTrig = false,
--   --     snippetType = "autosnippet",
--   --   },
--   --   fmt("\\{char}", {
--   --     char = f(function(_, snip)
--   --       return snip.captures[1]
--   --     end),
--   --   })
--   -- ),
--   s(
--     {
--       trig = "(^|\\s)minus",
--       trigEngine = "ecma",
--       dscr = "minus",
--       wordTrig = false,
--       snippetType = "autosnippet",
--     },
--     fmt("{optional_whitespace}-", {
--       optional_whitespace = f(function(_, snip)
--         return snip.captures[1]
--       end),
--     })
--   ),
--   basic("underscore", "sb", "_"),
--   basic("caret", "td", "^"),
--   basic("colon", "cln", ":"),
--   basic("prime", "prm", "'"),
--   basic("asterisk", "asr", "*"),
--   basic("ampersand", "aps", "&"),
--   basic("equal", "ql", "="),
--   basic("double equal", " eq ", " == "),
--   basic("plus equal", " peq ", " += "),
--   basic("minus equal", " meq ", " -= "),
--   basic("less than or equal to", " leq ", " <= "),
--   basic("greater than or equal to", " geq ", " >= "),
--   basic("less than", " lt ", " < "),
--   basic("greater than", " gt ", " > "),
--   basic("plus", " pl ", " + "),
--   basic("minus", " ms ", " - "),
--   basic("caret", " xor ", " ^ "),
-- }

return {
  ms(
    {
      common = {
        trig = "ark",
        dscr = "angle brackets",
      },
      { wordTrig = false },
      { snippetType = "autosnippet" },
    },
    fmt("<{inner}>", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "[Pp]rs",
      trigEngine = "ecma",
      dscr = "parentheses",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("({inner})", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "[Bb]rk",
      trigEngine = "ecma",
      dscr = "brackets",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("[{inner}]", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "[Bb]rs",
      trigEngine = "ecma",
      dscr = "braces",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("{<inner>}", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "Qts",
      dscr = "double quotes",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta('"<inner>"', {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "qts",
      dscr = "single quotes",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("'<inner>'", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "icb",
      dscr = "backtick quotes",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("`{inner}`", {
      inner = i(1),
    })
  ),
  s(
    {
      trig = "imm",
      dscr = "inline math",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("${inner}$", {
      inner = i(1),
    })
  ),
  s({
    trig = "lkj",
    dscr = "backslash",
    wordTrig = false,
    snippetType = "autosnippet",
  }, { t("\\") }),
  s(
    {
      trig = "lkj(.)",
      trigEngine = "ecma",
      dscr = "backslash",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\{char}", {
      char = f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),
  s(
    {
      trig = "(^|\\s)minus",
      trigEngine = "ecma",
      dscr = "minus",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("{optional_whitespace}-", {
      optional_whitespace = f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),
  -- basic("underscore", "sb", "_"),
  -- basic("caret", "td", "^"),
  basic("colon", "cln", ":"),
  basic("prime", "prm", "'"),
  basic("asterisk", "asr", "*"),
  basic("ampersand", "aps", "&"),
  basic("equal", "ql", "="),
  basic("double equal", " eq ", " == "),
  basic("plus equal", " peq ", " += "),
  basic("minus equal", " meq ", " -= "),
  basic("less than or equal to", " leq ", " <= "),
  basic("greater than or equal to", " geq ", " >= "),
  basic("not equal to", " neq ", " != "),
  basic("less than", " lt ", " < "),
  basic("greater than", " gt ", " > "),
  basic("plus", " pl ", " + "),
  basic("minus", " ms ", " - "),
  basic("caret", " xor ", " ^ "),
}
