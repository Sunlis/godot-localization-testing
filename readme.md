# l10n

I couldn't find a solid demo for using CSV translations in Godot (4.6+) that also
used actual keys instead of english text as each string's key.

I have very low confidence that these translations OR plural rules are correct.
I just wanted to test how the parsing and CSV formatting worked.

## Files

`translations/example.csv` is the example from
https://docs.godotengine.org/en/stable/tutorials/i18n/localization_using_spreadsheets.html#specifying-plural-forms

`translations/main.csv` has my demo translations (absolutely not correct translations)

## Lessons learned

Each language can (should?) have its own pluralization rule. This is specified
on line 2 in the column for that language. You can see in `main.csv` that
English, French, and Russian all have different rules.

Strings without plural forms can be represented as a single line. Leave the
`?plural` column empty.

To make a string with plural forms, start by writing the singular form. Add the
key for the plural version of the string in the `?plural` column.  
On the next line, write the next plural form for that language. Leave the key
and `?plural` columns empty.

Since some languages have more plural forms than others (ie. Russian has 3... I
think), you will need to leave some cells empty. Notice in `main.csv` how the
Russian translation for `output_content` has 3 forms, but the English and French
translations only have 2. So on line 9 we just leave the `en` and `fr` columns
empty.

On rows that are specifying plural forms, we have to leave the key and `?plural`
columns empty. You **may not** fill these with copies of the singular and plural
key - the generated `.translation` files will fail to load the pluralized
strings at runtime (bug in Godot's CSV parser? should probably get caught at
parse time).
