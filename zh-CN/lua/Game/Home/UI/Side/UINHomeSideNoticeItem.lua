local UINHomeSideNoticeItem = class("UINHomeSideNoticeItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINHomeSideNoticeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_tipsItem, self, self.OnClickBtn)
end

UINHomeSideNoticeItem.InitSideResItem = function(self, CloseSide, resloader, refeshAllNotices)
  -- function num : 0_1
  self.CloseSide = CloseSide
  self.resloader = resloader
  self.refeshAllNotices = refeshAllNotices
end

UINHomeSideNoticeItem.RefreshSideResItem = function(self, noticeData)
  -- function num : 0_2 , upvalues : _ENV
  self.noticeData = noticeData
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = noticeData:GetNoticeStr()
  self.timeStamp = noticeData.timeStamp
  self.jumpInfo = noticeData.jumpInfo
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, noticeData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(noticeData:GetIcon())
  end
)
  self:RefreshTime()
end

UINHomeSideNoticeItem.RefreshTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local timePassed = PlayerDataCenter.timestamp - self.timeStamp
  if timePassed <= 60 then
    ((self.ui).tex_Timer):SetIndex(0, "1")
  else
    if timePassed <= 3600 then
      ((self.ui).tex_Timer):SetIndex(0, tostring((math.floor)(timePassed / 60)))
    else
      if timePassed <= 86400 then
        ((self.ui).tex_Timer):SetIndex(1, tostring((math.floor)(timePassed / 3600)))
      else
        local dataTable = TimestampToDate(self.timeStamp)
        ;
        ((self.ui).tex_Timer):SetIndex(2, tostring(dataTable.month), tostring(dataTable.day))
      end
    end
  end
end

UINHomeSideNoticeItem.OnClickBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV, JumpManager
  NoticeManager:DeleteNotice(self.noticeData)
  if self.jumpInfo == nil then
    if self.refeshAllNotices ~= nil then
      (self.refeshAllNotices)()
    end
    return 
  end
  JumpManager:Jump((self.jumpInfo).jumpType, function(jumpCallback)
    -- function num : 0_4_0 , upvalues : self
    if self.CloseSide ~= nil then
      (self.CloseSide)()
    end
    if jumpCallback ~= nil then
      jumpCallback()
    end
  end
, nil, (self.jumpInfo).argList)
end

UINHomeSideNoticeItem.PlayHideTween = function(self, callback)
  -- function num : 0_5 , upvalues : cs_DoTween
  self.outTweenSequence = (((((cs_DoTween.Sequence)()):Append(((self.transform):DOLocalMoveX(-((self.transform).sizeDelta).x, 0.2)):SetRelative(true))):AppendCallback(function()
    -- function num : 0_5_0 , upvalues : callback
    if callback ~= nil then
      callback()
    end
  end
)):Pause()):SetAutoKill(true)
  ;
  (self.outTweenSequence):Restart()
end

UINHomeSideNoticeItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.outTweenSequence ~= nil then
    (self.outTweenSequence):Kill()
    self.outTweenSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHomeSideNoticeItem

