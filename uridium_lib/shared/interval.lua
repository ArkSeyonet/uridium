------------------------------------------------------------------------------------------------------------
--                                     uridium_lib/shared/interval.lua                                    --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

Interval = {
    CancelledIntervals = {},
    IntervalCount = 1
}

---Generate a new unused interval id
---@return integer id
Interval.GetIntervalID = function()
    local id = (Interval.IntervalCount + 1 < 65635) and (Interval.IntervalCount + 1) or 1
    Interval.IntervalCount = id

    return id
end

---Check if interval is cancelled by id
---@param id integer
---@return boolean
Interval.IsIntervalCancelled = function(id)
    if id then
        return Interval.CancelledIntervals[id]
    end

    return false
end

---Clear interval by id
---@param id integer
Interval.Clear = function(id)
    Interval.CancelledIntervals[id] = true
end

---Run a function every x msec until cancelled
---@param msec integer
---@param cb function
---@cb integer id
Interval.Set = function(msec, cb)
    local id = Interval.GetIntervalID()
    local runInterval

    -- NOTICE: Adding a Wait(x) in the SetInterval will currently break and kill the coroutine, so
    -- do not use this SetInterval function if you need to use Wait(x) inside of it.
    runInterval = coroutine.create(function()
        while not Interval.IsIntervalCancelled(id) do
            cb(id)
            SetTimeout(msec, function() coroutine.resume(runInterval) end)
            coroutine.yield()
        end
    end)

    coroutine.resume(runInterval)

    return id
end

return Interval
