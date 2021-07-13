-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTSkillUltimateItem = class("UINCSTSkillUltimateItem", UIBaseNode)
local base = UIBaseNode
UINCSTSkillUltimateItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  ((self.ui).obj_Select):SetActive(false)
  self.defaultLocalPos = (self.transform).localPosition
  ;
  (((self.ui).dtAnim).onComplete):AddListener(BindCallback(self, self._OnMoveTweenComplete))
end

UINCSTSkillUltimateItem.InitCSTSkillUltimateItem = function(self, cmdSkillData, resLoader, clickFunc, isEquip)
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
  self:RefreshCSTSkillUltimateItem()
end

UINCSTSkillUltimateItem.ResetCSTSkillUltimateItemAnim = function(self)
  -- function num : 0_2
  ((self.ui).dtAnim):DOPause()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localPosition = self.defaultLocalPos
end

UINCSTSkillUltimateItem.PlayCSTSkillUltimateItemAnim = function(self, left, right, top, bottom)
  -- function num : 0_3
  local v3 = ((self.ui).dtAnim).endValueV3
  local x = (self.defaultLocalPos).x
  local y = (self.defaultLocalPos).y
  if left then
    x = x - 60
  else
    if right then
      x = x + 60
    else
      if top then
        y = y + 60
      else
        if bottom then
          y = y - 60
        end
      end
    end
  end
  v3.x = x
  v3.y = y
  if ((self.transform).localPosition).x == v3.x and v3.y == ((self.transform).localPosition).y then
    ((self.ui).line):SetActive(self.isEquip)
    return 
  end
  ;
  ((self.ui).line):SetActive(false)
  ;
  (((self.ui).dtAnim).tween):ChangeEndValue(v3, true)
  ;
  ((self.ui).dtAnim):DORestart()
end

UINCSTSkillUltimateItem._OnMoveTweenComplete = function(self)
  -- function num : 0_4
  if self.isEquip then
    ((self.ui).line):SetActive(true)
  end
end

UINCSTSkillUltimateItem.RefreshCSTSkillUltimateItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
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

UINCSTSkillUltimateItem._SetEquipState = function(self, isEquip)
  -- function num : 0_6
  (((self.ui).equip).gameObject):SetActive(self.isEquip)
end

UINCSTSkillUltimateItem._ShowLine = function(self, show)
  -- function num : 0_7 , upvalues : _ENV
  for k,lineGo in ipairs((self.ui).lineList) do
    lineGo:SetActive(show)
  end
end

UINCSTSkillUltimateItem.SetCSTSkillItemSelect = function(self, select)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).obj_Select):SetActive(select)
  ;
  (((self.ui).obj_Select).transform):SetParent(self.transform)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_Select).transform).anchoredPosition = Vector2.zero
end

UINCSTSkillUltimateItem.OnShow = function(self)
  -- function num : 0_9
  self:_ShowLine(true)
end

UINCSTSkillUltimateItem.OnHide = function(self)
  -- function num : 0_10
  self:_ShowLine(false)
end

UINCSTSkillUltimateItem._OnClickRoot = function(self)
  -- function num : 0_11
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.cmdSkillData, self)
  end
  self:ShowCSTSkillItemBlueDot(false)
end

UINCSTSkillUltimateItem.ShowCSTSkillItemBlueDot = function(self, show)
  -- function num : 0_12
  if ((self.ui).blueDot).activeInHierarchy ~= show then
    ((self.ui).blueDot):SetActive(show)
  end
end

UINCSTSkillUltimateItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillUltimateItem

