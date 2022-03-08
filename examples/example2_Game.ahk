SetBatchLines -1
#NoTrayIcon
#SingleInstance force
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk

A := new biga()


; In this example, let's take on the role of a gaming script that announces which enemy to attack
enemies := [{"name": "bear", "hp": 200, "armor": 20, "status": "exposed_wound"}
		, {"name": "wolf", "hp": 100, "armor": 12}
		, {"name": "crab", "hp": 150, "armor": 99, "magicweakness": true}]

; Let's sort the enemies by hp and announce the one with the lowest hp as a target
sortedEnemies := A.sortBy(enemies, "hp")
; sorting by hp will move the lowest hp object to index 1
target := sortedEnemies[1].name

newEnemy := {"name": "weakened bear", "hp": 10, "armor": 5}
; a new enemy has appeared after we sorted the array. Instead of resorting; let's practice searching for the correct spot to insert at
mappedHP := A.map(sortedEnemies, "hp")
insertIndex := A.sortedIndex(mappedHP, newEnemy.hp)
; => 1
sortedEnemies.InsertAt(insertIndex, newEnemy)

; Assume rogues get bonus damage to anything with a status of "exposed_{{x}}";
; let's filter the sorted array by those and call all of them out. In this case there is only 1
exposedTargets := A.filter(sortedEnemies, Func("fn_filterExposedFunc"))
fn_filterExposedFunc(o) {
	; We use .startsWith inside this function to check the status
	return biga.startsWith(o.status, "exposed")
}

; We can format our message with StartCase which is a ittle like ahk's TitleCase
callOutMessage := " Everyone attack: " A.startCase(sortedEnemies[1].name) "`n Rogues attack: " A.startCase(exposedTargets[1].name)

; Search the array of monsters for the first instance of one with "magicweakness" = true
magicweaknessTarget := A.find(sortedEnemies,"magicweakness")
callOutMessage := "Mages attack: " magicweaknessTarget.name

exitApp
