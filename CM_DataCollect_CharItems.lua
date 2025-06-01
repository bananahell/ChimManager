function ChimManager:getWornInventory()
  ChimManager.localVars.items.worn = {}
  ChimManager.localVars.items.worn.time = GetTimeStamp()

  for slotIndex = 0, GetBagSize(BAG_WORN) - 1 do
    local itemLink = GetItemLink(BAG_WORN, slotIndex)
    if itemLink ~= "" then
      ChimManager.localVars.items.worn[slotIndex] = {
        link = itemLink,
        name = GetItemName(BAG_WORN, slotIndex),
        id = GetItemId(BAG_WORN, slotIndex),
        quality = GetItemQuality(BAG_WORN, slotIndex),
        trait = GetItemTrait(BAG_WORN, slotIndex),
        traitType = GetItemTraitInformation(BAG_WORN, slotIndex),
        setName = GetItemSetInfo(BAG_WORN, slotIndex),
        level = GetItemLevel(BAG_WORN, slotIndex),
        requiredLevel = GetItemRequiredLevel(BAG_WORN, slotIndex),
        requiredChampionPoints = GetItemRequiredChampionPoints(BAG_WORN, slotIndex),
        isLocked = IsItemPlayerLocked(BAG_WORN, slotIndex),
        isStolen = IsItemStolen(BAG_WORN, slotIndex),
        isBound = IsItemBound(BAG_WORN, slotIndex),
        armorType = GetItemArmorType(BAG_WORN, slotIndex),
        weaponType = GetItemWeaponType(BAG_WORN, slotIndex),
        equipType = GetItemEquipType(BAG_WORN, slotIndex),
        icon = GetItemInfo(BAG_WORN, slotIndex)
      }
    end
  end
end

function ChimManager:getBackpackInventory()
  ChimManager.localVars.items.backpack = {}
  ChimManager.localVars.items.backpack.time = GetTimeStamp()

  for slotIndex = 0, GetBagSize(BAG_BACKPACK) - 1 do
    local itemLink = GetItemLink(BAG_BACKPACK, slotIndex)
    if itemLink ~= "" then
      local setName, _, _, _, _, setId = GetItemSetInfo(BAG_BACKPACK, slotIndex)
      ChimManager.localVars.items.backpack[slotIndex] = {
        link = itemLink,
        name = GetItemName(BAG_BACKPACK, slotIndex),
        id = GetItemId(BAG_BACKPACK, slotIndex),
        uniqueId = GetItemUniqueId(BAG_BACKPACK, slotIndex),
        quality = GetItemQuality(BAG_BACKPACK, slotIndex),
        trait = GetItemTrait(BAG_BACKPACK, slotIndex),
        traitType = GetItemTraitInformation(BAG_BACKPACK, slotIndex),
        setName = setName,
        setId = setId,
        itemType = GetItemType(BAG_BACKPACK, slotIndex),
        armorType = GetItemArmorType(BAG_BACKPACK, slotIndex),
        weaponType = GetItemWeaponType(BAG_BACKPACK, slotIndex),
        equipType = GetItemEquipType(BAG_BACKPACK, slotIndex),
        level = GetItemLevel(BAG_BACKPACK, slotIndex),
        requiredLevel = GetItemRequiredLevel(BAG_BACKPACK, slotIndex),
        requiredChampionPoints = GetItemRequiredChampionPoints(BAG_BACKPACK, slotIndex),
        stackCount = GetSlotStackSize(BAG_BACKPACK, slotIndex),
        isLocked = IsItemPlayerLocked(BAG_BACKPACK, slotIndex),
        isStolen = IsItemStolen(BAG_BACKPACK, slotIndex),
        isBound = IsItemBound(BAG_BACKPACK, slotIndex),
        isJunk = IsItemJunk(BAG_BACKPACK, slotIndex),
        icon = select(1, GetItemInfo(BAG_BACKPACK, slotIndex)),
      }
    end
  end
end
