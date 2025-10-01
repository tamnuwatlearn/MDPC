proc erosion_implementation {matrix} {

    set padding 1
    set matrix_W [llength $matrix]
    set matrix_H [llength [lindex $matrix 0]]
    
    set padding_matrix {}
    for {set i 0} {$i < [expr {$matrix_W + $padding}]} {incr i} {
        lappend padding_matrix [lrepeat [expr {$matrix_H + $padding}] 0]
    }

    for {set h 0} {$h < $matrix_H} {incr h} {
        for {set w 0} {$w < $matrix_W} {incr w} {
            lset padding_matrix [expr {$w + $padding}] [expr {$h + $padding}] [lindex [lindex $matrix $w] $h]
        }
    }
	
	set erosion_matrix {}
    for {set i 0} {$i < $matrix_W} {incr i} {
        lappend erosion_matrix [lrepeat $matrix_H 0]
    }

    # Perform erosion operation
    for {set h $padding} {$h < $matrix_H} {incr h} {
        for {set w $padding} {$w < $matrix_W} {incr w} {
            if {[lindex [lindex $padding_matrix $w] $h] == 1} {
                set count 0
                if {[lindex [lindex $padding_matrix [expr $w-1]] [expr $h+1]] == 1} {incr count}
                if {[lindex [lindex $padding_matrix $w] [expr $h+1]] == 1} {incr count}
                if {[lindex [lindex $padding_matrix [expr $w+1]] [expr $h+1]] == 1} {incr count}
                if {[lindex [lindex $padding_matrix [expr $w-1]] $h] == 1} {incr count}
                if {[lindex [lindex $padding_matrix [expr $w+1]] $h] == 1} {incr count}
                if {[lindex [lindex $padding_matrix [expr $w-1]] [expr $h-1]] == 1} {incr count}
                if {[lindex [lindex $padding_matrix $w] [expr $h-1]] == 1} {incr count}
                if {[lindex [lindex $padding_matrix [expr $w+1]] [expr $h-1]] == 1} {incr count}

                if {$count < 8 && $count > 0} {
                    lset erosion_matrix [expr $w-$padding] [expr $h-$padding] 0
                } else {
                    lset erosion_matrix [expr $w-$padding] [expr $h-$padding] [lindex [lindex $padding_matrix $w] $h]
                }
            }
        }
    }

    return $erosion_matrix
}