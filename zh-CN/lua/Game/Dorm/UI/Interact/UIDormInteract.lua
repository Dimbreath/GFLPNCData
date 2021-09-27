local UIDormInteract = class("UIDormInteract", UIBaseWindow)
local base = UIBaseWindow
local UINDormInteractItem = require("Game.Dorm.UI.Interact.UINDormInteractItem")
local cs_Tweening = (CS.DG).Tweening
local cs_Ease = cs_Tweening.Ease
local cs_DoTween = cs_Tweening.DOTween
UIDormInteract.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDormInteractItem
  self.interactList = (UIItemPool.New)(UINDormInteractItem, (self.ui).interactItem)
  ;
  ((self.ui).interactItem):SetActive(false)
  self._resLoader = ((CS.ResLoader).Create)()
  local iconPath = PathConsts:GetSpriteAtlasPath("UI_DormRoom")
  self._iconAtlas = (self._resLoader):LoadABAsset(iconPath)
end

UIDormInteract.UpdateInteractList = function(self, interActionList)
  -- function num : 0_1 , upvalues : _ENV, cs_DoTween, cs_Ease
  (self.interactList):HideAll()
  for _,interAction in pairs(interActionList) do
    local interactItem = (self.interactList):GetOne()
    interactItem:InitInteractActionItem(interAction, self._iconAtlas)
  end
  if self._listCount == #interActionList then
    return 
  end
  if #interActionList ~= 0 then
    if self._listSeq ~= nil then
      (self._listSeq):Restart()
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).fade_List).transform).localScale = Vector3.one
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).fade_List).alpha = 1
      local listSeq = (cs_DoTween.Sequence)()
      listSeq:Append((((((self.ui).fade_List).transform):DOScale((Vector3.New)(0.98, 0.98, 1), 0.95)):From()):SetEase(cs_Ease.OutElastic))
      listSeq:Join((((self.ui).fade_List):DOFade(0.6, 0.25)):From())
      listSeq:SetAutoKill(false)
      self._listSeq = listSeq
    end
  end
  do
    self._listCount = #interActionList
  end
end

UIDormInteract.HideInteractList = function(self)
  -- function num : 0_2
  (self.interactList):HideAll()
end

UIDormInteract.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  if self._listSeq ~= nil then
    (self._listSeq):Kill()
    self._listSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIDormInteract

