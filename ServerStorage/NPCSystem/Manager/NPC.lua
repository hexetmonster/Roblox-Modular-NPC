--!strict

-- TODO: add multi-tasking instructions in the future
--[[ 
	Example:

	self.Instructions = {
	    Movement = WalkToInstruction,
	    Gaze = LookAtPlayerInstruction,
	    Combat = ReloaderInstruction
	}

]]

local NPC = {} NPC.__index = NPC
local _Types = require(script.Parent.Parent._Types)

function NPC.new(id:number, model:Model) : _Types.NPC
	local self = setmetatable({ID = id; Model = model; CurrentInstruction = nil; UpdateRate = model:GetAttribute("UpdateRate") or 0; _timeSinceLastUpdate = 0;}, NPC)
	return (self::any) :: _Types.NPC
end

function NPC:Instruct(instruction:any)
	if self.CurrentInstruction then self.CurrentInstruction:Stop(self) end 
	self.CurrentInstruction = instruction 
	instruction:Start(self)
end

function NPC:CompleteInstruction()
	if self.CurrentInstruction then self.CurrentInstruction:Stop(self) self.CurrentInstruction = (nil :: any?) end
end

function NPC:Destroy()
	if self.CurrentInstruction then self.CurrentInstruction:Stop(self) end
	if self.Model and self.Model.Parent then self.Model:Destroy() end
	
	setmetatable(self::any, nil)
	table.clear(self::any)
end

return NPC
