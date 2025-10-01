proc subtraction_implementation {matrixA matrixB} {
    set matrix_W [llength $matrixA]
    set matrix_H [llength [lindex $matrixA 0]]

    # Create result matrix initialized to 0	
	set erosion_matrix {}
    for {set i 0} {$i < $matrix_W} {incr i} {
        lappend result_matrix [lrepeat $matrix_H 0]
    }

    # Perform subtraction operation
    for {set h 0} {$h < $matrix_H} {incr h} {
        for {set w 0} {$w < $matrix_W} {incr w} {
            if {[lindex [lindex $matrixA $w] $h] != [lindex [lindex $matrixB $w] $h]} {
                lset result_matrix $w $h 1
            }
        }
    }

    return $result_matrix
}