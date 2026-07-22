--!strict
local NPCTypes = require(game.ServerStorage.NPCSystem._Types) type NPCInstance = NPCTypes.NPC 
local MyInstruction = {} MyInstruction.__index = MyInstruction

export type MoveToInstruction = {
	-- Attributes --
	TargetPosition:Vector3;
	_connection:RBXScriptConnection?;
	
	-- Methods --
	Start:(self:MoveToInstruction, npc:NPCInstance) -> ();
	Update:(self:MoveToInstruction, npc:NPCInstance, dt:number) -> ();
	Stop:(self:MoveToInstruction, npc:NPCInstance) -> ();
}

function MyInstruction.new(targetPosition:Vector3) : MoveToInstruction
	local self = setmetatable({TargetPosition = targetPosition;}, MyInstruction)
	return (self::any) :: MoveToInstruction
end

function MyInstruction:Start(npc:NPCInstance)
	local rootPart = npc.Model:WaitForChild('HumanoidRootPart') :: BasePart
	local humanoid = npc.Model:WaitForChild('Humanoid') :: Humanoid
	rootPart:SetNetworkOwner(nil)
	self._connection = humanoid.MoveToFinished:Connect(function(reached)
		npc:CompleteInstruction()
	end)
	humanoid:MoveTo(self.TargetPosition)
end

function MyInstruction:Update(npc:NPCInstance, dt:number)
	print("Updated")
end

function MyInstruction:Stop(npc:NPCInstance)
	if self._connection then self._connection:Disconnect() self._connection = (nil :: any?) end
end 

return MyInstruction
