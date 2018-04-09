function GF_Commands(args)  
   local s,e,cmd,arg1,arg2,arg3,arg4 = string.find(args,"(%a*)%s?([.?%a%d]*)%s?([.?%a%d]*)%s?([.?%a%d-?]*)%s?([.?%a%d-?]*)")    
   
   --debug
   if cmd == "debug" then
      if arg1 == "on" then
         GF_Config["debug"] = true
         GF_LargessMessage("GBH: debug on")
      elseif arg1 == "off" then
         GF_Config["debug"] = false
         GF_LargessMessage("GBH: debug off")
      end    

    --show the GUI
    elseif cmd == "show" then
        GF_ToggleHitList() 
      
   --resync hit list
   elseif cmd == "sync" then     
      ChatThrottleLib:SendAddonMessage("ALERT","GF_SYNC_REQ", "", "GUILD");    
    
   --version
   elseif cmd == "version" then
      GF_LargessMessage("Guild Factions v"..GF_VERSION);
     
    --set UI scale
    elseif cmd == "scale" then
        if arg1 ~= nil then
            GF_Config["scale"] = arg1
            GF_HitListFrame:SetScale(arg1)
        end 
        
    --set reputations for guild groups
    elseif cmd == "setrep" then
        if arg1 == nil or arg2 == nil or arg3 == nil then
            GF_Help(cmd)
        else
            gf_debug("setrep: "..arg1.." "..arg2.." "..arg3.." "..arg4)
            GF_SetGuildRep(arg1, tonumber(arg2), arg3, tonumber(arg4))
        end  
		
    --public notes: save, load, list
    elseif cmd == "pnotes" then
        if arg1 == "save" and arg2 ~= nil then
            GF_SavePublicNotes(arg2)
        elseif arg1 == "load" and arg2 ~= nil then
            GF_LoadPublicNotes(arg2)
        elseif arg1 == "list" then
            GF_ListSavedPublicNotes()
        else
            GF_Help(cmd)
        end
   
   --help
   elseif cmd == "help" then
      GF_Help(arg1)    
   else 
      GF_Help()
   end
end
    
function GF_SavePublicNotes(tag)
    if GF_PublicNotes == nil then
        GF_PublicNotes = {}
    end
    
    if GF_GuildMates == nil then
        GuildRoster()
        GF_LargessMessage("Please open the guild roster.")
        return;
    end
    
    local timestamp = time()    
    local pnotes = {}    
    table.insert(GF_PublicNotes, {tag=tag, timestamp=timestamp, pnotes=pnotes})
    local i
    local n = #GF_PublicNotes
    
    for i = 1,#GF_GuildMates do
        table.insert(GF_PublicNotes[n].pnotes, {name=GF_GuildMates[i].name, note=GF_GuildMates[i].pnote})
        GF_LargessMessage(GF_GuildMates[i].name.. ":" .. GF_GuildMates[i].pnote)
    end
    
    GF_LargessMessage("Saved public notes as: " .. tag)
end

function GF_LoadPublicNotes(tag)
    if GF_PublicNotes == nil then
        GF_LargessMessage("There are no saved public notes.")
        return;
    end
    
    local pnotes = {}
    local i
    local n = #GF_PublicNotes
    
    for i = 1,n do
        if GF_PublicNotes[i].tag == tag then
            pnotes = GF_PublicNotes[i].pnotes
            break
        end
    end
    
    if pnotes == {} then
        GF_LargessMessage("There are no saved public notes named: "..tag)
        return
    end
    
    if GF_GuildMates == nil then
        GuildRoster()
        GF_LargessMessage("Please open the guild roster.")
        return;
    end
    
    local gnum = #GF_GuildMates        
    local numnotes = #pnotes
    local j
    
    for i = 1,gnum do
       for j = 1,numnotes do
           if GF_GuildMates[i].name == pnotes[j].name then
                GuildRosterSetPublicNote(i,pnotes[j].note)
                GF_LargessMessage(GF_GuildMates[i].name.. ":" .. pnotes[j].note)
                break
           end
       end           
    end
    GF_LargessMessage("Loaded public notes: " .. tag)
    GuildRoster()
end

function GF_ListSavedPublicNotes()
    if GF_PublicNotes == nil then
        GF_LargessMessage("There are no saved public notes.")
        return;
    end
    
    local n = #GF_PublicNotes
    local i
    
    GF_LargessMessage("Saved public notes...")
    
    for i = 1,n do
        GF_LargessMessage(GF_PublicNotes[i].tag.." "..SecondsToTime(time()-GF_PublicNotes[i].timestamp).." ago")
    end
end
