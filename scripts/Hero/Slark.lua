--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local SlarkMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

SlarkMrG.option = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark"}, "Slark", false)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Slark"}, "panorama/images/heroes/icons/npc_dota_hero_slark_png.vtex_c")
Menu.AddOptionIcon(SlarkMrG.option, "~/MrGarabato/npc_dota_hero_unnamed_png.png")

SlarkMrG.optionTarget = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Slark"}, "Target Radius", 200, 1000, 500)
SlarkMrG.optionComboKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Slark"}, "Combo key", Enum.ButtonCode.BUTTON_CODE_NONE)
Menu.AddOptionIcon(SlarkMrG.optionComboKey  , "panorama/images/icon_treasure_arrow_psd.vtex_c")

SlarkMrG.optionSilence  = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark", "Items"}, "Silence", false)
Menu.AddOptionIcon(SlarkMrG.optionSilence, "panorama/images/items/orchid_png.vtex_c")

SlarkMrG.optionNullifier  = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark", "Items"}, "Nullifier", false)
Menu.AddOptionIcon(SlarkMrG.optionNullifier, "panorama/images/items/nullifier_png.vtex_c")

SlarkMrG.optionDiffusal  = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark", "Items"}, "Diffusal", false)
Menu.AddOptionIcon(SlarkMrG.optionDiffusal, "panorama/images/items/diffusal_blade_png.vtex_c")

SlarkMrG.optionAbyssal = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark", "Items"}, "Abyssal", false)
Menu.AddOptionIcon(SlarkMrG.optionAbyssal , "panorama/images/items/abyssal_blade_png.vtex_c")

SlarkMrG.optionBkb  = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark", "Items"}, "Bkb", false)
Menu.AddOptionIcon(SlarkMrG.optionBkb , "panorama/images/items/black_king_bar_png.vtex_c")

SlarkMrG.optionPounceAim = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark"}, "Pounce aim", false)
Menu.AddOptionIcon(SlarkMrG.optionPounceAim, "panorama/images/spellicons/slark_pounce_png.vtex_c")

SlarkMrG.optionPounce = Menu.AddOptionCombo({"MrGarabato", "Select Hero" , "Slark"}, "Pounce", {"to enemy", "to mouse"}, 0)
Menu.AddOptionIcon(SlarkMrG.optionPounce, "panorama/images/spellicons/slark_pounce_png.vtex_c")

SlarkMrG.optionAutoUlt = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Slark"}, "Auto ultimate", false)
Menu.AddOptionIcon(SlarkMrG.optionAutoUlt, "panorama/images/spellicons/slark_shadow_dance_png.vtex_c")

SlarkMrG.optionUltSlider = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Slark"}, "HP threshold", 10 ,50, 30)
Menu.AddOptionIcon(SlarkMrG.optionUltSlider, "panorama/images/icon_treasure_arrow_psd.vtex_c")

SlarkMrG.check = true
SlarkMrG.casted = false
SlarkMrG.castedm = false


function SlarkMrG.OnUpdate()
  if not Menu.IsEnabled(SlarkMrG.option) then return end
  myHero = Heroes.GetLocal()
  if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_slark" then return end
  mana = NPC.GetMana(myHero)
  enemy = SlarkMrG.Target(myHero)
  mypos = Entity.GetAbsOrigin(myHero)
  
  
  --Skills
  local q = NPC.GetAbility(myHero, "slark_dark_pact")
  local w = NPC.GetAbility(myHero, "slark_pounce")
  local r = NPC.GetAbility(myHero, "slark_shadow_dance")
  
  
  --Items
  local mom = NPC.GetItem(myHero, "item_mask_of_madness", true)
  local urn = NPC.GetItem(myHero, "item_urn_of_shadows", true)
  local vessel = NPC.GetItem(myHero, "item_spirit_vessel", true)
  local hex = NPC.GetItem(myHero, "item_sheepstick", true)
  local nullifier = NPC.GetItem(myHero, "item_nullifier", true)
  local diffusal = NPC.GetItem(myHero, "item_diffusal_blade", true)
  local mjolnir = NPC.GetItem(myHero, "item_mjollnir", true)
  local halberd = NPC.GetItem(myHero, "item_heavens_halberd", true)
  local abyssal = NPC.GetItem(myHero, "item_abyssal_blade", true)
  local armlet = NPC.GetItem(myHero, "item_armlet", true)
  local bloodthorn = NPC.GetItem(myHero, "item_bloodthorn", true)
  local bkb = NPC.GetItem(myHero, "item_black_king_bar", true)
  local courage = NPC.GetItem(myHero, "item_medallion_of_courage", true)
  local solar = NPC.GetItem(myHero, "item_solar_crest", true)
  local blink = NPC.GetItem(myHero, "item_blink", true)
  local blademail = NPC.GetItem(myHero, "item_blade_mail", true)
  local orchid = NPC.GetItem(myHero, "item_orchid", true)
  local lotus = NPC.GetItem(myHero, "item_lotus_orb", true)
  local cyclone = NPC.GetItem(myHero, "item_cyclone", true)
  local satanic = NPC.GetItem(myHero, "item_satanic", true)
  local force = NPC.GetItem(myHero, "item_force_staff", true)
  local pike = NPC.GetItem(myHero, "item_hurricane_pike", true)
  local eblade = NPC.GetItem(myHero, "item_ethereal_blade", true)
  local phase = NPC.GetItem(myHero, "item_phase_boots", true)
  local dagon = NPC.GetItem(myHero, "item_dagon", true)
  if not dagon then
    for i = 2, 5 do
      local dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
      if dagon then break end
    end
  end
  local discord = NPC.GetItem(myHero, "item_veil_of_discord", true)
  local shiva = NPC.GetItem(myHero, "item_shivas_guard", true)
  local refresher = NPC.GetItem(myHero, "item_refresher", true)
  local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
  local manta = NPC.GetItem(myHero, "item_manta", true)
  local necro = NPC.GetItem(myHero, "item_necronomicon", true)
  if not necro then
    for i = 2, 3 do
      local necro = NPC.GetItem(myHero, "item_necronomicon_" .. i, true)
      if necro then break end
    end
  end
  local silver = NPC.GetItem(myHero, "item_silver_edge", true)
  local scptr = NPC.GetItem(myHero, "item_ultimate_scepter", true)
  
  
  --Combo
  if Menu.IsKeyDown(SlarkMrG.optionComboKey) then
    distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D()
    if distance>650 then 
      Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,enemy, Entity.GetAbsOrigin(enemy), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
    else
      if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then 
        Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
      else
        Player.AttackTarget(Players.GetLocal(), myHero, enemy, false)
        if q and Ability.IsCastable(q, mana) and Ability.IsReady(q) then
          Ability.CastNoTarget(q) 
          return
        end 
        if Menu.IsEnabled(SlarkMrG.optionNullifier) and nullifier and Ability.IsCastable(nullifier, mana) and Ability.IsReady(nullifier) then
          Ability.CastTarget(nullifier, enemy) 
          return
        end
        if Menu.IsEnabled(SlarkMrG.optionDiffusal) and diffusal and Ability.IsCastable(diffusal, mana) and Ability.IsReady(diffusal) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
          Ability.CastTarget(diffusal, enemy) 
          return
        end
        if Menu.IsEnabled(SlarkMrG.optionBkb) and bkb and Ability.IsCastable(bkb, mana) and Ability.IsReady(bkb) then
          Ability.CastNoTarget(bkb) 
          return
        end
        if Menu.IsEnabled(SlarkMrG.optionSilence) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED)  then
          if orchid and Ability.IsCastable(orchid, mana) and Ability.IsReady(orchid) then
            Ability.CastTarget(orchid, enemy) 
            return
          end
          if bloodthorn and Ability.IsCastable(bloodthorn, mana) and Ability.IsReady(bloodthorn) then
            Ability.CastTarget(bloodthorn, enemy) 
            return
          end
        end
        if distance<140 and Menu.IsEnabled(SlarkMrG.optionAbyssal) and abyssal and Ability.IsCastable(abyssal, mana) and Ability.IsReady(abyssal) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
          Ability.CastTarget(abyssal, enemy) 
          return
        end
        if w and Ability.IsCastable(w, mana) and Ability.IsReady(w) then
          castpos = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(distance - 1))
          Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,enemy, castpos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
          puncepos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(distance)
          if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) or not NPC.IsRunning(enemy) then
            predpos = SlarkMrG.InFront(50)
          else
            predpos = SlarkMrG.InFront(300)
          end
          jump = (puncepos - predpos):Length2D()
          if jump <= 100 then
            Ability.CastNoTarget(w) 
            return 
          end
        end
      end
    end
  end
  
  
  if SlarkMrG.casted == true then
    distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D()
    castpos = (Entity.GetAbsOrigin(enemy) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Normalized():Scaled(distance - 1))
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,enemy, castpos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
    puncepos = Entity.GetAbsOrigin(myHero) + Entity.GetRotation(myHero):GetForward():Normalized():Scaled(distance)
    if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) or not NPC.IsRunning(enemy) then
      predpos = SlarkMrG.InFront(50)
    else
      predpos = SlarkMrG.InFront(300)
    end
    jump = (puncepos - predpos):Length2D()
    if jump <= 100 then
      Ability.CastNoTarget(w) 
      SlarkMrG.casted = false
      return 
    end
  end
  
  
  
  if SlarkMrG.castedm == true then
    distance = (Input.GetWorldCursorPos() - Entity.GetAbsOrigin(myHero)):Length2D()
    if w and Ability.IsCastable(w, mana) and Ability.IsReady(w) then
      if SlarkMrG.check == true then
        SlarkMrG.check = false
        SlarkMrG.ComboTimer = os.clock() + 0.3
      end
      if SlarkMrG.check == false then
        castpos = (Input.GetWorldCursorPos() + (Entity.GetAbsOrigin(myHero) - Input.GetWorldCursorPos()):Normalized():Scaled(distance - 1))
        Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,enemy, castpos, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
        if SlarkMrG.ComboTimer < os.clock() then
          Ability.CastNoTarget(w) 
          SlarkMrG.check = true
          SlarkMrG.castedm = false
          return
        end 
      end
    end
  end
  
  
  --Ult
  if Menu.IsEnabled(SlarkMrG.optionAutoUlt) then
    if r and Ability.IsCastable(r, mana) and Ability.IsReady(r) then
      if (Entity.GetHealth(myHero) <= (Entity.GetMaxHealth(myHero) * (Menu.GetValue(SlarkMrG.optionUltSlider) / 100))) then
        if NPC.HasModifier(myHero, "modifier_slark_shadow_dance_passive_regen") then return end
        Ability.CastNoTarget(r) 
      end
    end
  end
end


function SlarkMrG.Target(myHero)
  if not myHero then return end
  enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  if not enemy then return end
  targetingRange = Menu.GetValue(SlarkMrG.optionTarget)
  mousePos = Input.GetWorldCursorPos()
  enemyDist = (Entity.GetAbsOrigin(enemy) - mousePos):Length2D()
  if enemyDist < targetingRange then 
    return enemy
  else
    return mousePos
  end
end


function SlarkMrG.OnPrepareUnitOrders(orders)
  if not orders or not orders.ability then return true end
  if not Entity.IsAbility(orders.ability) then return true end
  if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_TRAIN_ABILITY then return true end
  if Ability.GetName(orders.ability) == "slark_pounce" then
    if Menu.IsEnabled(SlarkMrG.optionPounceAim) then
      if Menu.GetValue(SlarkMrG.optionPounce) < 1 then
        distance = (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(myHero)):Length2D()
        if distance>650 then 
          Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,enemy, Entity.GetAbsOrigin(enemy), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
        else
          SlarkMrG.casted = true
        end
      else
        SlarkMrG.castedm = true
      end
      return false
    else
      return true
    end
  end
end

function SlarkMrG.InFront(delay)
  enemyPos = Entity.GetAbsOrigin(enemy)
  vec = Entity.GetRotation(enemy):GetVectors()
  adjusment = NPC.GetMoveSpeed(enemy)
  if delay == 610 then
    adjusment = 300
  end
  if vec then		
    x = enemyPos:GetX() + vec:GetX() *(delay / 1000) * adjusment
    y = enemyPos:GetY() + vec:GetY() *(delay / 1000) * adjusment
    return Vector(x, y, enemyPos:GetZ())
  end
end


return SlarkMrG
