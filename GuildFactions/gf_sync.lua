function GF_DoUpdateDescription(msg)  
    local timestamp, faction, desc
  
    timestamp, faction, desc = string.split(":", msg)  
    timestamp = tonumber(timestamp)
    faction = tonumber(faction)
    if timestamp > GF_GuildFactions[faction].timestamp then
        GF_GuildFactions[faction].description = desc
        GF_GuildFactions[faction].timestamp = timestamp
        
        gf_debug("Update: "..msg)
        
    end    
end

--update faction title, gold to rep, bounty to rep and repairs to rep
function GF_DoUpdateTitle(msg)
    local timestamp, faction, title, goldtorep, bountytorep, repairstorep
    
    timestamp, faction, title, goldtorep, bountytorep, repairstorep = string.split(",", msg)
    timestamp = tonumber(timestamp)
    faction = tonumber(faction)
    if timestamp > GF_GuildFactions[faction].timestamp then
        GF_GuildFactions[faction].title = title
        GF_GuildFactions[faction].timestamp = timestamp
        GF_GuildFactions[faction].goldtorep = tonumber(goldtorep)
        GF_GuildFactions[faction].bountytorep = tonumber(bountytorep)
        GF_GuildFactions[faction].repairstorep = tonumber(repairstorep)        
        
        gf_debug("Update: "..msg)
        
    end   
end

function GF_DoUpdateDiscounts(msg)
    local timestamp, faction, discount
    
    timestamp, faction, discount = string.split(",", msg)
    timestamp = tonumber(timestamp)
    faction = tonumber(faction)
    local d11,d12,d13,d14,d21,d22,d23,d24,d31,d32,d33,d34,d41,d42,d43,d44,d51,d52,d53,d54,d61,d62,d63,d64,d71,d72,d73,d74,d81,d82,d83,d84 = string.split(":", discount)
    if timestamp > GF_GuildFactions[faction].timestamp then
        GF_GuildFactions[faction].discount[1][1] = tonumber(d11)
        GF_GuildFactions[faction].discount[1][2] = tonumber(d12)
        GF_GuildFactions[faction].discount[1][3] = tonumber(d13)
        GF_GuildFactions[faction].discount[1][4] = tonumber(d14)
        GF_GuildFactions[faction].discount[2][1] = tonumber(d21)
        GF_GuildFactions[faction].discount[2][2] = tonumber(d22)
        GF_GuildFactions[faction].discount[2][3] = tonumber(d23)
        GF_GuildFactions[faction].discount[2][4] = tonumber(d24)
        GF_GuildFactions[faction].discount[3][1] = tonumber(d31)
        GF_GuildFactions[faction].discount[3][2] = tonumber(d32)
        GF_GuildFactions[faction].discount[3][3] = tonumber(d33)
        GF_GuildFactions[faction].discount[3][4] = tonumber(d34)
        GF_GuildFactions[faction].discount[4][1] = tonumber(d41)
        GF_GuildFactions[faction].discount[4][2] = tonumber(d42)
        GF_GuildFactions[faction].discount[4][3] = tonumber(d43)
        GF_GuildFactions[faction].discount[4][4] = tonumber(d44)
        GF_GuildFactions[faction].discount[5][1] = tonumber(d51)
        GF_GuildFactions[faction].discount[5][2] = tonumber(d52)
        GF_GuildFactions[faction].discount[5][3] = tonumber(d53)
        GF_GuildFactions[faction].discount[5][4] = tonumber(d54)
        GF_GuildFactions[faction].discount[6][1] = tonumber(d61)
        GF_GuildFactions[faction].discount[6][2] = tonumber(d62)
        GF_GuildFactions[faction].discount[6][3] = tonumber(d63)
        GF_GuildFactions[faction].discount[6][4] = tonumber(d64)
        GF_GuildFactions[faction].discount[7][1] = tonumber(d71)
        GF_GuildFactions[faction].discount[7][2] = tonumber(d72)
        GF_GuildFactions[faction].discount[7][3] = tonumber(d73)
        GF_GuildFactions[faction].discount[7][4] = tonumber(d74)
        GF_GuildFactions[faction].discount[8][1] = tonumber(d81)
        GF_GuildFactions[faction].discount[8][2] = tonumber(d82)
        GF_GuildFactions[faction].discount[8][3] = tonumber(d83)
        GF_GuildFactions[faction].discount[8][4] = tonumber(d84)  
        
        gf_debug("Update: "..msg)
        
    end   
end

--send all guild faction data to the guild
function GF_DoSync()   
    local timestamp, faction, title, goldtorep, bountytorep, repairstorep, description, msg
    local d11,d12,d13,d14,d21,d22,d23,d24,d31,d32,d33,d34,d41,d42,d43,d44,d51,d52,d53,d54,d61,d62,d63,d64,d71,d72,d73,d74,d81,d82,d83,d84
           
    for  faction = 1, GF_MAX_NUM_GUILD_FACTIONS do        
        --faction title message       
        timestamp = tostring(GF_GuildFactions[faction].timestamp)
        title = GF_GuildFactions[faction].title
        description = GF_GuildFactions[faction].description
        goldtorep = tostring(GF_GuildFactions[faction].goldtorep)
        bountytorep = tostring(GF_GuildFactions[faction].bountytorep)
        repairstorep = tostring(GF_GuildFactions[faction].repairstorep)
        
        msg = timestamp..","..tostring(faction)..","..title..","..goldtorep..","..bountytorep..","..repairstorep      
        gf_debug("Send: "..msg)                 
        ChatThrottleLib:SendAddonMessage("BULK","GF_UPDATE_1",msg,"GUILD");
        
        --faction description message
        msg = timestamp..":"..tostring(faction)..":"..description        
        gf_debug("Send: "..msg)       
        ChatThrottleLib:SendAddonMessage("BULK","GF_UPDATE_2",msg,"GUILD");
        
        --faction discount message
        d11 = GF_GuildFactions[faction].discount[1][1]
        d12 = GF_GuildFactions[faction].discount[1][2]
        d13 = GF_GuildFactions[faction].discount[1][3]
        d14 = GF_GuildFactions[faction].discount[1][4]
        d21 = GF_GuildFactions[faction].discount[2][1]
        d22 = GF_GuildFactions[faction].discount[2][2]
        d23 = GF_GuildFactions[faction].discount[2][3]
        d24 = GF_GuildFactions[faction].discount[2][4]
        d31 = GF_GuildFactions[faction].discount[3][1]
        d32 = GF_GuildFactions[faction].discount[3][2]
        d33 = GF_GuildFactions[faction].discount[3][3]
        d34 = GF_GuildFactions[faction].discount[3][4]
        d41 = GF_GuildFactions[faction].discount[4][1]
        d42 = GF_GuildFactions[faction].discount[4][2]
        d43 = GF_GuildFactions[faction].discount[4][3]
        d44 = GF_GuildFactions[faction].discount[4][4]
        d51 = GF_GuildFactions[faction].discount[5][1]
        d52 = GF_GuildFactions[faction].discount[5][2]
        d53 = GF_GuildFactions[faction].discount[5][3]
        d54 = GF_GuildFactions[faction].discount[5][4]
        d61 = GF_GuildFactions[faction].discount[6][1]
        d62 = GF_GuildFactions[faction].discount[6][2]
        d63 = GF_GuildFactions[faction].discount[6][3]
        d64 = GF_GuildFactions[faction].discount[6][4]
        d71 = GF_GuildFactions[faction].discount[7][1]
        d72 = GF_GuildFactions[faction].discount[7][2]
        d73 = GF_GuildFactions[faction].discount[7][3]
        d74 = GF_GuildFactions[faction].discount[7][4]
        d81 = GF_GuildFactions[faction].discount[8][1]
        d82 = GF_GuildFactions[faction].discount[8][2]
        d83 = GF_GuildFactions[faction].discount[8][3]
        d84 = GF_GuildFactions[faction].discount[8][4]  
        msg = timestamp..","..tostring(faction)..","..d11..":"..d12..":"..d13..":"..d14..":"..d21..":"..d22..":"..d23..":"..d24..":"..d31..":"..d32..":"..d33..":"..d34..":"..d41..":"..d42..":"..d43..":"..d44..":"..d51..":"..d52..":"..d53..":"..d54..":"..d61..":"..d62..":"..d63..":"..d64..":"..d71..":"..d72..":"..d73..":"..d74..":"..d81..":"..d82..":"..d83..":"..d84
        gf_debug("Send: "..msg)       
        ChatThrottleLib:SendAddonMessage("BULK","GF_UPDATE_3",msg,"GUILD");
        
    end
end    