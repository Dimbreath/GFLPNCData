local UIEventFestivalSignIn = class("UIEventFestivalSignIn", UIBaseWindow)
local base = UIBaseWindow
local TaskEnum = require("Game.Task.TaskEnum")
local UINEvtFestivalSignItem = require("Game.EventFestivalSignIn.UI.UINEvtFestivalSignItem")
UIEventFestivalSignIn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEvtFestivalSignItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Background, self, self.Delete)
  self.resloader = ((CS.ResLoader).Create)()
  ;
  ((self.ui).festivalSignInItem):SetActive(false)
  self.signItemPool = (UIItemPool.New)(UINEvtFestivalSignItem, (self.ui).festivalSignInItem)
end

UIEventFestivalSignIn.InitEventFestivalSignIn = function(self, id, isShowCloseBtn)
  -- function num : 0_1 , upvalues : _ENV, TaskEnum
  ;
  (((self.ui).btn_Close).gameObject):SetActive(isShowCloseBtn or false)
  ;
  (((self.ui).btn_Background).gameObject):SetActive(isShowCloseBtn or false)
  self._isShowCloseBtn = isShowCloseBtn
  local signData = ((PlayerDataCenter.eventNoviceSignData).dataDic)[id]
  signData:SetPoped()
  local signRewardList = (signData:GetSignRewardList())
  local canPickId = nil
  ;
  (self.signItemPool):HideAll()
  for k,v in ipairs(signRewardList) do
    local signItem = (self.signItemPool):GetOne()
    signItem:InitFestivalSignItem(signData, v)
    local state = signData:GetReceiveState(v.day)
    if state == (TaskEnum.eTaskState).Picked or state == (TaskEnum.eTaskState).Completed then
      canPickId = k
    end
  end
  local maxNum = #signRewardList
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).verticalNormalizedPosition = 1 - ((canPickId or maxNum) - 1) / (maxNum - 1)
  local signCfg = signData:GetSignCfg()
  local path = PathConsts:GetFestivalSignPath(signCfg.sign_prefab)
  ;
  (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_1_0 , upvalues : _ENV, self, path, signData
    if IsNull(prefab) then
      return 
    end
    local go = prefab:Instantiate((self.ui).reHolder)
    local bind = {}
    ;
    (UIUtil.LuaUIBindingTable)(go.transform, bind)
    if IsNull(bind.tex_Time) then
      error("bind.tex_Time is nil, path:" .. path)
      return 
    end
    local dateFormat = (bind.tex_Time).text
    local startTs, endTs = signData:GetSignDataStartEndTimestamp()
    local startTimeStr = (os.date)(dateFormat, startTs)
    local endTimeStr = (os.date)(dateFormat, endTs)
    local text = startTimeStr .. "-" .. endTimeStr
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (bind.tex_Time).text = text
  end
)
end

UIEventFestivalSignIn.UpdUIFestivalSignIn = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in ipairs((self.signItemPool).listItem) do
    v:UpdUIFestivalSignInItem()
  end
end

UIEventFestivalSignIn.SetCloseCallback = function(self, callback)
  -- function num : 0_3
  self.closeCallback = callback
end

UIEventFestivalSignIn.FestivalSignOutOfDate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    -- function num : 0_4_0 , upvalues : _ENV, self
    if win == nil then
      return 
    end
    win:ShowTextBoxWithConfirm(ConfigData:GetTipContent(6033), function()
      -- function num : 0_4_0_0 , upvalues : self, _ENV
      if self._isShowCloseBtn then
        self:Delete()
      else
        ;
        (UIUtil.OnClickBack)()
      end
    end
)
  end
)
end

UIEventFestivalSignIn.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.signItemPool):DeleteAll()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  ;
  (base.OnDelete)(self)
end

return UIEventFestivalSignIn

