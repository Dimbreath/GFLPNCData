-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgImgTweenUntil = {}
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local CS_DOTween = ((CS.DG).Tweening).DOTween
local CS_RotateMode = ((CS.DG).Tweening).RotateMode
AvgImgTweenUntil.Tween = function(imgItem, tweenCfg)
  -- function num : 0_0 , upvalues : CS_DOTween, _ENV, eAvgImgType, eAvgImgPosType, CS_RotateMode
  local transform = imgItem.transform
  local rawImg = (imgItem.ui).rawImg
  local imgType = imgItem:GetAvgImgType()
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
    local picPosData, pos = nil, nil
    if tweenCfg.posId ~= nil then
      if imgType == eAvgImgType.Character then
        if picPosData == nil then
          picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
        end
        if picPosData ~= nil then
          pos = picPosData.pos
        end
      else
        pos = eAvgImgPosType[tweenCfg.posId]
      end
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
        local scale = nil
        if tweenCfg.posId ~= nil and imgType == eAvgImgType.Character then
          if picPosData == nil then
            picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
          end
          if picPosData ~= nil then
            scale = picPosData.scale
          end
        else
          if tweenCfg.scale ~= nil then
            scale = (Vector3.New)((tweenCfg.scale)[1], (tweenCfg.scale)[2], (tweenCfg.scale)[3])
          end
        end
        do
          if scale ~= nil then
            local tween = transform:DOScale(scale, duration)
            sequence:Insert(delay, tween)
          end
          local color = nil
          if tweenCfg.posId ~= nil and imgType == eAvgImgType.Character then
            if picPosData == nil then
              picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
            end
            if picPosData ~= nil then
              color = rawImg.color
              color.a = picPosData.alpha
            end
          end
          if tweenCfg.alpha ~= nil then
            if color == nil then
              color = rawImg.color
            end
            color.a = tweenCfg.alpha
          end
          do
            if not tweenCfg.isDark or not 0.5 then
              local value = tweenCfg.isDark == nil or 1
            end
            if color == nil then
              color = rawImg.color
            end
            color.r = value
            color.g = value
            color.b = value
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgImgTweenUntil = {}
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local CS_DOTween = ((CS.DG).Tweening).DOTween
local CS_RotateMode = ((CS.DG).Tweening).RotateMode
AvgImgTweenUntil.Tween = function(imgItem, tweenCfg)
    -- function num : 0_0 , upvalues : CS_DOTween, _ENV, eAvgImgType, eAvgImgPosType, CS_RotateMode
    local transform = imgItem.transform
    local rawImg = (imgItem.ui).rawImg
    local imgType = imgItem:GetAvgImgType()
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
        local picPosData, pos = nil, nil
        if tweenCfg.posId ~= nil then
            if imgType == eAvgImgType.Character then
                if picPosData == nil then
                    picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
                end
                if picPosData ~= nil then pos = picPosData.pos end
            else
                pos = eAvgImgPosType[tweenCfg.posId]
            end
        else
            if tweenCfg.pos ~= nil then
                pos = (Vector3.New)((tweenCfg.pos)[1], (tweenCfg.pos)[2],
                                    (tweenCfg.pos)[3])
            end
        end
        do
            if pos ~= nil then
                local tween = transform:DOLocalMove(pos, duration)
                sequence:Insert(delay, tween)
            end
            if tweenCfg.rot ~= nil then
                local rot = (Vector3.New)((tweenCfg.rot)[1], (tweenCfg.rot)[2],
                                          (tweenCfg.rot)[3])
                local tween = transform:DOLocalRotate(rot, duration,
                                                      CS_RotateMode.FastBeyond360)
                sequence:Insert(delay, tween)
            end
            do
                local scale = nil
                if tweenCfg.posId ~= nil and imgType == eAvgImgType.Character then
                    if picPosData == nil then
                        picPosData = imgItem:GetAvgHeroPicResetData(
                                         tweenCfg.posId)
                    end
                    if picPosData ~= nil then
                        scale = picPosData.scale
                    end
                else
                    if tweenCfg.scale ~= nil then
                        scale = (Vector3.New)((tweenCfg.scale)[1],
                                              (tweenCfg.scale)[2],
                                              (tweenCfg.scale)[3])
                    end
                end
                do
                    if scale ~= nil then
                        local tween = transform:DOScale(scale, duration)
                        sequence:Insert(delay, tween)
                    end
                    local color = nil
                    if tweenCfg.posId ~= nil and imgType ==
                        eAvgImgType.Character then
                        if picPosData == nil then
                            picPosData =
                                imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
                        end
                        if picPosData ~= nil then
                            color = rawImg.color
                            color.a = picPosData.alpha
                        end
                    end
                    if tweenCfg.alpha ~= nil then
                        if color == nil then
                            color = rawImg.color
                        end
                        color.a = tweenCfg.alpha
                    end
                    do
                        if not tweenCfg.isDark or not 0.5 then
                            local value = tweenCfg.isDark == nil or 1
                        end
                        if color == nil then
                            color = rawImg.color
                        end
                        color.r = value
                        color.g = value
                        color.b = value
                        do
                            if color ~= nil then
                                local tween = rawImg:DOColor(color, duration)
                                sequence:Insert(delay, tween)
                            end
                            do
                                if tweenCfg.shake ~= nil then
                                    local tween =
                                        transform:DOShakePosition(duration,
                                                                  (Vector3.New)(
                                                                      10, 10, 0),
                                                                  20)
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

