-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgImgTweenUntil = {}
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local CS_DOTween = ((CS.DG).Tweening).DOTween
local CS_RotateMode = ((CS.DG).Tweening).RotateMode
AvgImgTweenUntil.Tween = function(imgItem, tweenCfg)
  -- function num : 0_0 , upvalues : CS_DOTween, _ENV, eAvgImgPosType, CS_RotateMode
  local transform = imgItem.transform
  local rawImg = (imgItem.ui).rawImg
  local sequence = imgItem:GetAvgImgSequence()
  if sequence == nil then
    sequence = (CS_DOTween.Sequence)()
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then
      sequence:SetUpdate(avgCtrl:AvgIgnoreTimeScale())
    end
  end
  do
    local delay = tweenCfg.delay or 0
    local duration = tweenCfg.duration or 0
    local pos = nil
    if tweenCfg.posId ~= nil then
      pos = eAvgImgPosType[tweenCfg.posId]
    else
      if tweenCfg.pos ~= nil then
        pos = (Vector3.New)((tweenCfg.pos)[1], (tweenCfg.pos)[2], (tweenCfg.pos)[3])
      end
    end
    do
      if pos ~= nil then
        local tween = transform:DOLocalMove(pos, duration)
        sequence:Insert(delay, tween)
      end
      if tweenCfg.rot ~= nil then
        local rot = (Vector3.New)((tweenCfg.rot)[1], (tweenCfg.rot)[2], (tweenCfg.rot)[3])
        local tween = transform:DOLocalRotate(rot, duration, CS_RotateMode.FastBeyond360)
        sequence:Insert(delay, tween)
      end
      do
        if tweenCfg.scale ~= nil then
          local scale = (Vector3.New)((tweenCfg.scale)[1], (tweenCfg.scale)[2], (tweenCfg.scale)[3])
          local tween = transform:DOScale(scale, duration)
          sequence:Insert(delay, tween)
        end
        do
          local color = nil
          if tweenCfg.alpha ~= nil then
            color = rawImg.color
            color.a = tweenCfg.alpha
          end
          if tweenCfg.isDark ~= nil then
            if color == nil then
              color = rawImg.color
            end
            local value = tweenCfg.isDark and 0.5 or 1
            color.r = value
            color.g = value
            color.b = value
          end
          do
            do
              if color ~= nil then
                local tween = rawImg:DOColor(color, duration)
                sequence:Insert(delay, tween)
              end
              do
                if tweenCfg.shake ~= nil then
                  local tween = transform:DOShakePosition(duration, (Vector3.New)(10, 10, 0), 20)
                  sequence:Insert(delay, tween)
                end
                imgItem:SetAvgImgSequence(sequence)
              end
            end
          end
        end
      end
    end
  end
end

return AvgImgTweenUntil

