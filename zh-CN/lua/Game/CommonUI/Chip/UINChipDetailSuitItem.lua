local UINChipDetailSuitItem = class("UINChipDetailSuitItem", UIBaseNode)
local base = UIBaseNode
local cs_Image = ((CS.UnityEngine).UI).Image
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
UINChipDetailSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._countList = {}
  self._countPool = {}
  ;
  (table.insert)(self._countList, (self.ui).img_CountItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_CountItem).fillAmount = 0
end

UINChipDetailSuitItem.InitChipDetailSuit = function(self, tagId)
  -- function num : 0_1 , upvalues : _ENV
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(chipTagCfg.tag_icon, CommonAtlasType.ExplorationIcon)
end

UINChipDetailSuitItem.InitChipDetailSuitAndCount = function(self, tagId, haveCount, maxCount, dynPlayer, isOwnData, isFirstGet)
  -- function num : 0_2 , upvalues : _ENV, cs_DoTweenLoopType
  self.haveCount = haveCount
  self:InitChipDetailSuit(tagId)
  self:_RecycleAll()
  if maxCount == 0 then
    return 
  end
  local unitAngle = 360
  unitAngle = unitAngle / maxCount
  for i = 1, maxCount do
    local ring = self:_GetOne(true)
    if haveCount - i < 0 or not Color.white then
      do
        ring.color = (Color.New)(1, 1, 1, 0.3)
        ring.fillAmount = 1 / maxCount - (self.ui).float_Block
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (ring.transform).localRotation = (Quaternion.Euler)(0, 0, -((i - 1) * (unitAngle)))
        -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tran_CountNode).localRotation = (Quaternion.Euler)(0, 0, -((self.ui).float_Block * 100 * 2))
  if dynPlayer ~= nil and not isOwnData and isFirstGet then
    local compoment = (self._countList)[haveCount + 1]
    if compoment == nil then
      return 
    end
    compoment.color = Color.white
    local t = Time.time % 1.4
    ;
    ((((compoment:DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(compoment.gameObject)):Goto(t, true)
  end
end

UINChipDetailSuitItem._RecycleAll = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if #self._countList <= 0 then
    return 
  end
  while #self._countList > 0 do
    local compoment = (table.remove)(self._countList, #self._countList)
    ;
    (compoment.gameObject):SetActive(false)
    compoment:DOKill()
    ;
    (table.insert)(self._countPool, compoment)
  end
end

UINChipDetailSuitItem._GetOne = function(self, active)
  -- function num : 0_4 , upvalues : _ENV, cs_Image
  local compoment = nil
  if #self._countPool > 0 then
    compoment = (table.remove)(self._countPool, #self._countPool)
  else
    local go = ((self.ui).img_CountItem):Instantiate()
    compoment = go:GetComponent(typeof(cs_Image))
  end
  do
    ;
    (table.insert)(self._countList, compoment)
    ;
    (compoment.gameObject):SetActive(active)
    return compoment
  end
end

UINChipDetailSuitItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  self:_RecycleAll()
  self._countPool = nil
  ;
  (base.OnDelete)(self)
end

return UINChipDetailSuitItem

