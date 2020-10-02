warn("Loading IOT whitelist api")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

local HttpRequest_GET = function(Link)
	warn("Link: " .. Link)
	local toReturn
	--return HttpService:JSONDecode(HttpService:GetAsync(Link)).ownership
	
	local success,error = pcall(function()
		toReturn = HttpService:JSONDecode(HttpService:GetAsync(Link)).ownership
	end)

	warn(toReturn)

	if error == nil then
		return toReturn
	else
		return "Server offline"
	end
end

local Whitelisted = "None"

if PlaceInfo.Creator.CreatorType == "Group" then
    local GetOwner = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
	local WhitelistedAsCreatorGroup = HttpRequest_GET("REDACTED" .. tostring(GetOwner) .. "&assetid=4678125369")
	local WhitelistedGroup = HttpRequest_GET("REDACTED" .. tostring(game.CreatorId) .. "&assetid=4678125369")

	if WhitelistedAsCreatorGroup == false or WhitelistedAsCreatorGroup == "Server offline" then
		if WhitelistedGroup == false or WhitelistedGroup == "Server offline" then
			error("IOT API: Not Whitelisted")
		else
			Whitelisted = "Group"
		end
	else
		Whitelisted = "GroupOwner"
	end
end

warn("Whitelisted as: " .. Whitelisted)
