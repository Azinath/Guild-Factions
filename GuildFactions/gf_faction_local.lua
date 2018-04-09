--  ================================ new hooked functions  ================================
function GF_GetNumFactions() 
   
   
   local OrigNumFactions = GF_Orig_GetNumFactions();
   local GF_NumFactions = 0;
   if (GF_FactionData[1] == nil) then 
      
      return OrigNumFactions;
   else
      GF_NumFactions = table.getn(GF_FactionData);    
      
   end;
   
   
   local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GF_GetFactionInfo(OrigNumFactions+1);
   
   if (isHeader and (isCollapsed)) then
      
      return OrigNumFactions + 1;
      
   else
      --GF_Message(GF_NumFactions);    
      return OrigNumFactions + GF_NumFactions;
   end
end

function GF_GetFactionInfo(factionIndex) 
   local OrigNumFactions = GF_Orig_GetNumFactions();
   local GF_NumFactions = 0;
   if (GF_FactionData[1] == nil) then 
      GF_NumFactions = 0;
   else
      GF_NumFactions = table.getn(GF_FactionData);    
   end;
   
   local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GF_Orig_GetFactionInfo(factionIndex);
   
   if (factionIndex > OrigNumFactions and factionIndex <= OrigNumFactions + GF_NumFactions) then
      
      local data = GF_FactionData[factionIndex - OrigNumFactions];
      name = data.name;
      description = data.description;
      standingID = data.standingID;
      barMin = GF_BarMinValues[standingID].minValue;
      barMax = GF_BarMinValues[standingID].maxValue;
      barValue = data.value;
      atWarWith = data.atWarWith;
      canToggleAtWar = data.canToggleAtWar;
      isHeader = data.isHeader;
      isCollapsed = data.isCollapsed;
      isWatched = data.isWatched;
      
   end
   
   
   
   return name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild;
end

function GF_GetSelectedFaction() 
   --local ID = GF_Orig_GetSelectedFaction();
   
   return GF_SelectedFaction;
end

function GF_SetSelectedFaction(ID) 
   GF_SelectedFaction = ID;
   --GF_Orig_SetSelectedFaction(ID);
   
end

function GF_GetWatchedFactionInfo() 
   --GF_Message("Get Watched faction info");
   --if InCombatLockdown() then return nil end;
   
   if GF_Config == nil or GF_Config["WatchedFaction"] == nil or GF_Config["WatchedFaction"] == 0 then return nil,"",0,0,0; end;
   local name, description, standingID, barMin, barMax, barValue = GF_GetFactionInfo(GF_Config["WatchedFaction"]);
   
   return name, standingID, barMin, barMax, barValue;
end

function GF_SetWatchedFactionIndex(index) 
   --GF_Orig_SetWatchedFactionIndex(index);
   --GF_WatchedFaction = index;
   
   GF_Config["WatchedFaction"] = index
end

function GF_IsFactionInactive(index)
   
   local OrigNumFactions = GF_Orig_GetNumFactions();
   if ( (index>OrigNumFactions) and GF_SelectedFaction == index) then
      ReputationDetailInactiveCheckBoxText:SetText(L_GF_OWNFACTION);
      -- localization
      REPUTATION_MOVE_TO_INACTIVE = L_GF_TEXT_JOIN_FACT;
      
      if GF_FactionData[index-OrigNumFactions].leader == nil then
         -- localization
         --GF_FactionDecTextLabel1:SetText(L_GF_NO_FACTIONLEADER);
      elseif GF_FactionData[index-OrigNumFactions].leader == ""then
         -- localization
         --GF_FactionDecTextLabel1:SetText(L_GF_NO_FACTIONLEADER);
      else
         -- localization
         --GF_FactionDecTextLabel1:SetText(L_GF_FACTION_LEADER..": "..GF_FactionData[index-OrigNumFactions].leader);
      end
      --GF_FactionDecText:Show();
      
      if GF_FactionData[index-OrigNumFactions].standingID < 4 then
         ReputationDetailInactiveCheckBox:Disable();
         ReputationDetailInactiveCheckBoxText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      else
         
         ReputationDetailInactiveCheckBoxText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
         ReputationDetailInactiveCheckBox:Enable();
         return GF_FactionData[index-OrigNumFactions].ownFaction;
      end
      
      
   else
      --GF_FactionDecText:Hide();
      
      REPUTATION_MOVE_TO_INACTIVE = ORIG_REPUTATION_MOVE_TO_INACTIVE;
      ReputationDetailInactiveCheckBox:Enable();
      ReputationDetailInactiveCheckBoxText:SetText(L_GF_M_T_INACTIVE);
      ReputationDetailInactiveCheckBoxText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      return GF_Orig_IsFactionInactive(index);
   end
   
   
   
end

function GF_SetFactionInactive(index)
   local OrigNumFactions = GF_Orig_GetNumFactions();
   if ( (index>OrigNumFactions) and GF_SelectedFaction == index) then
      GF_SetOwnFaction(index-OrigNumFactions);
   else
      GF_Orig_SetFactionInactive(index);
   end
end

function GF_SetFactionActive(index)
   local OrigNumFactions = GF_Orig_GetNumFactions();
   if ( (index>OrigNumFactions) and GF_SelectedFaction == index) then
      GF_SetOwnFaction(0);
   else
      GF_Orig_SetFactionActive(index);
   end
end

function GF_CollapseFactionHeader(i)  
   local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame);
   --local factionHeader = getglobal("ReputationHeader"..i-factionOffset);
   local factionHeader = getglobal("ReputationBar"..i-factionOffset.."FactionName");   
   
   if (GF_FactionData[1] == nil ) then
      GF_Orig_CollapseFactionHeader(i);    
   elseif factionHeader:GetText() == GF_FactionData[1].name then      
      GF_CollapseHeader(1);
      ReputationFrame_Update();
   else
      GF_Orig_CollapseFactionHeader(i);
   end   
end

function GF_CollapseHeader(collapse)
	GF_FactionData[1].isCollapsed = collapse;
end

function GF_ExpandFactionHeader(i)   
   local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame);
   --local factionHeader = getglobal("ReputationHeader"..i-factionOffset);
   local factionHeader = getglobal("ReputationBar"..i-factionOffset.."FactionName");
   if not(GF_FactionData[1] == nil) and factionHeader:GetText() == GF_FactionData[1].name then
      GF_CollapseHeader(nil);
      ReputationFrame_Update();      
   else
      GF_Orig_ExpandFactionHeader(i);
   end   
end

function GF_FactionToggleAtWar(index)
   
   local name = GF_GetFactionInfo(index);
   
   local OrigNumFactions = GF_Orig_GetNumFactions();
   local GF_NumFactions = 0;
   if not(GF_FactionData[1] == nil) then
      GF_NumFactions = table.getn(GF_FactionData);
   end
   
   if (index > OrigNumFactions and index <= OrigNumFactions + GF_NumFactions) then
      GF_ToggleWar(index - OrigNumFactions);
      ReputationFrame_Update();
   else    
      GF_Orig_FactionToggleAtWar(index);
   end
end

function GF_ReputationBar_OnClick(self)
   --GF_ModerateFrame:Hide();
   --GF_OptionsFrame:Hide();
   GF_Orig_ReputationBar_OnClick(self);
end

function GF_AddFaction(name,description,canToggleAtWar,ID,initVal)
   local GF_NumFactions = table.getn(GF_FactionData);
   -- debug localization
   --GF_DebugMsg("Adding "..name..". Dec: "..description);
   
   local val = 0;
   local stID = 4;
   
   if not(initVal==nil) then
      local a,b,c,StandingID = GF_GetStandingName(initVal)
      val = initVal;
      stID = StandingID;
   end
   
   table.insert(GF_FactionData,{
         name = name, 
         description = description, 
         standingID = stID, 
         value = val, 
         initval = initVal,
         atWarWith = false, 
         canToggleAtWar = canToggleAtWar, 
         isHeader = false, 
         isCollapsed = false, 
         isWatched = false,
         ownFaction = false,
         ID = ID,
      }
   );
   
   --GF_FactionData[1].version = version;
   
   ReputationFrame_Update();
   --ReputationWatchBar_Update();
end

----- Manual setup functions
function GF_CreateNewProject(name)
   if not(GF_FactionData[1] == nil) then
      --GF_Message(L_GF_ARIP);
   else
      --GF_Message(L_GF_CNP..": "..name);
      currentTime = time();
      Pname = GF_GetFullName("player");
      
      GF_FactionData = {
         [1] = {
            name = name, 
            description = "", 
            standingID = 4, 
            value = 0, 
            leader = Pname,
            atWarWith = false, 
            canToggleAtWar = false, 
            isHeader = true, 
            isCollapsed = nil, 
            isWatched = false,
            ownFaction = false,
            version = currentTime;
            created = currentTime;
         },
      };    
      GF_OwnRank = 1;
      --GF_UpdateRankText();
      --GF_UpdateOptionsText();
      --GF_ModerateFrame_OnLoad(GF_ModerateFrame);
   end
end

function GF_OnInitialize()
   
   GF_Orig_GetNumFactions = GetNumFactions; 
   GetNumFactions = GF_GetNumFactions;
   
   GF_Orig_GetFactionInfo = GetFactionInfo; 
   GetFactionInfo = GF_GetFactionInfo;
   
   GF_Orig_GetSelectedFaction = GetSelectedFaction;
   GetSelectedFaction = GF_GetSelectedFaction; 
   
   GF_Orig_SetSelectedFaction = SetSelectedFaction;  
   SetSelectedFaction = GF_SetSelectedFaction;
   
   GF_Orig_SetWatchedFactionIndex = SetWatchedFactionIndex; 
   SetWatchedFactionIndex = GF_SetWatchedFactionIndex;
   
   GF_Orig_GetWatchedFactionInfo = GetWatchedFactionInfo;  
   GetWatchedFactionInfo = GF_GetWatchedFactionInfo;   --x
   
   GF_Orig_IsFactionInactive = IsFactionInactive;
   IsFactionInactive = GF_IsFactionInactive;
   
   GF_Orig_SetFactionInactive = SetFactionInactive;
   SetFactionInactive = GF_SetFactionInactive;
   
   GF_Orig_SetFactionActive = SetFactionActive;
   SetFactionActive = GF_SetFactionActive;
   
   GF_Orig_CollapseFactionHeader = CollapseFactionHeader;
   CollapseFactionHeader = GF_CollapseFactionHeader;
   
   GF_Orig_ExpandFactionHeader = ExpandFactionHeader;
   ExpandFactionHeader = GF_ExpandFactionHeader;
   
   GF_Orig_FactionToggleAtWar = FactionToggleAtWar;
   FactionToggleAtWar = GF_FactionToggleAtWar;
   
   GF_Orig_ReputationBar_OnClick = ReputationBar_OnClick;
   ReputationBar_OnClick = GF_ReputationBar_OnClick;  
   ---- Hook tooltip text
   ORIG_REPUTATION_MOVE_TO_INACTIVE = REPUTATION_MOVE_TO_INACTIVE;
   --    Hooking for error messages
   --GF_orig_ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler;
   --ChatFrame_MessageEventHandler = GF_ChatFrame_MessageEventHandler;
   
   --GF_original_FriendsFrame_OnEvent = FriendsFrame_OnEvent;
   --FriendsFrame_OnEvent = GF_FriendsFrame_OnEvent;
   
   --GF_ReptabTextLabel1:SetText(L_GF_VERSION..GF_Version);
   -- GF_UpdateRankText();
   --GF_UpdateOptionsText();
   -- localization
   --GF_Message(L_GF_LOADED);
   --if GF_OwnRank > 0 and GF_OwnRank < 4 then 
   --   GF_ModerateFrame_OnLoad(GF_ModerateFrame);
   --end
   
   --GF_ReptabTextLabel1:SetText(L_GF_VERSION..GF_Version);  
   
end

function GF_GetStandingName(amount)
   amount = tonumber(amount);
   if amount < -6000 then
      -- localization menu
      return amount + 42000,36000, L_GF_REP_L[0],1;
   elseif amount < -3000 then
      -- localization menu
      return amount + 6000,3000, L_GF_REP_L[1],2;
   elseif amount < 0 then
      -- localization menu
      return amount + 3000,3000, L_GF_REP_L[2],3;
   elseif amount < 3000 then
      -- localization menu
      return amount,3000, L_GF_REP_L[3],4;
   elseif amount < 9000 then
      -- localization menu
      return amount - 3000,6000, L_GF_REP_L[4],5;
   elseif amount < 21000 then
      -- localization menu
      return amount - 9000 ,12000, L_GF_REP_L[5],6;
   elseif amount < 42000 then
      -- localization menu
      return amount - 21000,21000, L_GF_REP_L[6],7;
   elseif amount < 43000 then
      -- localization menu
      return amount - 42000,1000,  L_GF_REP_L[7],8;
   elseif amount >= 43000 then
      -- localization menu
      return 999,1000,  L_GF_REP_L[7],8;
   else
      return 0,0,"",0;
   end
end

L_GF_REP_L = {
   [0] = "hated",
   [1] = "hostile",
   [2] = "unfriendly",
   [3] = "neutral",
   [4] = "friendly",
   [5] = "honored",
   [6] = "revered",
   [7] = "exalted"
};

--GF_FactionNum = 3;
GF_BarMinValues = {
   [1] = {
      minValue = -42000,
      maxValue = -6000
   },
   [2] = {
      minValue = -6000,
      maxValue = -3000
   },
   [3] = {
      minValue = -3000,
      maxValue = 0
   },
   [4] = {
      minValue = 0,
      maxValue = 3000
   },
   [5] = {
      minValue = 3000,
      maxValue = 9000
   },
   [6] = {
      minValue = 9000,
      maxValue = 21000
   },
   [7] = {
      minValue = 21000,
      maxValue = 42000
   },
   [8] = {
      minValue = 42000,
      maxValue = 43000
   },
};


function GF_SetReputation(index,newValue)
   
   if newValue > 42999 then
      newValue = 42999;
   end
   if newValue < -42000 then
      newValue = -42000;
   end
   
   GF_FactionData[index].value = newValue;
   -- calc new standing ID 
   local calculated = false;
   for i=1,8 do
      if calculated == false then
         if GF_BarMinValues[i].minValue <= newValue and GF_BarMinValues[i].maxValue > newValue then
            GF_FactionData[index].standingID = i;
            calculated = true;    
         end
      end
   end
   
   ReputationFrame_Update();
   --ReputationWatchBar_Update();
end

--add rep for gold deposits
function GF_AddLocalGoldRep(amount)
    --initial reps
    local irep1 = GF_FactionData[2].value or 0
    local irep2 = GF_FactionData[3].value or 0
    local irep3 = GF_FactionData[4].value or 0
    local irep4 = GF_FactionData[5].value or 0
    local irep5 = GF_FactionData[6].value or 0
    
    --adjusted reps
    local arep1 = math.floor(amount*(GF_GuildFactions[1].goldtorep or 0)/10000)
    local arep2 = math.floor(amount*(GF_GuildFactions[2].goldtorep or 0)/10000)       
    local arep3 = math.floor(amount*(GF_GuildFactions[3].goldtorep or 0)/10000)
    local arep4 = math.floor(amount*(GF_GuildFactions[4].goldtorep or 0)/10000)
    local arep5 = math.floor(amount*(GF_GuildFactions[5].goldtorep or 0)/10000)
    
    --total reps
    local trep1 = math.floor(irep1 + arep1)
    local trep2 = math.floor(irep2 + arep2)
    local trep3 = math.floor(irep3 + arep3)
    local trep4 = math.floor(irep4 + arep4)
    local trep5 = math.floor(irep5 + arep5)    
    
    --set reps
    GF_SetReputation(2, trep1)
    GF_SetReputation(3, trep2)
    GF_SetReputation(4, trep3)
    GF_SetReputation(5, trep4)
    GF_SetReputation(6, trep5)
    
    --print reps
    if arep1 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[2].name.." increased by "..arep1..".", "rep")
    end
    if arep2 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[3].name.." increased by "..arep2..".", "rep")
    end
    if arep3 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[4].name.." increased by "..arep3..".", "rep")
    end
    if arep4 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[5].name.." increased by "..arep4..".", "rep")
    end
    if arep5 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[6].name.." increased by "..arep5..".", "rep")
    end    
        
end

--subtract rep for withdraws
function GF_SubLocalGoldRep(amount)
    --initial reps
    local irep1 = GF_FactionData[2].value or 0
    local irep2 = GF_FactionData[3].value or 0
    local irep3 = GF_FactionData[4].value or 0
    local irep4 = GF_FactionData[5].value or 0
    local irep5 = GF_FactionData[6].value or 0
    
    --adjusted reps
    local arep1 = math.floor(amount*(GF_GuildFactions[1].goldtorep or 0)/10000)
    local arep2 = math.floor(amount*(GF_GuildFactions[2].goldtorep or 0)/10000)      
    local arep3 = math.floor(amount*(GF_GuildFactions[3].goldtorep or 0)/10000)
    local arep4 = math.floor(amount*(GF_GuildFactions[4].goldtorep or 0)/10000)
    local arep5 = math.floor(amount*(GF_GuildFactions[5].goldtorep or 0)/10000)
    
    --total reps
    local trep1 = math.floor(irep1 - arep1)
    local trep2 = math.floor(irep2 - arep2)
    local trep3 = math.floor(irep3 - arep3)
    local trep4 = math.floor(irep4 - arep4)
    local trep5 = math.floor(irep5 - arep5)    
    
    --set reps
    GF_SetReputation(2, trep1)
    GF_SetReputation(3, trep2)
    GF_SetReputation(4, trep3)
    GF_SetReputation(5, trep4)
    GF_SetReputation(6, trep5)
    
    --print reps
    if arep1 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[2].name.." decreased by "..arep1..".", "rep")
    end
    if arep2 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[3].name.." decreased by "..arep2..".", "rep")
    end
    if arep3 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[4].name.." decreased by "..arep3..".", "rep")
    end
    if arep4 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[5].name.." decreased by "..arep4..".", "rep")
    end
    if arep5 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[6].name.." decreased by "..arep5..".", "rep")
    end    
end

--add rep for bounty claims
function GF_AddLocalBountyRep(amount) 
    --initial reps
    local irep1 = GF_FactionData[2].value or 0
    local irep2 = GF_FactionData[3].value or 0
    local irep3 = GF_FactionData[4].value or 0
    local irep4 = GF_FactionData[5].value or 0
    local irep5 = GF_FactionData[6].value or 0
    
    --adjusted reps
    local arep1 = amount*(GF_GuildFactions[1].bountytorep or 0)/10000
    local arep2 = amount*(GF_GuildFactions[2].bountytorep or 0)/10000       
    local arep3 = amount*(GF_GuildFactions[3].bountytorep or 0)/10000
    local arep4 = amount*(GF_GuildFactions[4].bountytorep or 0)/10000
    local arep5 = amount*(GF_GuildFactions[5].bountytorep or 0)/10000
    
    --total reps
    local trep1 = irep1 + arep1
    local trep2 = irep2 + arep2
    local trep3 = irep3 + arep3
    local trep4 = irep4 + arep4
    local trep5 = irep5 + arep5    
    
    --set reps
    GF_SetReputation(2, math.floor(trep1))
    GF_SetReputation(3, math.floor(trep2))
    GF_SetReputation(4, math.floor(trep3))
    GF_SetReputation(5, math.floor(trep4))
    GF_SetReputation(6, math.floor(trep5))
    
    --print reps
    if arep1 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[2].name.." increased by "..arep1..".", "rep")
    end
    if arep2 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[3].name.." increased by "..arep2..".", "rep")
    end
    if arep3 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[4].name.." increased by "..arep3..".", "rep")
    end
    if arep4 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[5].name.." increased by "..arep4..".", "rep")
    end
    if arep5 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[6].name.." increased by "..arep5..".", "rep")
    end    
end

function GF_AddLocalItemRep(item,count)
     local name, link, quality, iLevel,  reqLevel, class, subclass, maxStack,  equipSlot, texture, vendorPrice = GetItemInfo(item)
     
    --initial reps
    local irep1 = GF_FactionData[2].value or 0
    local irep2 = GF_FactionData[3].value or 0
    local irep3 = GF_FactionData[4].value or 0
    local irep4 = GF_FactionData[5].value or 0
    local irep5 = GF_FactionData[6].value or 0
    
    --adjusted reps
    local arep1, arep2, arep3, arep4, arep5 = GF_GetFactionItemRep(link)
    arep1 = arep1*count
    arep2 = arep2*count
    arep3 = arep3*count
    arep4 = arep4*count
    arep5 = arep5*count
    
    --total reps
    local trep1 = irep1 + arep1
    local trep2 = irep2 + arep2
    local trep3 = irep3 + arep3
    local trep4 = irep4 + arep4
    local trep5 = irep5 + arep5    
    
    --set reps
    GF_SetReputation(2, math.floor(trep1))
    GF_SetReputation(3, math.floor(trep2))
    GF_SetReputation(4, math.floor(trep3))
    GF_SetReputation(5, math.floor(trep4))
    GF_SetReputation(6, math.floor(trep5))
    
    --print reps
    if arep1 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[2].name.." increased by "..arep1..".", "rep")
    end
    if arep2 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[3].name.." increased by "..arep2..".", "rep")
    end
    if arep3 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[4].name.." increased by "..arep3..".", "rep")
    end
    if arep4 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[5].name.." increased by "..arep4..".", "rep")
    end
    if arep5 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[6].name.." increased by "..arep5..".", "rep")
    end    

end

function GF_SubLocalItemRep(item,count)
     local name, link, quality, iLevel,  reqLevel, class, subclass, maxStack,  equipSlot, texture, vendorPrice = GetItemInfo(item)
     
    --initial reps
    local irep1 = GF_FactionData[2].value or 0
    local irep2 = GF_FactionData[3].value or 0
    local irep3 = GF_FactionData[4].value or 0
    local irep4 = GF_FactionData[5].value or 0
    local irep5 = GF_FactionData[6].value or 0
    
    --adjusted reps
    local arep1, arep2, arep3, arep4, arep5 = GF_GetFactionItemRep(link)
    arep1 = arep1*count
    arep2 = arep2*count
    arep3 = arep3*count
    arep4 = arep4*count
    arep5 = arep5*count
    
    --total reps
    local trep1 = irep1 - arep1
    local trep2 = irep2 - arep2
    local trep3 = irep3 - arep3
    local trep4 = irep4 - arep4
    local trep5 = irep5 - arep5    
    
    --set reps
    GF_SetReputation(2, math.floor(trep1))
    GF_SetReputation(3, math.floor(trep2))
    GF_SetReputation(4, math.floor(trep3))
    GF_SetReputation(5, math.floor(trep4))
    GF_SetReputation(6, math.floor(trep5))
    
    --print reps
    if arep1 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[2].name.." decreased by "..arep1..".", "rep")
    end
    if arep2 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[3].name.." decreased by "..arep2..".", "rep")
    end
    if arep3 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[4].name.." decreased by "..arep3..".", "rep")
    end
    if arep4 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[5].name.." decreased by "..arep4..".", "rep")
    end
    if arep5 > 0 then
        GF_LargessMessage("Reputation with "..GF_FactionData[6].name.." decreased by "..arep5..".", "rep")
    end    

end

function GF_DiscountTransByLocalRep(amount,ttype,item)
    --ttype is index into discount matrix
    -- 1: Money
    -- 2: Repair
    -- 3: Item
    -- 4: Bounty    
    local irep1 = 1
    local irep2 = 1
    local irep3 = 1
    local irep4 = 1
    local irep5 = 1
    local name1,name2,i
    
    if ttype == "withdraw" then 
        ttype = 1
    elseif ttype == "repair" then
        ttype = 2
    elseif ttype == "item" then
        ttype = 3
        for i = 1, #GF_ItemLargess do
            name1 = GetItemInfo(GF_ItemLargess[i].item)
            name2 = GetItemInfo(item)
            if name1 == name2 then
                --item exists in list
                if GF_ItemLargess[i].rep1 == 0 then
                    irep1 = 0
                end
                if GF_ItemLargess[i].rep2 == 0 then
                    irep2 = 0
                end
                if GF_ItemLargess[i].rep3 == 0 then
                    irep3 = 0
                end
                if GF_ItemLargess[i].rep4 == 0 then
                    irep4 = 0
                end
                if GF_ItemLargess[i].rep5 == 0 then
                    irep5 = 0
                end                
            end
        end
    elseif ttype == "bounty" then
        ttype = 4
    end      
    
    local lvl01,lvl02,lvl03,lvl04,lvl05
    local disc = 0    
    
    local rep1 = GF_FactionData[2].value or 0
    local rep2 = GF_FactionData[3].value or 0
    local rep3 = GF_FactionData[4].value or 0
    local rep4 = GF_FactionData[5].value or 0
    local rep5 = GF_FactionData[6].value or 0
    
    lvl01 = GF_GrpToRepLevelNumber(rep1+42000)
    lvl02 = GF_GrpToRepLevelNumber(rep2+42000)
    lvl03 = GF_GrpToRepLevelNumber(rep3+42000)
    lvl04 = GF_GrpToRepLevelNumber(rep4+42000)
    lvl05 = GF_GrpToRepLevelNumber(rep5+42000)
    
    --gf_debug("Rep1 level:"..lvl01)
    
    --add up discounts for all factions    
    disc = GF_GuildFactions[1].discount[lvl01][ttype]*irep1
    disc = disc + GF_GuildFactions[2].discount[lvl02][ttype]*irep2
    disc = disc + GF_GuildFactions[3].discount[lvl03][ttype]*irep3
    disc = disc + GF_GuildFactions[4].discount[lvl04][ttype]*irep4
    disc = disc + GF_GuildFactions[5].discount[lvl05][ttype]*irep5
    
    return amount - floor(amount*(disc/100))
    
end