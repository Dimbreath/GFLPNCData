local UINLtrPoolRecordItem = class("UINLtrPoolRecordItem", UIBaseNode)
local base = UIBaseNode
UINLtrPoolRecordItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrPoolRecordItem.InitItem = function(self, records)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Time).text = (os.date)("%y/%m/%d %H:%M:%S", records.ts)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PoolName).text = (LanguageUtil.GetLocaleText)(((ConfigData.lottery_para)[records.poolId]).name)
  local item = (ConfigData.item)[records.itemId]
  local star = (item.arg)[2]
  local count = (math.ceil)(star / 2)
  local pre = ""
  for i = 1, count do
    pre = pre .. "★"
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

  if count == 3 then
    ((self.ui).img_recordItem).color = (self.ui).col_ThreeStar
  else
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_recordItem).color = (self.ui).col_OtheStar
  end
  local post = ""
  if records.transform then
    local heroId = (item.arg)[1]
    local rankCfg = (ConfigData.hero_rank)[star]
    local rankItem = (ConfigData.item)[(rankCfg.repeat_extra_trans_id)[1]]
    post = (string.format)(ConfigData:GetTipContent(312), (LanguageUtil.GetLocaleText)(rankItem.name), (rankCfg.repeat_extra_trans_num)[1])
  end
  do
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Result).text = pre .. (LanguageUtil.GetLocaleText)(item.name) .. post
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

    if records.way == 1 then
      ((self.ui).tex_By).text = ConfigData:GetTipContent(313)
    else
      -- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

      if records.way == 2 then
        ((self.ui).tex_By).text = ConfigData:GetTipContent(315)
      else
        -- DECOMPILER ERROR at PC120: Confused about usage of register: R7 in 'UnsetPending'

        if records.way == 3 then
          ((self.ui).tex_By).text = ConfigData:GetTipContent(314)
        end
      end
    end
  end
end

return UINLtrPoolRecordItem

