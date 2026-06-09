-- GreenAlienHead
-- Xaidee
mods["ReturnsAPI-ReturnsAPI"].auto{
    namespace   = "GreenAlienHead",
    mp          = true
}

PATH = _ENV["!plugins_mod_folder_path"].."/"

local init = function()
	-- Predefine here so we can make it configurable at a later date.
	local alienHeadCdr = 0.85 --(this is a -15% reduction)
	
	local alienHead = Item.find("alienHead")
	GM.sprite_replace(gm.constants.sAlienHead, path.combine(PATH, "greenAlienHead.png"), 1, false, false, 16, 16)
	alienHead:set_tier(ItemTier.UNCOMMON) --set the item's tier

	local log = ItemLog.wrap(alienHead.item_log_id)
	log.token_description = "item.alienHeadNew.description" --this works for log but doesn't affect the item description if viewed in-run through klehrik's general qol. i have no idea why. voltaicmittbuff does this exact thing and it affects both
	log.token_priority ="item.alienHeadNew.priority"
	
	RecalculateStats.add(function(actor, api)
		local stack = actor:item_count(alienHead)
		if stack <= 0 then return end
		--recalcstats rework removed the cdr variable and only left the option for mult
		--so we divide our desired alienhead cdr multiplier by the vanilla cdr mult (0.7)
		local realMult = alienHeadCdr / 0.7
		api.cooldown_mult(realMult ^ stack)
	end)
	
	HOTLOADING = true
end

Initialize.add(init)

if HOTLOADING then
	init()
end

