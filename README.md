# Yudi

Yudi is a module we use here at Coursera to internationalize our jade template files by wrapping strings with `_t()` so they can be translated and generating the bundles to be used with [require.i18n](https://github.com/requirejs/i18n)

## Usage
* `yudi.internationalize(file, content, [options])`
    - `file`: path/to/jadefile
    - `content`: the contents of file as a `string`
    - `options`: optional *options* object
    - **returns**: an object with the following keys
        + `source`: internationalized content string
        + `tokens`: list of *tokens* that can be internationalized
        + `bundles`: list of *bundle* objects

* `yudi.internationalize(file, content, [options])`
    - `file`: path/to/jadefile
    - `content`: the contents of file as a `string`
    - `options`: optional *options* object
    - **returns**: an object with the following keys
        + `source`: uninternationalized content string
        + `bundles`: list of *bundle* objects

### Options
* `attrs`: list of html attribute names with values that yudi can process. This will only work if the values are raw strings

### Token
* `type`: any of values the below
    - `text`: text elements
    - `attr`: attribute value string literals selected to be translated
    - `code`: string literals wrapped in `_t` found in escaped js code
* `val`: english string to be translated. This is used as the translation key to map to translated strings
* `line`: 0 based line number where this string appears

### Bundle
* `type`: either `root` or `language`. See [docs](http://requirejs.org/docs/api.html#i18n)
* `path`: path for the bundle
* `content`: content of the bundle as an object

## Test
Run tests with the following command:
```bash
npm test
```

## Naming
Yudi, 玉帝, or the Jade Emperor in Chinese