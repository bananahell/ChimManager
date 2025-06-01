local function GetSkillPointAllocation()
  local allocation = {}
  for skillType = 1, GetNumSkillTypes() do
    allocation[skillType] = {}
    for skillLineIndex = 1, GetNumSkillLines(skillType) do
      local skillLineName, _, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(skillType, skillLineIndex)
      allocation[skillType][skillLineIndex] = {
        name = skillLineName,
        abilities = {}
      }
      for abilityIndex = 1, GetNumSkillAbilities(skillType, skillLineIndex) do
        local abilityName, morph, rank, purchased, progressionIndex, _, _, _, isActive, isAutoGrant, isPointSpent =
            GetSkillAbilityInfo(skillType, skillLineIndex, abilityIndex)
        allocation[skillType][skillLineIndex].abilities[abilityIndex] = {
          name = abilityName,
          morph = morph,
          rank = rank,
          purchased = purchased,
          progression = progressionIndex,
          isActive = isActive,
          isAutoGrant = isAutoGrant,
          isPointSpent = isPointSpent
        }
      end
    end
  end
  return allocation
end

local function GetResearchTimers()
  local crafts = {
    { name = "Blacksmithing", type = CRAFTING_TYPE_BLACKSMITHING },
    { name = "Clothing",      type = CRAFTING_TYPE_CLOTHIER },
    { name = "Woodworking",   type = CRAFTING_TYPE_WOODWORKING },
    { name = "Jewelry",       type = CRAFTING_TYPE_JEWELRYCRAFTING },
  }
  local research = {}

  for _, craft in ipairs(crafts) do
    research[craft.name] = {}
    local numLines = GetNumSmithingResearchLines(craft.type)
    for lineIndex = 1, numLines do
      local lineName, _, numTraits = GetSmithingResearchLineInfo(craft.type, lineIndex)
      research[craft.name][lineName] = {}
      for traitIndex = 1, numTraits do
        local duration, timeRemaining = GetSmithingResearchLineTraitTimes(craft.type, lineIndex, traitIndex)
        local traitType, _, known = GetSmithingResearchLineTraitInfo(craft.type, lineIndex,
          traitIndex)
        research[craft.name][lineName][traitIndex] = {
          traitType = traitType,
          duration = duration,
          timeRemaining = timeRemaining,
          known = known
        }
      end
    end
  end

  return research
end

function ChimManager:getCharacterData()
  ChimManager.accountVars.championPoints = GetPlayerChampionPointsEarned()
  ChimManager.accountVars.time = GetTimeStamp()

  local health, maxHealth = GetUnitPower("player", POWERTYPE_HEALTH)
  local magicka, maxMagicka = GetUnitPower("player", POWERTYPE_MAGICKA)
  local stamina, maxStamina = GetUnitPower("player", POWERTYPE_STAMINA)

  ChimManager.localVars.character = {
    race = GetUnitRace("player"),
    class = GetUnitClass("player"),
    level = GetUnitLevel("player"),
    alliance = GetUnitAlliance("player"),
    attributePoints = {
      health = GetAttributeSpentPoints(ATTRIBUTE_HEALTH),
      magicka = GetAttributeSpentPoints(ATTRIBUTE_MAGICKA),
      stamina = GetAttributeSpentPoints(ATTRIBUTE_STAMINA),
    },
    attributes = {
      health = health,
      magicka = magicka,
      stamina = stamina,
      maxHealth = maxHealth,
      maxMagicka = maxMagicka,
      maxStamina = maxStamina,
      unspentSkillPoints = GetAvailableSkillPoints(),
    },
  }

  ChimManager.localVars.character.craftingResearch = GetResearchTimers()

  ChimManager.localVars.character.skillPointAllocation = GetSkillPointAllocation()

  ChimManager.localVars.character.riding = {}
  local capacity, _, horseStamina, _, speed, _ = GetRidingStats()
  ChimManager.localVars.character.riding.speed = speed
  ChimManager.localVars.character.riding.stamina = horseStamina
  ChimManager.localVars.character.riding.capacity = capacity
  ChimManager.localVars.character.riding.timeToNextTraining = GetTimeUntilCanBeTrained()
  ChimManager.localVars.character.time = GetTimeStamp()
end
