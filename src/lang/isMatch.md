Performs a partial deep comparison between object and source to determine if object contains equivalent property values.

Partial comparisons will match empty array and empty object source values against any array or object value, respectively. See [A.isEqual](/?id=isEqual) for a list of supported value comparisons.


## Arguments
object (Object): The object to inspect.

source (Object): The object of property values to match.


## Returns
(boolean): Returns true if object is a match, else false.