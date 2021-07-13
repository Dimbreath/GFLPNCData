-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSelectPlayerSkillItem = class("UINSelectPlayerSkillItem", UIBaseNode)
UINSelectPlayerSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).skillSelectItem, self, self.OnBtnSelfClicked)
end

UINSelectPlayerSkillItem.InitPlayerSkill = function(self, playerSkillData, resloader, selectFunc)
  -- function num : 0_1
  self.skillData = playerSkillData
  self.resloader = resloader
  self.selectFunc = selectFunc
  self.freshTexture = true
  self:RefreshPlayerSkillData()
end

UINSelectPlayerSkillItem.RefreshPlayerSkillData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.skillData == nil then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = (self.skillData):GetName()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillLevel).text = tostring((self.skillData).level)
  if self.freshTexture then
    self.freshTexture = false
    ;
    (self.resloader):LoadABAssetAsync(PathConsts:GetSkillIconPath((self.skillData):GetIcon()), function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SkillPic).texture = texture
  end
)
  end
end

UINSelectPlayerSkillItem.OnBtnSelfClicked = function(self)
  -- function num : 0_3
  if self.selectFunc ~= nil then
    (self.selectFunc)(self.skillData)
  end
end

UINSelectPlayerSkillItem.SetSelectActive = function(self, active)
  -- function num : 0_4
  ((self.ui).img_Select):SetActive(active)
end

UINSelectPlayerSkillItem.SetInFormationActive = function(self, active)
  -- function num : 0_5
  ((self.ui).inSelectNode):SetActive(active)
end

return UINSelectPlayerSkillItem

