-- auto, in-word, plain text
local basic = function(desc, trig, output)
  return s(
    { trig = trig, dscr = desc, wordTrig = false, snippetType = "autosnippet" },
    { t(output) }
  )
end

return {
  -- basic("std (overrides caret)", "std", "std"),
}
