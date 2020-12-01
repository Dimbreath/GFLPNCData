-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_ActiveSkillItem = class("UINCSTDetail_ActiveSkillItem", UIBaseNode)
local base = UIBaseNode
UINCSTDetail_ActiveSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_activeSkillItem, self, self.OnValueChange)
end

UINCSTDetail_ActiveSkillItem.InitActiveSkill = function(self, index, showOverload, hideOverload, resloader)
  -- function num : 0_1
  self.index = index
  self.resloader = resloader
  self.showOverloadCallback = showOverload
  self.hideOverloadCallback = hideOverload
end

UINCSTDetail_ActiveSkillItem.ShowActiveSkill = function(self, skillData, index, totalNum, unlockNum)
  -- function num : 0_2 , upvalues : _ENV
  self.skillData = skillData
  if skillData == nil or skillData.dataId == nil then
    self.skillId = 0
    ;
    (((self.ui).img_SkillIcon).gameObject):SetActive(false)
    ;
    ((self.ui).obj_img_lock):SetActive(true)
  else
    self.skillId = skillData.dataId
    ;
    (((self.ui).img_SkillIcon).gameObject):SetActive(true)
    ;
    ((self.ui).obj_img_lock):SetActive(false)
    ;
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, skillData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SkillIcon).sprite = spriteAtlas:GetSprite(skillData:GetIcon())
  end
)
  end
  if totalNum ~= nil then
    self:RefreshDots(totalNum - 1, unlockNum - 1)
  end
end

UINCSTDetail_ActiveSkillItem.OnValueChange = function(self, bool)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).img_Trangle).color = (self.ui).color_white
    if self.showOverloadCallback ~= nil then
      (self.showOverloadCallback)(self.skillId, self.index)
    end
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Trangle).color = (self.ui).color_black
    if self.hideOverloadCallback ~= nil then
      (self.hideOverloadCallback)()
    end
  end
end

UINCSTDetail_ActiveSkillItem.SetTog = function(self, bool)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_activeSkillItem).isOn = bool
end

UINCSTDetail_ActiveSkillItem.RefreshDots = function(self, totalNum, unlockNum)
  -- function num : 0_5 , upvalues : _ENV
  local size = ((self.ui).rect_Count).sizeDelta
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).rect_Count).sizeDelta = (Vector2.New)(6.4 * (totalNum * 2 - 1), size.y)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Count).fillAmount = 0.33 * unlockNum
end

UINCSTDetail_ActiveSkillItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTDetail_ActiveSkillItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_ActiveSkillItem = class("UINCSTDetail_ActiveSkillItem",
                                           UIBaseNode)
local base = UIBaseNode
UINCSTDetail_ActiveSkillItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_activeSkillItem, self,
                                     self.OnValueChange)
end

UINCSTDetail_ActiveSkillItem.InitActiveSkill =
    function(self, index, showOverload, hideOverload, resloader)
        -- function num : 0_1
        self.index = index
        self.resloader = resloader
        self.showOverloadCallback = showOverload
        self.hideOverloadCallback = hideOverload
    end

UINCSTDetail_ActiveSkillItem.ShowActiveSkill =
    function(self, skillData, index, totalNum, unlockNum)
        -- function num : 0_2 , upvalues : _ENV
        self.skillData = skillData
        if skillData == nil or skillData.dataId == nil then
            self.skillId = 0;
            (((self.ui).img_SkillIcon).gameObject):SetActive(false);
            ((self.ui).obj_img_lock):SetActive(true)
        else
            self.skillId = skillData.dataId;
            (((self.ui).img_SkillIcon).gameObject):SetActive(true);
            ((self.ui).obj_img_lock):SetActive(false);
            (self.resloader):LoadABAssetAsync(
                PathConsts:GetAtlasAssetPath("CommanderSkillIcons"),
                function(spriteAtlas)
                    -- function num : 0_2_0 , upvalues : self, skillData
                    if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
                    
                    ((self.ui).img_SkillIcon).sprite =
                        spriteAtlas:GetSprite(skillData:GetIcon())
                end)
        end
        if totalNum ~= nil then
            self:RefreshDots(totalNum - 1, unlockNum - 1)
        end
    end

UINCSTDetail_ActiveSkillItem.OnValueChange =
    function(self, bool)
        -- function num : 0_3
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

        if bool then
            ((self.ui).img_Trangle).color = (self.ui).color_white
            if self.showOverloadCallback ~= nil then
                (self.showOverloadCallback)(self.skillId, self.index)
            end
        else
            -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'


            ((self.ui).img_Trangle).color = (self.ui).color_black
            if self.hideOverloadCallback ~= nil then
                (self.hideOverloadCallback)()
            end
        end
    end

UINCSTDetail_ActiveSkillItem.SetTog = function(self, bool)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_activeSkillItem).isOn = bool
end

UINCSTDetail_ActiveSkillItem.RefreshDots =
    function(self, totalNum, unlockNum)
        -- function num : 0_5 , upvalues : _ENV
        local size = ((self.ui).rect_Count).sizeDelta -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).rect_Count).sizeDelta =
            (Vector2.New)(6.4 * (totalNum * 2 - 1), size.y) -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_Count).fillAmount = 0.33 * unlockNum
    end

UINCSTDetail_ActiveSkillItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_ActiveSkillItem

