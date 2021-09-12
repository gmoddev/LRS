LRS_System_Folder = script.Parent

local Core = {}
Linked = {}


local API
local Settings
EventsFolder = game.ReplicatedStorage:WaitForChild("LRS_EVENTS",10)
Send_Info = EventsFolder:WaitForChild("Send_Info",10)

_G["Stations"] = {}
Stations = _G["Stations"]

RunService = game:GetService("RunService")
ServerScriptService = game:GetService("ServerScriptService")
Players = game:GetService("Players")

if RunService:IsStudio() then
	if game.PlaceId ~= 7463384236 then
		script:Destroy()
	end
end

print([[
================================
Low's Radio System is loading...
================================
]])

--===== Init =====--

function GetProductName(id)
	return game:GetService("MarketplaceService"):GetProductInfo(id).Name
end

function Core:Init(zAPI,zSettings)
	Settings = zSettings
	API = zAPI
	
	for i,z in pairs(require( Settings)["RadioStations"]) do
		_G["Stations"][i] = {}
		for _,v in pairs(z) do
			if type(v[1]) == "number" then
				if type(v[2]) == "boolean" then
					if v[3] then
						if type(v[3]) == "string" then
							if v[2] == true then
								table.insert(_G["Stations"][i], {v[3], v[1]})
							else
								table.insert(_G["Stations"][i], {GetProductName(v[1]), v[1]})
							end
						end
					else
						if v[2] == true then
							table.insert(_G["Stations"][i], {GetProductName(v[1]), v[1]})
						end
					end
				end
			end
		end
		
	end
	
end

--====== ANTICHEAT ======--
-- Not really much of an anticheat, but i needed functions
--ACCheck
--ACLink
-- ACUnlink

function Core.ACCheck(plr)
	if table.find(Linked,plr.Name) then
		return true
	else
		return false
	end
end

function Core.ACUnlink(plr)
	local thing = table.find(Linked,plr.Name)
	if thing then
		table.remove(Linked,thing)
		if plr.PlayerGui:FindFirstChild("RadioGUI") then
			plr.PlayerGui.RadioGUI:Destroy()
		end
	end
end

function Core.ACLink(plr)
	local thing = table.find(Linked,plr.Name)
	if not thing then
		table.insert(Linked,plr.Name)
		script.RadioGUI:Clone().Parent = plr.PlayerGui
		plr.Character.Humanoid.Died:Connect(function()
			Core.ACUnlink(plr)
		end)
	end
end


print([[
=====================
[LRS] Stations Loaded
=====================
]])

return Core

