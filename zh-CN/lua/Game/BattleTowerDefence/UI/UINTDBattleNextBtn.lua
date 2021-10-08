local UINTDBattleNextBtn = class("UINTDBattleNextBtn", UIBaseNode)
local base = UIBaseNode
UINTDBattleNextBtn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_next, self, self.OnClickNextWave)
end

UINTDBattleNextBtn.SetNextWaveCallback = function(self, callback)
  -- function num : 0_1
  self.callback = callback
end

UINTDBattleNextBtn.RefreshNextBtnState = function(self, curWave, maxWave, rewardCount)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_Count):SetIndex(0, tostring(curWave), tostring(maxWave))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_CCCount).text = tostring(rewardCount)
end

UINTDBattleNextBtn.RefreshRewardCount = function(self, rewardCount)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_CCCount).text = tostring(rewardCount)
end

UINTDBattleNextBtn.OnClickNextWave = function(self)
  -- function num : 0_4
  self:Hide()
  if self.callback ~= nil then
    (self.callback)()
  end
end

return UINTDBattleNextBtn

