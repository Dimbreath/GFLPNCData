-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitExtraItem = class("UIATHSuitExtraItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitExtraItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).suitIconItem, self, self.__onClick)
end

UIATHSuitExtraItem.InitWithData = function(self, data, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.resLoader = resLoader
  local suitCfg = nil
  if data == 120002 then
    suitCfg = (ConfigData.game_config).ATHDungeonAllExtraIcon
    ;
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitCfg)
  end
)
    return 
  end
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[data]
  if suitParamCfg ~= nil then
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_1 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
end

UIATHSuitExtraItem.__onClick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIATHSuitExtraItem.OnHide = function(self)
  -- function num : 0_3
  self.clickEvent = nil
  self.data = nil
end

UIATHSuitExtraItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitExtraItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitExtraItem = class("UIATHSuitExtraItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitExtraItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).suitIconItem, self, self.__onClick)
end

UIATHSuitExtraItem.InitWithData = function(self, data, resLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.data = data
    self.resLoader = resLoader
    local suitCfg = nil
    if data == 120002 then
        suitCfg = (ConfigData.game_config).ATHDungeonAllExtraIcon;
        (self.resLoader):LoadABAssetAsync(
            PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
                -- function num : 0_1_0 , upvalues : self, suitCfg
                if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                
                ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitCfg)
            end)
        return
    end
    local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[data]
    if suitParamCfg ~= nil then
        (self.resLoader):LoadABAssetAsync(
            PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
                -- function num : 0_1_1 , upvalues : self, suitParamCfg
                if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                
                ((self.ui).img_SuitIcon).sprite =
                    spriteAtlas:GetSprite(suitParamCfg.icon)
            end)
    end
end

UIATHSuitExtraItem.__onClick = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UIATHSuitExtraItem.OnHide = function(self)
    -- function num : 0_3
    self.clickEvent = nil
    self.data = nil
end

UIATHSuitExtraItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIATHSuitExtraItem

