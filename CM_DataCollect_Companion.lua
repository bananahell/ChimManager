local function getCompanionData(companionId)
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
end


function ChimManager.getCompanionsData()
  for companionId = 0, 15 do
    if GetCompanionName(companionId) ~= "" then
      getCompanionData(companionId)
    end
  end
end
