function ChimManager:getCurrencies()
  ChimManager.localVars.currency = {}
  ChimManager.localVars.currency.time = GetTimeStamp()
  ChimManager.accountVars.currency = {}
  ChimManager.accountVars.currency.time = GetTimeStamp()

  -- Gold
  ChimManager.localVars.currency.gold = GetCurrentMoney()
  ChimManager.accountVars.currency.gold = GetBankedMoney()
  -- Tel Var
  ChimManager.localVars.currency.telVar = GetCurrencyAmount(CURT_TELVAR_STONES, CURRENCY_LOCATION_CHARACTER)
  ChimManager.accountVars.currency.telVar = GetCurrencyAmount(CURT_TELVAR_STONES, CURRENCY_LOCATION_BANK)
  -- Writ Vouchers
  ChimManager.localVars.currency.writVouchers = GetCurrencyAmount(CURT_WRIT_VOUCHERS, CURRENCY_LOCATION_CHARACTER)
  ChimManager.accountVars.currency.writVouchers = GetCurrencyAmount(CURT_WRIT_VOUCHERS, CURRENCY_LOCATION_BANK)
  -- Alliance Points
  ChimManager.localVars.currency.alliancePoints = GetCurrencyAmount(CURT_ALLIANCE_POINTS, CURRENCY_LOCATION_CHARACTER)
  ChimManager.accountVars.currency.alliancePoints = GetCurrencyAmount(CURT_ALLIANCE_POINTS, CURRENCY_LOCATION_BANK)

  -- Archival Fortunes
  ChimManager.accountVars.currency.archivalFortunes = GetCurrencyAmount(CURT_ARCHIVAL_FORTUNE, CURRENCY_LOCATION_ACCOUNT)
  -- Crown Gems
  ChimManager.accountVars.currency.crownGems = GetCurrencyAmount(CURT_CROWN_GEMS, CURRENCY_LOCATION_ACCOUNT)
  -- Crowns
  ChimManager.accountVars.currency.crowns = GetCurrencyAmount(CURT_CROWNS, CURRENCY_LOCATION_ACCOUNT)
  -- Event Tickets
  ChimManager.accountVars.currency.eventTickets = GetCurrencyAmount(CURT_EVENT_TICKETS, CURRENCY_LOCATION_ACCOUNT)
  -- Imperial Fragments
  ChimManager.accountVars.currency.imperialFragments = GetCurrencyAmount(CURT_IMPERIAL_SEALS, CURRENCY_LOCATION_ACCOUNT)
  -- Outfit Change Tokens
  ChimManager.accountVars.currency.outfitChangeTokens = GetCurrencyAmount(CURT_OUTFIT_CHANGE_TOKENS,
    CURRENCY_LOCATION_ACCOUNT)
  -- Seals of Endeavor
  ChimManager.accountVars.currency.sealsOfEndeavor = GetCurrencyAmount(CURT_ENDEAVOR_SEALS, CURRENCY_LOCATION_ACCOUNT)
  -- Transmute Crystals
  ChimManager.accountVars.currency.transmuteCrystals = GetCurrencyAmount(CURT_TRANSMUTE_CRYSTALS,
    CURRENCY_LOCATION_ACCOUNT)
  -- Undaunted Keys
  ChimManager.accountVars.currency.undauntedKeys = GetCurrencyAmount(CURT_UNDAUNTED_KEYS, CURRENCY_LOCATION_ACCOUNT)
end
