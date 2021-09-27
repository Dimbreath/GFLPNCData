local DormFightConst = require("Game.Fight.DormFightConst")
local CharacterFactory = {}
CharacterFactory.CreateCharacter = function(characterType)
  -- function num : 0_0 , upvalues : DormFightConst, _ENV
  local res = nil
  if characterType == (DormFightConst.CharacterType).Player then
    res = ((require("Game.Fight.Character.Entity.DormFightPlayerCharacter")).New)()
  else
    if characterType == (DormFightConst.CharacterType).Npc then
      res = ((require("Game.Fight.Character.Entity.DormFightNpcCharacter")).New)()
    end
  end
  return res
end

return CharacterFactory

