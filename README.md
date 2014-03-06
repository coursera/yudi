# Yudi

Yudi is a module we use here at Coursera to internationalize our jade templates. This module takes in jade source and transforms it by collecting all strings that can be translated and wrapping them with `_t("...")` so translations can be injected through the `_t` function.

Yudi collects strings from 3 sources:

* all *text elements*, unless they only contains numbers, symbols, or whitespace
* select *attributes*. Only attributes with raw string value whose names appear in the list of attributes passed in as `options.attrs` are collected
* any *string literal* wrapped with `_t("...")` in any escaped JavaScript code within the jade source

## Usage
* `yudi.internationalize(source, [options])`
    - `source`: jade source
    - `options`:
        + `filename`: jade filename
        + `attrs`: list of attribute names
        + `token`: boolean
    - **returns**: internationalized source string, unless `options.tokens` is set to `true`, in which case an object is returned:
        + `source`: internationalized source string
        + `tokens`: list of *tokens* that can be translated

* `yudi.internationalize(source, [options])`
    - `source`: jade source
    - `options`:
        + `filename`: jade filename
        + `attrs`: list of attribute names
    - **returns**: uninternationalized source string

### Token
* `type`: any of values the below
    - `text`: text elements
    - `attr`: attributes
    - `code`: string literals wrapped in `_t` in escaped js code
* `val`: string marked for translation
* `line`: 0 based line number in the jade source

### `_t` function signature
`_t(translationKey, [interpolationHash])`

* `translationKey`: english string used to lookup translations
* `interpolationHash`: optional hash of interpolations to their values that only gets passed if the `translationKey` includes interpolations in the form of `#{...}` or `!{...}`
* **returns**: translated string

Calls to `_t` are generated by Yudi automatically in any internationalized jade source

## Test
Run tests with the following command:
```bash
npm test
```

## Naming
Yudi, 玉帝, or the Jade Emperor in Chinese