local UIUserNameCreate = class("UIUserNameModify", UIBaseWindow)
local base = UIBaseWindow
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
local cs_RenderTextureFormat = (CS.UnityEngine).RenderTextureFormat
UIUserNameCreate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_RandomName, self, self.OnclickRandomNameBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickCreateUserConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_boy, self, self.OnClickBoySex)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_girl, self, self.OnClickGrilSex)
  self.isGril = (PlayerDataCenter.inforData):GetSex()
  self:initModel()
  self:RefreshPannel()
end

UIUserNameCreate.InitUIUserNameCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and (ControllerManager:GetController(ControllerTypeId.HomeController)):IsNormalState() then
    self._needChangeHomeState = true
    homeWin:OpenOtherCoverWin()
  end
end

UIUserNameCreate.initModel = function(self)
  -- function num : 0_2 , upvalues : LotteryRtUtil, cs_RenderTextureFormat, _ENV
  local isSupARGBHalf = (LotteryRtUtil.SupportsRenderTextures)(cs_RenderTextureFormat.ARGBHalf)
  for index,go in ipairs((self.ui).modelViews) do
    go:SetActive(isSupARGBHalf)
  end
  if not isSupARGBHalf then
    return 
  end
  self.male_texture = (LotteryRtUtil.GetARGBHalfRtTemporary)(143, 241, 24)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).boy_ImgCamera).texture = self.male_texture
  ;
  (((self.ui).boy_ImgCamera).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).boy_camera).targetTexture = self.male_texture
  self:__InitModelTranform((self.ui).dmodel_professor)
  self.female_texture = (LotteryRtUtil.GetARGBHalfRtTemporary)(143, 241, 24)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).gril_ImgCamera).texture = self.female_texture
  ;
  (((self.ui).gril_ImgCamera).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).gril_camera).targetTexture = self.female_texture
  self:__InitModelTranform((self.ui).dmodel_professor_boy)
end

UIUserNameCreate.__InitModelTranform = function(self, model)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if model ~= nil then
    (model.transform).localPosition = ((CS.UnityEngine).Vector3)(0, -0.5, 0)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (model.transform).rotation = ((CS.UnityEngine).Vector3)(0, 180, 0)
  end
end

UIUserNameCreate.OnClickBoySex = function(self)
  -- function num : 0_4
  self.isGril = false
  self:RefreshPannel()
end

UIUserNameCreate.OnClickGrilSex = function(self)
  -- function num : 0_5
  self.isGril = true
  self:RefreshPannel()
end

UIUserNameCreate.RefreshPannel = function(self)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if self.isGril then
    ((self.ui).canvas_boy).alpha = 0.4
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).canvas_girl).alpha = 1
    local var = (((self.ui).obj_Select).transform).anchoredPosition
    ;
    (((self.ui).obj_Select).transform):SetParent(((self.ui).btn_girl).transform)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).obj_Select).transform).anchoredPosition = var
  else
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).canvas_boy).alpha = 1
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).canvas_girl).alpha = 0.4
      do
        local var = (((self.ui).obj_Select).transform).anchoredPosition
        ;
        (((self.ui).obj_Select).transform):SetParent(((self.ui).btn_boy).transform)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((self.ui).obj_Select).transform).anchoredPosition = var
        ;
        ((self.ui).gril_Ring):SetActive(self.isGril)
        ;
        ((self.ui).boy_Ring):SetActive(not self.isGril)
        ;
        ((self.ui).boy_Icon):SetActive(self.isGril)
        ;
        ((self.ui).gril_Icon):SetActive(not self.isGril)
      end
    end
  end
end

UIUserNameCreate.BindUIUserNameAction = function(self, nextAction)
  -- function num : 0_7
  self.nextAction = nextAction
end

UIUserNameCreate.OnclickRandomNameBtn = function(self)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).input_UserName).text = self:GengrateRandomName()
end

UIUserNameCreate.GengrateRandomName = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local famulyName = require("LuaConfigs.player_familyName")
  local firstName = require("LuaConfigs.player_firstName")
  ;
  (math.randomseed)((os.time)())
  local num1 = (math.random)(#famulyName)
  local num2 = (math.random)(#firstName)
  local arg1 = (LanguageUtil.GetLocaleText)((famulyName[num1]).family_name)
  local arg2 = (LanguageUtil.GetLocaleText)((firstName[num2]).first_name)
  return arg1 .. arg2
end

UIUserNameCreate.OnClickCreateUserConfirm = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local inputUserName = ((self.ui).input_UserName).text
  if (string.IsNullOrEmpty)(inputUserName) then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(53))
    return 
  end
  if self.isGril ~= (PlayerDataCenter.inforData):GetSex() then
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_SexMod(self.isGril)
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_UserNameModify(inputUserName, function()
    -- function num : 0_10_0 , upvalues : self
    self:Delete()
    if self.nextAction ~= nil then
      (self.nextAction)()
    end
  end
)
end

UIUserNameCreate.OnDelete = function(self)
  -- function num : 0_11 , upvalues : LotteryRtUtil, _ENV, base
  if self.modelResloader ~= nil then
    (self.modelResloader):Put2Pool()
    self.modelResloader = nil
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if self.male_texture ~= nil then
    ((self.ui).boy_camera).targetTexture = nil
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).boy_ImgCamera).texture = nil
    ;
    (LotteryRtUtil.ReleaseTemporaryAndDestory)(self.male_texture)
    self.male_texture = nil
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  if self.female_texture ~= nil then
    ((self.ui).gril_camera).targetTexture = nil
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).gril_ImgCamera).texture = nil
    ;
    (LotteryRtUtil.ReleaseTemporaryAndDestory)(self.female_texture)
    self.female_texture = nil
  end
  ;
  (((self.ui).gril_camera).gameObject):SetActive(false)
  ;
  (((self.ui).gril_ImgCamera).gameObject):SetActive(false)
  ;
  (((self.ui).boy_camera).gameObject):SetActive(false)
  ;
  (((self.ui).boy_ImgCamera).gameObject):SetActive(false)
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and self._needChangeHomeState then
    self._needChangeHomeState = false
    homeWin:BackFromOtherCoverWin()
  end
  ;
  (base.OnDelete)(self)
end

return UIUserNameCreate

