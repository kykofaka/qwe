FAIO_Lite_orbwalker = {}

FAIO_Lite_orbwalker.orbwalkerOrderTime = 0
FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime = 0
FAIO_Lite_orbwalker.orbwalkerRangedAnimationEnd = 0
FAIO_Lite_orbwalker.orbwalkerMeleeAnimationEnd = 0
FAIO_Lite_orbwalker.orbwalkerRangedAnimationEndAlt = 0

FAIO_Lite_orbwalker.orbwalkerAttackPoint = 0

function FAIO_Lite_orbwalker.animationCapture(animation)
	if animation.type == 1 then
		FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime = os.clock()
		FAIO_Lite_orbwalker.orbwalkerMeleeAnimationEnd = os.clock() + animation.castpoint
		FAIO_Lite_orbwalker.orbwalkerRangedAnimationEndAlt = os.clock() + animation.castpoint
	end

end

function FAIO_Lite_orbwalker.projectileCapture(projectile)

	if projectile.isAttack then 

		FAIO_Lite_orbwalker.orbwalkerRangedAnimationEnd = os.clock()

	end

end

function FAIO_Lite_orbwalker.orbwalkerBackswingTimer(myHero)

	if FAIO_Lite_orbwalker.orbwalkerAttackPoint == 0 then return 0 end

	local attackTime = NPC.GetAttackTime(myHero)
		if not attackTime then return 0 end

	return attackTime - FAIO_Lite_orbwalker.orbwalkerAttackPoint

end

function FAIO_Lite_orbwalker.orbwalkerInAttackAnimation()

	if FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime == 0 then return false end
	if os.clock() < FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime then return false end

	local animationEndTimer = 0
		if Heroes.GetLocal() then
			if NPC.IsRanged(Heroes.GetLocal()) then
				animationEndTimer = FAIO_Lite_orbwalker.orbwalkerRangedAnimationEnd
			else
				animationEndTimer = FAIO_Lite_orbwalker.orbwalkerMeleeAnimationEnd
			end
		end

	if Heroes.GetLocal() then
		if NPC.IsRanged(Heroes.GetLocal()) then
			if os.clock() >= FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime then
				if FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime > animationEndTimer then
					if os.clock() < FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime + FAIO_Lite_orbwalker.orbwalkerAttackPoint + 0.2 then
						return true
					end
				end	
			end
		else
			if os.clock() >= FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime then
				if os.clock() < FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime + FAIO_Lite_orbwalker.orbwalkerAttackPoint + 0.2 then
					return true
				end
			end
		end
	end

	return false

end

function FAIO_Lite_orbwalker.orbwalkerAwaitingAnimation()

	if FAIO_Lite_orbwalker.orbwalkerOrderTime == 0 then return false end

	if os.clock() < FAIO_Lite_orbwalker.orbwalkerOrderTime + 0.1 then return true end

	if os.clock() >= FAIO_Lite_orbwalker.orbwalkerOrderTime then
		if FAIO_Lite_orbwalker.orbwalkerOrderTime > FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime then
			return true
		end
	end

	return false

end

function FAIO_Lite_orbwalker.orbwalkerAttackAnimationTiming()

	local startTime = FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime
		if startTime == 0 then
			return 0
		end

	local endTime = 0
		if Heroes.GetLocal() then
			if NPC.IsRanged(Heroes.GetLocal()) then
				endTime = FAIO_Lite_orbwalker.orbwalkerRangedAnimationEndAlt
			else
				endTime = FAIO_Lite_orbwalker.orbwalkerMeleeAnimationEnd
			end
		end

		if endTime == 0 then
			return 0
		end

	if os.clock() > endTime then return 0 end

	if endTime > startTime then
		if os.clock() >= startTime and os.clock() < endTime then
			return endTime - startTime
		end
	end

	return 0

end

function FAIO_Lite_orbwalker.orbwalkerIsInAttackBackswing(myHero)

	if not myHero then return false end

	if FAIO_Lite_orbwalker.orbwalkerAwaitingAnimation() == true then return false end
	if FAIO_Lite_orbwalker.orbwalkerInAttackAnimation() == true then return false end

	local backswingTimer = FAIO_Lite_orbwalker.orbwalkerBackswingTimer(myHero)

	local attackTime = NPC.GetAttackTime(myHero)

	if os.clock() < FAIO_Lite_orbwalker.orbwalkerAnimationCaptureTime + attackTime then
		return true
	end

	return false

end

return FAIO_Lite_orbwalker