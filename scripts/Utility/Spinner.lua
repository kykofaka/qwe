local Spinner = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

Spinner.optionEnable =	Menu.AddOptionBool	({"MrGarabato", "Utility",  "Aggro/Deaggro"},"Activate", false)
Spinner.optionKey =		Menu.AddKeyOption	({"MrGarabato", "Utility",  "Aggro/Deaggro"},"Key for spin",Enum.ButtonCode.BUTTON_CODE_NONE)
Spinner.typemove =		Menu.AddOptionCombo	({"MrGarabato", "Utility",  "Aggro/Deaggro"},"Movement Type", {"One place","Сircle","Triger"}, 2)

function Spinner.OnUpdate()
	if not Menu.IsEnabled(Spinner.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end   
	if Menu.IsKeyDown(Spinner.optionKey) then
		if Menu.GetValue(Spinner.typemove) == 0 then
			if tick <= GameRules.GetGameTime() then
				NPC.MoveTo(myHero,Spinner.PositionAngle(myHero,160,1),false,false)
				tick = GameRules.GetGameTime() + 0.05
			end
		end
		if Menu.GetValue(Spinner.typemove) == 1 then
			if tick <= GameRules.GetGameTime() then
				NPC.MoveTo(myHero,Spinner.PositionAngle(myHero,100,40),false,false)
				tick = GameRules.GetGameTime() + 0.15
			end
		end
		if Menu.GetValue(Spinner.typemove) == 2 then
			local minitable = {75,-120}
			if tick <= GameRules.GetGameTime() then
				NPC.MoveTo(myHero,Spinner.PositionAngle(myHero,minitable[trigerfor3],1),false,false)
				tick = GameRules.GetGameTime() + 0.1
				trigerfor3 = trigerfor3 + 1
				if trigerfor3 > 2 then trigerfor3 = 1 end
			end
		end
	end
end

function Spinner.PositionAngle(nps,rotation,range)
	local angle = Entity.GetRotation(nps)
	local angleOffset = Angle(0, 45+rotation, 0)
	angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
	local x,y,z = angle:GetVectors()
	local direction = x + y + z
	direction:SetZ(0)
	direction:Normalize()
	direction:Scale(range)
	local origin = Entity.GetAbsOrigin(nps)
	NeedPos = origin + direction
	return NeedPos
end

function Spinner.init()
	degree = 0
	tick = 0
	trigerfor3 = 1
end
function Spinner.OnGameStart()
	Spinner.init()
end
function Spinner.OnGameEnd()
	Spinner.init()
end
Spinner.init()
return Spinner
