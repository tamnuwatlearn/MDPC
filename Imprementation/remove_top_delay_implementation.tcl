proc remove_top_delay_implementation {{delay_element "delay_req"} {net_in "d"} {net_out "z"}} {
	set net_connect "w"
	set delay_name "delay"
	set base_path [get_cells -hierarchical -filter "NAME =~ *${delay_element}"]
	set num_inserted_delay [llength [get_cells -hierarchical -filter {PRIMITIVE_LEVEL==LEAF} -regexp .*$delay_element/.*]]

	if {$num_inserted_delay > 0} {
		unplace_cell [get_cells "${base_path}/${delay_name}[expr {$num_inserted_delay - 1}]" ]
		remove_cell [get_cells "${base_path}/${delay_name}[expr {$num_inserted_delay - 1}]" ]
		if {$num_inserted_delay == 1} {
			remove_net [get_nets "${base_path}/${net_out}" ]
			connect_net -hierarchical -net "${base_path}/$net_in" -objects [list "${base_path}/${net_out}"]
		} else {
			remove_net [get_nets "${base_path}/${net_connect}[expr {$num_inserted_delay - 2}]" ]
			connect_net -hierarchical -net "${base_path}/$net_out" -objects [list "${base_path}/${delay_name}[expr {$num_inserted_delay - 2}]/O"]
		}
	}
}