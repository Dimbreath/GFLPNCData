-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonStoryItem = class("UIDungeonStoryItem", UIBaseNode)
local base = UIBaseNode
local UICondition = require("Game.Friendship.PlotDungeon.UIDungeonStoryCondition")
UIDungeonStoryItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_storyItem, self, self.__onClick)
end

UIDungeonStoryItem.InitWithData = function(self, cfg)
  -- function num : 0_1 , upvalues : _ENV
  self.conditionTextDict = {}
  self.conditionLockedDict = {}
  self.cfg = cfg
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.gameObject).name = (self.cfg).id
  self:UpdateUnLockCondition(cfg)
end

UIDungeonStoryItem.UpdateUnLockCondition = function(self, cfg)
  -- function num : 0_2 , upvalues : _ENV, UICondition
  self.isUnlock = true
  local conditionCount = #cfg.pre_condition
  if conditionCount <= 0 then
    ((self.ui).condition):SetActive(false)
    return 
  end
  for i = 1, conditionCount do
    local isMeet = (CheckCondition.CheckLua)({(cfg.pre_condition)[i]}, {(cfg.pre_para1)[i]}, {(cfg.pre_para2)[i]})
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.conditionTextDict)[(cfg.pre_condition)[i]] = (AvgUtil.GetConditionText)((cfg.pre_condition)[i], (cfg.pre_para1)[i], (cfg.pre_para2)[i])
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.conditionLockedDict)[(cfg.pre_condition)[i]] = isMeet
    if not isMeet and self.isUnlock then
      self.isUnlock = false
    end
  end
  if ((self.ui).condition).activeSelf == self.isUnlock then
    ((self.ui).condition):SetActive(not self.isUnlock)
  end
  if not self.isUnlock then
    if self.conditionPool == nil then
      self.conditionPool = (UIItemPool.New)(UICondition, (self.ui).conditionItem)
    end
    ;
    (self.conditionPool):HideAll()
    for i = 1, conditionCount do
      local conditionItem = (self.conditionPool):GetOne()
      local condId = (cfg.pre_condition)[i]
      conditionItem:InitWithData((self.conditionTextDict)[condId], (self.conditionLockedDict)[condId])
    end
  end
end

UIDungeonStoryItem.__onClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not self.isUnlock then
    return 
  end
  local agvCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  agvCtrl:StartAvg((self.cfg).script_id)
end

UIDungeonStoryItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIDungeonStoryItem

