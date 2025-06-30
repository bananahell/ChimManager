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

local function collectAllData()
  ChimManager:getCurrencies()
  getCharacterInventory()
  getPlaceInventories()
  ChimManager:getCharacterData()
end

function ChimManager.OnAddonLoaded(event, addonName)
  ChimManager.name = "ChimManager"
  ChimManager.vars = "ChimManagerSavedVars"
  ChimManager.playerActivated = "ChimManagerPlayerActivated"
  ChimManager.playerDeactivated = "ChimManagerPlayerDeactivated"
  if addonName ~= ChimManager.name then
    return
  end
  ChimManagerLabel:SetText("working!")
  ChimManager.localVars = ZO_SavedVars:New(ChimManager.vars, 1, nil, {})
  ChimManager.accountVars = ZO_SavedVars:NewAccountWide(ChimManager.vars, 1, nil, {})
  EVENT_MANAGER:RegisterForEvent(ChimManager.playerDeactivated, EVENT_PLAYER_DEACTIVATED, collectAllData)
end

EVENT_MANAGER:RegisterForEvent("ChimManager", EVENT_ADD_ON_LOADED, ChimManager.OnAddonLoaded)
