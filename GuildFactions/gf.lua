function GF_OnLoad(self)
    self:RegisterEvent("VARIABLES_LOADED"); 	
    self:RegisterEvent("PLAYER_LOGIN");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");	    
    self:RegisterEvent("CHAT_MSG_SYSTEM");
    self:RegisterEvent("CHAT_MSG_ADDON"); 
    self:RegisterEvent("GUILD_ROSTER_UPDATE");    
    RegisterAddonMessagePrefix("GF_SET_REP")
    RegisterAddonMessagePrefix("GF_SYNC_REQ")
    RegisterAddonMessagePrefix("GF_UPDATE_1")
    RegisterAddonMessagePrefix("GF_UPDATE_2")
    RegisterAddonMessagePrefix("GF_UPDATE_3")
    
    --local faction init
    GF_OnInitialize()
    GF_InitFactions()
    
    if GF_FactionData == nil then
        GF_FactionData = {}
        GF_CreateNewProject(select(1, GetGuildInfo("player")))
        --GF_FactionData[1].name = select(1, GetGuildInfo("player")) --in case of guild change
        GF_AddFaction(GF_GuildFactions[1].title , GF_GuildFactions[1].description , false, "1",0)
        GF_AddFaction(GF_GuildFactions[2].title , GF_GuildFactions[2].description , false, "2",0)
        GF_AddFaction(GF_GuildFactions[3].title , GF_GuildFactions[3].description , false, "3",0)
        GF_AddFaction(GF_GuildFactions[4].title , GF_GuildFactions[4].description , false, "4",0)
        GF_AddFaction(GF_GuildFactions[5].title , GF_GuildFactions[5].description , false, "5", 0)    
    end
end

function GF_OnEvent(self, event, ...)    
    local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9 = ...;
    ---print("Event: "..event..", arg2: "..arg2..", arg5: "..arg5..", arg9: "..arg9)
    if event == "VARIABLES_LOADED" then 
        GF_HitListFrame:RegisterForDrag("LeftButton")    
        GF_Init()        
        
        if not GF_Config["WatchedFaction"] then    
            GF_Config["WatchedFaction"] = 0
        end 
        
        --GF_FactionData[1].name = select(1, GetGuildInfo("player")) --in case of guild change
    
    elseif (event == "GUILD_ROSTER_UPDATE") then
        --GF_LargessMessage("GUILD_ROSTER_UPDATE")
        local gnum = GetNumGuildMembers(true)
        local i,name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName
        
        GF_GuildMates = {}      
        for i = 1,gnum do
            name,rank,rankIndex,level,class,zone,note,officernote,online,status,classFileName = GetGuildRosterInfo(i) 
            table.insert(GF_GuildMates,{name=name,note=officernote,pnote=note})
        end             
        
        --guild faction data     
        if GF_FactionSaveFlag == nil then    --this is essentially done only once, should be moved?         
            GF_FactionInit()
            GF_FactionLoad() 
        end
        --GBL_SetupFactionViewList()     
    
    elseif (event == "PLAYER_LOGIN") then
       GF_LargessMessage("[GF] Guild Factions v"..GF_VERSION.." loaded", "sys")
       GF_LargessMessage("[GF] Type /gf help for a list of commands", "sys")
       
    elseif (event == "PLAYER_ENTERING_WORLD") then 
        GF_ActionQueueInit()
        GF_ActionQueueAdd([[GF_FactionData[1].name = select(1, GetGuildInfo("player"))]], 10)        
        GF_ActionQueueAdd([[ChatThrottleLib:SendAddonMessage("ALERT","GF_SYNC_REQ","","GUILD")]], 10)
        --GF_FactionData[1].name = select(1, GetGuildInfo("player")) --in case of guild change
        if GF_Config["scale"] ~= nil then
            GF_HitListFrame:SetScale(GF_Config["scale"])
        end
        --GF_Purge()
        GuildRoster()  
    
    --sync
    elseif (event == "CHAT_MSG_ADDON") then        
        --guild factions
        if (arg1 == "GF_SYNC_REQ") then
            --if arg4 ~= UnitName("player") then
                gf_debug("GF_SYNC_REQ")
                GF_DoSync()
            --end
        
        elseif (arg1 == "GF_UPDATE_1") then            
            --if arg4 ~= UnitName("player") then
                gf_debug("GF_UPDATE_1")
                GF_DoUpdateTitle(arg2);
            --end
        
        elseif (arg1 == "GF_UPDATE_2") then            
            --if arg4 ~= UnitName("player") then
                gf_debug("GF_UPDATE_2")
                GF_DoUpdateDescription(arg2);
            --end
            
        elseif (arg1 == "GF_UPDATE_3") then            
            --if arg4 ~= UnitName("player") then
                gf_debug("GF_UPDATE_3")
                GF_DoUpdateDiscounts(arg2);
            --end
            
        elseif (arg1 == "GF_SET_REP") then
            gf_debug("GF_SET_LOCAL_REP")
            local rep1, rep2, rep3, rep4, rep5 = string.split(",", arg2)
            GF_SetReputation(2, tonumber(rep1)-42000)
            GF_SetReputation(3, tonumber(rep2)-42000)
            GF_SetReputation(4, tonumber(rep3)-42000)
            GF_SetReputation(5, tonumber(rep4)-42000)
            GF_SetReputation(6, tonumber(rep5)-42000)  
            
        end  --CHAT_MSG_ADDON event  
    end
end      
  
function GF_GetFullName(name)
   if name == nil then
        return
   end
   
   if name == "player" then
		name = UnitName("player")
   end
	
   local n, r = string.split("-", name)
   if r ~= nil then
      return name  
      
   else
      local realm = GetRealmName()
      return name.."-"..realm
   end   
   
end

function GF_UnitIsInMyGuild(name)

	local i
	for i = 1, #GF_GuildMates do
		if GF_GuildMates[i].name == name then
			return true
		end
	end
	
	return false
end
	