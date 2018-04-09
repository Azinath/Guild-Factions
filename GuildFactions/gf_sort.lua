function GF_HitListSort(self)
   table.sort(GF_HitList,GF_SortBy(self.sortType,a,b))
    GF_HitListUpdate()
end

function GF_SortBy(sortType,a,b)
   
end