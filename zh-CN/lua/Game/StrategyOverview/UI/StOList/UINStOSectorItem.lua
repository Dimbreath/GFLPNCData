local UINStOSectorItem = class("UINStOSectorItem", UIBaseNode)
local base = UIBaseNode
UINStOSectorItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOSectorItem.InitStOSectorItem = function(self, sectorId, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Affiliation).text = (LanguageUtil.GetLocaleText)(sectorCfg.type_name)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(sectorCfg.name)
  local path = PathConsts:GetSectorStrategyOverviewBgPath(sectorCfg.pic_stratery_overview)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
end

UINStOSectorItem.SetBgImageColor = function(self, active)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  if active ~= true or not (Color.New)(1, 1, 1, 0.1) then
    ((self.ui).img_Adapter).color = (Color.New)(0, 0, 0, 0.2)
  end
end

UINStOSectorItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOSectorItem

