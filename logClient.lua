--// IOT
-- written by diltz, licensed under MIT, if you using some of this codebase you must credit IOT

local TestService = game:GetService("TestService")
local logger = {}

function logger:debug(Text)
    assert(Text,"string expected (got nil)") --// since it's nil we send ERROR
    local typeVar = type(Text)
    if typeVar ~= "string" then --// validating Text type
        error(string.format("string expected (got %s)",typeVar)) --// since it's not string we send ERROR
        return
    end

    warn(string.format("DEBUG:\n%s",Text)) --// sending to devconsole
end

function logger:info(Text)
    assert(Text,"string expected (got nil)") --// since it's nil we send ERROR
    local typeVar = type(Text)
    if typeVar ~= "string" then --// validating Text type
        error(string.format("string expected (got %s)",typeVar)) --// since it's not string we send ERROR
        return
    end

    TestService:Message(string.format("Info: %s",Text)) --// sending to devconsole, using TestService function
end

function logger:error(Text)
    assert(Text,"string expected (got nil)") --// since it's nil we send ERROR
    local typeVar = type(Text)
    if typeVar ~= "string" then --// validating Text type
        error(string.format("string expected (got %s)",typeVar)) --// since it's not string we send ERROR
        return
    end

    error(string.format("ERROR: %s",Text)) --// sending to devconsole
end

return logger

--[[
    EXAMPLE USAGE

    local log_Client = require(5768305105)
    log_Client:debug("Hello!") --// warn
    log_Client:info("Привет!") --// Message
    log_Client:error("Siema!") --// error
]]
