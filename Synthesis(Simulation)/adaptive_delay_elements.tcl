set delay_elements {

	{
		"delay_PC"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_PC_to_IF.tcl"
		0
	}
	
	{
		"delay_IF"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_IF_to_ID.tcl"
		0
	}
	
	{
		"DSU_ID/delay_element_DSU_ID_0"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_DSU_ID_delay0.tcl"
		0
	}
	
	{
		"DSU_ID/delay_element_DSU_ID_1"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_DSU_ID_delay1.tcl"
		0
	}
	
	{
		"delay_PCSrcE"
		"Jump"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_branch_ID_to_PC1.tcl"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_branch_ID_to_PC2.tcl"
		0
	}
	
	{
		"DSU_ID/delay_element_DSU_ID_2"
		"Branch"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_branch_ID_to_PC0.tcl"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_DSU_ID_delay2.tcl"
		0
	}
	
	{
		"DSU_ID/delay_element_DSU_ID_3"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_ID_to_EX_DSU_ID_delay3.tcl"
		0
	}
	
	{
		"delay_EXtoDMEM"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_EX_to_MEM_CLK_DMEM.tcl"
		0
	}
	
	{
		"DSU_EX/delay_element_DSU_EX_0"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_EX_to_MEM_DSU_EX_delay0.tcl"
		0
	}
	
	{
		"DSU_EX/delay_element_DSU_EX_1"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_EX_to_MEM_DSU_EX_delay1.tcl"
		0
	}
	
	{
		"DSU_EX/delay_element_DSU_EX_2"
		"Branch"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_EX_to_MEM_CLK_DMEM.tcl"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_EX_to_MEM_DSU_EX_delay2.tcl"
		0
	}
	
	{
		"delay_MEMtoRegister"
		"Normal"
		"D:/Circuit/RISCV/async_RV32I_normal_adative_frequency/STA/setup_RB_to_ID.tcl"
		0
	}
}