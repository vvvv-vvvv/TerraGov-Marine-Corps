/obj/item/armor_module/armor/cape
	name = "6E chameleon cape (long)"
	desc = "A chromatic cape to improve on the design of the 7E badge, this cape is capable of two colors, for all your fashion needs. It also is equipped with thermal insulators so it will double as a blanket. \n Interact with facepaint to color. Attaches onto a uniform. Activate it to toggle the hood."
	icon_state = "cape"
	slot = ATTACHMENT_SLOT_CAPE
	attachment_layer = CAPE_LAYER
	prefered_slot = SLOT_W_UNIFORM
	greyscale_config = /datum/greyscale_config/cape
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB|ATTACH_ACTIVATION
	attach_delay = 0 SECONDS
	detach_delay = 0 SECONDS
	secondary_color = TRUE
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight)
	///True if the hood is up, false if not.
	var/hood = FALSE

/obj/item/armor_module/armor/cape/Initialize()
	. = ..()
	AddComponent(/datum/component/attachment_handler, \
	attachments_by_slot, \
	list(
		/obj/item/armor_module/armor/cape_highlight,
		/obj/item/armor_module/armor/cape_highlight/half,
		/obj/item/armor_module/armor/cape_highlight/scarf,
		/obj/item/armor_module/armor/cape_highlight/kama,
	), \
	starting_attachments = starting_attachments)

/obj/item/armor_module/armor/cape/activate(mob/living/user)
	. = ..()
	hood = !hood
	update_icon()
	user.update_inv_w_uniform()

/obj/item/armor_module/armor/cape/update_icon()
	var/obj/item/armor_module/highlight = attachments_by_slot[ATTACHMENT_SLOT_CAPE_HIGHLIGHT]
	if(hood)
		icon_state = "cape_h"
		highlight?.icon_state = "highlight_h"
	else
		icon_state = "cape"
		highlight?.icon_state = "highlight"
	return ..()


/obj/item/armor_module/armor/cape/half
	name = "6E chameleon cape (half)"
	desc = "This version of the 6E cape only has one color. However, it is five percent cheaper. It also is equipped with thermal insulators so it will double as a blanket. \n Interact with facepaint to color. Attaches onto a uniform."
	greyscale_config = /datum/greyscale_config/cape/half
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight/half)

/obj/item/armor_module/armor/cape/scarf
	name = "6E chameleon cape (scarf)"
	desc =  "A cape to improve on the design of the 7E badge, this cape is capable of two colors, for all your fashion needs. This variation of the cape functions more as a scarf. \n Interact with facepaint to color. Attaches onto a uniform. Activate it to toggle the hood."
	greyscale_config = /datum/greyscale_config/cape/scarf
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight/scarf)

/obj/item/armor_module/armor/cape/short
	name = "6E chameleon cape (short)"
	greyscale_config = /datum/greyscale_config/cape/short
	starting_attachments = list()

/obj/item/armor_module/armor/cape/short/classic
	name = "6E chameleon cape (classic short)"
	greyscale_config = /datum/greyscale_config/cape/short/old

/obj/item/armor_module/armor/cape/kama
	name = "6E chameleon kama"
	desc = "A chromatic kama to improve on the design of the 7E badge, this kama is capable of two colors, for all your fashion needs. Hanged from the belt, it serves to flourish the lower extremities.  \n Interact with facepaint to color. Attaches onto a uniform."
	slot = ATTACHMENT_SLOT_KAMA
	attachment_layer = KAMA_LAYER
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight/kama)
	greyscale_config = /datum/greyscale_config/cape/kama


/obj/item/armor_module/armor/cape_highlight
	name = "Cape Highlight"
	desc = "A cape to improve on the design of the 7E badge, this cape is capable of six colors, for all your fashion needs. This variation of the cape functions more as a scarf. \n Interact with facepaint to color. Attaches onto a uniform. Activate it to toggle the hood."
	icon_state = "highlight"
	slot = ATTACHMENT_SLOT_CAPE_HIGHLIGHT
	flags_attach_features = ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	greyscale_config = /datum/greyscale_config/cape_highlight
	secondary_color = TRUE
	greyscale_colors = VISOR_PALETTE_GOLD
	flags_item_map_variant = NONE
	colorable_colors = VISOR_PALETTES_LIST

/obj/item/armor_module/armor/cape_highlight/kama
	greyscale_config = /datum/greyscale_config/cape_highlight/kama

/obj/item/armor_module/armor/cape_highlight/half
	greyscale_config = /datum/greyscale_config/cape_highlight/half

/obj/item/armor_module/armor/cape_highlight/scarf
	greyscale_config = /datum/greyscale_config/cape_highlight/scarf
