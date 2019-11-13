Converts the characters "&", "<", ">", '"', and "'" in string to their corresponding HTML entities.

> [!Note]
> No other characters are escaped. To escape additional characters use a third-party library.

Though the ">" character is escaped for symmetry, characters like ">" and "/" don't need escaping in HTML and have no special meaning unless they're part of a tag or unquoted attribute value. See Mathias [Bynens's article](https://mathiasbynens.be/notes/ambiguous-ampersands) (under "semi-related fun fact") for more details.

When working with HTML you should always quote attribute values to reduce XSS vectors.


## Arguments
[string:=""] (string): The string to escape.


## Returns
(string): Returns the escaped string.
