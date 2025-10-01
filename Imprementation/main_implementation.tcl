source "D:/MDPC/implementation/remove_all_delay_implementation.tcl"
source "D:/MDPC/implementation/morphological_implementation.tcl"

# Configure to connect STA to extract slack for each timing paths
source "D:/MDPC/implementation/adaptive_delay_elements.tcl"

config_timing_pessimism -disable

set delay_element_len [llength $delay_elements]

# target slack
set threshold_value 0.5
set threshold_error 0.02

# conigure number of LUT in slice, depending on FPGA familes (ZU102 -> 8)
set luts_per_slice 8

# Speed to placedelay 1-(number of LUT in slice-1), slow to fast
set speed 3

# remove all inserted delay 
for {set i 0} {$i < $delay_element_len} {incr i} {
	set delay_element [lindex [lindex $delay_elements $i] 0]
	remove_all_delay_implementation $delay_element "d" "z"
}

for {set i 0} {$i < $delay_element_len} {incr i} {

	
	set delay_element [lindex [lindex $delay_elements $i] 0]
	set type [lindex [lindex $delay_elements $i] 1]
	
	
	#remove_all_delay_implementation $delay_element "d" "z"
	
		puts "Delay : {$delay_element}"
		if {$type == "Normal"} {
			set extra [lindex [lindex $delay_elements $i] 3]
			set threshold [expr {$threshold_value + $extra}]
			set STA_control_path [lindex [lindex $delay_elements $i] 2]
			set STA_data_path ""
			morphological_implementation $delay_element $type $STA_data_path $STA_control_path $speed $threshold $threshold_error $luts_per_slice
		} elseif {$type == "Branch" || $type == "Jump" } {
			set extra [lindex [lindex $delay_elements $i] 4]
			set threshold [expr {$threshold_value + $extra}]
			set STA_data_path [lindex [lindex $delay_elements $i] 2]
			set STA_control_path [lindex [lindex $delay_elements $i] 3]
			morphological_implementation $delay_element $type $STA_data_path $STA_control_path $speed $threshold $threshold_error $luts_per_slice
		} 
	
}

source "D:/MDPC/implementation/generateAllTimingReport.tcl"



