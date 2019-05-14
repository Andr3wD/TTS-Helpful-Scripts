function onload() --(written by DeathKnight1003, ThatRobHuman, and dzikakulka)
   cooutside(params)
   startLuaCoroutine(self, "normalcoroutine") --this is calling the regular way people do coroutines
end

--This is the usual way people do coroutines, does not allow params to be passed through
function normalcoroutine() --no params can be passed
   waitTime(1)
   print("1")
   waitFrames(60)
   print("2")
return 1
end


--This function will allow params to a coroutine
function cooutside(params) --make coroutine like this so parameters can be passed through cooutside()
   function coinside()
      --can now use params inside here, as startLuaCoroutine(obj,function) does not take parameters to pass
      waitTime(1)
      print("1")
      waitFrames(60)
      print("2")
   return 1 --must return 1 at the end because that is how startLuaCoroutine() works, it is in the api. Without, it will error
   end
   startLuaCoroutine(self, "coinside") --must use this way to make coroutine in order to wait frames
end

--This function will wait a given number of frames
function waitFrames(frames) --This function can only be used inside a coroutine because it is using coroutine.yield()
   while frames > 0 do --loop until frames = 0
      coroutine.yield(0) --this will wait 1 frame, reguardless of the number put inside coroutine.yield(#)
      frames = frames - 1 --decrement frames every loop
   end
end

--This function will wait a given time in seconds
function waitTime(IN) --This function can only be used inside a coroutine because it is using coroutine.yield()
   local finished = false
   Wait.time(function() finished = true end, amount)
   while not finished do coroutine.yield(0) end
end
