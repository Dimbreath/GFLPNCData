-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Base = require("Game.Guide.GuideType.GuideType_Base")
local GuideType_Tips = class("GuideType_Tips", GuideType_Base)
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local CS_GameObject = (CS.UnityEngine).GameObject
local Type_RectTransform = typeof((CS.UnityEngine).RectTransform)
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
GuideType_Tips.ctor = function(self)
  -- function num : 0_0
  self.isTipsGuideEnd = false
end

GuideType_Base.NeedWaitWarn = function(self)
  -- function num : 0_1
  return false
end

GuideType_Tips.StartGuide = function(self, tipsGuideCfg)
  -- function num : 0_2
  self.tipsGuideCfg = tipsGuideCfg
  self:StartTipsGuide()
end

GuideType_Tips.EndGuide = function(self, success)
  -- function num : 0_3
  self.curTargetTransform = nil
  self.curBindTransform = nil
  if self.waitTimer ~= nil then
    (self.waitTimer):Stop()
    self.waitTimer = nil
  end
  self.tipsGuideCfg = nil
  self.isTipsGuideEnd = true
end

GuideType_Tips.StartTipsGuide = function(self)
  -- function num : 0_4 , upvalues : GuideEnum, _ENV
  if (self.tipsGuideCfg).type == (GuideEnum.TipsGuideType).Normal then
    if (self.tipsGuideCfg).target_type == 0 then
      self:RunCurStep()
    else
      if (self.tipsGuideCfg).target_type == 1 then
        self:NextWaitUIWindow(self.tipsGuideCfg)
      else
        if (self.tipsGuideCfg).target_type == 2 then
          self:NextWaitScene(self.tipsGuideCfg, BindCallback(self, self.NextWaitSceneTarget, self.tipsGuideCfg))
        else
          if (self.tipsGuideCfg).target_type == 3 then
            self:NextWaitScriptTarget(self.tipsGuideCfg)
          else
            error("tipsGuideCfg target_type error,id:" .. tostring((self.tipsGuideCfg).id))
            self:EndGuide(false)
          end
        end
      end
    end
  else
    if (self.tipsGuideCfg).type == (GuideEnum.TipsGuideType).Code then
      self:RunNextInternal(self.tipsGuideCfg)
    else
      error("tipsGuideCfg type error,id:" .. tostring((self.tipsGuideCfg).id))
      self:EndGuide(false)
    end
  end
end

GuideType_Tips.RunCurStep = function(self)
  -- function num : 0_5 , upvalues : GuideType_Base, GuideEnum, _ENV
  (GuideType_Base.RunCurStep)(self)
  if (self.tipsGuideCfg).type == (GuideEnum.TipsGuideType).Normal then
    self:__PlayNormalUITipsGuide()
  else
    if (self.tipsGuideCfg).type == (GuideEnum.TipsGuideType).Code then
      local guideCode = load((self.tipsGuideCfg).custom_code)
      if guideCode == nil then
        warn((string.format)("tips guide load code error id[%d],", (self.tipsGuideCfg).id))
        self:EndGuide(false)
        return 
      end
      local status, current = xpcall(guideCode, debug.traceback)
      if not status then
        error(current)
      else
        self:EndGuide(current)
      end
    end
  end
end

GuideType_Tips.__PlayNormalUITipsGuide = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self.tipsGuideCfg).target_type == 1 then
    local targetWindow = UIManager:GetWindow((self.tipsGuideCfg).target_parent)
    if targetWindow == nil then
      self:EndGuide(false)
      return 
    end
    local targetTrans = (targetWindow.transform):Find((self.tipsGuideCfg).target_name)
    if IsNull(targetTrans) then
      warn((string.format)("guide error,%s Id[%d],target Transform is null", (self.__class_type).__cname, (self.tipsGuideCfg).id))
      self:EndGuide(false)
      return 
    end
    self.curTargetTransform = targetTrans
  end
  do
    self:__PlayTipsGuide()
  end
end

GuideType_Tips.__PlayTipsGuide = function(self)
  -- function num : 0_7 , upvalues : _ENV, Type_RectTransform, CS_GameObject
  if IsNull(self.curTargetTransform) then
    warn((string.format)("guide error,%s Id[%d],play target Transform is null", (self.__class_type).__cname, (self.tipsGuideCfg).id))
    self:EndGuide(false)
    return 
  end
  local isRectTrasform = true
  if (self.tipsGuideCfg).target_type > 1 then
    isRectTrasform = (GR.IsType)(self.curTargetTransform, Type_RectTransform)
  end
  if not isRectTrasform then
    if (self.tipsGuideCfg).target_type == 2 then
      local bindObj = (CS_GameObject.Find)((self.tipsGuideCfg).target_name)
      if IsNull(bindObj) then
        warn((string.format)("guide error,%s Id[%d],bind transform is null", (self.__class_type).__cname, (self.tipsGuideCfg).id))
        self:EndGuide(false)
        return 
      end
      self.curBindTransform = bindObj.transform
    else
      do
        if (self.tipsGuideCfg).target_type == 3 then
          local configFunc = load((self.tipsGuideCfg).target_name)
          local targetBindTrans = configFunc()
          if IsNull(targetBindTrans) then
            warn((string.format)("guide error,%s Id[%d],bind transform is null", (self.__class_type).__cname, (self.tipsGuideCfg).id))
            self:EndGuide(false)
            return 
          end
          self.curBindTransform = targetBindTrans.transform
        else
          do
            self:EndGuide(false)
            do return  end
            local success = false
            if isRectTrasform then
              (GuideManager.resloader):LoadABAssetAsync(PathConsts:GetUIPrefabPath(GuideUtil.TipsGuidePrefabName), function(guidePrefab)
    -- function num : 0_7_0 , upvalues : self
    self:ShowUITipsGuide(guidePrefab)
  end
)
            end
          end
        end
      end
    end
  end
end

GuideType_Tips.ShowUITipsGuide = function(self, guidePrefab)
  -- function num : 0_8 , upvalues : _ENV
  if self.isTipsGuideEnd then
    return 
  end
  if IsNull(self.curTargetTransform) then
    self:EndGuide(false)
    return 
  end
  ;
  (GuideUtil.ShowTipsGuide)(self.curTargetTransform, guidePrefab, (self.tipsGuideCfg).show_dir)
  self:EndGuide(true)
end

GuideType_Tips.TryClearTipsGuide = function(id)
  -- function num : 0_9 , upvalues : _ENV, GuideConditionChecker, GuideEnum, CS_GSceneManager_Ins, CS_GameObject
  local tipsGuideCfg = (ConfigData.tips_guide)[id]
  if tipsGuideCfg == nil then
    error("tips_guide Cfg is null,id:" .. tostring(id))
    return 
  end
  if not (GuideConditionChecker.CheckGuideCondition)(tipsGuideCfg.condition, tipsGuideCfg.condition_arg) then
    return 
  end
  local curTargetTransform = nil
  if tipsGuideCfg.type == (GuideEnum.TipsGuideType).Normal then
    if tipsGuideCfg.target_type ~= 0 or tipsGuideCfg.target_type == 1 then
      local targetWindow = UIManager:GetWindow(tipsGuideCfg.target_parent)
      if targetWindow ~= nil then
        curTargetTransform = (targetWindow.transform):Find(tipsGuideCfg.target_name)
      end
    else
      do
        do
          -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

          if tipsGuideCfg.target_type == 2 and ((string.IsNullOrEmpty)(tipsGuideCfg.target_parent) or CS_GSceneManager_Ins.curSceneName == tipsGuideCfg.target_parent) then
            local targetObj = (CS_GameObject.Find)(tipsGuideCfg.target_name)
            if not IsNull(targetObj) then
              curTargetTransform = targetObj.transform
            end
          end
          if tipsGuideCfg.target_type == 3 then
            local configFunc = load(tipsGuideCfg.target_name)
            if configFunc ~= nil then
              local target = configFunc()
              if not IsNull(target) then
                curTargetTransform = target.transform
              end
            end
          end
          do
            if tipsGuideCfg.type == (GuideEnum.TipsGuideType).Code then
              if not (string.IsNullOrEmpty)(tipsGuideCfg.custom_code_clear) then
                local guideCode = load(tipsGuideCfg.custom_code_clear)
                if guideCode ~= nil then
                  local status, current = xpcall(guideCode, debug.traceback)
                  if not status then
                    error(current)
                  end
                end
              end
              do
                do return  end
                if not IsNull(curTargetTransform) then
                  local tipsGuideNodeName = (GuideUtil.GetTipsGuideNodeName)(curTargetTransform.name)
                  local tipsGuideNode = curTargetTransform:Find(tipsGuideNodeName)
                  if not IsNull(tipsGuideNode) then
                    DestroyUnityObject(tipsGuideNode.gameObject)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return GuideType_Tips

