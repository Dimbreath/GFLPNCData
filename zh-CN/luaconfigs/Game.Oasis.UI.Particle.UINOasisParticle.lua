-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisParticle = class("UINOasisParticle", UIBaseNode)
local UINOasisParticleItem = require("Game.Oasis.UI.Particle.UINOasisParticleItem")
local base = UIBaseNode
UINOasisParticle.ctor = function(self, oasisMain)
  -- function num : 0_0
  self.oasisMain = oasisMain
end

UINOasisParticle.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINOasisParticleItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.particlePool = (UIItemPool.New)(UINOasisParticleItem, (self.ui).particleItem)
  ;
  ((self.ui).particleItem):SetActive(false)
  self.parItemDic = {}
  self.onResFlyAniOver = BindCallback(self, self.OnResFlyAniOver)
end

UINOasisParticle.InitOasisParticle = function(self, oasisCtrl, topResUIPosDic, selBuildItems, resProgressDic)
  -- function num : 0_2 , upvalues : _ENV
  self.oasisCtrl = oasisCtrl
  ;
  (self.particlePool):HideAll()
  for buildId,buildItem in pairs(selBuildItems) do
    local resId = buildItem:GetResItemId()
    local resUiPos = buildItem:GetUIResPos()
    local targetPos = topResUIPosDic[resId]
    if not resProgressDic[buildId] then
      local progress = targetPos == nil or 1
    end
    local num = (math.max)((math.ceil)(progress * 8), 1)
    local particleItem = (self.particlePool):GetOne()
    particleItem:InitParticleItem(resId, resUiPos, targetPos, self.onResFlyAniOver, num)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (self.parItemDic)[buildId] = particleItem
    self:UpdateOasisResPaticlePos(buildId)
  end
end

UINOasisParticle.UpdateOasisResPaticlePosAll = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for buildId,v in pairs(self.parItemDic) do
    self:UpdateOasisResPaticlePos(buildId)
  end
end

UINOasisParticle.UpdateOasisResPaticlePos = function(self, buildId)
  -- function num : 0_4
  local parItem = (self.parItemDic)[buildId]
  local buildItem = (self.oasisCtrl):GetOasisBuildItemById(buildId)
  if parItem ~= nil and buildItem ~= nil then
    local resUiPos = buildItem:GetUIResPos()
    parItem:UpdateRootPos(resUiPos)
  end
end

UINOasisParticle.OnResFlyAniOver = function(self, item)
  -- function num : 0_5
  (self.particlePool):HideOne(item)
end

UINOasisParticle.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.particlePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINOasisParticle

