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
  self.AbleToBuffItemPointer = true
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UINDungeonBuffItem, (self.ui).obj_buffItem)
  ;
  ((self.ui).obj_buffItem):SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.__onEpBuffListChange = BindCallback(self, self.RefrshBuffList)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  self.__changeBuffListDisplay = BindCallback(self, self.ChangeBuffListDisplay)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListDisplay, self.__changeBuffListDisplay)
  self.buffHideList = {}
end

UINDungeonBuffList.SetBuffListAbleToPointer = function(self, able)
  -- function num : 0_1
  self.AbleToBuffItemPointer = able
end

UINDungeonBuffList.ChangeBuffListDisplay = function(self, isShow)
  -- function num : 0_2 , upvalues : _ENV
  if isShow then
    (table.remove)(self.buffHideList, #self.buffHideList)
  else
    ;
    (table.insert)(self.buffHideList, isShow)
  end
  if self.buffHideList == nil or #self.buffHideList <= 0 then
    self:Show()
  else
    self:Hide()
  end
end

UINDungeonBuffList.InitBuffList = function(self, buffList)
  -- function num : 0_3
  self:RefrshBuffList(buffList)
end

UINDungeonBuffList.RefrshBuffList = function(self, buffList)
  -- function num : 0_4 , upvalues : _ENV
  self.buffList = buffList
  local buffCount = 0
  ;
  (self.itemPool):HideAll()
  for index,epBuff in ipairs(buffList) do
    if epBuff:IsBuffNeedShowOnBuffList() then
      buffCount = buffCount + 1
      local item = (self.itemPool):GetOne(true)
      item:InitBuffByCfg(epBuff, epBuff:GetEpBuffCfg(), self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
  if buffCount <= 0 then
    self:Hide()
  else
    self:Show()
  end
  local maxShowBuffNum = (math.floor)(((((self.ui).buffListScrollRect).transform).sizeDelta).x / (((self.ui).buffList).spacing + ((((self.ui).obj_buffItem).transform).sizeDelta).x))
  if maxShowBuffNum <= buffCount then
    ((self.ui).obj_BuffCount):SetActive(true)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_BuffNum).text = tostring(buffCount)
  else
    ;
    ((self.ui).obj_BuffCount):SetActive(false)
  end
end

UINDungeonBuffList.ShowBuffDescription = function(self, item, buffCfg)
  -- function num : 0_5 , upvalues : _ENV, HAType, VAType
  if not self.AbleToBuffItemPointer then
    return 
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext((LanguageUtil.GetLocaleText)(buffCfg.name), (LanguageUtil.GetLocaleText)(buffCfg.describe))
  win:FloatTo(item.transform, HAType.autoCenter, VAType.up, nil, 0.25)
  win:Copy3DModifier((self.ui).comp_3dModifier)
end

UINDungeonBuffList.HideBuffDetail = function(self, skillData)
  -- function num : 0_6 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UINDungeonBuffList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  self.buffHideList = nil
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListDisplay, self.__changeBuffListDisplay)
  self:HideBuffDetail()
  ;
  (base.OnDelete)(self)
end

return UINDungeonBuffList

