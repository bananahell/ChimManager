function ChimManager:getBankInventory()
  ChimManager.accountVars.items.bank = {}
  ChimManager.accountVars.items.bank.time = GetTimeStamp()

  for slotIndex = 0, GetBagSize(BAG_BANK) - 1 do
    local itemLink = GetItemLink(BAG_BANK, slotIndex)
    if itemLink ~= "" then
      local setName, _, _, _, _, setId = GetItemSetInfo(BAG_BANK, slotIndex)
      ChimManager.accountVars.items.bank[slotIndex] = {
        link = itemLink,
        name = GetItemName(BAG_BANK, slotIndex),
        id = GetItemId(BAG_BANK, slotIndex),
        uniqueId = GetItemUniqueId(BAG_BANK, slotIndex),
        quality = GetItemQuality(BAG_BANK, slotIndex),
        trait = GetItemTrait(BAG_BANK, slotIndex),
        traitType = GetItemTraitInformation(BAG_BANK, slotIndex),
        setName = setName,
        setId = setId,
        itemType = GetItemType(BAG_BANK, slotIndex),
        armorType = GetItemArmorType(BAG_BANK, slotIndex),
        weaponType = GetItemWeaponType(BAG_BANK, slotIndex),
        equipType = GetItemEquipType(BAG_BANK, slotIndex),
        level = GetItemLevel(BAG_BANK, slotIndex),
        requiredLevel = GetItemRequiredLevel(BAG_BANK, slotIndex),
        requiredChampionPoints = GetItemRequiredChampionPoints(BAG_BANK, slotIndex),
        stackCount = GetSlotStackSize(BAG_BANK, slotIndex),
        isLocked = IsItemPlayerLocked(BAG_BANK, slotIndex),
        isStolen = IsItemStolen(BAG_BANK, slotIndex),
        isBound = IsItemBound(BAG_BANK, slotIndex),
        isJunk = IsItemJunk(BAG_BANK, slotIndex),
        icon = select(1, GetItemInfo(BAG_BANK, slotIndex)),
      }
    end
  end
end

function ChimManager:getSubscriberBankInventory()
  ChimManager.accountVars.items.subscriberBank = {}
  ChimManager.accountVars.items.subscriberBank.time = GetTimeStamp()

  for slotIndex = 0, GetBagSize(BAG_SUBSCRIBER_BANK) - 1 do
    local itemLink = GetItemLink(BAG_SUBSCRIBER_BANK, slotIndex)
    if itemLink ~= "" then
      local setName, _, _, _, _, setId = GetItemSetInfo(BAG_SUBSCRIBER_BANK, slotIndex)
      ChimManager.accountVars.items.subscriberBank[slotIndex] = {
        link = itemLink,
        name = GetItemName(BAG_SUBSCRIBER_BANK, slotIndex),
        id = GetItemId(BAG_SUBSCRIBER_BANK, slotIndex),
        uniqueId = GetItemUniqueId(BAG_SUBSCRIBER_BANK, slotIndex),
        quality = GetItemQuality(BAG_SUBSCRIBER_BANK, slotIndex),
        trait = GetItemTrait(BAG_SUBSCRIBER_BANK, slotIndex),
        traitType = GetItemTraitInformation(BAG_SUBSCRIBER_BANK, slotIndex),
        setName = setName,
        setId = setId,
        itemType = GetItemType(BAG_SUBSCRIBER_BANK, slotIndex),
        armorType = GetItemArmorType(BAG_SUBSCRIBER_BANK, slotIndex),
        weaponType = GetItemWeaponType(BAG_SUBSCRIBER_BANK, slotIndex),
        equipType = GetItemEquipType(BAG_SUBSCRIBER_BANK, slotIndex),
        level = GetItemLevel(BAG_SUBSCRIBER_BANK, slotIndex),
        requiredLevel = GetItemRequiredLevel(BAG_SUBSCRIBER_BANK, slotIndex),
        requiredChampionPoints = GetItemRequiredChampionPoints(BAG_SUBSCRIBER_BANK, slotIndex),
        stackCount = GetSlotStackSize(BAG_SUBSCRIBER_BANK, slotIndex),
        isLocked = IsItemPlayerLocked(BAG_SUBSCRIBER_BANK, slotIndex),
        isStolen = IsItemStolen(BAG_SUBSCRIBER_BANK, slotIndex),
        isBound = IsItemBound(BAG_SUBSCRIBER_BANK, slotIndex),
        isJunk = IsItemJunk(BAG_SUBSCRIBER_BANK, slotIndex),
        icon = select(1, GetItemInfo(BAG_SUBSCRIBER_BANK, slotIndex)),
      }
    end
  end
end

function ChimManager:getVirtualInventory()
  ChimManager.accountVars.items.virtual = {}
  ChimManager.accountVars.items.virtual.time = GetTimeStamp()

  local slotIndex = GetNextVirtualBagSlotId(nil)

  while slotIndex ~= nil do
    local itemLink = GetItemLink(BAG_VIRTUAL, slotIndex)
    if itemLink ~= "" then
      local setName, _, _, _, _, setId = GetItemSetInfo(BAG_VIRTUAL, slotIndex)
      ChimManager.accountVars.items.virtual[slotIndex] = {
        link = itemLink,
        name = GetItemName(BAG_VIRTUAL, slotIndex),
        id = GetItemId(BAG_VIRTUAL, slotIndex),
        uniqueId = GetItemUniqueId(BAG_VIRTUAL, slotIndex),
        quality = GetItemQuality(BAG_VIRTUAL, slotIndex),
        trait = GetItemTrait(BAG_VIRTUAL, slotIndex),
        traitType = GetItemTraitInformation(BAG_VIRTUAL, slotIndex),
        setName = setName,
        setId = setId,
        itemType = GetItemType(BAG_VIRTUAL, slotIndex),
        armorType = GetItemArmorType(BAG_VIRTUAL, slotIndex),
        weaponType = GetItemWeaponType(BAG_VIRTUAL, slotIndex),
        equipType = GetItemEquipType(BAG_VIRTUAL, slotIndex),
        level = GetItemLevel(BAG_VIRTUAL, slotIndex),
        requiredLevel = GetItemRequiredLevel(BAG_VIRTUAL, slotIndex),
        requiredChampionPoints = GetItemRequiredChampionPoints(BAG_VIRTUAL, slotIndex),
        stackCount = GetSlotStackSize(BAG_VIRTUAL, slotIndex),
        isLocked = IsItemPlayerLocked(BAG_VIRTUAL, slotIndex),
        isStolen = IsItemStolen(BAG_VIRTUAL, slotIndex),
        isBound = IsItemBound(BAG_VIRTUAL, slotIndex),
        isJunk = IsItemJunk(BAG_VIRTUAL, slotIndex),
        icon = select(1, GetItemInfo(BAG_VIRTUAL, slotIndex)),
      }
    end
    slotIndex = GetNextVirtualBagSlotId(slotIndex)
  end
end
