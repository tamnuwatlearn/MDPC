set delay_elements {

	{
		"delay_PC" # Name of Delay elemetn
		"Normal"   # Normal path or path with jump or branch
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_PC_to_IF.tcl" # script for extract slack value for the delay element
		0 #Extra target slack, it will be added with normal target slack in MDPC
	}
	
	{
		"delay_IF"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_IF_to_ID.tcl"
		0
	}
	
	{
		"delay_ID"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_ID_to_EX.tcl"
		0
	}
	
	{
		"delay_EX"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_EX_to_MEM.tcl"
		0
	}
	
	{
		"delay_PCSrcE"
		"Jump"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_ID_to_EX_branch_ID_to_PC1.tcl"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_ID_to_EX_branch_ID_to_PC2.tcl"
		0
	}
	
	{
		"delay_EXtoDMEM"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_EX_to_MEM_CLK_DMEM.tcl"
		0
	}
	
	{
		"delay_MEMtoRegister"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_Linear/STA/setup_RB_to_ID.tcl"
		0
	}
}