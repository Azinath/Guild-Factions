function GF_ActionQueueInit()
   GF_ActionQueue = {}
   if GF_Timer == nil then
      GF_Timer = CreateFrame("Frame")       
      GF_Timer:SetScript("OnUpdate", GF_ActionQueueUpdate)
   end
   
end

function GF_ActionQueueUpdate()
   if #GF_ActionQueue == 0 then 
      GF_Timer:Hide()
      return 
   end 
   if time() >= GF_ActionQueue[1].ts then 
      RunScript(GF_ActionQueue[1].script)
      table.remove(GF_ActionQueue, 1)
   end
end

function GF_ActionQueueAdd(script, delay)
   table.insert(GF_ActionQueue, {ts=time()+delay, script=script})
   table.sort(GF_ActionQueue, GF_ActionSort)
   GF_Timer:Show()
end

function GF_ActionSort(a,b)
   return a.ts < b.ts
end



