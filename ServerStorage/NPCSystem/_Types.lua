--!strict
local _Types = {}

export type NPC = {
	-- Attributes --
	ID:number;
	Model:Model;
	CurrentInstruction:any?;
	UpdateRate:number;
	_timeSinceLastUpdate:number;

	-- Methods --
	Instruct:(self:NPC, instruction:any) -> ();
	CompleteInstruction:(self:NPC) -> ();
	Destroy:(self:NPC) -> ();
}

return _Types
