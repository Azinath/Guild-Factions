function GF_Message(msg)
   --SendChatMessage(msg, GF_Config["channel"], nil)
   if GF_Config["channel"] == "PRIVATE" then
      ChatFrame1:AddMessage(msg,0,1,0);
   else
      ChatThrottleLib:SendChatMessage("NORMAL", "GBH", msg, GF_Config["channel"], nil, nil);
   end
end

function gf_debug(msg)
    if GF_Config == nil then
        return
    end
    if GF_Config["debug"] then
       ChatFrame1:AddMessage(msg,0,1,0);
    end
end

function GF_Msg(msg)
   if GF_FilterFormCheckGuild:GetChecked() then
      ChatThrottleLib:SendChatMessage("NORMAL", "GBH", msg, "GUILD", nil, nil);
   end
   
   if GF_FilterFormCheckSay:GetChecked() then
      ChatThrottleLib:SendChatMessage("NORMAL", "GBH", msg, "SAY", nil, nil);
   end
end
   
function GF_LargessMessage(msg,color)   
   if (color == nil) or (color == "GREEN") or (color == "green") then 
      --default color is green
      DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 1, 0);
   elseif (color == "RED") or (color == "red") then
      --here's red
      DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 0, 0);
   elseif (color == "sys") then
      --yellow?
      DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0);
   elseif (color == "rep") then
      DEFAULT_CHAT_FRAME:AddMessage(msg, GetMessageTypeColor("CHAT_MSG_COMBAT_FACTION_CHANGE"));
   end   
end