HandoutMaterials () {
/script SelectGossipAvailableQuest(1)
/script CompleteQuest()
/script GetQuestReward()
}

OneclickBuyout () {
/click BrowseBuyoutButton
/click StaticPopup1Button1
}

DefineMessage () {
/script msg="              what i want to say              "
}


BoardcastMessage () {
/script SendChatMessage(msg,"YELL");SendChatMessage(msg,"CHANNEL",nil,1);
}

SomeSetUp () {
/console cameraDistanceMaxZoomFactor 4
/console WorldTextScale 3
/console floatingCombatTextCombatDamageDirectionalScale 5
/console weatherDensity 0
/console ffxGlow 0
/script MainMenuBarLeftEndCap:Hide()
/script MainMenuBarRightEndCap:Hide()
}



