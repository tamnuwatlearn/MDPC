source "D:/MDPC/implementation/dilation_implementation.tcl"
source "D:/MDPC/implementation/erosion_implementation.tcl"
source "D:/MDPC/implementation/subtraction_implementation.tcl"

proc border_implementation {slice_locs {chip_W 500} {chip_H 500}} {
	
	# Initialize matrix as a list of lists
	set matrix [list]
	for {set h 0} {$h < $chip_H} {incr h} {
		set row {}
		for {set w 0} {$w < $chip_W} {incr w} {
			lappend row 0
		}
		lappend matrix $row
	}
	
	# Update matrix based on slice locations
	foreach slice $slice_locs {
		if {[regexp {SLICE_X(\d+)Y(\d+)} $slice match x y]} {
			if {$y < $chip_H && $x < $chip_W} {
				set row [lindex $matrix $y]
				lset row $x 1
				lset matrix $y $row
			}
		}
	}
	
	set dilation_matrix [dilation $matrix]
	set erosion_matrix [erosion $dilation_matrix]
	set subtract_matrix [subtract $dilation_matrix $erosion_matrix]

	#set print_list {}
	#for {set i 0} {$i < 500} {incr i} {
	#	for {set j 0} {$j < 500} {incr j} {
	#		if {[lindex [lindex $erosion_matrix $i] $j] == 1} {
	#			set slice "SLICE_X${j}Y${i}"
	#			lappend print_list $slice
	#		}
	#	}
	#}
	#select_objects [get_sites $print_list]
	
	set border_slices {}

	for {set y 0} {$y < $chip_H} {incr y} {
		set row [lindex $subtract_matrix $y]
		for {set x 0} {$x < $chip_W} {incr x} {
			if {[lindex $row $x] == 1} {
				if {$x != 0 && $y != 0} {
					if {[get_sites "SLICE_X${x}Y${y}"] != ""} {
						if {[get_property PRIMITIVE_COUNT [get_sites "SLICE_X${x}Y${y}"]]==0} {
							lappend border_slices "SLICE_X${x}Y${y}"
						}
					} 
				}
			}
		}
	}
	
	return $border_slices 
}