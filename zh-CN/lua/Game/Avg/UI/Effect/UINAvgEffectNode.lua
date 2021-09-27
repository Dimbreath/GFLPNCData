local UINAvgEffectNode = class("UINAvgEffectNode", UIBaseNode)
local base = UIBaseNode
local UINAvgEffectItem = require("Game.Avg.UI.Effect.UINAvgEffectItem")
local CS_ResLoader = CS.ResLoader
UINAvgEffectNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAvgEffectItem, CS_ResLoader
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).effectItem):SetActive(false)
  self.effectItemPool = (UIItemPool.New)(UINAvgEffectItem, (self.ui).effectItem)
  self.effectItemDic = {}
  self.resLoader = (CS_ResLoader.Create)()
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

UINAvgEffectNode.PlayAvgEffect = function(self, effectCfg)
  -- function num : 0_1 , upvalues : _ENV
  if effectCfg == nil then
    return 
  end
  local layer = effectCfg.layer or 2
  if #(self.ui).layerList < layer or layer < 1 then
    (self.avgCtrl):AvgLogError("Avg effect layer error, layer = " .. tostring(layer))
    return 
  end
  local stopList = nil
  for k,v in pairs(effectCfg) do
    if k == "stopList" then
      stopList = v
    else
      local effectItem = (self.effectItemDic)[k]
      if effectItem == nil then
        local parent = ((self.ui).layerList)[layer]
        local effectItem = (self.effectItemPool):GetOne()
        effectItem:InitAvgEffectItem(k, v.prefabName, self.resLoader, v.pos, parent)
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.effectItemDic)[k] = effectItem
      else
        do
          do
            effectItem:PlayAvgEffect()
            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if stopList ~= nil then
    for k,id in pairs(stopList) do
      local effectItem = (self.effectItemDic)[id]
      if effectItem ~= nil then
        effectItem:StopAvgEffect()
      end
    end
  end
end

UINAvgEffectNode.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.effectItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAvgEffectNode

