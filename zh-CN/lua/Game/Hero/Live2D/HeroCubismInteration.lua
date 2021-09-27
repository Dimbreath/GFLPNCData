local HeroCubismInteration = class("HeroCubismInteration")
HeroCubismInteration.ctor = function(self)
  -- function num : 0_0
end

HeroCubismInteration.InitHeroCubism = function(self, cs_CubismInterationController, heroId, heroSkinId, camera, flag)
  -- function num : 0_1 , upvalues : _ENV
  self.cs_CubismInterationController = cs_CubismInterationController
  if flag then
    self.backAction = BindCallback(self, self.BackAction)
    ;
    (self.cs_CubismInterationController):OnAnimationPlayEvent("+", self.backAction)
  end
  self.cs_rayCast = (self.cs_CubismInterationController):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).Raycasting).CubismRaycaster))
  self.shortTime = ((ConfigData.game_config).l2dWaitAnimationTime).ShortTime
  self.longTime = ((ConfigData.game_config).l2dWaitAnimationTime).LongTime
  ;
  (self.cs_CubismInterationController):InitController(true, true, self.shortTime, self.longTime, camera)
  self.heroId = heroId
  self.heroSkinId = heroSkinId
  self.IsCvOverBank = BindCallback(self, self.IsCVOver)
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  if self.heroSkinId ~= 0 then
    self.config = (ConfigData.skin_live2d)[self.heroSkinId]
  else
    self.config = (ConfigData.skin_live2d)[self.heroId]
  end
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.cs_CubismInterationController).enabled = true
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.cs_CubismInterationController).OpenGuiJudge = true
end

HeroCubismInteration.JudgeL2DLocked = function(heroSkinId)
  -- function num : 0_2 , upvalues : _ENV
  if heroSkinId == 0 then
    return false
  end
  if (ConfigData.skin)[heroSkinId] == nil then
    return false
  end
  do return ((ConfigData.skin)[heroSkinId]).is_locked == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HeroCubismInteration.InitShopCubism = function(self, cs_CubismInterationController, camera, callFunction)
  -- function num : 0_3 , upvalues : _ENV
  self.cs_CubismInterationController = cs_CubismInterationController
  self.cs_rayCast = (self.cs_CubismInterationController):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).Raycasting).CubismRaycaster))
  self.shopCallFunction = callFunction
  ;
  (self.cs_CubismInterationController):OnAnimationPlayEvent("+", self.shopCallFunction)
  self.shortTime = ((ConfigData.game_config).l2dWaitAnimationTime).ShortTime
  self.longTime = ((ConfigData.game_config).l2dWaitAnimationTime).LongTime
  ;
  (self.cs_CubismInterationController):InitController(true, true, self.shortTime, self.longTime, camera)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.cs_CubismInterationController).enabled = true
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.cs_CubismInterationController).OpenGuiJudge = false
end

HeroCubismInteration.BackAction = function(self, hitArea, animName, animLength)
  -- function num : 0_4 , upvalues : _ENV
  if self.config == nil then
    warn("英雄:" .. self.heroId .. "{" .. animName .. "}动作的cv未适配")
    return 
  end
  local cvIds = nil
  if (string.find)(animName, "wait") ~= nil then
    cvIds = ((self.config).waitIds)[animName]
  else
    if (string.find)(animName, "touch") ~= nil then
      cvIds = ((self.config).touchIds)[animName]
    else
      if (string.find)(animName, "idle") ~= nil then
        cvIds = ((self.config).idleIds)[animName]
      else
        if (string.find)(animName, "assign") ~= nil then
          cvIds = {tonumber(((string.split)(animName, "_"))[2])}
        else
          warn("英雄:" .. self.heroId .. "{" .. animName .. "}动作对照CV查表失败")
          return 
        end
      end
    end
  end
  if cvIds == nil or (table.length)(cvIds) == 0 then
    warn("英雄:" .. self.heroId .. "{" .. animName .. "}动作的cv未适配")
    return 
  end
  local cvId = nil
  local index = (math.random)(#cvIds)
  cvId = cvIds[index]
  if self.homeController ~= nil then
    (self.homeController):PlayHomeVoice(self.heroId, cvId, self.IsCvOverBank, animLength)
  end
end

HeroCubismInteration.IsCVOver = function(self, flag)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if self.cs_CubismInterationController ~= nil then
    (self.cs_CubismInterationController).IsCVOver = flag
  end
end

HeroCubismInteration.IsOpenWait = function(self, flag)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if self.cs_CubismInterationController ~= nil then
    (self.cs_CubismInterationController).IsOpenWait = flag
  end
end

HeroCubismInteration.IsOpenRayCast = function(self, flag)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if self.cs_rayCast ~= nil then
    (self.cs_rayCast).enabled = flag
  end
end

HeroCubismInteration.PlayHeroLive2DWait = function(self)
  -- function num : 0_8
  (self.cs_CubismInterationController):PlayWaitLive2D()
end

HeroCubismInteration.PlayLoginAnimation = function(self, loginType)
  -- function num : 0_9
  return (self.cs_CubismInterationController):PlayeLoginAni(loginType, true)
end

HeroCubismInteration.PlayShopLoginAnimation = function(self, loginType)
  -- function num : 0_10
  return (self.cs_CubismInterationController):PlayeLoginAni(loginType, true)
end

HeroCubismInteration.PlayBuyAnimation = function(self, idx)
  -- function num : 0_11
  return (self.cs_CubismInterationController):PlayeSpecialAni(idx, false)
end

HeroCubismInteration.Delete = function(self)
  -- function num : 0_12
  if self.cs_CubismInterationController ~= nil then
    if self.backAction ~= nil then
      (self.cs_CubismInterationController):OnAnimationPlayEvent("-", self.backAction)
    end
    if self.shopCallFunction ~= nil then
      (self.cs_CubismInterationController):OnAnimationPlayEvent("-", self.shopCallFunction)
    end
    self.cs_CubismInterationController = nil
  end
end

return HeroCubismInteration

