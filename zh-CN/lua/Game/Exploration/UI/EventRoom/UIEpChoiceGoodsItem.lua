local UIEpChoiceGoodsItem = class("UIEpChoiceGoodsItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UIEpChoiceGoodsItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpChoiceGoodsItem.ShowWithChipData = function(self, data, showCount)
  -- function num : 0_1 , upvalues : UINChipItem, _ENV
  if self.chipItem == nil then
    self.chipItem = (UINChipItem.New)()
    ;
    (((self.ui).goodsNode).onPressDown):AddListener(BindCallback(self, self.__OnChipItemPress, ((self.ui).uINChipItem).gameObject, data))
    ;
    (((self.ui).goodsNode).onPressUp):AddListener(BindCallback(self, self.HideFloatingFrame))
  end
  ;
  (self.chipItem):Init(((self.ui).uINChipItem).gameObject)
  ;
  (self.chipItem):InitChipItem(data, showCount)
  ;
  (self.chipItem):Show()
end

UIEpChoiceGoodsItem.__OnChipItemPress = function(self, item, chipData)
  -- function num : 0_2 , upvalues : _ENV, HAType, VAType
  if chipData == nil then
    return 
  end
  local name = chipData:GetName()
  local describe = chipData:GetChipDescription()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext((LanguageUtil.GetLocaleText)(name), (LanguageUtil.GetLocaleText)(describe))
  win:FloatTo(item.transform, HAType.right, VAType.down)
end

UIEpChoiceGoodsItem.ShowWithBuffData = function(self, buffId)
  -- function num : 0_3 , upvalues : _ENV
  local buffCfg = (ConfigData.exploration_buff)[buffId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).buffNode).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  ;
  (((self.ui).buffNode).gameObject):SetActive(true)
  ;
  (((self.ui).goodsNode).onPressDown):AddListener(BindCallback(self, self.ShowBuffDescription, (self.ui).buffNode, buffCfg))
  ;
  (((self.ui).goodsNode).onPressUp):AddListener(BindCallback(self, self.HideFloatingFrame))
end

UIEpChoiceGoodsItem.ShowBuffDescription = function(self, item, buffCfg)
  -- function num : 0_4 , upvalues : _ENV, HAType, VAType
  local window = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if window == nil or not window.active then
    window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
    window:SetTitleAndContext((LanguageUtil.GetLocaleText)(buffCfg.name), (LanguageUtil.GetLocaleText)(buffCfg.describe))
    window:FloatTo(item.transform, HAType.right, VAType.down)
  end
end

UIEpChoiceGoodsItem.HideFloatingFrame = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UIEpChoiceGoodsItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
  if self.chipItem ~= nil then
    (self.chipItem):OnDelete()
  end
end

return UIEpChoiceGoodsItem

