-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSortKindItem = class("UINSortKindItem", UIBaseNode)
local base = UIBaseNode
local eSortKindType, eSortKindMaxCount = (table.unpack)(require("Game.Hero.SortList.HeroSortKindHelper"))
UINSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).kind_Item, self, self.OnBtnKindClicked)
  self.select = false
  self:SetUISelectActive()
end

UINSortKindItem.InitKindItem = function(self, kindType, index, selectFunc)
  -- function num : 0_1 , upvalues : eSortKindType, _ENV
  self.selectFunc = selectFunc
  self.kindType = kindType
  self.indexPos = index
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  if kindType == eSortKindType.Star then
    ((self.ui).tex_Condition).text = tostring(index) .. "星"
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).sprite = CRH:GetSprite("star_" .. tostring(index), CommonAtlasType.CareerCamp)
  else
    if kindType == eSortKindType.Camp then
      local campCfg = (ConfigData.camp)[index]
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

      if campCfg ~= nil then
        ((self.ui).tex_Condition).text = (LanguageUtil.GetLocaleText)(campCfg.name)
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
      end
    else
      do
        local careerCfg = (ConfigData.career)[index]
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

        if careerCfg ~= nil then
          ((self.ui).tex_Condition).text = (LanguageUtil.GetLocaleText)(careerCfg.name)
          -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).img_Pic).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
        end
      end
    end
  end
end

UINSortKindItem.OnBtnKindClicked = function(self)
  -- function num : 0_2
  self.select = not self.select
  self:SetUISelectActive()
  if self.selectFunc ~= nil then
    (self.selectFunc)(self.kindType, self.indexPos, self.select)
  end
end

UINSortKindItem.SetUISelectActive = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (((self.ui).img_OnClick).gameObject):SetActive(self.select)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  if not self.select or not (self.ui).kind_highlight then
    ((self.ui).img_Kind).color = Color.white
  end
end

UINSortKindItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINSortKindItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSortKindItem = class("UINSortKindItem", UIBaseNode)
local base = UIBaseNode
local eSortKindType, eSortKindMaxCount =
    (table.unpack)(require("Game.Hero.SortList.HeroSortKindHelper"))
UINSortKindItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).kind_Item, self, self.OnBtnKindClicked)
    self.select = false
    self:SetUISelectActive()
end

UINSortKindItem.InitKindItem = function(self, kindType, index, selectFunc)
    -- function num : 0_1 , upvalues : eSortKindType, _ENV
    self.selectFunc = selectFunc
    self.kindType = kindType
    self.indexPos = index
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    if kindType == eSortKindType.Star then
        ((self.ui).tex_Condition).text = tostring(index) .. "星" -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite("star_" .. tostring(index),
                                                   CommonAtlasType.CareerCamp)
    else
        if kindType == eSortKindType.Camp then
            local campCfg = (ConfigData.camp)[index]
            -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

            if campCfg ~= nil then
                ((self.ui).tex_Condition).text =
                    (LanguageUtil.GetLocaleText)(campCfg.name) -- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).img_Pic).sprite =
                    CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
            end
        else
            do
                local careerCfg = (ConfigData.career)[index]
                -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

                if careerCfg ~= nil then
                    ((self.ui).tex_Condition).text =
                        (LanguageUtil.GetLocaleText)(careerCfg.name) -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'
                    ;
                    ((self.ui).img_Pic).sprite =
                        CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
                end
            end
        end
    end
end

UINSortKindItem.OnBtnKindClicked = function(self)
    -- function num : 0_2
    self.select = not self.select
    self:SetUISelectActive()
    if self.selectFunc ~= nil then
        (self.selectFunc)(self.kindType, self.indexPos, self.select)
    end
end

UINSortKindItem.SetUISelectActive = function(self)
    -- function num : 0_3 , upvalues : _ENV
    (((self.ui).img_OnClick).gameObject):SetActive(self.select)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    if not self.select or not (self.ui).kind_highlight then
        ((self.ui).img_Kind).color = Color.white
    end
end

UINSortKindItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINSortKindItem

