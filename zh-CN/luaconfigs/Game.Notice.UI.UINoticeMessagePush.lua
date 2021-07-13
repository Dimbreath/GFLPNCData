-- params : ...
-- function num : 0 , upvalues : _ENV
local UINoticeMessagePush = class("UINoticeMessagePush", UIBaseWindow)
local base = UIBaseWindow
local UINNoticeSide = require("Game.Notice.UI.UINNoticeSide")
local cs_ResLoader = CS.ResLoader
UINoticeMessagePush.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINNoticeSide, cs_ResLoader
  self.__permanent = true
  self.isShowingNoticeDic = {}
  self.noticeQueueDic = {}
  self.TimerDic = {}
  ;
  ((self.ui).obj_cup):SetActive(false)
  ;
  ((self.ui).obj_tips):SetActive(false)
  ;
  ((self.ui).obj_side):SetActive(false)
  self.sideItemPool = (UIItemPool.New)(UINNoticeSide, (self.ui).obj_side)
  self.originalCupImg = (self.ui).img_cupIcon
  self.resloader = (cs_ResLoader.Create)()
end

UINoticeMessagePush.AddNotice = function(self, noticeData, isPausing)
  -- function num : 0_1 , upvalues : _ENV
  if noticeData.noticeShowType == (NoticeManager.eNoticeShowType).defualt then
    noticeData.noticeShowType = (NoticeManager.eNoticeShowType).left
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  if (self.noticeQueueDic)[noticeData.noticeShowType] == nil then
    (self.noticeQueueDic)[noticeData.noticeShowType] = {}
  end
  ;
  (table.insert)((self.noticeQueueDic)[noticeData.noticeShowType], noticeData)
  if not isPausing then
    if noticeData.noticeShowType == (NoticeManager.eNoticeShowType).left then
      self:__ShowNotice(noticeData)
    else
      if not (self.isShowingNoticeDic)[noticeData.noticeShowType] then
        self:__ShowNotice(noticeData)
      end
    end
  end
end

UINoticeMessagePush.__TryPickFirstNoticeData = function(self, noticeShowType)
  -- function num : 0_2
  if (self.noticeQueueDic)[noticeShowType] == nil or #(self.noticeQueueDic)[noticeShowType] == 0 then
    self:ForceCleanAllNotice(noticeShowType)
    return nil
  else
    return ((self.noticeQueueDic)[noticeShowType])[1]
  end
end

UINoticeMessagePush.ForceCleanAllNotice = function(self, noticeShowType)
  -- function num : 0_3 , upvalues : _ENV
  if noticeShowType == (NoticeManager.eNoticeShowType).left then
    (self.sideItemPool):HideAll()
  else
    if noticeShowType == (NoticeManager.eNoticeShowType).down then
      ((self.ui).obj_cup):SetActive(false)
    else
      if noticeShowType == (NoticeManager.eNoticeShowType).mid then
        ((self.ui).obj_tips):SetActive(false)
      end
    end
  end
end

local NoticeFunc = nil
NoticeFunc = {[(NoticeManager.eNoticeShowType).defualt] = function(self, noticeData, isShow, hideCallback)
  -- function num : 0_4 , upvalues : NoticeFunc, _ENV
  (NoticeFunc[(NoticeManager.eNoticeShowType).left])(self, noticeData, isShow, hideCallback)
end
, [(NoticeManager.eNoticeShowType).down] = function(self, noticeData, isShow, hideCallback)
  -- function num : 0_5 , upvalues : _ENV
  if isShow then
    ((self.ui).obj_cup):SetActive(true)
    ;
    ((self.ui).tAnima_cup):DORestart()
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Title_cup).text = noticeData:GetNoticeTitle()
    ;
    ((self.ui).tex_Title_cup):StartScrambleTypeWriter()
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Intro_cup).text = noticeData:GetNoticeStr()
    ;
    ((self.ui).tex_Intro_cup):StartScrambleTypeWriter()
    if not (string.IsNullOrEmpty)(noticeData:GetIcon()) then
      (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    -- function num : 0_5_0 , upvalues : self, noticeData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_cupIcon).sprite = spriteAtlas:GetSprite(noticeData:GetIcon())
  end
)
    end
  else
    ;
    (((self.ui).tAnima_cup).onRewind):AddListener(function()
    -- function num : 0_5_1 , upvalues : self, hideCallback
    ((self.ui).obj_cup):SetActive(false)
    if hideCallback ~= nil then
      hideCallback()
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self.ui).img_cupIcon = self.originalCupImg
    ;
    (((self.ui).tAnima_cup).onRewind):RemoveAllListeners()
  end
)
    ;
    ((self.ui).tAnima_cup):DOPlayBackwards()
  end
end
, [(NoticeManager.eNoticeShowType).mid] = function(self, noticeData, isShow, hideCallback)
  -- function num : 0_6
  if isShow then
    ((self.ui).obj_tips):SetActive(true)
    ;
    ((self.ui).tAnima_tips):DORestart()
    ;
    ((self.ui).tAnima_tipsFade):DORestart()
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Title_tip).text = noticeData:GetNoticeTitle()
    ;
    ((self.ui).tex_Title_tip):StartScrambleTypeWriter()
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Intro_tip).text = noticeData:GetNoticeStr()
    ;
    ((self.ui).tex_Intro_tip):StartScrambleTypeWriter()
  else
    ;
    (((self.ui).tAnima_tips).onRewind):AddListener(function()
    -- function num : 0_6_0 , upvalues : self, hideCallback
    ((self.ui).obj_tips):SetActive(false)
    if hideCallback ~= nil then
      hideCallback()
    end
    ;
    (((self.ui).tAnima_tips).onRewind):RemoveAllListeners()
  end
)
    ;
    ((self.ui).tAnima_tips):DOPlayBackwards()
    ;
    ((self.ui).tAnima_tipsFade):DOPlayBackwards()
  end
end
, [(NoticeManager.eNoticeShowType).left] = function(self, noticeData, isShow, hideCallback)
  -- function num : 0_7 , upvalues : _ENV
  if isShow then
    local item = (self.sideItemPool):GetOne()
    item:SideShowNotice(noticeData, self.resloader)
  else
    do
      local firstitem = ((self.sideItemPool).listItem)[1]
      local hideItemNum = 0
      do
        for index,item in ipairs((self.sideItemPool).listItem) do
          if (math.abs)((item.noticeData).timeStampOfShow - (firstitem.noticeData).timeStampOfShow) < 0.1 then
            if item ~= nil and not item.isHiding then
              item.isHiding = true
              item:HideSideNotice(function()
    -- function num : 0_7_0 , upvalues : self, item, _ENV
    (self.sideItemPool):HideOne(item)
    item.isHiding = false
    ;
    (table.remove)((self.noticeQueueDic)[(NoticeManager.eNoticeShowType).left], 1)
  end
)
            end
            hideItemNum = hideItemNum + 1
          end
        end
      end
    end
  end
end
}
UINoticeMessagePush.__ShowNotice = function(self, noticeData, durationTime)
  -- function num : 0_8 , upvalues : NoticeFunc, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  (self.isShowingNoticeDic)[noticeData.noticeShowType] = true
  ;
  (NoticeFunc[noticeData.noticeShowType])(self, noticeData, true)
  noticeData.timeStampOfShow = PlayerDataCenter.timestamp
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

  if noticeData.noticeShowType == (NoticeManager.eNoticeShowType).left and (self.TimerDic)[noticeData.noticeShowType] == nil then
    (self.TimerDic)[noticeData.noticeShowType] = (TimerManager:GetTimer((self.ui).side_duration, function()
    -- function num : 0_8_0 , upvalues : self, noticeData
    self:__HideNotice(nil, true)
    if #(self.sideItemPool).listItem <= 0 then
      ((self.TimerDic)[noticeData.noticeShowType]):Stop()
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.TimerDic)[noticeData.noticeShowType] = nil
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.isShowingNoticeDic)[noticeData.noticeShowType] = false
      ;
      (self.sideItemPool):DeleteAll()
    end
  end
, self, false, false, true)):Start()
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.TimerDic)[noticeData.noticeShowType] = (TimerManager:GetTimer((self.ui).other_duration, function()
    -- function num : 0_8_1 , upvalues : self, noticeData
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (self.TimerDic)[noticeData.noticeShowType] = nil
    self:__HideNotice(noticeData)
  end
, self, true, false, true)):Start()
end

UINoticeMessagePush.__HideNotice = function(self, noticeData, isLeft)
  -- function num : 0_9 , upvalues : NoticeFunc, _ENV
  if isLeft then
    (NoticeFunc[(NoticeManager.eNoticeShowType).left])(self, nil, false)
  else
    ;
    (table.remove)((self.noticeQueueDic)[noticeData.noticeShowType], 1)
    ;
    (NoticeFunc[noticeData.noticeShowType])(self, nil, false, function()
    -- function num : 0_9_0 , upvalues : self, noticeData
    local nextNoticeData = self:__TryPickFirstNoticeData(noticeData.noticeShowType)
    if nextNoticeData ~= nil then
      self:__ShowNotice(nextNoticeData)
    else
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.isShowingNoticeDic)[noticeData.noticeShowType] = false
    end
  end
)
  end
end

UINoticeMessagePush.PuaseShowNotice = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for noticeShowType,value in pairs(self.TimerDic) do
    value:Stop()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.TimerDic)[noticeShowType] = nil
    if noticeShowType ~= (NoticeManager.eNoticeShowType).left then
      local noticeData = ((self.noticeQueueDic)[noticeShowType])[1]
      if noticeData.timeStampOfShow ~= nil and (self.ui).other_duration / 4 < PlayerDataCenter.timestamp - noticeData.timeStampOfShow then
        (table.remove)((self.noticeQueueDic)[noticeData.noticeShowType], 1)
      end
    end
  end
  ;
  (self.sideItemPool):DeleteAll()
  ;
  ((self.ui).obj_cup):SetActive(false)
  ;
  ((self.ui).obj_tips):SetActive(false)
  ;
  (((self.ui).tAnima_cup).onRewind):RemoveAllListeners()
  ;
  (((self.ui).tAnima_tips).onRewind):RemoveAllListeners()
end

UINoticeMessagePush.ContinueShowNotice = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for noticeShowType,noticeQueue in pairs(self.noticeQueueDic) do
    if noticeShowType == (NoticeManager.eNoticeShowType).left then
      for index,noticeData in ipairs(noticeQueue) do
        self:__ShowNotice(noticeData)
      end
    else
      do
        do
          if noticeQueue ~= nil and #noticeQueue > 0 then
            self:__ShowNotice(noticeQueue[1])
          end
          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINoticeMessagePush.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  ((self.ui).obj_cup):SetActive(false)
  ;
  ((self.ui).obj_tips):SetActive(false)
  ;
  ((self.ui).obj_side):SetActive(false)
  for key,value in pairs(self.TimerDic) do
    value:Stop()
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.TimerDic)[key] = nil
  end
  self.TimerDic = {}
  ;
  (base.OnDelete)(self)
end

return UINoticeMessagePush

