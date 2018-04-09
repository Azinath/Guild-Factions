GF_NUM_HITLIST_ENTRIES = 14

function GF_CreateFactionView()
   local i,frame,textString,moneyFrame   
   
   --GF_UIFrame:SetScript("OnShow",GF_UIShow)   
   GF_FactionScrollFrame:EnableMouse()
   GF_FactionScrollFrame:EnableMouseWheel(1)   
   GF_FactionScrollFrame:SetScript("OnShow",GF_FactionFrameUpdate) 
   GF_FactionScrollFrame:SetScript("OnUpdate",GF_FactionFrameUpdate)
   GF_FactionScrollFrame:Show()   
   --MoneyFrame_Update(GF_LargessAmountFrame, GBL_Largess); 
   
   --List Entry Frames (faux scroll frames)
   for i = 0,GF_NUM_HITLIST_ENTRIES-1 do       
      frame = CreateFrame("Button","GF_FactionEntry"..i,GF_FactionScrollFrame,"GF_FactionEntryTemplate")
      frame:SetPoint("TOPLEFT",0,-i*17)
      frame:Show() 
   end 
   GF_ListEntryNormalTexture = frame:GetNormalTexture()
   GF_FactionScrollFrame:SetPoint("TOPLEFT",10,-100) 
   GF_FactionCurrentEntry = 0
   
   --init guild faction reputation exit box
   GF_ReputationEditBox:SetText("0")
   
   --init guild faction selection menu
   local faction = GF_GuildFactions[1].title
   UIDropDownMenu_SetSelectedValue(GF_FactionSelectMenu, faction) 
   UIDropDownMenu_SetText(GF_FactionSelectMenu, faction)
 
end  

function GF_FactionFrameUpdate()
    local i,dataOffset,offset,n,m,name
    local moneyFrame,textString,entryFrame,negLargess,faction
    local repLvlStr, lvl, pts, rmax, r,g,b, ri    
   
    n = #GF_GuildFactionData
    FauxScrollFrame_Update(GF_FactionScrollFrame,n,GF_NUM_HITLIST_ENTRIES,17,nil,nil,nil,nil,nil,nil,true);
    offset = FauxScrollFrame_GetOffset(GF_FactionScrollFrame);
       
    for i = 0,GF_NUM_HITLIST_ENTRIES-1 do
        dataOffset = offset + i + 1      
        textString = _G["GF_FactionEntry"..i.."_GuildieName"]
        repString = _G["GF_FactionEntry"..i.."_Reputation"]        
        entryFrame = _G["GF_FactionEntry"..i]      
        if dataOffset <= n then
            name = GF_GuildFactionData[dataOffset].name
            textString:SetText(name)
            faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
            if faction == GF_GuildFactions[1].title then
                lvl, pts, rmax = GF_GrpToRepLevel(GF_GuildFactionData[dataOffset].rep1)
                --lvl, pts, rmax = GF_GrpToRepLevel(GBL_FactionViewList[dataOffset].rep1)
                repLvlStr = lvl.." "..pts.."/"..rmax
                
            elseif faction == GF_GuildFactions[2].title then
                lvl, pts, rmax = GF_GrpToRepLevel(GF_GuildFactionData[dataOffset].rep2)
                --lvl, pts, rmax = GF_GrpToRepLevel(GBL_FactionViewList[dataOffset].rep2)
                repLvlStr = lvl.." "..pts.."/"..rmax
                
            elseif faction == GF_GuildFactions[3].title then   
                lvl, pts, rmax = GF_GrpToRepLevel(GF_GuildFactionData[dataOffset].rep3)
                --lvl, pts, rmax = GF_GrpToRepLevel(GBL_FactionViewList[dataOffset].rep3)
                repLvlStr = lvl.." "..pts.."/"..rmax
               
            elseif faction == GF_GuildFactions[4].title then     
                lvl, pts, rmax = GF_GrpToRepLevel(GF_GuildFactionData[dataOffset].rep4)
                --lvl, pts, rmax = GF_GrpToRepLevel(GBL_FactionViewList[dataOffset].rep4)
                repLvlStr = lvl.." "..pts.."/"..rmax
               
            elseif faction == GF_GuildFactions[5].title then 
                lvl, pts, rmax = GF_GrpToRepLevel(GF_GuildFactionData[dataOffset].rep5)
                --lvl, pts, rmax = GF_GrpToRepLevel(GBL_FactionViewList[dataOffset].rep5)
                repLvlStr = lvl.." "..pts.."/"..rmax
                
            end
            
            r,g,b = GF_FactionGetRepColor(lvl)
            repString:SetTextColor(r,g,b)
            repString:SetText(repLvlStr)
            entryFrame.index = dataOffset
            if GF_FactionCurrentEntry == dataOffset then
                --set selected texture            
                entryFrame:LockHighlight()
            else
                --reset normal texture
                entryFrame:UnlockHighlight()
            end        
            entryFrame:Show()         
        else
            entryFrame:Hide()                
        end        
    end    
end

function GF_FactionEntryOnClick(self)
    GF_FactionCurrentEntry = self.index
    local faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    local replevel, pts    
    
    if faction == GF_GuildFactions[1].title then 
        pts = GF_GuildFactionData[GF_FactionCurrentEntry].rep1
    elseif faction == GF_GuildFactions[2].title then
        pts = GF_GuildFactionData[GF_FactionCurrentEntry].rep2
    elseif faction == GF_GuildFactions[3].title then
        pts = GF_GuildFactionData[GF_FactionCurrentEntry].rep3
    elseif faction == GF_GuildFactions[4].title then
        pts = GF_GuildFactionData[GF_FactionCurrentEntry].rep4
    elseif faction == GF_GuildFactions[5].title then
        pts = GF_GuildFactionData[GF_FactionCurrentEntry].rep5
    end
    replevel, _, _ = GF_GrpToRepLevel(pts)
    UIDropDownMenu_SetSelectedValue(GF_FactionRepMenu, replevel)     
end

function GF_FactionAddRep(player, rep1, rep2, rep3, rep4, rep5)
    local rep01, rep02, rep03, rep04, rep05 = GF_FactionGetRep(player)
    
    if rep1 == nil then 
        rep1 = 0
    end
    if rep2 == nil then
        rep2 = 0
    end
    if rep3 == nil then
        rep3 = 0
    end
    if rep4 == nil then
        rep4 = 0
    end
    if rep5 == nil then
        rep5 = 0
    end
    
    GF_FactionGetRep(player, tonumber(rep01)+tonumber(rep1), tonumber(rep02)+tonumber(rep2), tonumber(rep03)+tonumber(rep3), tonumber(rep04)+tonumber(rep4), tonumber(rep05)+tonumber(rep5))
end

function GF_FactionSubRep(player, rep1, rep2, rep3, rep4, rep5)
    local rep01, rep02, rep03, rep04, rep05 = GF_FactionGetRep(player)
    
    if rep1 == nil then 
        rep1 = 0
    end
    if rep2 == nil then
        rep2 = 0
    end
    if rep3 == nil then
        rep3 = 0
    end
    if rep4 == nil then
        rep4 = 0
    end
    if rep5 == nil then
        rep5 = 0
    end
    
    GF_FactionGetRep(player, rep01-rep1, rep02-rep2, rep03-rep3, rep04-rep4, rep05-rep5)
end
    
function GF_DisplayFactionView()    
    GF_UIFrame:Hide()      
    GF_FactionViewFrame:Show()
    GF_ConfigScrollFrame:Hide()
    --GF_LargessAmountFrame:Hide()
    --GF_AddBountyButton:Hide()
    --GF_HitListFrameTexture1:Hide()
    
    --set portrait icon
    SetPortraitToTexture(GF_HitListFrameSkullnXBonesTexture,"interface\\icons\\Achievement_General_DungeonDiplomat")
end

function GF_FactionDetailsAddRep()
    local rep = GF_ReputationEditBox:GetText()
    gf_debug(rep)
    gf_debug(GF_FactionCurrentEntry)
    local player = GF_GuildFactionData[GF_FactionCurrentEntry].name
    GF_LargessMessage(player)
    local faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    if faction == GF_GuildFactions[1].title then
        GF_FactionAddRep(player, rep, nil, nil, nil, nil)
    elseif faction == GF_GuildFactions[2].title then
        GF_FactionAddRep(player, nil, rep, nil, nil, nil)
    elseif faction == GF_GuildFactions[3].title then            
        GF_FactionAddRep(player, nil, nil, rep, nil, nil)
    elseif faction == GF_GuildFactions[4].title then            
        GF_FactionAddRep(player, nil, nil, nil, rep, nil)
    elseif faction == GF_GuildFactions[5].title then            
        GF_FactionAddRep(player, nil, nil, nil, nil, rep)
    end
    GF_FactionFrameUpdate()
end

function GF_FactionDetailsSubRep()
    local rep = GF_ReputationEditBox:GetText()
    local player = GF_GuildFactionData[GF_FactionCurrentEntry].name
    local faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    
    gf_debug(rep)    
    gf_debug(player)
    gf_debug(faction)       
    
    if faction == GF_GuildFactions[1].title then
        GF_FactionSubRep(player, rep, nil, nil, nil, nil)
    elseif faction == GF_GuildFactions[2].title then
        GF_FactionSubRep(player, nil, rep, nil, nil, nil)
    elseif faction == GF_GuildFactions[3].title then            
        GF_FactionSubRep(player, nil, nil, rep, nil, nil)
    elseif faction == GF_GuildFactions[4].title then            
        GF_FactionSubRep(player, nil, nil, nil, rep, nil)
    elseif faction == GF_GuildFactions[5].title then            
        GF_FactionSubRep(player, nil, nil, nil, nil, rep)
    end
    
    GF_FactionFrameUpdate()
end

--called when the set guild rep button (=) is clicked
function GF_FactionDetailsSubRep(guild, raid)
    local group = UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu)
    --local faction = UIDropDownMenu_GetSelectedID(GF_ItemFactionSelectMenu) or 1
    local faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    local replevel = UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu)
    local rep = GF_ReputationEditBox:GetText()
    local grp = GF_RepLevelToGrp(replevel, rep)    
    
    --faction title to ID
    if faction == GF_GuildFactions[1].title then
        faction = 1
    elseif faction == GF_GuildFactions[2].title then
        faction = 2
    elseif faction == GF_GuildFactions[3].title then
        faction = 3
    elseif faction == GF_GuildFactions[4].title then
        faction = 4
    elseif faction == GF_GuildFactions[5].title then
        faction = 5
    end
        
    if group == "Player" then 
        player = GF_GuildFactionData[GF_FactionCurrentEntry].name
        if faction == 1 then
            GF_FactionGetRep(player, grp, nil, nil, nil, nil)
        elseif faction == 2 then
            GF_FactionGetRep(player, nil, grp, nil, nil, nil)
        elseif faction == 3 then            
            GF_FactionGetRep(player, nil, nil, grp, nil, nil)
        elseif faction == 4 then            
            GF_FactionGetRep(player, nil, nil, nil, grp, nil)
        elseif faction == 5 then            
            GF_FactionGetRep(player, nil, nil, nil, nil, grp)
        end    
    else
        GF_SetGuildRep(group, faction, replevel, rep)
    end
end

function GF_FactionSelectMenuOnClick(self)
    --GF_LargessMessage("Faction Click...")
    ToggleDropDownMenu(1, nil, GF_FactionDropDownFrame, self:GetName(), -100, 0)
end

function GF_FactionSelectMenuInitialize()

    gf_debug("Faction Init") 
    
    GF_FactionSelectMenuButton:SetScript("OnClick", GF_FactionSelectMenuOnClick)
    
    --Menu Title
    local info = {}
    info.text = "Guild Factions"
    info.isTitle = true
    info.notCheckable = true
    --if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[1].title then
    --    info.checked = true
    --else
    --    info.checked = nil
    --end
    UIDropDownMenu_AddButton(info)
    
    --Faction 1    
    info = {}
    info.text = GF_GuildFactions[1].title       
    info.func = GF_FactionMenuItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[1].title then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Faction 2
    info = {}
    info.text = GF_GuildFactions[2].title
    info.func = GF_FactionMenuItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[2].title then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Faction 3
    info = {}
    info.text = GF_GuildFactions[3].title
    info.func = GF_FactionMenuItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[3].title then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Faction 4
    info = {}
    info.text = GF_GuildFactions[4].title
    info.func = GF_FactionMenuItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[4].title then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Faction 5
    info = {}
    info.text = GF_GuildFactions[5].title
    info.func = GF_FactionMenuItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[5].title then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)  
    
    --default value
    if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == nil then
        UIDropDownMenu_SetSelectedValue(GF_FactionSelectMenu, GF_GuildFactions[1].title)
    end
end

function GF_SetRepApplyToMenuInitialize()

    --gf_debug("SetRepApplyTo") 
    
    GF_SetRepApplyToMenuButton:SetScript("OnClick", GF_SetRepApplyToOnClick)
    
    --Menu Title
    local info = {}
    info.text = "Apply To"
    info.isTitle = true
    info.notCheckable = true
    --if UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu) == GF_GuildFactions[1].title then
    --    info.checked = true
    --else
    --    info.checked = nil
    --end
    UIDropDownMenu_AddButton(info)
    
    --Player   
    info = {}
    info.text = "Player"       
    info.func = GF_SetRepApplyToItemClick
    if UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu) == "Player" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Guild
    info = {}
    info.text = "Guild"
    info.func = GF_SetRepApplyToItemClick
    if UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu) == "Guild" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Party
    info = {}
    info.text = "Party"
    info.func = GF_SetRepApplyToItemClick
    if UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu) == "Party" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --Raid
    info = {}
    info.text = "Raid"
    info.func = GF_SetRepApplyToItemClick
    if UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu) == "Raid" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)   
    --default value
    if UIDropDownMenu_GetSelectedValue(GF_SetRepApplyToMenu) == nil then
        UIDropDownMenu_SetSelectedValue(GF_SetRepApplyToMenu, "Player")
    end
end

function GF_SetRepApplyToItemClick(self)
    gf_debug(self.value)    
    UIDropDownMenu_SetSelectedValue(GF_SetRepApplyToMenu, self.value)  
    UIDropDownMenu_SetSelectedValue(GF_SetRepApplyToMenu, self.value) 
    GF_SetRepApplyToMenuInitialize()
    --GF_FactionDetailsOnShow()
    --GF_FactionFrameUpdate()
end

function GF_FactionRepMenuInitialize()
    --GF_LargessMessage("Faction Init") 
    GF_FactionRepMenuButton:SetScript("OnClick", GF_FactionRepMenuOnClick)
    
    local info ={}
    info.text = "Standing"
    info.isTitle = true
    info.notCheckable = true
    UIDropDownMenu_AddButton(info)
    
    info = {}
    info.text = "Exalted"        
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Exalted" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Revered"
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Revered" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Honored"    
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Honored" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Friendly"
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Friendly" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Neutral"
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Neutral" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Unfriendly"    
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Unfriendly" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Hostile"
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Hostile" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    info.text = "Hated"
    info.func = GF_FactionRepItemClick
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == "Hated" then
        info.checked = true
    else
        info.checked = nil
    end
    UIDropDownMenu_AddButton(info)
    
    --default value
    if UIDropDownMenu_GetSelectedValue(GF_FactionRepMenu) == nil then
        UIDropDownMenu_SetSelectedValue(GF_FactionRepMenu, "Neutral")
    end
end

function GF_FactionSelectDropDownOnLoad(self)
    --GF_LargessMessage("Faction OnLoad")
    UIDropDownMenu_Initialize(self, GF_FactionSelectMenuInitialize)
end

function GF_SetRepApplyToDropDownOnLoad(self)
    --GF_LargessMessage("Faction OnLoad")
    UIDropDownMenu_Initialize(self, GF_SetRepApplyToMenuInitialize)
end

function GF_FactionMenuItemClick(self)    
    gf_debug(self.value)    
    UIDropDownMenu_SetSelectedValue(GF_FactionSelectMenu, self.value)  
    UIDropDownMenu_SetSelectedValue(GF_FactionSelectMenu, self.value) 
    GF_FactionRepMenuInitialize()
    GF_FactionDetailsOnShow()
    --GF_FactionFrameUpdate()
end

function GF_FactionRepDropDownOnLoad(self)
    --GF_LargessMessage("Faction OnLoad")
    UIDropDownMenu_Initialize(self, GF_FactionRepMenuInitialize)
end

function GF_FactionRepItemClick(self)        
    gf_debug(self.value)    
    UIDropDownMenu_SetSelectedValue(GF_FactionRepMenu, self.value)   
    --GF_FactionDetailsOnShow()
    GF_FactionRepMenuInitialize()
end

function GF_FactionRepMenuOnClick(self)
    --GF_LargessMessage("Faction Click...")
    ToggleDropDownMenu(1, nil, GF_FactionRepDropDownFrame, self:GetName(), -100, 0)
end

function GF_SetRepApplyToOnClick(self)
    --GF_LargessMessage("Faction Click...")
    ToggleDropDownMenu(1, nil, GF_SetRepApplyToDropDownFrame, self:GetName(), -100, 0)
end

function GF_FactionGetRepColor(str)
    local r,g,b
    if str == "Hated" then
        r = FACTION_BAR_COLORS[1].r
        g = FACTION_BAR_COLORS[1].g
        b = FACTION_BAR_COLORS[1].b
        return r,g,b
    end
    if str == "Hostile" then
        r = FACTION_BAR_COLORS[2].r
        g = FACTION_BAR_COLORS[2].g
        b = FACTION_BAR_COLORS[2].b
        return r,g,b
    end
    if str == "Unfriendly" then
        r = FACTION_BAR_COLORS[3].r
        g = FACTION_BAR_COLORS[3].g
        b = FACTION_BAR_COLORS[3].b
        return r,g,b
    end
    if str == "Neutral" then
        r = FACTION_BAR_COLORS[4].r
        g = FACTION_BAR_COLORS[4].g
        b = FACTION_BAR_COLORS[4].b
        return r,g,b
    end
    if str == "Friendly" then
        r = FACTION_BAR_COLORS[5].r
        g = FACTION_BAR_COLORS[5].g
        b = FACTION_BAR_COLORS[5].b
        return r,g,b
    end
    if str == "Honored" then
        r = FACTION_BAR_COLORS[6].r
        g = FACTION_BAR_COLORS[6].g
        b = FACTION_BAR_COLORS[6].b
        return r,g,b
    end
    if str == "Revered" then
        r = FACTION_BAR_COLORS[7].r
        g = FACTION_BAR_COLORS[7].g
        b = FACTION_BAR_COLORS[7].b
        return r,g,b
    end
    if str == "Exalted" then
        r = FACTION_BAR_COLORS[8].r
        g = FACTION_BAR_COLORS[8].g
        b = FACTION_BAR_COLORS[8].b
        return r,g,b
    end
end

function GF_ToggleFactionDetails()
    if GF_FactionScrollFrame:IsShown() then
       GF_FactionScrollFrame:Hide()
       GF_FactionDetailsScrollFrame:Show()
    else
       GF_FactionViewFrame:Show()
       GF_FactionScrollFrame:Show()
       GF_FactionDetailsScrollFrame:Hide()
    end
end

function GF_FactionDetailsOnShow()
    --local faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    local faction = UIDropDownMenu_GetSelectedID(GF_FactionSelectMenu)
    
    if faction == nil then
        faction = 2
    end
    
    GF_CurrentFactionIndex = faction - 1
    GF_FactionDetailsFormName:SetText(GF_GuildFactions[GF_CurrentFactionIndex].title)    
    
    GF_FactionDetailsFormDescription:SetText(GF_GuildFactions[GF_CurrentFactionIndex].description)
    GF_FactionDetailsFormMoneyRepGold:SetText(GF_GuildFactions[GF_CurrentFactionIndex].goldtorep)
    GF_FactionDetailsFormBountyRepGold:SetText(GF_GuildFactions[GF_CurrentFactionIndex].bountytorep)
    GF_FactionDetailsFormRepairsRepGold:SetText(GF_GuildFactions[GF_CurrentFactionIndex].repairstorep)
    GF_FactionDetailsForm11:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[1][1])
    GF_FactionDetailsForm12:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[1][2])
    GF_FactionDetailsForm13:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[1][3])
    GF_FactionDetailsForm14:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[1][4])
    GF_FactionDetailsForm21:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[2][1])
    GF_FactionDetailsForm22:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[2][2])
    GF_FactionDetailsForm23:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[2][3])
    GF_FactionDetailsForm24:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[2][4])
    GF_FactionDetailsForm31:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[3][1])
    GF_FactionDetailsForm32:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[3][2])
    GF_FactionDetailsForm33:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[3][3])
    GF_FactionDetailsForm34:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[3][4])
    GF_FactionDetailsForm41:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[4][1])
    GF_FactionDetailsForm42:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[4][2])
    GF_FactionDetailsForm43:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[4][3])
    GF_FactionDetailsForm44:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[4][4])
    GF_FactionDetailsForm51:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[5][1])
    GF_FactionDetailsForm52:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[5][2])
    GF_FactionDetailsForm53:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[5][3])
    GF_FactionDetailsForm54:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[5][4])
    GF_FactionDetailsForm61:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[6][1])
    GF_FactionDetailsForm62:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[6][2])
    GF_FactionDetailsForm63:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[6][3])
    GF_FactionDetailsForm64:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[6][4])
    GF_FactionDetailsForm71:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[7][1])
    GF_FactionDetailsForm72:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[7][2])
    GF_FactionDetailsForm73:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[7][3])
    GF_FactionDetailsForm74:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[7][4])
    GF_FactionDetailsForm81:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[8][1])
    GF_FactionDetailsForm82:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[8][2])
    GF_FactionDetailsForm83:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[8][3])
    GF_FactionDetailsForm84:SetText(GF_GuildFactions[GF_CurrentFactionIndex].discount[8][4])
end
    
function GF_FactionDetailsOnSave()  
    if not CanEditPublicNote() then
        GF_LargessMessage("You do not have permission to change guild faction details.")
        return
    end
    
    --update global faction details
    local timestamp = time()
    for i = 1, GF_MAX_NUM_GUILD_FACTIONS do
        GF_GuildFactions[i].timestamp = timestamp
    end
    GF_GuildFactions[GF_CurrentFactionIndex].title = GF_FactionDetailsFormName:GetText()   
    GF_GuildFactions[GF_CurrentFactionIndex].description = GF_FactionDetailsFormDescription:GetText()  
    GF_GuildFactions[GF_CurrentFactionIndex].goldtorep = GF_FactionDetailsFormMoneyRepGold:GetText()
    GF_GuildFactions[GF_CurrentFactionIndex].bountytorep = GF_FactionDetailsFormBountyRepGold:GetText()
    GF_GuildFactions[GF_CurrentFactionIndex].repairstorep = GF_FactionDetailsFormRepairsRepGold:GetText()
    GF_GuildFactions[GF_CurrentFactionIndex].discount[1][1] = tonumber(GF_FactionDetailsForm11:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[1][2] = tonumber(GF_FactionDetailsForm12:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[1][3] = tonumber(GF_FactionDetailsForm13:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[1][4] = tonumber(GF_FactionDetailsForm14:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[2][1] = tonumber(GF_FactionDetailsForm21:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[2][2] = tonumber(GF_FactionDetailsForm22:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[2][3] = tonumber(GF_FactionDetailsForm23:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[2][4] = tonumber(GF_FactionDetailsForm24:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[3][1] = tonumber(GF_FactionDetailsForm31:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[3][2] = tonumber(GF_FactionDetailsForm32:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[3][3] = tonumber(GF_FactionDetailsForm33:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[3][4] = tonumber(GF_FactionDetailsForm34:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[4][1] = tonumber(GF_FactionDetailsForm41:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[4][2] = tonumber(GF_FactionDetailsForm42:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[4][3] = tonumber(GF_FactionDetailsForm43:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[4][4] = tonumber(GF_FactionDetailsForm44:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[5][1] = tonumber(GF_FactionDetailsForm51:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[5][2] = tonumber(GF_FactionDetailsForm52:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[5][3] = tonumber(GF_FactionDetailsForm53:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[5][4] = tonumber(GF_FactionDetailsForm54:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[6][1] = tonumber(GF_FactionDetailsForm61:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[6][2] = tonumber(GF_FactionDetailsForm62:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[6][3] = tonumber(GF_FactionDetailsForm63:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[6][4] = tonumber(GF_FactionDetailsForm64:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[7][1] = tonumber(GF_FactionDetailsForm71:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[7][2] = tonumber(GF_FactionDetailsForm72:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[7][3] = tonumber(GF_FactionDetailsForm73:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[7][4] = tonumber(GF_FactionDetailsForm74:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[8][1] = tonumber(GF_FactionDetailsForm81:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[8][2] = tonumber(GF_FactionDetailsForm82:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[8][3] = tonumber(GF_FactionDetailsForm83:GetText())
    GF_GuildFactions[GF_CurrentFactionIndex].discount[8][4] = tonumber(GF_FactionDetailsForm84:GetText())    
    
    --update local faction details
    GF_FactionData[GF_CurrentFactionIndex+1].name = GF_FactionDetailsFormName:GetText()
    GF_FactionData[GF_CurrentFactionIndex+1].description = GF_FactionDetailsFormDescription:GetText() 
   
    GF_FactionDetailsOnShow()
    GF_FactionSelectMenuInitialize()
    ReputationFrame_Update();
    --ReputationWatchBar_Update();
    
    --send update to the guild
    GF_DoSync() 
end

--decrement the number in the reputation edit box
function GF_RepBoxDecrement_OnClick()
    local pts = tonumber(GF_ReputationEditBox:GetText())
    
    if pts == nil or pts == "" then
        pts = 0
    end
    
    GF_ReputationEditBox:SetText(tostring(pts-1))
end

--increment the number in the reputation edit box
function GF_RepBoxIncrement_OnClick()
    local pts = tonumber(GF_ReputationEditBox:GetText())
    
    if pts == nil or pts == "" then
        pts = 0
    end
    
    GF_ReputationEditBox:SetText(tostring(pts+1))
end

function GF_FactionSortByGuildie(a,b)    
   if GF_SORT_FACTION_GUILDIE then      
      return a.name > b.name
   else      
      return a.name < b.name
   end
end

function GF_GetFactionIndexByName(name)
    local index
    
    for index = 1, #GF_GuildFactionData do
        if GF_GuildFactionData[index].name == name then
            return index
        end
    end 
    
    return nil
end

function GF_FactionSortByReputation(a,b)
    faction = UIDropDownMenu_GetSelectedValue(GF_FactionSelectMenu)
    
    if faction == GF_GuildFactions[1].title then
        --faction 1   
        if (a.rep1 == nil and b.rep1) then
            return false
        elseif (a.rep1 and b.rep1 == nil) then
            return true
        elseif (a.rep1 == nil and b.rep1 == nil) then
            return false
        end
        if (a.rep1 > b.rep1) then            
            if GF_SORT_FACTION_REP then
                return true        
            else
                return false
            end
        elseif (a.rep1 < b.rep1) then
            if GF_SORT_FACTION_REP then
                return false        
            else
                return true
            end       
        end
    elseif faction == GF_GuildFactions[2].title then
        --faction 2 
        if (a.rep2 == nil and b.rep2) then
            return false
        elseif (a.rep2 and b.rep2 == nil) then
            return true
        elseif (a.rep2 == nil and b.rep2 == nil) then
            return false
        end
        if (a.rep2 > b.rep2) then            
            if GF_SORT_FACTION_REP then
                return true        
            else
                return false
            end
        elseif (a.rep2 < b.rep2) then
            if GF_SORT_FACTION_REP then
                return false        
            else
                return true
            end       
        end
    elseif faction == GF_GuildFactions[3].title then
        --faction 3 
       if (a.rep3 == nil and b.rep3) then
            return false
        elseif (a.rep3 and b.rep3 == nil) then
            return true
        elseif (a.rep3 == nil and b.rep3 == nil) then
            return false
        end
       if (a.rep3 > b.rep3) then            
            if GF_SORT_FACTION_REP then
                return true        
            else
                return false
            end
        elseif (a.rep3 < b.rep3) then
            if GF_SORT_FACTION_REP then
                return false        
            else
                return true
            end       
        end
    elseif faction == GF_GuildFactions[4].title then
        --faction 4
        if (a.rep4 == nil and b.rep4) then
            return false
        elseif (a.rep4 and b.rep4 == nil) then
            return true
        elseif (a.rep4 == nil and b.rep4 == nil) then
            return false
        end
       if (a.rep4 > b.rep4) then            
            if GF_SORT_FACTION_REP then
                return true        
            else
                return false
            end
        elseif (a.rep4 < b.rep4) then
            if GF_SORT_FACTION_REP then
                return false        
            else
                return true
            end       
        end
    elseif faction == GF_GuildFactions[5].title then
        --faction 5
        if (a.rep5 == nil and b.rep5) then
            return false
        elseif (a.rep5 and b.rep5 == nil) then
            return true
        elseif (a.rep5 == nil and b.rep5 == nil) then
            return false
        end
       if (a.rep5 > b.rep5) then            
            if GF_SORT_FACTION_REP then
                return true        
            else
                return false
            end
        elseif (a.rep5 < b.rep5) then
            if GF_SORT_FACTION_REP then
                return false        
            else
                return true
            end       
        end
    end
end
  