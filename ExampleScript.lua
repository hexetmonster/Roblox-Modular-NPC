local m = require(game.ServerStorage.NPCSystem.Manager)
local moveToInstruction = require(script["ExampleInstruction (MoveTo)"]).new(Vector3.new(50,0,50))
local newNPC = m.addNPC(workspace.Rig)
newNPC:Instruct(moveToInstruction)
