function GF_Init()
   --set version string
   GF_VERSION = GetAddOnMetadata("GuildFactions", "version")   
   if GF_Config == nil then
      GF_Config = {}
      GF_Config["channel"] = "GUILD"
   end  
   
   GF_CreateGUI()
   --GF_CreateFriendsTab()
   --GuildRoster()
   GF_ActionQueueInit()   
   GF_CreateFactionView()
   
   --get player faction and enemy faction
   GF_PlayerFaction = UnitFactionGroup("player")
   if GF_PlayerFaction == "Alliance" then
      GF_EnemyFaction = "Horde"
   else
      GF_EnemyFaction = "Alliance"
   end
   
   SLASH_GF1 = "/gf"
   SlashCmdList["GF"] = GF_Commands;
   
   --set portrait icon
    SetPortraitToTexture(GF_HitListFrameSkullnXBonesTexture,"interface\\icons\\Achievement_General_DungeonDiplomat")
   --SendAddonMessage("GF_HL_SYNC_REQ",nil,"GUILD");

end  
