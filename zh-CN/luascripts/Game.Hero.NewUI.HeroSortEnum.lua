-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroSortEnum = {}
HeroSortEnum.eSortMannerType = {Rank = 1, Level = 2, Id = 3, GetOrder = 4}
HeroSortEnum.SortMannerDefine = {
[(HeroSortEnum.eSortMannerType).Rank] = {descSort = function(hero1, hero2)
  -- function num : 0_0
  if hero2.rank < hero1.rank then
    return true
  else
    if hero1.rank == hero2.rank then
      if hero2.level < hero1.level then
        return true
      else
        if hero2.dataId >= hero1.dataId then
          do return hero1.level ~= hero2.level end
          do return false end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end
, asceSort = function(hero1, hero2)
  -- function num : 0_1
  if hero1.rank < hero2.rank then
    return true
  else
    if hero1.rank == hero2.rank then
      if hero1.level < hero2.level then
        return true
      else
        if hero1.dataId >= hero2.dataId then
          do return hero1.level ~= hero2.level end
          do return false end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end
}
, 
[(HeroSortEnum.eSortMannerType).GetOrder] = {descSort = function(hero1, hero2)
  -- function num : 0_2
  do return hero2.ts < hero1.ts end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, asceSort = function(hero1, hero2)
  -- function num : 0_3
  do return hero1.ts < hero2.ts end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
, 
[(HeroSortEnum.eSortMannerType).Level] = {descSort = function(hero1, hero2)
  -- function num : 0_4
  if hero2.level < hero1.level then
    return true
  else
    if hero1.level == hero2.level then
      if hero2.rank < hero1.rank then
        return true
      else
        if hero2.dataId >= hero1.dataId then
          do return hero1.rank ~= hero2.rank end
          do return false end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end
, asceSort = function(hero1, hero2)
  -- function num : 0_5
  if hero1.level < hero2.level then
    return true
  else
    if hero1.level == hero2.level then
      if hero1.rank < hero2.rank then
        return true
      else
        if hero1.dataId >= hero2.dataId then
          do return hero1.rank ~= hero2.rank end
          do return false end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end
}
, 
[(HeroSortEnum.eSortMannerType).Id] = {descSort = function(hero1, hero2)
  -- function num : 0_6
  do return hero2.dataId < hero1.dataId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, asceSort = function(hero1, hero2)
  -- function num : 0_7
  do return hero1.dataId < hero2.dataId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
}
return HeroSortEnum

