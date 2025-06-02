# ChimManager v0.1

Hey man, congrats on achieving chim! Playing on PC and using mods really gets you far, eh? But so, how do you think you're gonna administer all of that forbidden knowledge? ChimManager is here to help!

## Main goal

The idea of this Addon is to help ESO players organize their ingame "outgame", as in out of the gam.... whatever...

I'm sick of having to login into each character to know what they're up to, what they're holding, etc. And sure, [Inventory Insight](https://www.esoui.com/downloads/info731-InventoryInsight.html) and [Craftstore](https://www.esoui.com/downloads/info1590-CraftStoreMorrowind.html) both do an amazing job on that, most probably even better than myself, since they learned how to program with that lua/xml environment, but they still require you to log into the game to see the data.

The idea of ChimManager is to display the game's info outside of the game. No rules are being broken here, you still need to login to get the data, but like the dudes at [Tamriel Trade Centre](https://tamrieltradecentre.com/), I intend on getting the data from the saved variables made available to then REST API it from a client to, I don't know, a website, or even a mobile app?

I also think it would be neat to also have this app notify me of finished researches, so that I can log into the game knowing which research is done!

## Usability

### Common users

You'll really just need to get the addon and the app, run the client, login, and there you go - nice clinky ESO data! Currency in bank, craftbag stuff, character's backpack, skill points, crafting research timers, all will be available! The only catch is - that to see a character's data, you'll need to log into that specific character, but previously loggen in characters will have their data kept in the app! More details to come when I actually make all of this stuff...

### Advanced users

Nothing much more for you to see, honestly. The data is extracted from the game and saved into the SavedVariables folder, inside .../Elder Scrolls Online/live/SavedVariables/ChimManager.lua, and pronto. The client will watch for this file changing and send its content straight to the app!

## Progress

### TODO

First commit, man! I just played around with the API a bunch and got some lots of data. I still need to start work on the client and on the viewing app, while always keeping an eye out for what more data I would like to get.

### Done

I still have nothing on the client, nor the app.

I'll (try to) keep the updated extracted tree here in the top as I make progress:
```
[@username]
  ["$AccountWide"]
    [currency] -- bank and account currency
    [items]
      [bank] -- regular bank
      [SubscriberBank] -- regular bank too, but the spaces you get with eso+
      [virtual] -- craft bag
      [chapionPoints]
  [CharacterName] -- each character has structure
    [character]
      [alliance]
      [skillPointAllocation] -- all the skill points allocated where
      [class]
      [craftingResearch] -- research timers
      [level]
      [attributes] -- stamina, max health, etc
      [attributePoints] -- allocated points in health, magicka and stamina
      [race]
      [riding] -- points in speed/stamina/capacity and timer for training
    [currency] -- in character currency
    [items]
      [worn]
      [backpack]
```

#### First commit

I started by learning the API. The first commit will have this tree available:
```
[@username]
  ["$AccountWide"]
    [currency] -- bank and account currency
    [items]
      [bank] -- regular bank
      [SubscriberBank] -- regular bank too, but the spaces you get with eso+
      [virtual] -- craft bag
      [chapionPoints]
  [CharacterName] -- each character has structure
    [character]
      [alliance]
      [skillPointAllocation] -- all the skill points allocated where
      [class]
      [craftingResearch] -- research timers
      [level]
      [attributes] -- stamina, max health, etc
      [attributePoints] -- allocated points in health, magicka and stamina
      [race]
      [riding] -- points in speed/stamina/capacity and timer for training
    [currency] -- in character currency
    [items]
      [worn]
      [backpack]
```
I'm not pulling any punches with this data. I'm getting a lot of stuff, and I'll send it all to the app to then process it. Every data I can get in each item, for example, will be sent to the app, even in the craft bag. This means that right now I'm looking at a 28125 lines long saved variables file, and this was only by analysing one character. Earlier today I logged into all of my 15 characters, and got something around 50000 lines, without the skill allocation work.
