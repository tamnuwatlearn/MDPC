proc find_closest_slack_implementation {data_list N} {
	
	set sorted_list [lsort -real -index 1 $data_list]


    set min_diff -1
	set closest_item {}

    foreach item $sorted_list {
        set slack [lindex $item 1]
        set diff [expr abs($N - $slack)]

        if {$slack == $N} {
            return $item
        } elseif {$min_diff == -1 || $diff < $min_diff} {
            set min_diff $diff
			set closest_item $item
        }
    }

    return $closest_item
}