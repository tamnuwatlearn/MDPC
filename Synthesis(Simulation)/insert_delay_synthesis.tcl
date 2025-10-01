proc insert_delay_synthesis {{delay_element "delay_req"} {net_in "d"} {net_out "z"}} {

	set net_connect "w"
	set delay_name "delay"
	set base_path [get_cells -hierarchical -filter "NAME =~ *${delay_element}"]
	set num_inserted_delay [llength [get_cells -hierarchical -filter {PRIMITIVE_LEVEL==LEAF} -regexp .*$delay_element/.*]]


	create_cell -reference LUT1 "${base_path}/${delay_name}${num_inserted_delay}"
	set_property init 2'h2 [get_cells "${base_path}/${delay_name}${num_inserted_delay}"]

	if {$num_inserted_delay == 0} {
		disconnect_net -net "${base_path}/${net_in}" -objects [list "${base_path}/${net_in}" "${base_path}/${net_out}"]
		connect_net -hierarchical -net "${base_path}/${net_in}" -objects [list "${base_path}/${net_in}" "${base_path}/${delay_name}${num_inserted_delay}/I0"]
	} else {
		remove_net [list "${base_path}/${net_out}" "${base_path}/${net_out}"]
		create_net "${base_path}/${net_connect}[expr {$num_inserted_delay - 1}]"
		connect_net -hierarchical -net "${base_path}/${net_connect}[expr {$num_inserted_delay - 1}]" \
					-objects [list "${base_path}/${delay_name}[expr {$num_inserted_delay - 1}]/O" "${base_path}/${delay_name}${num_inserted_delay}/I0"]
	}


	create_net "${base_path}/$net_out" 
	connect_net -hierarchical -net "${base_path}/$net_out" -objects [list "${base_path}/${net_out}" "${base_path}/${delay_name}${num_inserted_delay}/O"]
}
