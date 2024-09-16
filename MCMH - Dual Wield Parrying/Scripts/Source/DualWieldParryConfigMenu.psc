Scriptname DualWieldParryConfigMenu extends MCM_ConfigBase  

;/
int keyMapOptionID = 0
int enableModOptionID = 0
bool modActive = true

Event OnPageReset(String page)
	SetCursorPosition(0)

	keyMapOptionID = AddKeymapOption("Block Key", ((self as quest) as DualWieldParryingQuestScript).getBlockKeyCode())
	AddEmptyOption()
	
	enableModOptionID = AddToggleOption("Mod Active", modActive)
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, String conflictControl, String conflictName)
	If(option == keyMapOptionID)
		bool continue = true
		If(conflictControl != "")
			String mssg
			If(conflictName != "")
				mssg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			Else
				mssg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
			EndIf

			continue = ShowMessage(mssg, true, "$Yes", "$No")
		EndIf

		If(continue)
			SetKeyMapOptionValue(keyMapOptionID, keyCode)
			((self as quest) as DualWieldParryingQuestScript).setBlockKeyCode(keyCode)
		EndIf
	EndIf
EndEvent

String Function GetCustomControl(int keyCode)
	If(keyCode == ((self as quest) as DualWieldParryingQuestScript).getBlockKeyCode())
		return "Dual Wield Blocking"
	Else
		return ""
	EndIf
EndFunction

int Function GetVersion()
	return 1
EndFunction

Event OnOptionDefault(int option)
	If(option == keyMapOptionID)
		SetKeyMapOptionValue(keyMapOptionID, 47);V, default
		((self as quest) as DualWieldParryingQuestScript).setBlockKeyCode(47)
	ElseIf(option == enableModOptionID)
		If(!modActive)
			modActive = true
			SetToggleOptionValue(enableModOptionID, modActive)
			((self as quest) as DualWieldParryingQuestScript).activateMod()
		EndIf
	EndIf
EndEvent

Event OnOptionHighlight(int option)
	If(option == keyMapOptionID)
		SetInfoText("Pressing the chosen key will make your character block. Does not work with Bows or with Spells equipped in the right hand.")
	ElseIf(option == enableModOptionID)
		If(!modActive)
			SetInfoText("Toggle this option on to turn the mod back on")
		Else
			SetInfoText("Toggle this option off to deactivate the mod entirely. \nThis will prevent the mod from leaving any traces in your saved game should you choose to disable the mod.")
		EndIf
	EndIf
EndEvent

Event OnOptionSelect(int option)
	If(option == enableModOptionID)
		modActive = !modActive
		SetToggleOptionValue(enableModOptionID, modActive)
		
		If(modActive)
			((self as quest) as DualWieldParryingQuestScript).activateMod()
		Else
			((self as quest) as DualWieldParryingQuestScript).deactivateMod()
		EndIf
	EndIf
EndEvent
/;
