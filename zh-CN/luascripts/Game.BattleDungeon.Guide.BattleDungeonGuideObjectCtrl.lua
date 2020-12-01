-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleDungeonObjectCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonObjectCtrl")
local BattleDungeonGuideObjectCtrl = class("BattleDungeonGuideObjectCtrl", BattleDungeonObjectCtrl)
BattleDungeonGuideObjectCtrl.ctor = function(self, bdCtrl, guideType)
  -- function num : 0_0
  self.guideType = guideType
end

BattleDungeonGuideObjectCtrl.DungeonOverRewardsLogic = function(self, rewardMsg)
  -- function num : 0_1 , upvalues : BattleDungeonObjectCtrl
  if self.guideType == 2 then
    self.battleWin = rewardMsg.result
    self.dontShowResult = true
  else
    ;
    (BattleDungeonObjectCtrl.DungeonOverRewardsLogic)(self, rewardMsg)
  end
end

return BattleDungeonGuideObjectCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleDungeonObjectCtrl = require(
                                    "Game.BattleDungeon.Ctrl.BattleDungeonObjectCtrl")
local BattleDungeonGuideObjectCtrl = class("BattleDungeonGuideObjectCtrl",
                                           BattleDungeonObjectCtrl)
BattleDungeonGuideObjectCtrl.ctor = function(self, bdCtrl, guideType)
    -- function num : 0_0
    self.guideType = guideType
end

BattleDungeonGuideObjectCtrl.DungeonOverRewardsLogic =
    function(self, rewardMsg)
        -- function num : 0_1 , upvalues : BattleDungeonObjectCtrl
        if self.guideType == 2 then
            self.battleWin = rewardMsg.result
            self.dontShowResult = true
        else

            (BattleDungeonObjectCtrl.DungeonOverRewardsLogic)(self, rewardMsg)
        end
    end

return BattleDungeonGuideObjectCtrl

