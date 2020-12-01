-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrSPointBingo = class("UINLtrSPointBingo", UIBaseNode)
local base = UIBaseNode
UINLtrSPointBingo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrSPointBingo.InitLtrSPointBingo = function(self, pos)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).anchoredPosition = pos
  ;
  ((self.ui).anim):Rewind()
  ;
  ((self.ui).anim):Play("UI_LSPointBingo_Enter")
  AudioManager:PlayAudioById(1051)
end

UINLtrSPointBingo.PlayLtrSPointBingoExit = function(self)
  -- function num : 0_2 , upvalues : _ENV
  AudioManager:PlayAudioById(1052)
  ;
  ((self.ui).anim):Play("UI_LSPointBingo_Exit")
end

UINLtrSPointBingo.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrSPointBingo

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrSPointBingo = class("UINLtrSPointBingo", UIBaseNode)
local base = UIBaseNode
UINLtrSPointBingo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrSPointBingo.InitLtrSPointBingo = function(self, pos)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.transform).anchoredPosition = pos;
    ((self.ui).anim):Rewind();
    ((self.ui).anim):Play("UI_LSPointBingo_Enter")
    AudioManager:PlayAudioById(1051)
end

UINLtrSPointBingo.PlayLtrSPointBingoExit =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        AudioManager:PlayAudioById(1052);
        ((self.ui).anim):Play("UI_LSPointBingo_Exit")
    end

UINLtrSPointBingo.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINLtrSPointBingo

