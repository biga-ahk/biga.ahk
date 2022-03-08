SetBatchLines -1
#NoTrayIcon
#SingleInstance force
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk

A := new biga()


; For the last example let's administer some online comments.
comments := [{"text": "I think...", "likes": 1, "sentiment": -9, "author": "Bob", "subscriber": false}
			, {"text": "You see...", "likes": 2, "sentiment": 10, "author": "Fred", "subscriber": true}
			, {"text": "Listen....", "likes": 9, "sentiment": 80, "author": "Barney", "subscriber": true}]

Newcomments := [{"text": "You see...", "likes": 2, "sentiment": 10, "author": "Fred", "subscriber": true}
			, {"text": "You see...", "likes": 2, "sentiment": 10, "author": "Fred", "subscriber": true}]

; You can combine two arrays with .concat.
A.concat(comments, Newcomments)
; biga does NOT mutate inputs, changes are always delivered by the return value/object
comments := A.concat(comments, Newcomments)

; Theres a bug somewhere causing comments to be duplicated. In another example we used .uniq to remove duplicate strings, but it works on whole objects too.
comments := A.uniq(comments)

; Arrays can be reversed easily. Let's ensure that the negative comments are at the end of the array by sorting then reversing
negativeCommentsLast := A.reverse(A.sortBy(comments, "sentiment"))

; We can map the "sentiment" values to a new array for finding the average
sentimentArray := A.map(comments, "sentiment")
; => [-9, 10, 80]

; If you want to find out who is new in the comment section, how about mapping all the author names and finding the difference with regular posters
newFaces := A.difference(A.map(comments, "author"), ["Regular1", "Regular2", "Fred"])
; => ["Bob", "Barney"]

; Let's choose a random subscriber comment to feature. Obviously we could filter by subscribers only and choose, but for the sake of example let's perform some logic
while (!featureComment) {
	comment := A.sample(comments)
	if (A.isMatch(comment, {"subscriber": true})) {
		featureComment := comment
	}
}

; Before injecting the comment into html, we can trim any leading and trailing whitespace
featureCommentText := A.trim(featureComment.text)
; let's trim any puncuation off the end as well
featureCommentText := A.trimEnd(featureCommentText, " .!?;:")

; .replace works like StrReplace but also accepts javascript formatted regular expressions. We'll remove any scripts the comment might have
featureCommentText := A.replace(featureCommentText, "/(<script>[\s\S]+<\/script>)/")

exitApp
