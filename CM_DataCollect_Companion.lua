function ChimManager:getCompanionData(companionId)
  if not HasActiveCompanion() then
    return
  end

  d(tostring(GetCompanionName(companionId)))

  ChimManager.localVars.companions.time = GetTimeStamp()
  ChimManager.localVars.companions[GetCompanionName(companionId)] = {}
  ChimManager.accountVars.companions.time = GetTimeStamp()
  ChimManager.accountVars.companions[GetCompanionName(companionId)] = {}

  local gear = {}
  for slot = 0, 8 do
    local itemLink = GetItemLink(BAG_COMPANION_WORN, slot)
    gear[slot] = itemLink
  end

  local skills = {}
  for skillLineIndex = 1, GetNumSkillLines(SKILL_TYPE_COMPANION) do
    local skillLineName, rank = GetSkillLineInfo(SKILL_TYPE_COMPANION, skillLineIndex)
    skills[skillLineName] = rank
  end

  ChimManager.accountVars.companions[GetCompanionName(companionId)] = {
    level = GetUnitLevel("companion"),
    gear = gear,
    skills = skills
  }
  ChimManager.localVars.companions[GetCompanionName(companionId)] = {
    rapport = GetActiveCompanionRapport()
  }
end
