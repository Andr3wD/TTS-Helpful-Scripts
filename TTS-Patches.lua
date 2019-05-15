-- Avoid emitting non-standard error
do
    local remove = table.remove
    function table.remove(tab, pos)
        if #tab < pos then return end
        return remove(tab, pos)
    end
end
do
    local pack = table.pack
    function table.pack(...)
        local values = pack(...)
        -- A patch for this bug (Remove it if the bug is fixed) => (function(...) return table.pack(...) end)().n == 1
        if values.n == 1 and type(values[1]) == 'nil' then values.n = 0 end
        return values
    end
end
-- Process the n property for parameters containing nil
do
    local unpack = table.unpack
    function table.unpack(table) return unpack(table, nil, table.n) end
end
-- Avoid crashing when too many calls to print are made
do
  local print = print
  local count = 0
  Wait.time(function() count = 0 end, 0, -1)
  function print(...)
      -- The maximum is probably memory dependent, testing might lower it
      if count == 900 then error('Too many calls to print in frame') end
      count = count + 1
      return print(...)
  end
end
