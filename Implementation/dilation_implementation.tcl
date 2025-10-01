proc dilation_implementation {matrix} {
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
    

    set dilation_matrix {}
    for {set i 0} {$i < $matrix_W} {incr i} {
        lappend dilation_matrix [lrepeat $matrix_H 0]
    }
    
    for {set h $padding} {$h < $matrix_H} {incr h} {
        for {set w $padding} {$w < $matrix_W} {incr w} {
            if {
                [lindex [lindex $padding_matrix [expr {$w - 1}]] [expr {$h + 1}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w}]] [expr {$h + 1}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w + 1}]] [expr {$h + 1}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w - 1}]] [expr {$h}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w + 1}]] [expr {$h}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w - 1}]] [expr {$h - 1}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w}]] [expr {$h - 1}]] == 1 ||
                [lindex [lindex $padding_matrix [expr {$w + 1}]] [expr {$h - 1}]] == 1
            } {
                lset dilation_matrix [expr {$w - $padding}] [expr {$h - $padding}] 1
            }
        }
    }
    
    return $dilation_matrix
}