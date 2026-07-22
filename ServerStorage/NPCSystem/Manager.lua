--!strict
local RunService = game:GetService('RunService')

local NPCObj = require(script.NPC) local _Types = require(script.Parent._Types)
local Manager = {stored={}} local nc = 0

function Manager.addNPC(rigModel:Model) : _Types.NPC
	assert(rigModel:FindFirstChildOfClass('Humanoid'), string.format("Humanoid is not a valid member of Model \"%s\"", tostring(rigModel)))
	nc += 1 local newNPC = NPCObj.new(nc, rigModel)
	Manager.stored[newNPC] = newNPC
	return newNPC
end

function Manager.removeNPC(npc:_Types.NPC)
	Manager.stored[npc]:Destroy()
	Manager.stored[npc] = nil
end

RunService.Heartbeat:Connect(function(dt)
	for _, npc in Manager.stored do
		if not npc.Model.Parent or not npc.Model:FindFirstChild("HumanoidRootPart") then Manager.removeNPC(npc) continue end
		if npc.CurrentInstruction and npc.CurrentInstruction.Update then
			npc._timeSinceLastUpdate += dt
			if npc._timeSinceLastUpdate >= npc.UpdateRate then
				npc.CurrentInstruction:Update(npc, npc._timeSinceLastUpdate)
				npc._timeSinceLastUpdate -= npc.UpdateRate 
			end
		end
	end
end)

return Manager
