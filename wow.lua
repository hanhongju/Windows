HandoutMaterials ()  {
/script SelectGossipAvailableQuest(1)
/script CompleteQuest()
/script GetQuestReward()
}


DefineMessage () {
/script msg="what i want to say"
}


BoardcastMessage () {
/script SendChatMessage(msg,"YELL");SendChatMessage(msg,"CHANNEL",nil,1);
}

