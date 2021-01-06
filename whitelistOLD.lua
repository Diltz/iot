--// IOT
-- written by diltz, licensed under GNU General Public License v2.0, if you using some of this codebase you must credit IOT
-- NOT RECOMMENDED TO USE THIS WHITELIST HAVE VULNERABILITIES

warn("Loading IOT whitelist api")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

local HttpRequest_GET = function(Link) -- HTTP GET
	warn("Link: " .. Link) -- debug info
	local toReturn
	--return HttpService:JSONDecode(HttpService:GetAsync(Link)).ownership
	
	local success,error = pcall(function()
		toReturn = HttpService:JSONDecode(HttpService:GetAsync(Link)).ownership -- true or false
	end)

	warn(toReturn) -- debug info

	if error == nil then
		return toReturn -- whitelist response
	else
		return "Server offline" -- unable to connect server
	end
end

local Whitelisted = "None"

if PlaceInfo.Creator.CreatorType == "Group" then
    local GetOwner = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
	local WhitelistedAsCreatorGroup = HttpRequest_GET("REDACTED" .. tostring(GetOwner) .. "&assetid=4678125369")
	local WhitelistedGroup = HttpRequest_GET("REDACTED" .. tostring(game.CreatorId) .. "&assetid=4678125369")

	if WhitelistedAsCreatorGroup == false or WhitelistedAsCreatorGroup == "Server offline" then
		if WhitelistedGroup == false or WhitelistedGroup == "Server offline" then
			error("IOT API: Not Whitelisted") -- error prevents script from running
		else
			Whitelisted = "Group"
		end
	else
		Whitelisted = "GroupOwner"
	end
end

warn("Whitelisted as: " .. Whitelisted)
