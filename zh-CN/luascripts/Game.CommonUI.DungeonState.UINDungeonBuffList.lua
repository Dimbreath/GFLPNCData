-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonBuffList = class("UINDungeonBuffList", UIBaseNode)
local base = UIBaseNode
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINDungeonBuffList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDungeonBuffItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UINDungeonBuffItem, (self.ui).obj_buffItem)
  ;
  ((self.ui).obj_buffItem):SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.__onEpBuffListChange = BindCallback(self, self.RefrshBuffList)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
end

UINDungeonBuffList.InitBuffList = function(self, buffList)
  -- function num : 0_1
  self:RefrshBuffList(buffList)
end

UINDungeonBuffList.RefrshBuffList = function(self, buffList)
  -- function num : 0_2 , upvalues : _ENV
  self.buffList = buffList
  if #buffList == 0 then
    self:Hide()
  else
    self:Show()
  end
  ;
  (self.itemPool):HideAll()
  for index,epBuff in ipairs(buffList) do
    if epBuff:IsBuffNeedShow() then
      local item = (self.itemPool):GetOne(true)
      item:InitBuffByCfg(epBuff, epBuff:GetEpBuffCfg(), self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
end

UINDungeonBuffList.ShowBuffDescription = function(self, item, buffCfg)
  -- function num : 0_3 , upvalues : _ENV, HAType, VAType
  UIManager:ShowWindowAsync(UIWindowTypeID.FloatingFrame, function(win)
    -- function num : 0_3_0 , upvalues : _ENV, buffCfg, item, HAType, VAType, self
    win:SetTitleAndContext((LanguageUtil.GetLocaleText)(buffCfg.name), (LanguageUtil.GetLocaleText)(buffCfg.describe))
    win:FloatTo(item.transform, HAType.right, VAType.down)
    win:Copy3DModifier((self.ui).comp_3dModifier)
  end
)
end

UINDungeonBuffList.HideBuffDetail = function(self, skillData)
  -- function num : 0_4 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UINDungeonBuffList.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  ;
  (base.OnDelete)(self)
end

return UINDungeonBuffList

