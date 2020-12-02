-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDeployPlayerSkill = class("UINDeployPlayerSkill", UIBaseNode)
UINDeployPlayerSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).skillItem, self, self.OnClickButton)
end

UINDeployPlayerSkill.InitPlayerSkill = function(self, index, playerSkillData, resloader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.posIndex = index
  self.skillData = playerSkillData
  local isNull = playerSkillData == nil
  ;
  ((self.ui).skillLeveNode):SetActive(not isNull)
  ;
  (((self.ui).img_SkillPic).gameObject):SetActive(not isNull)
  ;
  ((self.ui).img_Add):SetActive(isNull)
  if isNull then
    ((self.ui).tex_SkillName):SetIndex(1)
  else
    resloader:LoadABAssetAsync(PathConsts:GetSkillIconPath(playerSkillData:GetIcon()), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self, playerSkillData
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if self.skillData == playerSkillData then
      ((self.ui).img_SkillPic).texture = texture
    end
  end
)
    ;
    ((self.ui).tex_SkillName):SetIndex(0, playerSkillData:GetName())
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_SkillLevel).text = tostring(playerSkillData.level)
  end
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINDeployPlayerSkill.SetRedDotActive = function(self, active)
  -- function num : 0_2
  ((self.ui).redDotCommanderSkill):SetActive(active)
end

UINDeployPlayerSkill.OnClickButton = function(self)
  -- function num : 0_3
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

return UINDeployPlayerSkill

