set delay_element_len [llength $delay_elements]

for {set i 0} {$i < $delay_element_len} {incr i} {
	set delay_element [lindex [lindex $delay_elements $i] 0]
	set type [lindex [lindex $delay_elements $i] 1]
	if {$type == "Normal" || $type == "No"} {
		set STA [lindex [lindex $delay_elements $i] 2]
		source $STA
	} else {
		set STA_data_path [lindex [lindex $delay_elements $i] 2]
		source $STA_data_path
		set STA_control_path [lindex [lindex $delay_elements $i] 3]
		source $STA_control_path
	}
}