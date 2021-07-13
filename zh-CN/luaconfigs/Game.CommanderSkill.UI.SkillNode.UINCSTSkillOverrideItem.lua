-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTSkillOverrideItem = class("UINCSTSkillOverrideItem", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillOverrideLvItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillOverrideLvItem")
UINCSTSkillOverrideItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSTSkillOverrideLvItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  ((self.ui).advItem):SetActive(false)
  self.advItemPool = (UIItemPool.New)(UINCSTSkillOverrideLvItem, (self.ui).advItem)
  self.lineDefaultColor = (((self.ui).lineList)[1]).color
  ;
  ((self.ui).obj_Select):SetActive(false)
  self.sizeDeltaDefault = (self.transform).sizeDelta
end

UINCSTSkillOverrideItem.InitCSTSkillOverrideItem = function(self, cmdSkillData, resLoader, clickFunc, isEquip)
  -- function num : 0_1 , upvalues : _ENV
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self.isEquip = isEquip
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, cmdSkillData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(cmdSkillData:GetIcon())
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  ;
  (self.advItemPool):HideAll()
  self.advItemDic = {}
  for level = 1, cmdSkillData.maxLevel do
    local iconName = (cmdSkillData.levelIconList)[level]
    local item = (self.advItemPool):GetOne()
    item:InitCSTSkillOverrideLvItem(resLoader, iconName)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.advItemDic)[level] = item
  end
  self:RefreshCSTSkillOverrideItem()
end

UINCSTSkillOverrideItem.ResetCSTSkillOverrideItemAnim = function(self)
  -- function num : 0_2
  ((self.ui).dtAnim):DOPause()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = self.sizeDeltaDefault
end

UINCSTSkillOverrideItem.PlayCSTSkillOverrideItemAnim = function(self, isMiddle)
  -- function num : 0_3
  local v2 = ((self.ui).dtAnim).endValueV2
  local x = (self.sizeDeltaDefault).x
  if self.isEquip then
    x = x + 65
  else
  end
  if isMiddle then
    x = x - 65
    v2.x = x
    if ((self.transform).sizeDelta).x == v2.x then
      return 
    end
    v2.y = (self.sizeDeltaDefault).y
    ;
    (((self.ui).dtAnim).tween):ChangeEndValue(v2, true)
    ;
    ((self.ui).dtAnim):DORestart()
  end
end

UINCSTSkillOverrideItem.RefreshCSTSkillOverrideItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local cmdSkillData = self.cmdSkillData
  ;
  ((self.ui).obj_Next):SetActive(false)
  ;
  ((self.ui).obj_Lock):SetActive(false)
  ;
  ((self.ui).nextLevel):SetActive(true)
  ;
  ((self.ui).obj_Mask):SetActive(false)
  if not cmdSkillData.isUnlock then
    ((self.ui).obj_Lock):SetActive(true)
    ;
    ((self.ui).obj_Mask):SetActive(true)
    ;
    ((self.ui).tex_NextLevel):SetIndex(0, tostring(cmdSkillData.unlockLevel))
  else
    ;
    ((self.ui).nextLevel):SetActive(false)
  end
  self:_SetEquipState(self.isEquip)
end

UINCSTSkillOverrideItem._SetEquipState = function(self, isEquip)
  -- function num : 0_5 , upvalues : _ENV
  (((self.ui).equip).gameObject):SetActive(isEquip)
  for k,imgLine in ipairs((self.ui).lineList) do
    if not isEquip or not ((self.ui).equip).color then
      do
        imgLine.color = self.lineDefaultColor
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local equpColor = nil
  if isEquip then
    equpColor = ((self.ui).equip).color
  end
  for level,item in pairs(self.advItemDic) do
    local lock = level <= (self.cmdSkillData).level and not (self.cmdSkillData).isUnlock
    item:SetCSTSkillOverrideLvItemLock(lock, equpColor)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINCSTSkillOverrideItem.SetCSTSkillOverrideItemEquip = function(self, isEquip)
  -- function num : 0_6
  self.isEquip = isEquip
  self:_SetEquipState(self.isEquip)
end

UINCSTSkillOverrideItem.SetCSTSkillItemSelect = function(self, select)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).obj_Select):SetActive(select)
  ;
  (((self.ui).obj_Select).transform):SetParent((self.ui).skill)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_Select).transform).anchoredPosition = Vector2.zero
end

UINCSTSkillOverrideItem._OnClickRoot = function(self)
  -- function num : 0_8
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.cmdSkillData, self)
  end
  self:ShowCSTSkillItemBlueDot(false)
end

UINCSTSkillOverrideItem.ShowCSTSkillItemBlueDot = function(self, show)
  -- function num : 0_9
  if ((self.ui).blueDot).activeInHierarchy ~= show then
    ((self.ui).blueDot):SetActive(show)
  end
end

UINCSTSkillOverrideItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  if self.advItemPool ~= nil then
    (self.advItemPool):DeleteAll()
  end
  ;
  (base.OnDelete)(self)
end

return UINCSTSkillOverrideItem

