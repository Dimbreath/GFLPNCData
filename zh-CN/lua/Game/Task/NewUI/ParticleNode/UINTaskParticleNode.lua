local UINTaskParticleNode = class("UINTaskParticleNode", UIBaseNode)
local base = UIBaseNode
local UINTaskLivelyParticleItem = require("Game.Task.NewUI.ParticleNode.UINTaskLivelyParticleItem")
UINTaskParticleNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINTaskLivelyParticleItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).particleItem):SetActive(false)
  self.particlePool = (UIItemPool.New)(UINTaskLivelyParticleItem, (self.ui).particleItem)
  self._OnResFlyAniOverFunc = BindCallback(self, self._OnResFlyAniOver)
end

UINTaskParticleNode.HideTaskParticle = function(self)
  -- function num : 0_1
  (self.particlePool):HideAll()
end

UINTaskParticleNode.FlyTaskLively = function(self, startPos, targetPos)
  -- function num : 0_2
  local resflyAni = (self.particlePool):GetOne()
  resflyAni:InitTaskLivelyParticleItem(startPos, targetPos, self._OnResFlyAniOverFunc)
end

UINTaskParticleNode._OnResFlyAniOver = function(self, item)
  -- function num : 0_3
  (self.particlePool):HideOne(item)
end

UINTaskParticleNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.particlePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINTaskParticleNode

