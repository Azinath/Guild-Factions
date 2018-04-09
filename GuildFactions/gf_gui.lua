----------------------
--  Minimap Button  --
----------------------
do
	local dragMode = nil
	
	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = math.abs(x), math.abs(y)
			centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
			centerX = x < 0 and -centerX or centerX
			centerY = y < 0 and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local button = CreateFrame("Button", "GBHMinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", -65.35, -38.8)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("interface\\icons\\Achievement_General_DungeonDiplomat")
	button:SetPushedTexture("interface\\icons\\Achievement_General_DungeonDiplomat")
	--button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	button:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and IsAltKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)        
		end
	end)
	button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)
	button:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() then return end        
        GF_ToggleHitList()
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText("Guild Factions")
        GameTooltip:AddLine("Left Click to toggle the Guild Factions window",1,1,1)        
        GameTooltip:AddLine("Shift+Click to move this button on the minimap",1,1,1)
        GameTooltip:AddLine("Shift+Alt+Click to move this button anywhere",1,1,1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	function GF_ToggleMinimapButton()
		self.Options.ShowMinimapButton = not self.Options.ShowMinimapButton
		if self.Options.ShowMinimapButton then
			button:Show()
		else
			button:Hide()
		end
	end

	function GF_HideMinimapButton()
		return button:Hide()
	end
end

function GF_ToggleHitList()
    if (GF_HitListFrame:IsShown()) then
        GF_HitListFrame:Hide();
    else
        GF_HitListFrame:Show();
    end
end

function GF_CreateGUI()
   local i,frame,textString,moneyFrame   
   
   --Set Column Header Widths (kludgey adaptation to 4.0.1 guild roster)  
   --faction view
   GF_FactionColumnHeaderGuildieMiddle:SetWidth(150-9)
   GF_FactionColumnHeaderReputationMiddle:SetWidth(161-9)
      
   --GF_UIFrame:SetScript("OnShow",GF_UIShow)  
   GF_FactionViewFrame:SetPoint("TOPLEFT",5,2)   
   
end

function GF_CreateFriendsTab()   
   FriendsFrameTab6 = CreateFrame("Button", "FriendsFrameTab" ..6, FriendsFrame, "FriendsFrameTabTemplate");
   FriendsFrameTab6:SetPoint("LEFT", "FriendsFrameTab" .. 5, "RIGHT", -14, 0);
   FriendsFrameTab6:SetID(6);
   PanelTemplates_SetNumTabs(FriendsFrame, 6);
   PanelTemplates_UpdateTabs(FriendsFrame);
   FriendsFrameTab6:SetPoint("LEFT", "FriendsFrameTab" .. 5, "RIGHT", -14, 0);
   FriendsFrameTab6:SetText("GBH")
   TabID = 6

   -- add ourself to the subframe list....
   tinsert(FRIENDSFRAME_SUBFRAMES, "GF_UIFrame");

   hooksecurefunc("FriendsFrame_Update", GF_FriendsFrame_Update);
end

function GF_FriendsFrame_Update()
   if(FriendsFrame.selectedTab == 6) then
      FriendsFrameTitleText:SetText("Guild Factions");
      if(GF_UIFrame:IsVisible()) then
         return;
      end
      FriendsFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
      FriendsFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
      FriendsFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\GuildFrame-BotLeft");      
      FriendsFrameBottomRight:SetTexture("Interface\\FriendsFrame\\GuildFrame-BotRight");
      
      --GF_UIFrame:ScrollFrameUpdate();
      GF_UIFrame:SetParent("FriendsFrame");
      GF_UIFrame:SetAllPoints();
      GF_UIFrame:Show();
      
      FriendsFrame_ShowSubFrame("NonExistingFrame"); -- so all friendframe tabs get hidden  
      FriendsFrame_ShowSubFrame("GF_UIFrame")
   end
end

function GF_DelayScript(script,delay,id)   
   if id == nil then
      id = "GF_TimerFrame"
   else
      id = "GF_TimerFrame"..id
   end
   local f = CreateFrame("Frame",id,UIParent)
   local stop = time() + delay
   f:SetScript("OnUpdate",function() GF_TimerUpdate(stop,f,script) end)   
end

function GF_TimerUpdate(stop,self,script)   
   local t = time()    
   if t >= stop then       
      self:SetScript("OnUpdate",nil)
      RunScript(script)
   end   
end

function GF_GuiUpdate()     
    if GBL_Largess == nil then
        return
    end
    local largess = GBL_Largess 
    if largess < 0 then 
      largess = abs(largess)
      GF_NegLargess:Show()
    else 
      GF_NegLargess:Hide()
    end
      --GF_LargessMessage(largess)
      MoneyFrame_Update(GF_LargessAmountFrame, largess);      
end

function GF_EnterFactionViewButton(self)
    --GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine("Guild Factions")
    GameTooltip:AddLine("List member reputations with each guild faction",1,1,1)
    GameTooltip:Show()
end

function GF_LeaveFactionViewButton()
    GameTooltip:Hide()
end

function GF_LeaveFactionDetailsButton()
    GameTooltip:Hide()
end

function GF_EnterConfigButton(self)
    --GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine("Configuration")
    GameTooltip:AddLine("Change some GBH settings",1,1,1)
    GameTooltip:Show()
end

function GF_LeaveConfigButton()
    GameTooltip:Hide()
end