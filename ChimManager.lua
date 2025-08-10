ChimManager = {}

local function getCharacterInventory()
  ChimManager.localVars.items = {}

  ChimManager:getWornInventory()
  ChimManager:getBackpackInventory()
end

local function getPlaceInventories()
  ChimManager.accountVars.items = {}

  ChimManager:getBankInventory()
  ChimManager:getSubscriberBankInventory()
  ChimManager:getVirtualInventory()
end

local function getInventories()
  ChimManager:getCurrencies()
  getCharacterInventory()
  getPlaceInventories()
end

local function GetCharacterInfo()
  getCharacterInventory()
  ChimManager:getCharacterData()
end

local function collectAllData()
  getInventories()
  GetCharacterInfo()
  ChimManager.getCompanionsData()
end

local function OnCompanionRapportUpdate(event, companionId, previousRapport, currentRapport, adjustmentAmountType)
  ChimManager.localVars.companions.time = GetTimeStamp()
  ChimManager.localVars.companions[GetCompanionName(companionId)] = {}
  ChimManager.localVars.companions[GetCompanionName(companionId)] = {
    rapport = currentRapport
  }
end

function ChimManager.OnAddonLoaded(event, addonName)
  ChimManager.name = "ChimManager"
  ChimManager.vars = "ChimManagerSavedVars"
  ChimManager.playerActivated = "ChimManagerPlayerActivated"
  ChimManager.playerDeactivated = "ChimManagerPlayerDeactivated"
  ChimManager.companionActivated = "ChimManagercompanionActivated"
  if addonName ~= ChimManager.name then
    return
  end
  ChimManagerLabel:SetText("working!")
  ChimManager.localVars = ZO_SavedVars:New(ChimManager.vars, 1, nil, {})
  ChimManager.accountVars = ZO_SavedVars:NewAccountWide(ChimManager.vars, 1, nil, {})
  ChimManager.localVars.companions = {}
  ChimManager.accountVars.companions = {}
  EVENT_MANAGER:RegisterForEvent(ChimManager.playerDeactivated, EVENT_PLAYER_DEACTIVATED, collectAllData)
  EVENT_MANAGER:RegisterForEvent(ChimManager.companionActivated, EVENT_COMPANION_RAPPORT_UPDATE,
    OnCompanionRapportUpdate)
end

EVENT_MANAGER:RegisterForEvent("ChimManager", EVENT_ADD_ON_LOADED, ChimManager.OnAddonLoaded)
