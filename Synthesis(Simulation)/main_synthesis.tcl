source "D:/ECO/synthesis/adaptive_delay_elements.tcl"
source "D:/ECO/synthesis/remove_delay_synthesis.tcl"
source "D:/ECO/synthesis/insert_delay_synthesis.tcl"
config_timing_pessimism -disable


set delay_element_len [llength $delay_elements]
set threshold_value 0.5
set delay_net_in "d"  
set delay_net_out "z"

for {set i 0} {$i < $delay_element_len} {incr i} {

	set delay_element [lindex [lindex $delay_elements $i] 0]
	set type [lindex [lindex $delay_elements $i] 1]
	
	puts $delay_element
	remove_delay_synthesis $delay_element $delay_net_in $delay_net_out
	
	if {$type == "Normal"} {
		set STA [lindex [lindex $delay_elements $i] 2]
		source $STA
		while {1} {
			set slack [get_property SLACK [get_timing_paths -max_paths 1]]
			set extra [lindex [lindex $delay_elements $i] 3]
			set threshold [expr {$threshold_value + $extra}]
			
			
			puts "${delay_element} : ${slack}"
			if {$slack >= $threshold} {
				puts "${delay_element} : ${slack}"
				source $STA
				break;
			}
			insert_delay_synthesis $delay_element $delay_net_in $delay_net_out
		}
	} elseif {$type == "Jump"} {
		# get required_time from fix data paths
		set STA_data_path [lindex [lindex $delay_elements $i] 2]
		source $STA_data_path
		set required_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
		
		# get arrival time
		set STA_control_path [lindex [lindex $delay_elements $i] 3]
		source $STA_control_path
		
		set extra [lindex [lindex $delay_elements $i] 4]
		set threshold [expr {$threshold_value + $extra}]
		
		while {1} {
			set arrival_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
			set slack [expr {$arrival_time - $required_time}]
			puts "${delay_element} :${required_time}:${arrival_time}: ${slack}"
			if {$slack >= $threshold} {
				puts "${delay_element} : ${slack}"
				source $STA_data_path
				source $STA_control_path
				break;
			}
			insert_delay_synthesis $delay_element $delay_net_in $delay_net_out
			
		}
		
	} elseif {$type == "Branch"} {
		# get required_time from fix data paths
		set STA_data_path [lindex [lindex $delay_elements $i] 2]
		source $STA_data_path
		set required_time [get_property ARRIVAL_TIME [get_timing_paths -max_paths 1]]
		
		puts " required_time : ${required_time}"
		
		set STA_control_path [lindex [lindex $delay_elements $i] 3]
		source $STA_control_path
		
		set extra [lindex [lindex $delay_elements $i] 4]
		set threshold [expr {$threshold_value + $extra}]
		
		while {1} {
			set arrival_time [get_property REQUIRED_TIME [get_timing_paths -max_paths 1]]
			set slack [expr {$arrival_time - $required_time}]
			puts "${delay_element} :${required_time}:${arrival_time}: ${slack}"
			if {$slack >= $threshold} {
				puts "${delay_element} : ${slack}"
				source $STA_data_path
				source $STA_control_path
				break;
			}
			insert_delay_synthesis $delay_element $delay_net_in $delay_net_out
		}
	}
}



source "D:/ECO/synthesis/generateAllTimingReport.tcl"