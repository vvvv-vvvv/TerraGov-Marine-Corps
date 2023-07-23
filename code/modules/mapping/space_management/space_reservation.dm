
//Yes, they can only be rectangular.
//Yes, I'm sorry.
/datum/turf_reservation
	var/list/reserved_turfs = list()
	var/width = 0
	var/height = 0
	var/bottom_left_coords[3]
	var/top_right_coords[3]
	var/wipe_reservation_on_release = TRUE
	var/turf_type = /turf/open/space

/datum/turf_reservation/transit
	turf_type = /turf/open/space/transit

/datum/turf_reservation/banish
	turf_type = /turf/closed/banish_space

/datum/turf_reservation/proc/Release()
	var/v = reserved_turfs.Copy()
	for(var/i in reserved_turfs)
		reserved_turfs -= i
		SSmapping.used_turfs -= i
	SSmapping.reserve_turfs(v)

/datum/turf_reservation/proc/Reserve(width, height, zlevel)
	if(width > world.maxx || height > world.maxy || width < 1 || height < 1)
		log_debug("turf reservation had invalid dimensions")
		return FALSE
	var/list/avail = SSmapping.unused_turfs["[zlevel]"]
	var/turf/BL
	var/turf/TR
	var/list/turf/final = list()
	var/passing = FALSE
	for(var/i in avail)
		CHECK_TICK
		BL = i
		if(!(BL.flags_atom & UNUSED_RESERVATION_TURF_1))
			continue
		if(BL.x + width > world.maxx || BL.y + height > world.maxy)
			continue
		TR = locate(BL.x + width - 1, BL.y + height - 1, BL.z)
		if(!(TR.flags_atom & UNUSED_RESERVATION_TURF_1))
			continue
		final = block(BL, TR)
		if(!final)
			continue
		passing = TRUE
		for(var/I in final)
			var/turf/checking = I
			if(!(checking.flags_atom & UNUSED_RESERVATION_TURF_1))
				passing = FALSE
				break
		if(!passing)
			continue
		break
	if(!passing || !istype(BL) || !istype(TR))
		log_debug("failed to pass reservation tests, [passing], [istype(BL)], [istype(TR)]")
		return FALSE
	bottom_left_coords = list(BL.x, BL.y, BL.z)
	top_right_coords = list(TR.x, TR.y, TR.z)
	for(var/i in final)
		var/turf/T = i
		reserved_turfs |= T
		T.flags_atom &= ~UNUSED_RESERVATION_TURF_1
		SSmapping.unused_turfs["[T.z]"] -= T
		SSmapping.used_turfs[T] = src
		T.ChangeTurf(turf_type, turf_type)
	src.width = width
	src.height = height
	return TRUE

///Change the turf type of all tiles that are belonging to the turf reservation
/datum/turf_reservation/proc/set_turf_type(new_turf_type)
	for(var/turf/T as anything in reserved_turfs)
		if(istype(T, turf_type))
			T.ChangeTurf(new_turf_type, new_turf_type)
	turf_type = new_turf_type


/datum/turf_reservation/New()
	LAZYADD(SSmapping.turf_reservations, src)

/datum/turf_reservation/Destroy()
	INVOKE_ASYNC(src, PROC_REF(Release))
	LAZYREMOVE(SSmapping.turf_reservations, src)
	return ..()
