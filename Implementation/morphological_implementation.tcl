source "D:/MDPC/implementation/insert_delay_implementation.tcl"
source "D:/MDPC/implementation/remove_delay_implementation.tcl"
source "D:/MDPC/implementation/border_implementation.tcl"
source "D:/MDPC/implementation/remove_top_delay_implementation.tcl"
source "D:/MDPC/implementation/find_closest_slack_implementation.tcl"

proc morphological_implementation {delay_element type STA_data_path STA_control_path speed threshold threshold_error luts_per_slice} { 
	
	# process round
	set round 1
	
	set letters {}
	for {set m 0} {$m < $luts_per_slice} {incr m} {
		lappend letters [format %c [expr {65 + $m}]]
	}
	
	# run STA
	if {$type == "Normal"} {
		source $STA_control_path
	} elseif {$type == "Branch"} {
		source $STA_data_path
		set required_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
		source $STA_control_path
	} elseif {$type == "Jump"} {
		source $STA_data_path
		set required_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
		source $STA_control_path
	}
	
	
	# Row and col of chip
	set part [get_property PART [current_design]]
	set ROWS [get_property ROWS [get_parts $part]] 
	set COLS [get_property COLS [get_parts $part]] 
	
	
	
	set sites [get_property LOC [get_cells -hierarchical -filter { PRIMITIVE_GROUP!=CLK && PRIMITIVE_GROUP!=IO} -regexp .*/.*]]
	set border_sites [border_implementation $sites]
		

	puts "length of list {[llength $border_sites]}"
	for {set m 0} {$m < $speed} {incr m} {
		set filtered_list [list]
		for {set n 0} {$n < [llength $border_sites]} {incr n} {
			if {$n % 2 == 0} {  # Keep even indices (0, 2, 4,...)
				lappend filtered_list [lindex $border_sites $n]
			}
		}
		set border_sites $filtered_list
	}
	puts "length of filtered list {[llength $border_sites]}"
	
	while {1} {
		set slacks {}
		foreach site $border_sites {	
			
			set insertingSite ""
			
			foreach letter $letters {
				set is_used [get_property IS_USED [get_bels "${site}/${letter}6LUT"]]
				if {$is_used == 0} {
					set insertingSite "${site}/${letter}6LUT"
					break
				}
			}
						
			
			if {$insertingSite != ""} {
				insert_delay_implementation $delay_element "d" "z" $insertingSite
				if {$type == "Normal"} {
					set slack [get_property SLACK [get_timing_paths -max_paths 1]]
				} elseif {$type == "Branch"} {
					set arrival_time [get_property REQUIRED_TIME [get_timing_paths -max_paths 1]]
					set slack [expr {$arrival_time - $required_time}]
				} elseif {$type == "Jump"} {
					set arrival_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
					set slack [expr {$arrival_time - $required_time}]
				}
				lappend slacks [list $insertingSite $slack]
				remove_top_delay_implementation $delay_element "d" "z"
				#puts "${insertingSite} : ${slack}"
			}
			
			
			#if {[get_property PRIMITIVE_COUNT [get_sites $site]]==0 } {
			#	insert_delay_implementation $delay_element "d" "z" "${site}/D6LUT"
			#	
			#	if {$type == "Normal"} {
			#		set slack [get_property SLACK [get_timing_paths -max_paths 1]]
			#	} elseif {$type == "Branch"} {
			#		set arrival_time [get_property REQUIRED_TIME [get_timing_paths -max_paths 1]]
			#		set slack [expr {$arrival_time - $required_time}]
			#	} 

			#	lappend slacks [list $site $slack]
			#	remove_top_delay_implementation $delay_element "d" "z"
			#	puts "${site} : ${slack}"
			#}
		}
		
		set item [find_closest_slack_implementation $slacks $threshold]
		set inserted_site [lindex $item 0]
		set inserted_slack [lindex $item 1]
		
		insert_delay_implementation $delay_element "d" "z" "${inserted_site}"
		puts "closest of round ${round} of ${delay_element} : site ${inserted_site} : ${inserted_slack}"
		
		# remove inserted site from the list
		set index [lsearch -exact $border_sites $inserted_site]
		set border_sites [lreplace $border_sites $index $index]
		
		set diff [expr abs($threshold - $inserted_slack)]
		if {$diff <= $threshold_error || $inserted_slack >= $threshold} {
			puts "finnish to insert delay"
			return;
		} else {
			
			# expand location 
			#[regexp {SLICE_X(\d+)Y(\d+)} $inserted_site match x y]
			
			#set offsets {
			#		{-1  1} {0  1} {1  1}
			#		{-1  0}        {1  0}
			#		{-1 -1} {0 -1} {1 -1}
			#	}
				
			#foreach offset $offsets {
			#	lassign $offset dx dy
			#	set newX [expr {$x + $dx}]
			#	set newY [expr {$y + $dy}] 
			#	if {($newY < $ROWS) && ($newY > 0) && ($newX < $COLS) && ($newX > 0)} {
			#		set s "SLICE_X[expr {$newX}]Y[expr {$newY}]"
			#		if {[get_property PRIMITIVE_COUNT [get_sites $s]] == 0 &&
			#			[lsearch -exact $border_sites $s] == -1
			#		} {
			#				lappend border_sites $s
			#		}
			#			
			#	}
					
			#}
		}
		incr round
	}
}
