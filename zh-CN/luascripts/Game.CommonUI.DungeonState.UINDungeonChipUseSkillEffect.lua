-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonChipUseSkillEffect = class("UINDungeonChipUseSkillEffect", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local cs_Material = (CS.UnityEngine).Material
UINDungeonChipUseSkillEffect.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_Material
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__OnPlayEnd = BindCallback(self, self.OnPlayEnd)
  self.onPlayEndCallBack = nil
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).eff_OutLine).material = cs_Material(((self.ui).eff_OutLine).material)
  ;
  ((self.ui).ui_3dModifier):SetMat(((self.ui).eff_OutLine).material)
end

UINDungeonChipUseSkillEffect.PlayEffect = function(self, time, chipItem)
  -- function num : 0_1 , upvalues : _ENV
  if type(time) ~= "number" or time == 0 then
    time = 1
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).eff_OutLine).material).color = ItemQualityColor[(chipItem.chipData).quality]
  ;
  (self.transform):SetParent(chipItem.transform)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).position = (((chipItem.ui).obj_propGlobalItem).transform).position
  if self.tween ~= nil then
    (self.tween):Kill(true)
  end
  self.tween = ((((self.ui).eff_OutLine).material):DOFloat(1, "_UI_Player", time)):OnComplete(self.__OnPlayEnd)
end

UINDungeonChipUseSkillEffect.OnPlayEnd = function(self)
  -- function num : 0_2
  if self.onPlayEndCallBack ~= nil then
    (self.onPlayEndCallBack)(self)
  end
end

UINDungeonChipUseSkillEffect.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  (self.tween):Kill()
  self.tween = nil
  DestroyUnityObject(((self.ui).eff_OutLine).material)
  ;
  (base.OnDelete)(self)
end

return UINDungeonChipUseSkillEffect

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonChipUseSkillEffect = class("UINDungeonChipUseSkillEffect",
                                           UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local cs_Material = (CS.UnityEngine).Material
UINDungeonChipUseSkillEffect.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, cs_Material
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.__OnPlayEnd = BindCallback(self, self.OnPlayEnd)
    self.onPlayEndCallBack = nil -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).eff_OutLine).material = cs_Material(
                                           ((self.ui).eff_OutLine).material);
    ((self.ui).ui_3dModifier):SetMat(((self.ui).eff_OutLine).material)
end

UINDungeonChipUseSkillEffect.PlayEffect =
    function(self, time, chipItem)
        -- function num : 0_1 , upvalues : _ENV
        if type(time) ~= "number" or time == 0 then time = 1 end -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
        
        (((self.ui).eff_OutLine).material).color =
            ItemQualityColor[(chipItem.chipData).quality];
        (self.transform):SetParent(chipItem.transform) -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.transform).position =
            (((chipItem.ui).obj_propGlobalItem).transform).position
        if self.tween ~= nil then (self.tween):Kill(true) end
        self.tween = ((((self.ui).eff_OutLine).material):DOFloat(1,
                                                                 "_UI_Player",
                                                                 time)):OnComplete(
                         self.__OnPlayEnd)
    end

UINDungeonChipUseSkillEffect.OnPlayEnd =
    function(self)
        -- function num : 0_2
        if self.onPlayEndCallBack ~= nil then
            (self.onPlayEndCallBack)(self)
        end
    end

UINDungeonChipUseSkillEffect.OnDelete = function(self)
    -- function num : 0_3 , upvalues : _ENV, base
    (self.tween):Kill()
    self.tween = nil
    DestroyUnityObject(((self.ui).eff_OutLine).material);
    (base.OnDelete)(self)
end

return UINDungeonChipUseSkillEffect

