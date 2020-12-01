-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectPlayerSkill = class("UISelectPlayerSkill", UIBaseNode)
local base = UIBaseNode
local UINSelectPlayerSkillItem = require("Game.Sector.SelectPlayerSkill.UINSelectPlayerSkillItem")
UISelectPlayerSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).mask_Close, self, self.OnMaskClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnBtnCancelClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnBtnConfirmClicked)
  ;
  ((self.ui).skillSelectItem):SetActive(false)
  self.__selectSkillFunc = BindCallback(self, self.__RefreshCurSelectSkill)
  self.playerSkillItemList = {}
end

UISelectPlayerSkill.InitFirstUI = function(self, uiParent, resloader)
  -- function num : 0_1
  self.uiParent = uiParent
  self.resloader = resloader
end

UISelectPlayerSkill.InitSelectSkillData = function(self, playerSkillData, formationSkillDic)
  -- function num : 0_2
  self.modifySkill = playerSkillData
  self.formationList = formationSkillDic
  self.isModifSkill = playerSkillData ~= nil
  self.isFirstEnter = true
  self.ableNoSelect = true
  self:InitPlayerSkillList()
  self:RefreshPlayerSkillList()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UISelectPlayerSkill.InitPlayerSkillList = function(self)
  -- function num : 0_3
end

UISelectPlayerSkill.ClearSelectSkill = function(self)
  -- function num : 0_4
  do
    if self.selectSkill ~= nil then
      local lastSkillItem = (self.playerSkillItemList)[(self.selectSkill).dataId]
      if lastSkillItem ~= nil then
        lastSkillItem:SetSelectActive(false)
      end
    end
    self.selectSkill = nil
  end
end

UISelectPlayerSkill.RefreshPlayerSkillList = function(self)
  -- function num : 0_5
  if self.isModifSkill then
    self:RefreshCurSelectSkill((self.originSkillList)[1])
  else
    self:RefreshCurSelectSkill(nil)
  end
end

UISelectPlayerSkill.__RefreshCurSelectSkill = function(self, skillData)
  -- function num : 0_6
  self:RefreshCurSelectSkill(skillData)
end

UISelectPlayerSkill.RefreshCurSelectSkill = function(self, skillData)
  -- function num : 0_7
  if skillData == nil then
    if self.ableNoSelect then
      do
        if self.selectSkill ~= nil then
          local lastSkillItem = (self.playerSkillItemList)[(self.selectSkill).dataId]
          lastSkillItem:SetSelectActive(false)
        end
        self.selectSkill = nil
        self:__RefreshFormationSkill(nil)
        do return  end
        if self.selectSkill == skillData then
          do
            if self.ableNoSelect then
              local lastSkillItem = (self.playerSkillItemList)[(self.selectSkill).dataId]
              lastSkillItem:SetSelectActive(false)
              self.selectSkill = nil
              self:__RefreshFormationSkill(nil)
            end
            do return  end
            do
              if self.selectSkill ~= nil then
                local lastSkillItem = (self.playerSkillItemList)[(self.selectSkill).dataId]
                lastSkillItem:SetSelectActive(false)
              end
              self.selectSkill = skillData
              local skillItem = (self.playerSkillItemList)[skillData.dataId]
              skillItem:SetSelectActive(true)
              self:__RefreshFormationSkill(skillData)
            end
          end
        end
      end
    end
  end
end

UISelectPlayerSkill.__RefreshFormationSkill = function(self, skillData)
  -- function num : 0_8 , upvalues : _ENV
  if skillData == nil then
    ((self.ui).skillInfoNode):SetActive(false)
    return 
  end
  ;
  ((self.ui).skillInfoNode):SetActive(true)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillInfo).text = skillData:GetDescribe()
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillLevelInfo).text = skillData:GetCurLevelDescribe()
  local id = skillData:GetID()
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SelectedSkillName).text = ((((self.playerSkillItemList)[id]).ui).tex_SkillName).text
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_SelectedSkillPic).texture = ((((self.playerSkillItemList)[id]).ui).img_SkillPic).texture
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SelectedSkillLevel).text = ((((self.playerSkillItemList)[id]).ui).tex_SkillLevel).text
  ;
  ((self.ui).tex_MpCost):SetIndex(0, tostring(skillData.mpCost))
end

UISelectPlayerSkill.OnBtnConfirmClicked = function(self)
  -- function num : 0_9
  if self.modifySkill ~= self.selectSkill then
    (self.uiParent):ModiyForamtionPlayerSkill(self.selectSkill)
  end
  self:Hide()
end

UISelectPlayerSkill.OnBtnCancelClicked = function(self)
  -- function num : 0_10
  self:Hide()
end

UISelectPlayerSkill.OnMaskClicked = function(self)
  -- function num : 0_11
  self:Hide()
end

UISelectPlayerSkill.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UISelectPlayerSkill

-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectPlayerSkill = class("UISelectPlayerSkill", UIBaseNode)
local base = UIBaseNode
local UINSelectPlayerSkillItem = require(
                                     "Game.Sector.SelectPlayerSkill.UINSelectPlayerSkillItem")
UISelectPlayerSkill.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).mask_Close, self, self.OnMaskClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self,
                               self.OnBtnCancelClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.OnBtnConfirmClicked);
    ((self.ui).skillSelectItem):SetActive(false)
    self.__selectSkillFunc = BindCallback(self, self.__RefreshCurSelectSkill)
    self.playerSkillItemList = {}
end

UISelectPlayerSkill.InitFirstUI = function(self, uiParent, resloader)
    -- function num : 0_1
    self.uiParent = uiParent
    self.resloader = resloader
end

UISelectPlayerSkill.InitSelectSkillData =
    function(self, playerSkillData, formationSkillDic)
        -- function num : 0_2
        self.modifySkill = playerSkillData
        self.formationList = formationSkillDic
        self.isModifSkill = playerSkillData ~= nil
        self.isFirstEnter = true
        self.ableNoSelect = true
        self:InitPlayerSkillList()
        self:RefreshPlayerSkillList()
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

UISelectPlayerSkill.InitPlayerSkillList =
    function(self)
        -- function num : 0_3
    end

UISelectPlayerSkill.ClearSelectSkill = function(self)
    -- function num : 0_4
    do
        if self.selectSkill ~= nil then
            local lastSkillItem =
                (self.playerSkillItemList)[(self.selectSkill).dataId]
            if lastSkillItem ~= nil then
                lastSkillItem:SetSelectActive(false)
            end
        end
        self.selectSkill = nil
    end
end

UISelectPlayerSkill.RefreshPlayerSkillList =
    function(self)
        -- function num : 0_5
        if self.isModifSkill then
            self:RefreshCurSelectSkill((self.originSkillList)[1])
        else
            self:RefreshCurSelectSkill(nil)
        end
    end

UISelectPlayerSkill.__RefreshCurSelectSkill =
    function(self, skillData)
        -- function num : 0_6
        self:RefreshCurSelectSkill(skillData)
    end

UISelectPlayerSkill.RefreshCurSelectSkill =
    function(self, skillData)
        -- function num : 0_7
        if skillData == nil then
            if self.ableNoSelect then
                do
                    if self.selectSkill ~= nil then
                        local lastSkillItem =
                            (self.playerSkillItemList)[(self.selectSkill).dataId]
                        lastSkillItem:SetSelectActive(false)
                    end
                    self.selectSkill = nil
                    self:__RefreshFormationSkill(nil)
                    do return end
                    if self.selectSkill == skillData then
                        do
                            if self.ableNoSelect then
                                local lastSkillItem =
                                    (self.playerSkillItemList)[(self.selectSkill).dataId]
                                lastSkillItem:SetSelectActive(false)
                                self.selectSkill = nil
                                self:__RefreshFormationSkill(nil)
                            end
                            do return end
                            do
                                if self.selectSkill ~= nil then
                                    local lastSkillItem =
                                        (self.playerSkillItemList)[(self.selectSkill).dataId]
                                    lastSkillItem:SetSelectActive(false)
                                end
                                self.selectSkill = skillData
                                local skillItem =
                                    (self.playerSkillItemList)[skillData.dataId]
                                skillItem:SetSelectActive(true)
                                self:__RefreshFormationSkill(skillData)
                            end
                        end
                    end
                end
            end
        end
    end

UISelectPlayerSkill.__RefreshFormationSkill =
    function(self, skillData)
        -- function num : 0_8 , upvalues : _ENV
        if skillData == nil then
            ((self.ui).skillInfoNode):SetActive(false)
            return
        end
        ((self.ui).skillInfoNode):SetActive(true) -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_SkillInfo).text = skillData:GetDescribe() -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_SkillLevelInfo).text = skillData:GetCurLevelDescribe()
        local id = skillData:GetID() -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_SelectedSkillName).text =
            ((((self.playerSkillItemList)[id]).ui).tex_SkillName).text -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_SelectedSkillPic).texture =
            ((((self.playerSkillItemList)[id]).ui).img_SkillPic).texture -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_SelectedSkillLevel).text =
            ((((self.playerSkillItemList)[id]).ui).tex_SkillLevel).text;
        ((self.ui).tex_MpCost):SetIndex(0, tostring(skillData.mpCost))
    end

UISelectPlayerSkill.OnBtnConfirmClicked =
    function(self)
        -- function num : 0_9
        if self.modifySkill ~= self.selectSkill then
            (self.uiParent):ModiyForamtionPlayerSkill(self.selectSkill)
        end
        self:Hide()
    end

UISelectPlayerSkill.OnBtnCancelClicked =
    function(self)
        -- function num : 0_10
        self:Hide()
    end

UISelectPlayerSkill.OnMaskClicked = function(self)
    -- function num : 0_11
    self:Hide()
end

UISelectPlayerSkill.OnDelete = function(self)
    -- function num : 0_12 , upvalues : base
    (base.OnDelete)(self)
end

return UISelectPlayerSkill

