-- params : ...
-- function num : 0 , upvalues : _ENV
local UIRichIntroList = class("UIRichIntroList", UIBaseNode)
local base = UIBaseNode
local UIRichIntroItem = require("Game.CommonUI.RichIntro.UIRichIntroItem")
UIRichIntroList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIRichIntroItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UIRichIntroItem, (self.ui).obj_introItem)
  ;
  ((self.ui).obj_introItem):SetActive(false)
  ;
  ((self.ui).obj_infoItem):SetActive(false)
end

UIRichIntroList.SetModifier = function(self, modifier, is3d)
  -- function num : 0_1 , upvalues : _ENV
  if modifier ~= nil or self.modifier ~= modifier then
    self.modifier = modifier
  else
    return 
  end
  local modifierRote = Vector3.zero
  local modifierPos = Vector3.zero
  if modifier ~= nil then
    modifierRote = modifier.rotation
    modifierPos = modifier.position
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).modifier).rotation = modifierRote
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).modifier).position = modifierPos
  local is3dModifier = is3d or false
  local addRenderQueue = is3dModifier and 101 or 0
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).modifier).is3D = is3dModifier
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).modifier).setRenderQueue = addRenderQueue
  ;
  ((self.ui).modifier):InitModifierMat(is3dModifier)
  ;
  ((self.ui).modifier):RefreshGraphics()
end

UIRichIntroList.RefreshIntroListUI = function(self, uiIntroData)
  -- function num : 0_2 , upvalues : _ENV
  if uiIntroData == nil then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if uiIntroData.showHead then
    ((self.ui).tex_infoName).text = uiIntroData.name
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_infoDesc).text = uiIntroData.desc
    ;
    ((self.ui).obj_infoItem):SetActive(true)
  else
    ;
    ((self.ui).obj_infoItem):SetActive(false)
  end
  if uiIntroData.cdTime == nil or uiIntroData.cdTime == 0 then
    (((self.ui).tex_CDTime).gameObject):SetActive(false)
  else
    ;
    (((self.ui).tex_CDTime).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_CDTime).text = tostring(uiIntroData.cdTime) .. "s"
  end
  self:__SetTween()
  self:__RefreshRichIntroItem(uiIntroData.skillLabeIdList)
end

UIRichIntroList.__RefreshRichIntroItem = function(self, skillLabeIdList)
  -- function num : 0_3 , upvalues : _ENV
  (self.itemPool):HideAll()
  if skillLabeIdList ~= nil then
    for i = 1, #skillLabeIdList do
      local item = (self.itemPool):GetOne()
      local cfg = (ConfigData.skill_label_info)[skillLabeIdList[i]]
      if cfg ~= nil then
        item:InitRichIntroItem(cfg)
      end
    end
  end
end

UIRichIntroList.__SetTween = function(self)
  -- function num : 0_4
  if self.canvasTween ~= nil then
    (self.canvasTween):Kill()
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = 0
  self.canvasTween = ((self.ui).canvasGroup):DOFade(1, 0.3)
end

UIRichIntroList.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  if self.canvasTween ~= nil then
    (self.canvasTween):Kill()
    self.canvasTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIRichIntroList

