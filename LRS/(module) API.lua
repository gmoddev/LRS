local Core
local Settings

LinkComplete = false

local module = {}

function module:Link(zCore,zSettings)
	
	if LinkComplete == false then
		Core = zCore; Settings = zSettings

		LinkComplete = true		
	else
		print([[
		=============================================================================
		[LRS] WARNING: A script attempted to link after the link was already complete
								(Kinda sus not gonna lie)
		=============================================================================
		]])
		print("[LRS] WARNING: Scripts that ran ".. getfenv(2).script)

		
	end
end

function module:GiveGUI(plr)
	if not LinkComplete then
		return
	end	
	
	Core:ACLink(plr)
	
	plr.Character.Humanoid.Died:Connect(function(plr)
		Core:ACUnlink(plr)
	end)
end

game.Players.PlayerRemoving:Connect(function(plr)
	if Core:ACCheck(plr) then
		Core:ACUnlink(plr)
	end
end)


return module
