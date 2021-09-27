local UINAvgNounDetailNode = class("UINAvgNounDetailNode", UIBaseNode)
local base = UIBaseNode
local CS_ResLoader = CS.ResLoader
UINAvgNounDetailNode.OnInit = function(self)
  -- function num : 0_0
end

UINAvgNounDetailNode.InitInfo = function(self, trans, nounId)
  -- function num : 0_1 , upvalues : _ENV, CS_ResLoader
  (UIUtil.LuaUIBindingTable)(trans, self.ui)
  self.nounCfg = (ConfigData.noun_des)[nounId]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = (LanguageUtil.GetLocaleText)((self.nounCfg).name)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = (LanguageUtil.GetLocaleText)((self.nounCfg).des)
  if (string.IsNullOrEmpty)((self.nounCfg).picture) == false then
    ((self.ui).obj_pic):SetActive(true)
    if self.resloader ~= nil then
      (self.resloader):Put2Pool()
      self.resloader = nil
    end
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

    if (self.nounCfg).picture_type ~= nil and (self.nounCfg).picture_type == 0 then
      ((self.ui).Layout_pic).minHeight = 524
    else
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

      if (self.nounCfg).picture_type == 1 then
        ((self.ui).Layout_pic).minHeight = 396
      end
    end
    self.resloader = (CS_ResLoader.Create)()
    ;
    (self.resloader):LoadABAssetAsync(PathConsts:GetAvgNounImgPath((self.nounCfg).picture), function(texture)
    -- function num : 0_1_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Pic).texture = texture
  end
)
  else
    ;
    ((self.ui).obj_pic):SetActive(false)
  end
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_expand, self, self.ExpandAvgNoun)
end

UINAvgNounDetailNode.ExpandAvgNoun = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local avgnounwindow = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  avgnounwindow:OnClickExpand()
  ;
  (((self.ui).btn_expand).gameObject):SetActive(false)
end

UINAvgNounDetailNode.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgNounDetailNode

