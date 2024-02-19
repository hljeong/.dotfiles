return {
  ms(
    {
      common = {
        trig = 'ark',
        dscr = 'angle brackets',
      },
      { wordTrig = false },
      { snippetType = 'autosnippet' },
    },
    fmt(
      '<{inner}>',
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = '[Pp]rs',
      trigEngine = 'ecma',
      dscr = 'parentheses',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmt(
      '({inner})',
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = '[Bb]rk',
      trigEngine = 'ecma',
      dscr = 'brackets',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmt(
      '[{inner}]',
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = '[Bb]rs',
      trigEngine = 'ecma',
      dscr = 'braces',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmta(
      '{<inner>}',
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = 'Qts',
      dscr = 'double quotes',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmta(
      '"<inner>"',
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = 'qts',
      dscr = 'single quotes',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmta(
      "'<inner>'",
      {
        inner = i(1),
      }
    )
  ),
  s(
    {
      trig = 'lkj',
      dscr = 'backslash',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t('\\') }
  ),
  s(
    {
      trig = 'lkj(.)',
      trigEngine = 'ecma',
      dscr = 'backslash',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmt(
      '\\{char}',
      {
        char = f(function(_, snip)
          return snip.captures[1]
        end),
      }
    )
  ),
  s(
    {
      trig = 'sb',
      dscr = 'underscore',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t('_') }
  ),
  s(
    {
      trig = 'cln',
      dscr = 'colon',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t(':') }
  ),
  s(
    {
      trig = 'asr',
      dscr = 'asterisk',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t('*') }
  ),
  s(
    {
      trig = 'prm',
      dscr = 'prime',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t("'") }
  ),
  s(
    {
      trig = '(^|\\s)minus',
      trigEngine = 'ecma',
      dscr = 'minus',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    fmt(
      '{optional_whitespace}-',
      {
        optional_whitespace = f(function(_, snip)
          return snip.captures[1]
        end),
      }
    )
  ),
  ms(
    {
      common = {
        trig = 'ql',
        dscr = 'equals',
      },
      { wordTrig = false },
      { snippetType = 'autosnippet' },
    },
    { t('=') }
  ),
  s(
    {
      trig = ' lt ',
      dscr = 'less than',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t(' < ') }
  ),
  s(
    {
      trig = ' gt ',
      dscr = 'greater than',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t(' > ') }
  ),
  s(
    {
      trig = ' pl ',
      dscr = 'plus',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t(' + ') }
  ),
  s(
    {
      trig = ' ms ',
      dscr = 'minus',
      wordTrig = false,
      snippetType = 'autosnippet',
    },
    { t(' - ') }
  ),
  ms(
    {
      common = {
        trig = 'aps',
        dscr = 'ampersand',
      },
      { wordTrig = false },
      { snippetType = 'autosnippet' },
    },
    { t('&') }
  ),
}
