-- params : ...
-- function num : 0 , upvalues : _ENV
local AllEventNoviceSignData = class("AllEventNoviceSignData")
local EventNoviceSignData = require("Game.EventNoviceSign.EventNoviceSignData")
AllEventNoviceSignData.ctor = function(self)
  -- function num : 0_0
  self.dataDic = {}
end

AllEventNoviceSignData.InitNoviceSignData = function(self, signActs)
  -- function num : 0_1 , upvalues : _ENV, EventNoviceSignData
  self.dataDic = {}
  for i,v in ipairs(signActs) do
    local data = (EventNoviceSignData.New)()
    data:InitNoviceSignData(v)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.dataDic)[v.id] = data
  end
end

AllEventNoviceSignData.UpdateNoviceSignData = function(self, signAct)
  -- function num : 0_2 , upvalues : EventNoviceSignData
  local data = (self.dataDic)[signAct.id]
  if data == nil then
    data = (EventNoviceSignData.New)()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.dataDic)[signAct.id] = data
    data:InitNoviceSignData(signAct)
  else
    data:UpdateNoviceSignData(signAct)
  end
end

return AllEventNoviceSignData

