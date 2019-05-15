# TTS-Helpful-Scripts
This is a repository of helpful scripts/tutorials for Table Top Simulator the game.<br/>
It is community driven, so not all scripts here are neccessarily made or edited by one person. <br/>
When possible, credit will be given inside the scripts or in the commit message.<br/>

All scripts are written in TTSLUA, which is different than regular LUA, so you might see some things done differently than they would be done in regular LUA.


## Communication/Personal Help

Table Top Simulator official discord: https://discord.gg/tabletopsimulator <br/>
Table Top Simulator Club (TTSClub) discord: https://discord.me/ttsclub <br/>
Feel free to join and ask any questions in the scripting channel if you need any help with scripting. <br/>

If you choose to get help in these discords, please follow this list to get help effectively:
1) State the nature of your scripting emergency. What is your end goal? (Consider: http://xyproblem.info/) <br/>
2) Provide context. Why are you trying to do it? <br/>
3) State what you have attempted so far. <br/>
4) Try not to use pseudo-code unless you haven't written the code yet. Try to provide ALL the relevant bits. <br/>

## Modules

Lua code can be reused by creating and sharing 'packages'. [LuaRocks](https://luarocks.org/) can be used to package and find modules containing both Lua and C code, which can then be used through the `require` function.

As Tabletop Simulator does not support any filesystem functions, we are not able to load modules while our script is running, meaning we must put all code we want to make use of in the same file.

The [Official Atom Package](https://github.com/Berserk-Games/atom-tabletopsimulator-lua/) solves this using the `#include` keyword, which can be used to combine the source of two lua files. However, as it works differently to the `require` method, this cannot be used to import lua packages without issues.

That said, many lua-only packages can be used with TTS using a simple trick:

```lua
local uuid = (function(...)
#include uuid -- (https://github.com/Tieske/uuid)
end)()

uuid.seed()
local UserObjects = {}

function onObjectSpawn(obj)
  UserObjects[uuid()] = obj.guid
end
```

### Common Modules for TTS Mods

* [Orderly](https://github.com/TomSputz/Orderly/releases/) - A Promises/A+ library with support for the async/await model
## Contributing

Please read the [Contributing Guideline](/CONTRIBUTING.md) to contribute.
