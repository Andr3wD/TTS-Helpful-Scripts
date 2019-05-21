-- Lua is a lightweight programming language designed to be embedded
-- in many different applications. Tabletop Simulator uses MoonSharp,
-- an interpreter written specifically to be used in Unity.

-- As a complete rewrite of the language, MoonSharp's interpreter
-- contains bugs which make our scripts unpredictable, making
-- writing scripts and debugging difficult.

-- These patches fix these issues in the standard library to ensure
-- Lua 5.3 compatible code will work in TTS

-- Unfortunately, there are some language-level issues which we cannot fully solve:
if false then
-- # __newindex fails on tuple assignments
    local tool = setmetatable({}, {
        __newindex = function(_, key, value)
            print(key, value)
            if select('#', value) == 0 then
                -- If a tuple assignment was performed
            end
        end
    })
    tool.one, tool.two = 1, 2
    --> one 1
    --> two
-- # vararg length cannot be 0
--   - This affects table.pack
-- This is a minor issue - the difference between nil and the lack of an argument very rarely applies
    print((function(...) return select('#', ...) end)())
    --> 1
end

-- Avoid emitting non-standard error
-- table.remove({}, 1) --> error: position out of bounds
if not pcall(table.remove, {}, 1) then
    local remove = table.remove
    function table.remove(tab, pos)
        if #tab < pos then return end
        return remove(tab, pos)
    end
end
-- Ensure table.unpack uses <table>.n as a default for j
-- table.pack(nil, 1) --> { 2 = 1, n = 2 }
if select(2, table.unpack { 2 = 1, n = 2 }) == nil then
    local unpack = table.unpack
    function table.unpack(tab, i, j)
        if j == nil then
            local n = tab.n
            if n then
                j = tab[n] == nil and 0 or n
            end
        end
        if j == 0 then return end
        return unpack(tab, i, j)
    end
end
