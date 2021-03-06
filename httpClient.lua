--// IOT
-- written by diltz, licensed under GNU General Public License v2.0, if you using some of this codebase you must credit IOT

local HttpService = game:GetService("HttpService")
local client = {}

function client:POST(link,body) --// usage module:POST("https://example.com",{foo="bar"},true) (ApplicationJSON only)
    assert(link,"link expected (got nil)") --// link nil
    local Response
    local Success,Error = pcall(function() --// making PCALL so we escape issues with error and we would properly log it
        Response = HttpService:PostAsync(link,HttpService:JSONEncode(body)) --// sending POST request to LINK with encoded ARRAY to JSON
    end)

    if Error then --// handling error
        warn("Error on POST:",tostring(Error)) --// logging to devconsole
        warn("\nexit code: 0")
        return 0; --// since we got ERROR we sent back exit code
    end

    local Success,Error = pcall(function() --// making PCALL so we escape issues with error and we would properly log it
        Response = HttpService:JSONDecode(Response) --// decoding from JSON to ARRAY
        --// examples
        --[[
            local Array = {
                foo = "bar"
            }

            local JSON = "{foo:'bar'}"
        ]]
    end)

    return Response or 0 --// returning caller Response or exit code (if there was issue)
end

function client:GET(link) --// usage module:GET("https://example.com")
    assert(link,"link expected (got nil)") --// link nil

    local Response
    local Success,Error = pcall(function() --// making PCALL so we escape issues with error and we would properly log it
        Response = HttpService:GetAsync(link) --// sending GET request to LINK
    end)

    if Error then --// handling error
        warn("Error on GET:",tostring(Error)) --// logging to devconsole
        warn("\nexit code: 0")
        return 0; --// since we got ERROR we sent back exit code
    end

    return Response or 0
end

return client

--[[EXAMPLE USAGE
    local HttpClient = require(5768189528)
    
    -- GET
	local GET_REQUEST = HttpClient:GET("https://example.com")
    print(GET_REQUEST) --// html body
    
    -- POST
	local POST_REQUEST = HttpClient:POST("http://diltzhost:1111/api/send",{foo="bar"})
	print(POST_REQUEST) -- diltz.xyz returns JSON, http module converted into Array
	
	for k,v in pairs(POST_REQUEST) do
		warn(k,v) --// hello from diltz!
	end
]]
