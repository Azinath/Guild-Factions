GF_MAX_NUM_GUILD_FACTIONS = 5
GF_DEFAULT_START_REP = 42000

function GF_InitFactions()
    if GF_GuildFactions == nil then

       --define default factions
       GF_GuildFactions = {}
       GF_GuildFactions[1] = {}
       GF_GuildFactions[1].timestamp = 0
       GF_GuildFactions[1].title = "Bounty Hunters"
       GF_GuildFactions[1].leader = ""
       GF_GuildFactions[1].description = "Reputation with this guild faction is gained by claiming others' bounties.  Higher reputation levels are rewarded with discounts on placing bounties."
       GF_GuildFactions[1].start = "N"
       GF_GuildFactions[1].goldtorep = 0
       GF_GuildFactions[1].bountytorep = 25
       GF_GuildFactions[1].repairstorep = 0

       --define faction discounts (discount[replevel][type])
       GF_GuildFactions[1].discount = {}
       GF_GuildFactions[1].discount[1] = {}
       GF_GuildFactions[1].discount[2] = {}
       GF_GuildFactions[1].discount[3] = {}
       GF_GuildFactions[1].discount[4] = {}
       GF_GuildFactions[1].discount[5] = {}
       GF_GuildFactions[1].discount[6] = {}
       GF_GuildFactions[1].discount[7] = {}
       GF_GuildFactions[1].discount[8] = {}

       --money discount type = 1
       GF_GuildFactions[1].discount[1][1] = 0
       GF_GuildFactions[1].discount[2][1] = 0
       GF_GuildFactions[1].discount[3][1] = 0
       GF_GuildFactions[1].discount[4][1] = 0
       GF_GuildFactions[1].discount[5][1] = 0
       GF_GuildFactions[1].discount[6][1] = 10
       GF_GuildFactions[1].discount[7][1] = 25
       GF_GuildFactions[1].discount[8][1] = 50
       --repair discount type = 2
       GF_GuildFactions[1].discount[1][2] = 0
       GF_GuildFactions[1].discount[2][2] = 0
       GF_GuildFactions[1].discount[3][2] = 0
       GF_GuildFactions[1].discount[4][2] = 0
       GF_GuildFactions[1].discount[5][2] = 0
       GF_GuildFactions[1].discount[6][2] = 0
       GF_GuildFactions[1].discount[7][2] = 0
       GF_GuildFactions[1].discount[8][2] = 0
       --item discount type = 3
       GF_GuildFactions[1].discount[1][3] = 0
       GF_GuildFactions[1].discount[2][3] = 0
       GF_GuildFactions[1].discount[3][3] = 0
       GF_GuildFactions[1].discount[4][3] = 0
       GF_GuildFactions[1].discount[5][3] = 0
       GF_GuildFactions[1].discount[6][3] = 0
       GF_GuildFactions[1].discount[7][3] = 0
       GF_GuildFactions[1].discount[8][3] = 0
       --bounty discount type = 4
       GF_GuildFactions[1].discount[1][4] = 0
       GF_GuildFactions[1].discount[2][4] = 0
       GF_GuildFactions[1].discount[3][4] = 0
       GF_GuildFactions[1].discount[4][4] = 0
       GF_GuildFactions[1].discount[5][4] = 0
       GF_GuildFactions[1].discount[6][4] = 0
       GF_GuildFactions[1].discount[7][4] = 0
       GF_GuildFactions[1].discount[8][4] = 0


       GF_GuildFactions[2] = {}
       GF_GuildFactions[2].timestamp = 0
       GF_GuildFactions[2].title = "Guild Bankers"
       GF_GuildFactions[2].description = "A faction of guild bankers and bean counters.  Reputation is gained by depositing gold and items into the guild bank.  Higher reputation levels are rewarded with discounted guild bank transactions."
       GF_GuildFactions[2].goldtorep = 25
       GF_GuildFactions[2].bountytorep = 0
       GF_GuildFactions[2].repairstorep = 25
       
       --define faction discounts (discount[replevel][type])
       GF_GuildFactions[2].discount = {}
       GF_GuildFactions[2].discount[1] = {}
       GF_GuildFactions[2].discount[2] = {}
       GF_GuildFactions[2].discount[3] = {}
       GF_GuildFactions[2].discount[4] = {}
       GF_GuildFactions[2].discount[5] = {}
       GF_GuildFactions[2].discount[6] = {}
       GF_GuildFactions[2].discount[7] = {}
       GF_GuildFactions[2].discount[8] = {}
       --money discount type = 1
       GF_GuildFactions[2].discount[1][1] = 0
       GF_GuildFactions[2].discount[2][1] = 0
       GF_GuildFactions[2].discount[3][1] = 0
       GF_GuildFactions[2].discount[4][1] = 0
       GF_GuildFactions[2].discount[5][1] = 0
       GF_GuildFactions[2].discount[6][1] = 0
       GF_GuildFactions[2].discount[7][1] = 0
       GF_GuildFactions[2].discount[8][1] = 0
       --repair discount type = 2
       GF_GuildFactions[2].discount[1][2] = 0
       GF_GuildFactions[2].discount[2][2] = 0
       GF_GuildFactions[2].discount[3][2] = 0
       GF_GuildFactions[2].discount[4][2] = 0
       GF_GuildFactions[2].discount[5][2] = 0
       GF_GuildFactions[2].discount[6][2] = 0
       GF_GuildFactions[2].discount[7][2] = 0
       GF_GuildFactions[2].discount[8][2] = 0
       --item discount type = 3
       GF_GuildFactions[2].discount[1][3] = 0
       GF_GuildFactions[2].discount[2][3] = 0
       GF_GuildFactions[2].discount[3][3] = 0
       GF_GuildFactions[2].discount[4][3] = 0
       GF_GuildFactions[2].discount[5][3] = 10
       GF_GuildFactions[2].discount[6][3] = 25
       GF_GuildFactions[2].discount[7][3] = 50
       GF_GuildFactions[2].discount[8][3] = 100
       --bounty discount type = 4
       GF_GuildFactions[2].discount[1][4] = 0
       GF_GuildFactions[2].discount[2][4] = 0
       GF_GuildFactions[2].discount[3][4] = 0
       GF_GuildFactions[2].discount[4][4] = 0
       GF_GuildFactions[2].discount[5][4] = 0
       GF_GuildFactions[2].discount[6][4] = 0
       GF_GuildFactions[2].discount[7][4] = 0
       GF_GuildFactions[2].discount[8][4] = 0

       GF_GuildFactions[3] = {}
       GF_GuildFactions[3].timestamp = 0
       GF_GuildFactions[3].title = "Crafters"
       GF_GuildFactions[3].description = "Guild craftsmen who reward gatherers with discounted consumables from the guild bank."
       GF_GuildFactions[3].goldtorep = 0
       GF_GuildFactions[3].bountytorep = 0
       GF_GuildFactions[3].repairstorep = 0
       
       --define faction discounts (discount[replevel][type])
       GF_GuildFactions[3].discount = {}
       GF_GuildFactions[3].discount[1] = {}
       GF_GuildFactions[3].discount[2] = {}
       GF_GuildFactions[3].discount[3] = {}
       GF_GuildFactions[3].discount[4] = {}
       GF_GuildFactions[3].discount[5] = {}
       GF_GuildFactions[3].discount[6] = {}
       GF_GuildFactions[3].discount[7] = {}
       GF_GuildFactions[3].discount[8] = {}
       --money discount type = 1
       GF_GuildFactions[3].discount[1][1] = 0
       GF_GuildFactions[3].discount[2][1] = 0
       GF_GuildFactions[3].discount[3][1] = 0
       GF_GuildFactions[3].discount[4][1] = 0
       GF_GuildFactions[3].discount[5][1] = 0
       GF_GuildFactions[3].discount[6][1] = 0
       GF_GuildFactions[3].discount[7][1] = 0
       GF_GuildFactions[3].discount[8][1] = 0
       --repair discount type = 2
       GF_GuildFactions[3].discount[1][2] = 0
       GF_GuildFactions[3].discount[2][2] = 0
       GF_GuildFactions[3].discount[3][2] = 0
       GF_GuildFactions[3].discount[4][2] = 0
       GF_GuildFactions[3].discount[5][2] = 0
       GF_GuildFactions[3].discount[6][2] = 0
       GF_GuildFactions[3].discount[7][2] = 0
       GF_GuildFactions[3].discount[8][2] = 0
       --item discount type = 3
       GF_GuildFactions[3].discount[1][3] = 0
       GF_GuildFactions[3].discount[2][3] = 0
       GF_GuildFactions[3].discount[3][3] = 0
       GF_GuildFactions[3].discount[4][3] = 0
       GF_GuildFactions[3].discount[5][3] = 0
       GF_GuildFactions[3].discount[6][3] = 10
       GF_GuildFactions[3].discount[7][3] = 25
       GF_GuildFactions[3].discount[8][3] = 50
       --bounty discount type = 4
       GF_GuildFactions[3].discount[1][4] = 0
       GF_GuildFactions[3].discount[2][4] = 0
       GF_GuildFactions[3].discount[3][4] = 0
       GF_GuildFactions[3].discount[4][4] = 0
       GF_GuildFactions[3].discount[5][4] = 0
       GF_GuildFactions[3].discount[6][4] = 0
       GF_GuildFactions[3].discount[7][4] = 0
       GF_GuildFactions[3].discount[8][4] = 0

       GF_GuildFactions[4] = {}
       GF_GuildFactions[4].timestamp = 0
       GF_GuildFactions[4].title = "Gatherers"
       GF_GuildFactions[4].description = "Reputation is awarded for depositing herbs, ore, leather and other crafting materials."
       GF_GuildFactions[4].goldtorep = 0
       GF_GuildFactions[4].bountytorep = 0
       GF_GuildFactions[4].repairstorep = 0
       
       --define faction discounts (discount[replevel][type])
       GF_GuildFactions[4].discount = {}
       GF_GuildFactions[4].discount[1] = {}
       GF_GuildFactions[4].discount[2] = {}
       GF_GuildFactions[4].discount[3] = {}
       GF_GuildFactions[4].discount[4] = {}
       GF_GuildFactions[4].discount[5] = {}
       GF_GuildFactions[4].discount[6] = {}
       GF_GuildFactions[4].discount[7] = {}
       GF_GuildFactions[4].discount[8] = {}
       --money discount type = 1
       GF_GuildFactions[4].discount[1][1] = 0
       GF_GuildFactions[4].discount[2][1] = 0
       GF_GuildFactions[4].discount[3][1] = 0
       GF_GuildFactions[4].discount[4][1] = 0
       GF_GuildFactions[4].discount[5][1] = 0
       GF_GuildFactions[4].discount[6][1] = 0
       GF_GuildFactions[4].discount[7][1] = 0
       GF_GuildFactions[4].discount[8][1] = 0
       --repair discount type = 2
       GF_GuildFactions[4].discount[1][2] = 0
       GF_GuildFactions[4].discount[2][2] = 0
       GF_GuildFactions[4].discount[3][2] = 0
       GF_GuildFactions[4].discount[4][2] = 0
       GF_GuildFactions[4].discount[5][2] = 0
       GF_GuildFactions[4].discount[6][2] = 0
       GF_GuildFactions[4].discount[7][2] = 0
       GF_GuildFactions[4].discount[8][2] = 0
       --item discount type = 3
       GF_GuildFactions[4].discount[1][3] = 0
       GF_GuildFactions[4].discount[2][3] = 0
       GF_GuildFactions[4].discount[3][3] = 0
       GF_GuildFactions[4].discount[4][3] = 0
       GF_GuildFactions[4].discount[5][3] = 0
       GF_GuildFactions[4].discount[6][3] = 10
       GF_GuildFactions[4].discount[7][3] = 25
       GF_GuildFactions[4].discount[8][3] = 50
       --bounty discount type = 4
       GF_GuildFactions[4].discount[1][4] = 0
       GF_GuildFactions[4].discount[2][4] = 0
       GF_GuildFactions[4].discount[3][4] = 0
       GF_GuildFactions[4].discount[4][4] = 0
       GF_GuildFactions[4].discount[5][4] = 0
       GF_GuildFactions[4].discount[6][4] = 0
       GF_GuildFactions[4].discount[7][4] = 0
       GF_GuildFactions[4].discount[8][4] = 0

       GF_GuildFactions[5] = {}
       GF_GuildFactions[5].timestamp = 0
       GF_GuildFactions[5].title = "Raiders"
       GF_GuildFactions[5].description = "Guild raiders who discount repairs and other guild bank transactions."
       GF_GuildFactions[5].goldtorep = 0
       GF_GuildFactions[5].bountytorep = 0
       GF_GuildFactions[5].repairstorep = 0
       
       --define faction discounts (discount[replevel][type])
       GF_GuildFactions[5].discount = {}
       GF_GuildFactions[5].discount[1] = {}
       GF_GuildFactions[5].discount[2] = {}
       GF_GuildFactions[5].discount[3] = {}
       GF_GuildFactions[5].discount[4] = {}
       GF_GuildFactions[5].discount[5] = {}
       GF_GuildFactions[5].discount[6] = {}
       GF_GuildFactions[5].discount[7] = {}
       GF_GuildFactions[5].discount[8] = {}
       --money discount type = 1
       GF_GuildFactions[5].discount[1][1] = 0
       GF_GuildFactions[5].discount[2][1] = 0
       GF_GuildFactions[5].discount[3][1] = 0
       GF_GuildFactions[5].discount[4][1] = 0
       GF_GuildFactions[5].discount[5][1] = 0
       GF_GuildFactions[5].discount[6][1] = 0
       GF_GuildFactions[5].discount[7][1] = 0
       GF_GuildFactions[5].discount[8][1] = 0
       --repair discount type = 2
       GF_GuildFactions[5].discount[1][2] = 0
       GF_GuildFactions[5].discount[2][2] = 0
       GF_GuildFactions[5].discount[3][2] = 0
       GF_GuildFactions[5].discount[4][2] = 0
       GF_GuildFactions[5].discount[5][2] = 25
       GF_GuildFactions[5].discount[6][2] = 50
       GF_GuildFactions[5].discount[7][2] = 75
       GF_GuildFactions[5].discount[8][2] = 100
       --item discount type = 3
       GF_GuildFactions[5].discount[1][3] = 0
       GF_GuildFactions[5].discount[2][3] = 0
       GF_GuildFactions[5].discount[3][3] = 0
       GF_GuildFactions[5].discount[4][3] = 0
       GF_GuildFactions[5].discount[5][3] = 10
       GF_GuildFactions[5].discount[6][3] = 20
       GF_GuildFactions[5].discount[7][3] = 30
       GF_GuildFactions[5].discount[8][3] = 40
       --bounty discount type = 4
       GF_GuildFactions[5].discount[1][4] = 0
       GF_GuildFactions[5].discount[2][4] = 0
       GF_GuildFactions[5].discount[3][4] = 0
       GF_GuildFactions[5].discount[4][4] = 0
       GF_GuildFactions[5].discount[5][4] = 0
       GF_GuildFactions[5].discount[6][4] = 0
       GF_GuildFactions[5].discount[7][4] = 0
       GF_GuildFactions[5].discount[8][4] = 0
    end
end
--init public notes
function GF_FactionInit()
    local i, pnote, role1, role2   
    local rep1, rep2, rep3, rep4, rep01, rep02, rep03, rep04, rep05
    
    if GF_GuildMates == nil then 
       GuildRoster()
       return
    end
    
    GF_GuildFactionData = {}  
   
    for i = 1, #GF_GuildMates do 
        pnote = GF_GuildMates[i].pnote    
        rep01 = tonumber(string.sub(pnote,5,9))
        rep02 = tonumber(string.sub(pnote,10,14))
        rep03 = tonumber(string.sub(pnote,15,19))
        rep04 = tonumber(string.sub(pnote,20,24))
        rep05 = tonumber(string.sub(pnote,25,29))
        
        --stub for roles
        role1 = 0
        role2 = 0    
        
        rep01 = rep01 or GF_DEFAULT_START_REP
        rep02 = rep02 or GF_DEFAULT_START_REP
        rep03 = rep03 or GF_DEFAULT_START_REP
        rep04 = rep04 or GF_DEFAULT_START_REP
        rep05 = rep05 or GF_DEFAULT_START_REP
        
        table.insert(GF_GuildFactionData,{name=name,rep1=rep01,rep2=rep02,rep3=rep03,rep4=rep04,rep5=rep05}) 
    end
end

function GF_FactionLoad()
   local gnum = #GF_GuildMates
   local i, name, pnote, role1, role2, rep01, rep02, rep03, rep04, rep05 
   
    for i = 1,gnum do      
        name = GF_GuildMates[i].name      
        pnote = GF_GuildMates[i].pnote    
        rep01 = tonumber(string.sub(pnote,5,9))
        rep02 = tonumber(string.sub(pnote,10,14))
        rep03 = tonumber(string.sub(pnote,15,19))
        rep04 = tonumber(string.sub(pnote,20,24))
        rep05 = tonumber(string.sub(pnote,25,29))
        GF_GuildFactionData[i].name = name
        GF_GuildFactionData[i].rep1 = rep01
        GF_GuildFactionData[i].rep2 = rep02
        GF_GuildFactionData[i].rep3 = rep03
        GF_GuildFactionData[i].rep4 = rep04   
        GF_GuildFactionData[i].rep5 = rep05
    end     
end

function GF_FactionSave()
    local gnum = #GF_GuildMates
    local i, name, note, role1, role2, rep01, rep02, rep03, rep04, rep05
   
    --stub out roles for now
    role1 = 0
    role2 = 0
   
    for i = 1,gnum do         
        name = GF_GuildMates[i].name   
        local index = GF_GetFactionIndexByName(name)
        GF_GuildFactionData[index].name = name
        rep01 = GF_GuildFactionData[index].rep1 or GF_DEFAULT_START_REP
        rep02 = GF_GuildFactionData[index].rep2 or GF_DEFAULT_START_REP
        rep03 = GF_GuildFactionData[index].rep3 or GF_DEFAULT_START_REP
        rep04 = GF_GuildFactionData[index].rep4 or GF_DEFAULT_START_REP     
        rep05 = GF_GuildFactionData[index].rep5 or GF_DEFAULT_START_REP
        pnote = string.format("%2d%2d%5d%5d%5d%5d%5d",role1,role2,rep01 or 0,rep02 or 0,rep03 or 0,rep04 or 0, rep05 or 0)   
        GuildRosterSetPublicNote(i, pnote)
    end 
    
    GF_FactionSaveFlag = true
    --GuildRoster()
end
    
--set the guild faction for a player
function GF_FactionGetRep(player, rep1, rep2, rep3, rep4, rep5)
    local pnote, role1, role2
    local rep01, rep02, rep03, rep04, rep05
            
    --GuildRoster()
    
    if GF_GuildFactionData == nil then        
       GuildRoster()
       return
    end
    
    rep01, rep02, rep03, rep04, rep05 = GF_FactionGetRep(player)
    
    --stub for roles
    role1 = 0
    role2 = 0    
    
    local index = GF_GetFactionIndexByName(player)
    
    GF_GuildFactionData[index].rep1 = floor(rep1 or rep01)
    GF_GuildFactionData[index].rep2 = floor(rep2 or rep02)
    GF_GuildFactionData[index].rep3 = floor(rep3 or rep03)
    GF_GuildFactionData[index].rep4 = floor(rep4 or rep04)
    GF_GuildFactionData[index].rep5 = floor(rep5 or rep05)  
    
    GF_FactionSave()
    
    local msg = GF_GuildFactionData[index].rep1..","..GF_GuildFactionData[index].rep2..","..GF_GuildFactionData[index].rep3..","..GF_GuildFactionData[index].rep4..","..GF_GuildFactionData[index].rep5
    ChatThrottleLib:SendAddonMessage("BULK","GF_SET_REP", msg, "WHISPER", player)    
    
    --GF_LargessMessage("Set rep: "..player..":"..GF_GuildFactionData[index].rep1..":"..GF_GuildFactionData[index].rep2..":"..GF_GuildFactionData[index].rep3..":"..GF_GuildFactionData[index].rep4..":"..GF_GuildFactionData[index].rep5)
end    

--set the guild faction reputation for entire guild
function GF_FactionSetRepGuild(rep1, rep2, rep3, rep4, rep5)
    local pnote, role1, role2
    local rep01, rep02, rep03, rep04, rep05
    local i
    
    --GuildRoster()
    
    if GF_GuildFactionData == nil then        
       GuildRoster()
       return
    end   
    
    --set public notes
    for i = 1, #GF_GuildMates do
        player = GF_GuildMates[i].name
        rep01, rep02, rep03, rep04, rep05 = GF_FactionGetRep(player)
        GF_GuildFactionData[i].name = player
        GF_GuildFactionData[i].rep1 = floor(rep1 or rep01)
        GF_GuildFactionData[i].rep2 = floor(rep2 or rep02)
        GF_GuildFactionData[i].rep3 = floor(rep3 or rep03)
        GF_GuildFactionData[i].rep4 = floor(rep4 or rep04)
        GF_GuildFactionData[i].rep5 = floor(rep5 or rep05)  
    end
    
    GF_FactionSave()
    
    --send message to guild to update local reps
    i = 1
    local msg = GF_GuildFactionData[i].rep1..","..GF_GuildFactionData[i].rep2..","..GF_GuildFactionData[i].rep3..","..GF_GuildFactionData[i].rep4..","..GF_GuildFactionData[i].rep5
    ChatThrottleLib:SendAddonMessage("BULK","GF_SET_REP", msg, "GUILD")    
    
    GF_LargessMessage("Set rep: GUILD:"..GF_GuildFactionData[i].rep1..":"..GF_GuildFactionData[i].rep2..":"..GF_GuildFactionData[i].rep3..":"..GF_GuildFactionData[i].rep4..":"..GF_GuildFactionData[i].rep5)
    --pnote = string.format("%2d%2d%5d%5d%5d%5d",role1,role2,rep01,rep02,rep03,rep04)
    --GF_LargessMessage(pnote)
    --GuildRosterSetPublicNote(iplayer, pnote)
end    

--extract guild faction reps from public note
function GF_FactionGetRep(player)
    local index
    
    for index = 1, #GF_GuildFactionData do
        if GF_GuildFactionData[index].name == player then
            local rep1 = GF_GuildFactionData[index].rep1 or GF_DEFAULT_START_REP
            local rep2 = GF_GuildFactionData[index].rep2 or GF_DEFAULT_START_REP
            local rep3 = GF_GuildFactionData[index].rep3 or GF_DEFAULT_START_REP
            local rep4 = GF_GuildFactionData[index].rep4 or GF_DEFAULT_START_REP
            local rep5 = GF_GuildFactionData[index].rep5 or GF_DEFAULT_START_REP
            return rep1,rep2,rep3,rep4,rep5
        end
    end
    
    return GF_DEFAULT_START_REP,GF_DEFAULT_START_REP,GF_DEFAULT_START_REP,GF_DEFAULT_START_REP,GF_DEFAULT_START_REP
end

--add a guild faction
function GF_AddGuildFaction(faction)
   --guild faction data
   --faction.timestamp (time of last faction data change)
   --faction.title (name of faction)
   --faction.leader (name of faction leader)
   --faction.description (description text)
   --faction.start (e.g. Neutral, Friendly)
   --faction.bonuses (table of bonuses per rep level)
   
   --check guild faction limit
   if #GF_GuildFactions >= GF_MAX_NUM_GUILD_FACTIONS then
      GF_LargessMessage("Cannot have more than "..GF_MAX_NUM_GUILD_FACTIONS.." guild factions.")
      return
   end    
   
   faction.timestamp = time()
   table.insert(GF_GuildFactions,faction)
   GF_UpdateGuildFactions()
end

--remove a guild faction
function GF_DelGuildFaction(index)
   table.remove(GF_GuildFactions, index)
   GF_UpdateGuildFactions()
end

--officer broadcast of updated guild faction data to guild
function GF_UpdateGuildFactions()
   local i, fmsg, bmsg
   
   if GF_GuildFactions == nil then
      return
   end
   
   for i = 1,GF_MAX_NUM_GUILD_FACTIONS do
      if GF_GuildFactions[i] == nil then
         return
      else
         fmsg, bmsg = GF_FactionToString(i)
         ChatThrottleLib:SendAddonMessage("NORMAL","GBL_FACTION_UPDATE", fmsg, "GUILD")
         ChatThrottleLib:SendAddonMessage("NORMAL","GBL_FBONUS_UPDATE", bmsg, "GUILD")
      end
   end
end

--pack faction data into two strings
function GF_FactionToString(index)
   if GF_GuildFactions == nil then
      return
   end
   
   if GF_GuildFactions[index] == nil then
      return
   end
   
   local fmsg, bmsg, i, n, typ, amount, rep
   
   fmsg = GF_GuildFactions[index].timestamp..","..GF_GuildFactions[index].leader..","
   fmsg = fmsg..GF_GuildFactions[index].description..","..GF_GuildFactions[index].start
   
   --bonuses to string
   bmsg = index..","..#GF_GuildFactions[index].bonus
   for i = 1,#GF_GuildFactions[index].bonus do
      typ = GF_GuildFactions[index].bonus[i].type
      amount = GF_GuildFactions[index].bonus[i].amount
      rep = GF_GuildFactions[index].bonus[i].rep
      bmsg = bmsg..","..typ..","..amount..","..rep
   end 
   
   return fmsg, bmsg    
end

--converts total grp to rep level and pts
function GF_GrpToRepLevel(grp)	
	local pts
    
    if grp == nil then             
        grp = 0
    end       
    
    grp = tonumber(grp)
    
	if grp > 84999 then
		return "Exalted", 999, 999
	elseif grp >= 84000 then
		pts = grp - 84000
		return "Exalted", pts, 999
	elseif grp >= 63000 then
		pts = grp - 63000
		return "Revered", pts, 21000
	elseif grp >= 51000 then
		pts = grp - 51000
		return "Honored", pts, 12000
	elseif grp >= 45000 then
		pts = grp - 45000
		return "Friendly", pts, 6000
    elseif grp >= 42000 then
		pts = grp - 42000
		return "Neutral", pts, 3000
    elseif grp >= 39000 then
		pts = grp - 39000
		return "Unfriendly", pts, 3000
	elseif grp >= 36000 then
        pts = grp - 36000
		return "Hostile", pts, 3000
    elseif grp >= 0 then
        return "Hated", grp, 36000
    else 
        return "Hated", 0, 36000
	end
end

--returns the rep level number (1-8)
function GF_GrpToRepLevelNumber(grp)
    local pts
    
    if grp == nil then   
        gf_debug("grp is nil")   
        grp = 0
    end       
    
    grp = tonumber(grp)
    
    --gf_debug("grp:"..grp)
    
	if grp >= 84000 then		
		return 8
	elseif grp >= 63000 then		
		return 7
	elseif grp >= 51000 then
		return 6
	elseif grp >= 45000 then
		return 5
    elseif grp >= 42000 then
		return 4
    elseif grp >= 39000 then
		return 3
	elseif grp >= 36000 then
        return 2
    elseif grp >= 0 then
        return 1
    else 
        return 1
	end
end  

--converts rep level and pts to total grp
function GF_RepLevelToGrp(level, pts)
    local grp 
    
    if pts == nil then
        pts = 0
    end
  
    --pts = tonumber(pts)
    
    if level == "Exalted" then
        return 84000 + pts
    elseif level == "Revered" then
        return 63000 + pts
    elseif level == "Honored" then
        return 51000 + pts
    elseif level == "Friendly" then
        return 45000 + pts
    elseif level == "Neutral" then
        return 42000 + pts
    elseif level == "Unfriendly" then
        return 39000 + pts
    elseif level == "Hostile" then
        return 36000 + pts
    elseif level == "Hated" then
        return pts
    else
        return 0
    end       
end

function GF_GetFactionItemRep(item)
    local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(item)
    
    --check item largess table
    for i = 1, #GF_ItemLargess do
    
        --gf_debug(GF_ItemLargess[i].item..":"..item)
        
        if GF_ItemLargess[i].item == link then
            return GF_ItemLargess[i].rep1 or 0, GF_ItemLargess[i].rep2 or 0, GF_ItemLargess[i].rep3 or 0, GF_ItemLargess[i].rep4 or 0, GF_ItemLargess[i].rep5 or 0
        end
    end
    
    --not in table so use vendor price for rep
    if vendorPrice ~= nil then
        return math.floor(GF_GuildFactions[1].goldtorep*vendorPrice/10000), math.floor(GF_GuildFactions[2].goldtorep*vendorPrice/10000), math.floor(GF_GuildFactions[3].goldtorep*vendorPrice/10000), math.floor(GF_GuildFactions[4].goldtorep*vendorPrice/10000), math.floor(GF_GuildFactions[5].goldtorep*vendorPrice/10000)
    else
        return 0,0,0,0,0
    end
end

--bounty claim rep
function GF_FactionAdjustBountyRep(name, amount)
    --update faction reputation
    local rep1, rep2, rep3, rep4, rep5 = GF_FactionGetRep(name)            
    rep1 = rep1 + amount*(GF_GuildFactions[1].bountytorep or 0)/10000       
    rep2 = rep2 + amount*(GF_GuildFactions[2].bountytorep or 0)/10000
    rep3 = rep3 + amount*(GF_GuildFactions[3].bountytorep or 0)/10000
    rep4 = rep4 + amount*(GF_GuildFactions[4].bountytorep or 0)/10000
    rep5 = rep5 + amount*(GF_GuildFactions[5].bountytorep or 0)/10000
    GF_FactionGetRep(name, rep1, rep2, rep3, rep4, rep5)
end

--money transaction rep
function GF_FactionAdjustMoneyRep(name, amount)
    --ensure player is still in the guild
    if name == nil or not GF_UnitIsInMyGuild(name) then
        return
    end
    
    --update faction reputation
    local rep1, rep2, rep3, rep4, rep5 = GF_FactionGetRep(name)            
    rep1 = rep1 + amount*(GF_GuildFactions[1].goldtorep or 0)/10000       
    rep2 = rep2 + amount*(GF_GuildFactions[2].goldtorep or 0)/10000
    rep3 = rep3 + amount*(GF_GuildFactions[3].goldtorep or 0)/10000
    rep4 = rep4 + amount*(GF_GuildFactions[4].goldtorep or 0)/10000
    rep5 = rep5 + amount*(GF_GuildFactions[5].goldtorep or 0)/10000
    GF_FactionGetRep(name, rep1, rep2, rep3, rep4, rep5)
end

function GF_DiscountTransByRep(amount,ttype,item)
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
    
    local rep01,rep02,rep03,rep04,rep05
    local lvl01,lvl02,lvl03,lvl04,lvl05
    local disc = 0
    local name
	local realm
	local fullName
	
	name = GF_GetFullName("player")	
    rep01,rep02,rep03,rep04,rep05 = GF_FactionGetRep(name)
    lvl01 = GF_GrpToRepLevelNumber(rep01)
    lvl02 = GF_GrpToRepLevelNumber(rep02)
    lvl03 = GF_GrpToRepLevelNumber(rep03)
    lvl04 = GF_GrpToRepLevelNumber(rep04)
    lvl05 = GF_GrpToRepLevelNumber(rep05)
    
    --add up discounts for all factions    
    disc = GF_GuildFactions[1].discount[lvl01][ttype]*irep1
    disc = disc + GF_GuildFactions[2].discount[lvl02][ttype]*irep2
    disc = disc + GF_GuildFactions[3].discount[lvl03][ttype]*irep3
    disc = disc + GF_GuildFactions[4].discount[lvl04][ttype]*irep4
    disc = disc + GF_GuildFactions[5].discount[lvl05][ttype]*irep5
        
    gf_debug("Discount type: "..ttype.." Amount: "..disc)
        
    return amount - floor(amount*(disc/100))
    
end

--set guild rep for entire guild or group
function GF_SetGuildRep(dest, faction, level, rep)   

    gf_debug("SetGuildRep Faction: "..faction)
    
    --check permissions
    if not CanEditPublicNote() then
        GF_LargessMessage("You do not have permission to edit public notes.")
        return
    end
    
    local player, nr, np, i    
    local grp = GF_RepLevelToGrp(level, rep)  
    
    if dest == "guild" or dest == "Guild" then       
        if faction == 1 then
            GF_FactionSetRepGuild(grp, nil, nil, nil, nil)
        elseif faction == 2 then
            GF_FactionSetRepGuild(nil, grp, nil, nil, nil)
        elseif faction == 3 then            
            GF_FactionSetRepGuild(nil, nil, grp, nil, nil)
        elseif faction == 4 then            
            GF_FactionSetRepGuild(nil, nil, nil, grp, nil)
        elseif faction == 5 then            
            GF_FactionSetRepGuild(nil, nil, nil, nil, grp)
        end        
    elseif dest == "raid" or dest == "Raid" then
        --raid
        local nr = GetNumRaidMembers()        
        if nr > 0 then            
            for i = 1, nr do
                player, _, _, _, _, _, _, online, _, _, _ = GetRaidRosterInfo(i)
                if GF_UnitIsInMyGuild(player) and player ~= GF_GetFullName("player") and online then
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
                end
            end 
        end
        
    elseif dest == "party" or dest == "Party" then
        local np = GetNumPartyMembers()
        if np > 0 then         
            --party
            for i = 1, np do
                player = UnitName("party"..i)
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
            end
        end
    end  
    
    GF_FactionFrameUpdate()
end
	