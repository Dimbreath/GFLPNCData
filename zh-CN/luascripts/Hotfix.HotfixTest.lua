-- params : ...
-- function num : 0 , upvalues : _ENV
local M = class("HotfixTest", HotfixBase)
local OasisCameraController = CS.OasisCameraController
;
(xlua.private_accessible)(CS.OasisCameraController)
local EnableBlur = function(self, enable)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.m_cameraBlur).enabled = enable
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.m_focusAssistCam).enabled = enable
  warn("EnableBlur in lua" .. (self.gameObject).name)
end

local EnableBlur_RetainOld = function(self, enable)
  -- function num : 0_1 , upvalues : _ENV
  self:EnableBlur(enable)
  warn("EnableBlur in lua" .. (self.gameObject).name)
end

M.Register = function(self)
  -- function num : 0_2 , upvalues : OasisCameraController, EnableBlur_RetainOld
  self:RegisterHotfix(OasisCameraController, "EnableBlur", EnableBlur_RetainOld, true)
end

return M

