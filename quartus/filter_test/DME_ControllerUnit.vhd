--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ADCSamples1_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal RData_from_the_ADCSamples1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal ADCSamples1_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal Address_to_the_ADCSamples1 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal RD_to_the_ADCSamples1 : OUT STD_LOGIC;
                 signal RData_from_the_ADCSamples1_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                 signal d1_ADCSamples1_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity ADCSamples1_avalon_slave_arbitrator;


architecture europa of ADCSamples1_avalon_slave_arbitrator is
                signal ADCSamples1_avalon_slave_allgrants :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_begins_xfer :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_counter_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ADCSamples1_avalon_slave_end_xfer :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_firsttransfer :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_grant_vector :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_wait_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ADCSamples1_avalon_slave_waits_for_read :  STD_LOGIC;
                signal ADCSamples1_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register_in :  STD_LOGIC;
                signal cpu_data_master_saved_grant_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_ADCSamples1_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal p1_cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_ADCSamples1_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_ADCSamples1_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ADCSamples1_avalon_slave_end_xfer;
    end if;

  end process;

  ADCSamples1_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_ADCSamples1_avalon_slave);
  --assign RData_from_the_ADCSamples1_from_sa = RData_from_the_ADCSamples1 so that symbol knows where to group signals which may go to master only, which is an e_assign
  RData_from_the_ADCSamples1_from_sa <= RData_from_the_ADCSamples1;
  internal_cpu_data_master_requests_ADCSamples1_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --ADCSamples1_avalon_slave_arb_share_counter set values, which is an e_mux
  ADCSamples1_avalon_slave_arb_share_set_values <= std_logic'('1');
  --ADCSamples1_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  ADCSamples1_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_ADCSamples1_avalon_slave;
  --ADCSamples1_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  ADCSamples1_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --ADCSamples1_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  ADCSamples1_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ADCSamples1_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ADCSamples1_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ADCSamples1_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ADCSamples1_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ADCSamples1_avalon_slave_allgrants all slave grants, which is an e_mux
  ADCSamples1_avalon_slave_allgrants <= ADCSamples1_avalon_slave_grant_vector;
  --ADCSamples1_avalon_slave_end_xfer assignment, which is an e_assign
  ADCSamples1_avalon_slave_end_xfer <= NOT ((ADCSamples1_avalon_slave_waits_for_read OR ADCSamples1_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave <= ADCSamples1_avalon_slave_end_xfer AND (((NOT ADCSamples1_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ADCSamples1_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  ADCSamples1_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave AND ADCSamples1_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave AND NOT ADCSamples1_avalon_slave_non_bursting_master_requests));
  --ADCSamples1_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples1_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ADCSamples1_avalon_slave_arb_counter_enable) = '1' then 
        ADCSamples1_avalon_slave_arb_share_counter <= ADCSamples1_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ADCSamples1_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples1_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ADCSamples1_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave)) OR ((end_xfer_arb_share_counter_term_ADCSamples1_avalon_slave AND NOT ADCSamples1_avalon_slave_non_bursting_master_requests)))) = '1' then 
        ADCSamples1_avalon_slave_slavearbiterlockenable <= ADCSamples1_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master ADCSamples1/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ADCSamples1_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ADCSamples1_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ADCSamples1_avalon_slave_slavearbiterlockenable2 <= ADCSamples1_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master ADCSamples1/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ADCSamples1_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --ADCSamples1_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  ADCSamples1_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_ADCSamples1_avalon_slave <= internal_cpu_data_master_requests_ADCSamples1_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic(((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)))))));
  --cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register_in <= (internal_cpu_data_master_granted_ADCSamples1_avalon_slave AND cpu_data_master_read) AND NOT ADCSamples1_avalon_slave_waits_for_read;
  --shift register p1 cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register) & A_ToStdLogicVector(cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register_in)));
  --cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register <= p1_cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_data_master_read_data_valid_ADCSamples1_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_ADCSamples1_avalon_slave <= cpu_data_master_read_data_valid_ADCSamples1_avalon_slave_shift_register;
  --master is always granted when requested
  internal_cpu_data_master_granted_ADCSamples1_avalon_slave <= internal_cpu_data_master_qualified_request_ADCSamples1_avalon_slave;
  --cpu/data_master saved-grant ADCSamples1/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_ADCSamples1_avalon_slave <= internal_cpu_data_master_requests_ADCSamples1_avalon_slave;
  --allow new arb cycle for ADCSamples1/avalon_slave, which is an e_assign
  ADCSamples1_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ADCSamples1_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ADCSamples1_avalon_slave_master_qreq_vector <= std_logic'('1');
  --ADCSamples1_avalon_slave_firsttransfer first transaction, which is an e_assign
  ADCSamples1_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(ADCSamples1_avalon_slave_begins_xfer) = '1'), ADCSamples1_avalon_slave_unreg_firsttransfer, ADCSamples1_avalon_slave_reg_firsttransfer);
  --ADCSamples1_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  ADCSamples1_avalon_slave_unreg_firsttransfer <= NOT ((ADCSamples1_avalon_slave_slavearbiterlockenable AND ADCSamples1_avalon_slave_any_continuerequest));
  --ADCSamples1_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples1_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ADCSamples1_avalon_slave_begins_xfer) = '1' then 
        ADCSamples1_avalon_slave_reg_firsttransfer <= ADCSamples1_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ADCSamples1_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ADCSamples1_avalon_slave_beginbursttransfer_internal <= ADCSamples1_avalon_slave_begins_xfer;
  --RD_to_the_ADCSamples1 assignment, which is an e_mux
  RD_to_the_ADCSamples1 <= ((internal_cpu_data_master_granted_ADCSamples1_avalon_slave AND cpu_data_master_read)) AND NOT ADCSamples1_avalon_slave_begins_xfer;
  shifted_address_to_ADCSamples1_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_ADCSamples1 mux, which is an e_mux
  Address_to_the_ADCSamples1 <= A_EXT (A_SRL(shifted_address_to_ADCSamples1_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 9);
  --d1_ADCSamples1_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ADCSamples1_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ADCSamples1_avalon_slave_end_xfer <= ADCSamples1_avalon_slave_end_xfer;
    end if;

  end process;

  --ADCSamples1_avalon_slave_waits_for_read in a cycle, which is an e_mux
  ADCSamples1_avalon_slave_waits_for_read <= ADCSamples1_avalon_slave_in_a_read_cycle AND wait_for_ADCSamples1_avalon_slave_counter;
  --ADCSamples1_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  ADCSamples1_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_ADCSamples1_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ADCSamples1_avalon_slave_in_a_read_cycle;
  --ADCSamples1_avalon_slave_waits_for_write in a cycle, which is an e_mux
  ADCSamples1_avalon_slave_waits_for_write <= ADCSamples1_avalon_slave_in_a_write_cycle AND wait_for_ADCSamples1_avalon_slave_counter;
  --ADCSamples1_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  ADCSamples1_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_ADCSamples1_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ADCSamples1_avalon_slave_in_a_write_cycle;
  internal_ADCSamples1_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("000000000000000000000000000000") & (ADCSamples1_avalon_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples1_avalon_slave_wait_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      ADCSamples1_avalon_slave_wait_counter <= ADCSamples1_avalon_slave_counter_load_value;
    end if;

  end process;

  ADCSamples1_avalon_slave_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((ADCSamples1_avalon_slave_in_a_read_cycle AND ADCSamples1_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((ADCSamples1_avalon_slave_in_a_write_cycle AND ADCSamples1_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((NOT internal_ADCSamples1_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("0000000000000000000000000000000") & (ADCSamples1_avalon_slave_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 2);
  wait_for_ADCSamples1_avalon_slave_counter <= ADCSamples1_avalon_slave_begins_xfer OR NOT internal_ADCSamples1_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  ADCSamples1_avalon_slave_wait_counter_eq_0 <= internal_ADCSamples1_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_ADCSamples1_avalon_slave <= internal_cpu_data_master_granted_ADCSamples1_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_ADCSamples1_avalon_slave <= internal_cpu_data_master_qualified_request_ADCSamples1_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_ADCSamples1_avalon_slave <= internal_cpu_data_master_requests_ADCSamples1_avalon_slave;
--synthesis translate_off
    --ADCSamples1/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ADCSamples2_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal RData_from_the_ADCSamples2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal ADCSamples2_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal Address_to_the_ADCSamples2 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal RD_to_the_ADCSamples2 : OUT STD_LOGIC;
                 signal RData_from_the_ADCSamples2_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                 signal d1_ADCSamples2_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity ADCSamples2_avalon_slave_arbitrator;


architecture europa of ADCSamples2_avalon_slave_arbitrator is
                signal ADCSamples2_avalon_slave_allgrants :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_begins_xfer :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_counter_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ADCSamples2_avalon_slave_end_xfer :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_firsttransfer :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_grant_vector :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_wait_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ADCSamples2_avalon_slave_waits_for_read :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register_in :  STD_LOGIC;
                signal cpu_data_master_saved_grant_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_ADCSamples2_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal p1_cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_ADCSamples2_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_ADCSamples2_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ADCSamples2_avalon_slave_end_xfer;
    end if;

  end process;

  ADCSamples2_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_ADCSamples2_avalon_slave);
  --assign RData_from_the_ADCSamples2_from_sa = RData_from_the_ADCSamples2 so that symbol knows where to group signals which may go to master only, which is an e_assign
  RData_from_the_ADCSamples2_from_sa <= RData_from_the_ADCSamples2;
  internal_cpu_data_master_requests_ADCSamples2_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000001000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --ADCSamples2_avalon_slave_arb_share_counter set values, which is an e_mux
  ADCSamples2_avalon_slave_arb_share_set_values <= std_logic'('1');
  --ADCSamples2_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  ADCSamples2_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_ADCSamples2_avalon_slave;
  --ADCSamples2_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  ADCSamples2_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --ADCSamples2_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  ADCSamples2_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ADCSamples2_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ADCSamples2_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ADCSamples2_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ADCSamples2_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ADCSamples2_avalon_slave_allgrants all slave grants, which is an e_mux
  ADCSamples2_avalon_slave_allgrants <= ADCSamples2_avalon_slave_grant_vector;
  --ADCSamples2_avalon_slave_end_xfer assignment, which is an e_assign
  ADCSamples2_avalon_slave_end_xfer <= NOT ((ADCSamples2_avalon_slave_waits_for_read OR ADCSamples2_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave <= ADCSamples2_avalon_slave_end_xfer AND (((NOT ADCSamples2_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ADCSamples2_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  ADCSamples2_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave AND ADCSamples2_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave AND NOT ADCSamples2_avalon_slave_non_bursting_master_requests));
  --ADCSamples2_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples2_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ADCSamples2_avalon_slave_arb_counter_enable) = '1' then 
        ADCSamples2_avalon_slave_arb_share_counter <= ADCSamples2_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ADCSamples2_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples2_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ADCSamples2_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave)) OR ((end_xfer_arb_share_counter_term_ADCSamples2_avalon_slave AND NOT ADCSamples2_avalon_slave_non_bursting_master_requests)))) = '1' then 
        ADCSamples2_avalon_slave_slavearbiterlockenable <= ADCSamples2_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master ADCSamples2/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ADCSamples2_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ADCSamples2_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ADCSamples2_avalon_slave_slavearbiterlockenable2 <= ADCSamples2_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master ADCSamples2/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ADCSamples2_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --ADCSamples2_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  ADCSamples2_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_ADCSamples2_avalon_slave <= internal_cpu_data_master_requests_ADCSamples2_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic(((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)))))));
  --cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register_in <= (internal_cpu_data_master_granted_ADCSamples2_avalon_slave AND cpu_data_master_read) AND NOT ADCSamples2_avalon_slave_waits_for_read;
  --shift register p1 cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register) & A_ToStdLogicVector(cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register_in)));
  --cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register <= p1_cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_data_master_read_data_valid_ADCSamples2_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_ADCSamples2_avalon_slave <= cpu_data_master_read_data_valid_ADCSamples2_avalon_slave_shift_register;
  --master is always granted when requested
  internal_cpu_data_master_granted_ADCSamples2_avalon_slave <= internal_cpu_data_master_qualified_request_ADCSamples2_avalon_slave;
  --cpu/data_master saved-grant ADCSamples2/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_ADCSamples2_avalon_slave <= internal_cpu_data_master_requests_ADCSamples2_avalon_slave;
  --allow new arb cycle for ADCSamples2/avalon_slave, which is an e_assign
  ADCSamples2_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ADCSamples2_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ADCSamples2_avalon_slave_master_qreq_vector <= std_logic'('1');
  --ADCSamples2_avalon_slave_firsttransfer first transaction, which is an e_assign
  ADCSamples2_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(ADCSamples2_avalon_slave_begins_xfer) = '1'), ADCSamples2_avalon_slave_unreg_firsttransfer, ADCSamples2_avalon_slave_reg_firsttransfer);
  --ADCSamples2_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  ADCSamples2_avalon_slave_unreg_firsttransfer <= NOT ((ADCSamples2_avalon_slave_slavearbiterlockenable AND ADCSamples2_avalon_slave_any_continuerequest));
  --ADCSamples2_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples2_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ADCSamples2_avalon_slave_begins_xfer) = '1' then 
        ADCSamples2_avalon_slave_reg_firsttransfer <= ADCSamples2_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ADCSamples2_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ADCSamples2_avalon_slave_beginbursttransfer_internal <= ADCSamples2_avalon_slave_begins_xfer;
  --RD_to_the_ADCSamples2 assignment, which is an e_mux
  RD_to_the_ADCSamples2 <= ((internal_cpu_data_master_granted_ADCSamples2_avalon_slave AND cpu_data_master_read)) AND NOT ADCSamples2_avalon_slave_begins_xfer;
  shifted_address_to_ADCSamples2_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_ADCSamples2 mux, which is an e_mux
  Address_to_the_ADCSamples2 <= A_EXT (A_SRL(shifted_address_to_ADCSamples2_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 9);
  --d1_ADCSamples2_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ADCSamples2_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ADCSamples2_avalon_slave_end_xfer <= ADCSamples2_avalon_slave_end_xfer;
    end if;

  end process;

  --ADCSamples2_avalon_slave_waits_for_read in a cycle, which is an e_mux
  ADCSamples2_avalon_slave_waits_for_read <= ADCSamples2_avalon_slave_in_a_read_cycle AND wait_for_ADCSamples2_avalon_slave_counter;
  --ADCSamples2_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  ADCSamples2_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_ADCSamples2_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ADCSamples2_avalon_slave_in_a_read_cycle;
  --ADCSamples2_avalon_slave_waits_for_write in a cycle, which is an e_mux
  ADCSamples2_avalon_slave_waits_for_write <= ADCSamples2_avalon_slave_in_a_write_cycle AND wait_for_ADCSamples2_avalon_slave_counter;
  --ADCSamples2_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  ADCSamples2_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_ADCSamples2_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ADCSamples2_avalon_slave_in_a_write_cycle;
  internal_ADCSamples2_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("000000000000000000000000000000") & (ADCSamples2_avalon_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ADCSamples2_avalon_slave_wait_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      ADCSamples2_avalon_slave_wait_counter <= ADCSamples2_avalon_slave_counter_load_value;
    end if;

  end process;

  ADCSamples2_avalon_slave_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((ADCSamples2_avalon_slave_in_a_write_cycle AND ADCSamples2_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'(((ADCSamples2_avalon_slave_in_a_read_cycle AND ADCSamples2_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_ADCSamples2_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("0000000000000000000000000000000") & (ADCSamples2_avalon_slave_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 2);
  wait_for_ADCSamples2_avalon_slave_counter <= ADCSamples2_avalon_slave_begins_xfer OR NOT internal_ADCSamples2_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  ADCSamples2_avalon_slave_wait_counter_eq_0 <= internal_ADCSamples2_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_ADCSamples2_avalon_slave <= internal_cpu_data_master_granted_ADCSamples2_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_ADCSamples2_avalon_slave <= internal_cpu_data_master_qualified_request_ADCSamples2_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_ADCSamples2_avalon_slave <= internal_cpu_data_master_requests_ADCSamples2_avalon_slave;
--synthesis translate_off
    --ADCSamples2/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DACSamples_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_DACSamples : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal DACSamples_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal Data_to_the_DACSamples : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_DACSamples : OUT STD_LOGIC;
                 signal cpu_data_master_granted_DACSamples_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_DACSamples_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_DACSamples_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_DACSamples_avalon_slave : OUT STD_LOGIC;
                 signal d1_DACSamples_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity DACSamples_avalon_slave_arbitrator;


architecture europa of DACSamples_avalon_slave_arbitrator is
                signal DACSamples_avalon_slave_allgrants :  STD_LOGIC;
                signal DACSamples_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal DACSamples_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal DACSamples_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal DACSamples_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal DACSamples_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal DACSamples_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal DACSamples_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal DACSamples_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal DACSamples_avalon_slave_begins_xfer :  STD_LOGIC;
                signal DACSamples_avalon_slave_counter_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal DACSamples_avalon_slave_end_xfer :  STD_LOGIC;
                signal DACSamples_avalon_slave_firsttransfer :  STD_LOGIC;
                signal DACSamples_avalon_slave_grant_vector :  STD_LOGIC;
                signal DACSamples_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal DACSamples_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal DACSamples_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal DACSamples_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal DACSamples_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal DACSamples_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal DACSamples_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal DACSamples_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal DACSamples_avalon_slave_wait_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal DACSamples_avalon_slave_waits_for_read :  STD_LOGIC;
                signal DACSamples_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_DACSamples_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_DACSamples_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_DACSamples_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_DACSamples_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_DACSamples_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_DACSamples_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_DACSamples_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_DACSamples_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT DACSamples_avalon_slave_end_xfer;
    end if;

  end process;

  DACSamples_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_DACSamples_avalon_slave);
  internal_cpu_data_master_requests_DACSamples_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --DACSamples_avalon_slave_arb_share_counter set values, which is an e_mux
  DACSamples_avalon_slave_arb_share_set_values <= std_logic'('1');
  --DACSamples_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  DACSamples_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_DACSamples_avalon_slave;
  --DACSamples_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  DACSamples_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --DACSamples_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  DACSamples_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(DACSamples_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(DACSamples_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(DACSamples_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(DACSamples_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --DACSamples_avalon_slave_allgrants all slave grants, which is an e_mux
  DACSamples_avalon_slave_allgrants <= DACSamples_avalon_slave_grant_vector;
  --DACSamples_avalon_slave_end_xfer assignment, which is an e_assign
  DACSamples_avalon_slave_end_xfer <= NOT ((DACSamples_avalon_slave_waits_for_read OR DACSamples_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_DACSamples_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_DACSamples_avalon_slave <= DACSamples_avalon_slave_end_xfer AND (((NOT DACSamples_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --DACSamples_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  DACSamples_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_DACSamples_avalon_slave AND DACSamples_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_DACSamples_avalon_slave AND NOT DACSamples_avalon_slave_non_bursting_master_requests));
  --DACSamples_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      DACSamples_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(DACSamples_avalon_slave_arb_counter_enable) = '1' then 
        DACSamples_avalon_slave_arb_share_counter <= DACSamples_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --DACSamples_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      DACSamples_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((DACSamples_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_DACSamples_avalon_slave)) OR ((end_xfer_arb_share_counter_term_DACSamples_avalon_slave AND NOT DACSamples_avalon_slave_non_bursting_master_requests)))) = '1' then 
        DACSamples_avalon_slave_slavearbiterlockenable <= DACSamples_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master DACSamples/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= DACSamples_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --DACSamples_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  DACSamples_avalon_slave_slavearbiterlockenable2 <= DACSamples_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master DACSamples/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= DACSamples_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --DACSamples_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  DACSamples_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_DACSamples_avalon_slave <= internal_cpu_data_master_requests_DACSamples_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_DACSamples_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_DACSamples_avalon_slave <= (internal_cpu_data_master_granted_DACSamples_avalon_slave AND cpu_data_master_read) AND NOT DACSamples_avalon_slave_waits_for_read;
  --Data_to_the_DACSamples mux, which is an e_mux
  Data_to_the_DACSamples <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_DACSamples_avalon_slave <= internal_cpu_data_master_qualified_request_DACSamples_avalon_slave;
  --cpu/data_master saved-grant DACSamples/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_DACSamples_avalon_slave <= internal_cpu_data_master_requests_DACSamples_avalon_slave;
  --allow new arb cycle for DACSamples/avalon_slave, which is an e_assign
  DACSamples_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  DACSamples_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  DACSamples_avalon_slave_master_qreq_vector <= std_logic'('1');
  --DACSamples_avalon_slave_firsttransfer first transaction, which is an e_assign
  DACSamples_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(DACSamples_avalon_slave_begins_xfer) = '1'), DACSamples_avalon_slave_unreg_firsttransfer, DACSamples_avalon_slave_reg_firsttransfer);
  --DACSamples_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  DACSamples_avalon_slave_unreg_firsttransfer <= NOT ((DACSamples_avalon_slave_slavearbiterlockenable AND DACSamples_avalon_slave_any_continuerequest));
  --DACSamples_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      DACSamples_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(DACSamples_avalon_slave_begins_xfer) = '1' then 
        DACSamples_avalon_slave_reg_firsttransfer <= DACSamples_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --DACSamples_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  DACSamples_avalon_slave_beginbursttransfer_internal <= DACSamples_avalon_slave_begins_xfer;
  --WR_to_the_DACSamples assignment, which is an e_mux
  WR_to_the_DACSamples <= (((internal_cpu_data_master_granted_DACSamples_avalon_slave AND cpu_data_master_write)) AND NOT DACSamples_avalon_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (DACSamples_avalon_slave_wait_counter))>=std_logic_vector'("00000000000000000000000000000001"))));
  shifted_address_to_DACSamples_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_DACSamples mux, which is an e_mux
  Address_to_the_DACSamples <= A_EXT (A_SRL(shifted_address_to_DACSamples_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 9);
  --d1_DACSamples_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_DACSamples_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_DACSamples_avalon_slave_end_xfer <= DACSamples_avalon_slave_end_xfer;
    end if;

  end process;

  --DACSamples_avalon_slave_waits_for_read in a cycle, which is an e_mux
  DACSamples_avalon_slave_waits_for_read <= DACSamples_avalon_slave_in_a_read_cycle AND DACSamples_avalon_slave_begins_xfer;
  --DACSamples_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  DACSamples_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_DACSamples_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= DACSamples_avalon_slave_in_a_read_cycle;
  --DACSamples_avalon_slave_waits_for_write in a cycle, which is an e_mux
  DACSamples_avalon_slave_waits_for_write <= DACSamples_avalon_slave_in_a_write_cycle AND wait_for_DACSamples_avalon_slave_counter;
  --DACSamples_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  DACSamples_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_DACSamples_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= DACSamples_avalon_slave_in_a_write_cycle;
  internal_DACSamples_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("000000000000000000000000000000") & (DACSamples_avalon_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      DACSamples_avalon_slave_wait_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      DACSamples_avalon_slave_wait_counter <= DACSamples_avalon_slave_counter_load_value;
    end if;

  end process;

  DACSamples_avalon_slave_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((DACSamples_avalon_slave_in_a_write_cycle AND DACSamples_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000011"), A_WE_StdLogicVector((std_logic'((NOT internal_DACSamples_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("0000000000000000000000000000000") & (DACSamples_avalon_slave_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  wait_for_DACSamples_avalon_slave_counter <= DACSamples_avalon_slave_begins_xfer OR NOT internal_DACSamples_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  DACSamples_avalon_slave_wait_counter_eq_0 <= internal_DACSamples_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_DACSamples_avalon_slave <= internal_cpu_data_master_granted_DACSamples_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_DACSamples_avalon_slave <= internal_cpu_data_master_qualified_request_DACSamples_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_DACSamples_avalon_slave <= internal_cpu_data_master_requests_DACSamples_avalon_slave;
--synthesis translate_off
    --DACSamples/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Decoder_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_Decoder : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_Decoder : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Decoder_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_Decoder : OUT STD_LOGIC;
                 signal cpu_data_master_granted_Decoder_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_Decoder_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Decoder_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_Decoder_avalon_slave : OUT STD_LOGIC;
                 signal d1_Decoder_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity Decoder_avalon_slave_arbitrator;


architecture europa of Decoder_avalon_slave_arbitrator is
                signal Decoder_avalon_slave_allgrants :  STD_LOGIC;
                signal Decoder_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Decoder_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Decoder_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal Decoder_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal Decoder_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal Decoder_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal Decoder_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal Decoder_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Decoder_avalon_slave_begins_xfer :  STD_LOGIC;
                signal Decoder_avalon_slave_counter_load_value :  STD_LOGIC;
                signal Decoder_avalon_slave_end_xfer :  STD_LOGIC;
                signal Decoder_avalon_slave_firsttransfer :  STD_LOGIC;
                signal Decoder_avalon_slave_grant_vector :  STD_LOGIC;
                signal Decoder_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal Decoder_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal Decoder_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal Decoder_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Decoder_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal Decoder_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Decoder_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Decoder_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Decoder_avalon_slave_wait_counter :  STD_LOGIC;
                signal Decoder_avalon_slave_waits_for_read :  STD_LOGIC;
                signal Decoder_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_Decoder_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Decoder_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_Decoder_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_Decoder_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_Decoder_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_Decoder_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_Decoder_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_Decoder_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Decoder_avalon_slave_end_xfer;
    end if;

  end process;

  Decoder_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_Decoder_avalon_slave);
  internal_cpu_data_master_requests_Decoder_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100101100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --Decoder_avalon_slave_arb_share_counter set values, which is an e_mux
  Decoder_avalon_slave_arb_share_set_values <= std_logic'('1');
  --Decoder_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  Decoder_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_Decoder_avalon_slave;
  --Decoder_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Decoder_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Decoder_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  Decoder_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(Decoder_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Decoder_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(Decoder_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Decoder_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --Decoder_avalon_slave_allgrants all slave grants, which is an e_mux
  Decoder_avalon_slave_allgrants <= Decoder_avalon_slave_grant_vector;
  --Decoder_avalon_slave_end_xfer assignment, which is an e_assign
  Decoder_avalon_slave_end_xfer <= NOT ((Decoder_avalon_slave_waits_for_read OR Decoder_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Decoder_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Decoder_avalon_slave <= Decoder_avalon_slave_end_xfer AND (((NOT Decoder_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Decoder_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Decoder_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Decoder_avalon_slave AND Decoder_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Decoder_avalon_slave AND NOT Decoder_avalon_slave_non_bursting_master_requests));
  --Decoder_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Decoder_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(Decoder_avalon_slave_arb_counter_enable) = '1' then 
        Decoder_avalon_slave_arb_share_counter <= Decoder_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Decoder_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Decoder_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Decoder_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Decoder_avalon_slave)) OR ((end_xfer_arb_share_counter_term_Decoder_avalon_slave AND NOT Decoder_avalon_slave_non_bursting_master_requests)))) = '1' then 
        Decoder_avalon_slave_slavearbiterlockenable <= Decoder_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master Decoder/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= Decoder_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --Decoder_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Decoder_avalon_slave_slavearbiterlockenable2 <= Decoder_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master Decoder/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= Decoder_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --Decoder_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Decoder_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_Decoder_avalon_slave <= internal_cpu_data_master_requests_Decoder_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_Decoder_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_Decoder_avalon_slave <= (internal_cpu_data_master_granted_Decoder_avalon_slave AND cpu_data_master_read) AND NOT Decoder_avalon_slave_waits_for_read;
  --Data_to_the_Decoder mux, which is an e_mux
  Data_to_the_Decoder <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_Decoder_avalon_slave <= internal_cpu_data_master_qualified_request_Decoder_avalon_slave;
  --cpu/data_master saved-grant Decoder/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_Decoder_avalon_slave <= internal_cpu_data_master_requests_Decoder_avalon_slave;
  --allow new arb cycle for Decoder/avalon_slave, which is an e_assign
  Decoder_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Decoder_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Decoder_avalon_slave_master_qreq_vector <= std_logic'('1');
  --Decoder_avalon_slave_firsttransfer first transaction, which is an e_assign
  Decoder_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Decoder_avalon_slave_begins_xfer) = '1'), Decoder_avalon_slave_unreg_firsttransfer, Decoder_avalon_slave_reg_firsttransfer);
  --Decoder_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  Decoder_avalon_slave_unreg_firsttransfer <= NOT ((Decoder_avalon_slave_slavearbiterlockenable AND Decoder_avalon_slave_any_continuerequest));
  --Decoder_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Decoder_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Decoder_avalon_slave_begins_xfer) = '1' then 
        Decoder_avalon_slave_reg_firsttransfer <= Decoder_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Decoder_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Decoder_avalon_slave_beginbursttransfer_internal <= Decoder_avalon_slave_begins_xfer;
  --~WR_to_the_Decoder assignment, which is an e_mux
  WR_to_the_Decoder <= NOT ((internal_cpu_data_master_granted_Decoder_avalon_slave AND cpu_data_master_write));
  shifted_address_to_Decoder_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_Decoder mux, which is an e_mux
  Address_to_the_Decoder <= A_EXT (A_SRL(shifted_address_to_Decoder_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Decoder_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Decoder_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Decoder_avalon_slave_end_xfer <= Decoder_avalon_slave_end_xfer;
    end if;

  end process;

  --Decoder_avalon_slave_waits_for_read in a cycle, which is an e_mux
  Decoder_avalon_slave_waits_for_read <= Decoder_avalon_slave_in_a_read_cycle AND Decoder_avalon_slave_begins_xfer;
  --Decoder_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  Decoder_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_Decoder_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Decoder_avalon_slave_in_a_read_cycle;
  --Decoder_avalon_slave_waits_for_write in a cycle, which is an e_mux
  Decoder_avalon_slave_waits_for_write <= Decoder_avalon_slave_in_a_write_cycle AND wait_for_Decoder_avalon_slave_counter;
  --Decoder_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  Decoder_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_Decoder_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Decoder_avalon_slave_in_a_write_cycle;
  internal_Decoder_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Decoder_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Decoder_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      Decoder_avalon_slave_wait_counter <= Decoder_avalon_slave_counter_load_value;
    end if;

  end process;

  Decoder_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((Decoder_avalon_slave_in_a_write_cycle AND Decoder_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_Decoder_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Decoder_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_Decoder_avalon_slave_counter <= Decoder_avalon_slave_begins_xfer OR NOT internal_Decoder_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  Decoder_avalon_slave_wait_counter_eq_0 <= internal_Decoder_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_Decoder_avalon_slave <= internal_cpu_data_master_granted_Decoder_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_Decoder_avalon_slave <= internal_cpu_data_master_qualified_request_Decoder_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_Decoder_avalon_slave <= internal_cpu_data_master_requests_Decoder_avalon_slave;
--synthesis translate_off
    --Decoder/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Deterctor_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_Deterctor : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_Deterctor : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Deterctor_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_Deterctor : OUT STD_LOGIC;
                 signal cpu_data_master_granted_Deterctor_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_Deterctor_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Deterctor_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_Deterctor_avalon_slave : OUT STD_LOGIC;
                 signal d1_Deterctor_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity Deterctor_avalon_slave_arbitrator;


architecture europa of Deterctor_avalon_slave_arbitrator is
                signal Deterctor_avalon_slave_allgrants :  STD_LOGIC;
                signal Deterctor_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Deterctor_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Deterctor_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal Deterctor_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal Deterctor_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal Deterctor_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal Deterctor_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal Deterctor_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Deterctor_avalon_slave_begins_xfer :  STD_LOGIC;
                signal Deterctor_avalon_slave_counter_load_value :  STD_LOGIC;
                signal Deterctor_avalon_slave_end_xfer :  STD_LOGIC;
                signal Deterctor_avalon_slave_firsttransfer :  STD_LOGIC;
                signal Deterctor_avalon_slave_grant_vector :  STD_LOGIC;
                signal Deterctor_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal Deterctor_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal Deterctor_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal Deterctor_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Deterctor_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal Deterctor_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Deterctor_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Deterctor_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Deterctor_avalon_slave_wait_counter :  STD_LOGIC;
                signal Deterctor_avalon_slave_waits_for_read :  STD_LOGIC;
                signal Deterctor_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_Deterctor_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Deterctor_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_Deterctor_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_Deterctor_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_Deterctor_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_Deterctor_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_Deterctor_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_Deterctor_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Deterctor_avalon_slave_end_xfer;
    end if;

  end process;

  Deterctor_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_Deterctor_avalon_slave);
  internal_cpu_data_master_requests_Deterctor_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100101010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --Deterctor_avalon_slave_arb_share_counter set values, which is an e_mux
  Deterctor_avalon_slave_arb_share_set_values <= std_logic'('1');
  --Deterctor_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  Deterctor_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_Deterctor_avalon_slave;
  --Deterctor_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Deterctor_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Deterctor_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  Deterctor_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(Deterctor_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Deterctor_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(Deterctor_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Deterctor_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --Deterctor_avalon_slave_allgrants all slave grants, which is an e_mux
  Deterctor_avalon_slave_allgrants <= Deterctor_avalon_slave_grant_vector;
  --Deterctor_avalon_slave_end_xfer assignment, which is an e_assign
  Deterctor_avalon_slave_end_xfer <= NOT ((Deterctor_avalon_slave_waits_for_read OR Deterctor_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Deterctor_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Deterctor_avalon_slave <= Deterctor_avalon_slave_end_xfer AND (((NOT Deterctor_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Deterctor_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Deterctor_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Deterctor_avalon_slave AND Deterctor_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Deterctor_avalon_slave AND NOT Deterctor_avalon_slave_non_bursting_master_requests));
  --Deterctor_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Deterctor_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(Deterctor_avalon_slave_arb_counter_enable) = '1' then 
        Deterctor_avalon_slave_arb_share_counter <= Deterctor_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Deterctor_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Deterctor_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Deterctor_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Deterctor_avalon_slave)) OR ((end_xfer_arb_share_counter_term_Deterctor_avalon_slave AND NOT Deterctor_avalon_slave_non_bursting_master_requests)))) = '1' then 
        Deterctor_avalon_slave_slavearbiterlockenable <= Deterctor_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master Deterctor/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= Deterctor_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --Deterctor_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Deterctor_avalon_slave_slavearbiterlockenable2 <= Deterctor_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master Deterctor/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= Deterctor_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --Deterctor_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Deterctor_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_Deterctor_avalon_slave <= internal_cpu_data_master_requests_Deterctor_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_Deterctor_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_Deterctor_avalon_slave <= (internal_cpu_data_master_granted_Deterctor_avalon_slave AND cpu_data_master_read) AND NOT Deterctor_avalon_slave_waits_for_read;
  --Data_to_the_Deterctor mux, which is an e_mux
  Data_to_the_Deterctor <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_Deterctor_avalon_slave <= internal_cpu_data_master_qualified_request_Deterctor_avalon_slave;
  --cpu/data_master saved-grant Deterctor/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_Deterctor_avalon_slave <= internal_cpu_data_master_requests_Deterctor_avalon_slave;
  --allow new arb cycle for Deterctor/avalon_slave, which is an e_assign
  Deterctor_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Deterctor_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Deterctor_avalon_slave_master_qreq_vector <= std_logic'('1');
  --Deterctor_avalon_slave_firsttransfer first transaction, which is an e_assign
  Deterctor_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Deterctor_avalon_slave_begins_xfer) = '1'), Deterctor_avalon_slave_unreg_firsttransfer, Deterctor_avalon_slave_reg_firsttransfer);
  --Deterctor_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  Deterctor_avalon_slave_unreg_firsttransfer <= NOT ((Deterctor_avalon_slave_slavearbiterlockenable AND Deterctor_avalon_slave_any_continuerequest));
  --Deterctor_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Deterctor_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Deterctor_avalon_slave_begins_xfer) = '1' then 
        Deterctor_avalon_slave_reg_firsttransfer <= Deterctor_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Deterctor_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Deterctor_avalon_slave_beginbursttransfer_internal <= Deterctor_avalon_slave_begins_xfer;
  --~WR_to_the_Deterctor assignment, which is an e_mux
  WR_to_the_Deterctor <= NOT ((internal_cpu_data_master_granted_Deterctor_avalon_slave AND cpu_data_master_write));
  shifted_address_to_Deterctor_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_Deterctor mux, which is an e_mux
  Address_to_the_Deterctor <= A_EXT (A_SRL(shifted_address_to_Deterctor_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Deterctor_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Deterctor_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Deterctor_avalon_slave_end_xfer <= Deterctor_avalon_slave_end_xfer;
    end if;

  end process;

  --Deterctor_avalon_slave_waits_for_read in a cycle, which is an e_mux
  Deterctor_avalon_slave_waits_for_read <= Deterctor_avalon_slave_in_a_read_cycle AND Deterctor_avalon_slave_begins_xfer;
  --Deterctor_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  Deterctor_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_Deterctor_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Deterctor_avalon_slave_in_a_read_cycle;
  --Deterctor_avalon_slave_waits_for_write in a cycle, which is an e_mux
  Deterctor_avalon_slave_waits_for_write <= Deterctor_avalon_slave_in_a_write_cycle AND wait_for_Deterctor_avalon_slave_counter;
  --Deterctor_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  Deterctor_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_Deterctor_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Deterctor_avalon_slave_in_a_write_cycle;
  internal_Deterctor_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Deterctor_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Deterctor_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      Deterctor_avalon_slave_wait_counter <= Deterctor_avalon_slave_counter_load_value;
    end if;

  end process;

  Deterctor_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((Deterctor_avalon_slave_in_a_write_cycle AND Deterctor_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_Deterctor_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Deterctor_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_Deterctor_avalon_slave_counter <= Deterctor_avalon_slave_begins_xfer OR NOT internal_Deterctor_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  Deterctor_avalon_slave_wait_counter_eq_0 <= internal_Deterctor_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_Deterctor_avalon_slave <= internal_cpu_data_master_granted_Deterctor_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_Deterctor_avalon_slave <= internal_cpu_data_master_qualified_request_Deterctor_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_Deterctor_avalon_slave <= internal_cpu_data_master_requests_Deterctor_avalon_slave;
--synthesis translate_off
    --Deterctor/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HIPController_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_to_the_HIPController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HIPController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_HIPController : OUT STD_LOGIC;
                 signal cpu_data_master_granted_HIPController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_HIPController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_HIPController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_HIPController_avalon_slave : OUT STD_LOGIC;
                 signal d1_HIPController_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity HIPController_avalon_slave_arbitrator;


architecture europa of HIPController_avalon_slave_arbitrator is
                signal HIPController_avalon_slave_allgrants :  STD_LOGIC;
                signal HIPController_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal HIPController_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal HIPController_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal HIPController_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal HIPController_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal HIPController_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal HIPController_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal HIPController_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal HIPController_avalon_slave_begins_xfer :  STD_LOGIC;
                signal HIPController_avalon_slave_counter_load_value :  STD_LOGIC;
                signal HIPController_avalon_slave_end_xfer :  STD_LOGIC;
                signal HIPController_avalon_slave_firsttransfer :  STD_LOGIC;
                signal HIPController_avalon_slave_grant_vector :  STD_LOGIC;
                signal HIPController_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal HIPController_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal HIPController_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal HIPController_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal HIPController_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal HIPController_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal HIPController_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal HIPController_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal HIPController_avalon_slave_wait_counter :  STD_LOGIC;
                signal HIPController_avalon_slave_waits_for_read :  STD_LOGIC;
                signal HIPController_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_HIPController_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_HIPController_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_HIPController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_HIPController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_HIPController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_HIPController_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_HIPController_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_HIPController_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT HIPController_avalon_slave_end_xfer;
    end if;

  end process;

  HIPController_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_HIPController_avalon_slave);
  internal_cpu_data_master_requests_HIPController_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110101000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --HIPController_avalon_slave_arb_share_counter set values, which is an e_mux
  HIPController_avalon_slave_arb_share_set_values <= std_logic'('1');
  --HIPController_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  HIPController_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_HIPController_avalon_slave;
  --HIPController_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  HIPController_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --HIPController_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  HIPController_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(HIPController_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HIPController_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(HIPController_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HIPController_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --HIPController_avalon_slave_allgrants all slave grants, which is an e_mux
  HIPController_avalon_slave_allgrants <= HIPController_avalon_slave_grant_vector;
  --HIPController_avalon_slave_end_xfer assignment, which is an e_assign
  HIPController_avalon_slave_end_xfer <= NOT ((HIPController_avalon_slave_waits_for_read OR HIPController_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_HIPController_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_HIPController_avalon_slave <= HIPController_avalon_slave_end_xfer AND (((NOT HIPController_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --HIPController_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  HIPController_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_HIPController_avalon_slave AND HIPController_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_HIPController_avalon_slave AND NOT HIPController_avalon_slave_non_bursting_master_requests));
  --HIPController_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HIPController_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(HIPController_avalon_slave_arb_counter_enable) = '1' then 
        HIPController_avalon_slave_arb_share_counter <= HIPController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --HIPController_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HIPController_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((HIPController_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_HIPController_avalon_slave)) OR ((end_xfer_arb_share_counter_term_HIPController_avalon_slave AND NOT HIPController_avalon_slave_non_bursting_master_requests)))) = '1' then 
        HIPController_avalon_slave_slavearbiterlockenable <= HIPController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master HIPController/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= HIPController_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --HIPController_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  HIPController_avalon_slave_slavearbiterlockenable2 <= HIPController_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master HIPController/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= HIPController_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --HIPController_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  HIPController_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_HIPController_avalon_slave <= internal_cpu_data_master_requests_HIPController_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_HIPController_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_HIPController_avalon_slave <= (internal_cpu_data_master_granted_HIPController_avalon_slave AND cpu_data_master_read) AND NOT HIPController_avalon_slave_waits_for_read;
  --Data_to_the_HIPController mux, which is an e_mux
  Data_to_the_HIPController <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_HIPController_avalon_slave <= internal_cpu_data_master_qualified_request_HIPController_avalon_slave;
  --cpu/data_master saved-grant HIPController/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_HIPController_avalon_slave <= internal_cpu_data_master_requests_HIPController_avalon_slave;
  --allow new arb cycle for HIPController/avalon_slave, which is an e_assign
  HIPController_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  HIPController_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  HIPController_avalon_slave_master_qreq_vector <= std_logic'('1');
  --HIPController_avalon_slave_firsttransfer first transaction, which is an e_assign
  HIPController_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(HIPController_avalon_slave_begins_xfer) = '1'), HIPController_avalon_slave_unreg_firsttransfer, HIPController_avalon_slave_reg_firsttransfer);
  --HIPController_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  HIPController_avalon_slave_unreg_firsttransfer <= NOT ((HIPController_avalon_slave_slavearbiterlockenable AND HIPController_avalon_slave_any_continuerequest));
  --HIPController_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HIPController_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(HIPController_avalon_slave_begins_xfer) = '1' then 
        HIPController_avalon_slave_reg_firsttransfer <= HIPController_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --HIPController_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  HIPController_avalon_slave_beginbursttransfer_internal <= HIPController_avalon_slave_begins_xfer;
  --~WR_to_the_HIPController assignment, which is an e_mux
  WR_to_the_HIPController <= NOT ((internal_cpu_data_master_granted_HIPController_avalon_slave AND cpu_data_master_write));
  shifted_address_to_HIPController_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_HIPController_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_HIPController_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_HIPController_avalon_slave_end_xfer <= HIPController_avalon_slave_end_xfer;
    end if;

  end process;

  --HIPController_avalon_slave_waits_for_read in a cycle, which is an e_mux
  HIPController_avalon_slave_waits_for_read <= HIPController_avalon_slave_in_a_read_cycle AND HIPController_avalon_slave_begins_xfer;
  --HIPController_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  HIPController_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_HIPController_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= HIPController_avalon_slave_in_a_read_cycle;
  --HIPController_avalon_slave_waits_for_write in a cycle, which is an e_mux
  HIPController_avalon_slave_waits_for_write <= HIPController_avalon_slave_in_a_write_cycle AND wait_for_HIPController_avalon_slave_counter;
  --HIPController_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  HIPController_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_HIPController_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= HIPController_avalon_slave_in_a_write_cycle;
  internal_HIPController_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HIPController_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HIPController_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      HIPController_avalon_slave_wait_counter <= HIPController_avalon_slave_counter_load_value;
    end if;

  end process;

  HIPController_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((HIPController_avalon_slave_in_a_write_cycle AND HIPController_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_HIPController_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HIPController_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_HIPController_avalon_slave_counter <= HIPController_avalon_slave_begins_xfer OR NOT internal_HIPController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  HIPController_avalon_slave_wait_counter_eq_0 <= internal_HIPController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_HIPController_avalon_slave <= internal_cpu_data_master_granted_HIPController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_HIPController_avalon_slave <= internal_cpu_data_master_qualified_request_HIPController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_HIPController_avalon_slave <= internal_cpu_data_master_requests_HIPController_avalon_slave;
--synthesis translate_off
    --HIPController/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IDController_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_IDController : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal IDController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WData_to_the_IDController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_IDController : OUT STD_LOGIC;
                 signal cpu_data_master_granted_IDController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_IDController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_IDController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_IDController_avalon_slave : OUT STD_LOGIC;
                 signal d1_IDController_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity IDController_avalon_slave_arbitrator;


architecture europa of IDController_avalon_slave_arbitrator is
                signal IDController_avalon_slave_allgrants :  STD_LOGIC;
                signal IDController_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal IDController_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal IDController_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal IDController_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal IDController_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal IDController_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal IDController_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal IDController_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal IDController_avalon_slave_begins_xfer :  STD_LOGIC;
                signal IDController_avalon_slave_counter_load_value :  STD_LOGIC;
                signal IDController_avalon_slave_end_xfer :  STD_LOGIC;
                signal IDController_avalon_slave_firsttransfer :  STD_LOGIC;
                signal IDController_avalon_slave_grant_vector :  STD_LOGIC;
                signal IDController_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal IDController_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal IDController_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal IDController_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal IDController_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal IDController_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal IDController_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal IDController_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal IDController_avalon_slave_wait_counter :  STD_LOGIC;
                signal IDController_avalon_slave_waits_for_read :  STD_LOGIC;
                signal IDController_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_IDController_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_IDController_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_IDController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_IDController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_IDController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_IDController_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_IDController_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_IDController_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT IDController_avalon_slave_end_xfer;
    end if;

  end process;

  IDController_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_IDController_avalon_slave);
  internal_cpu_data_master_requests_IDController_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100100100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --IDController_avalon_slave_arb_share_counter set values, which is an e_mux
  IDController_avalon_slave_arb_share_set_values <= std_logic'('1');
  --IDController_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  IDController_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_IDController_avalon_slave;
  --IDController_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  IDController_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --IDController_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  IDController_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(IDController_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(IDController_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(IDController_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(IDController_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --IDController_avalon_slave_allgrants all slave grants, which is an e_mux
  IDController_avalon_slave_allgrants <= IDController_avalon_slave_grant_vector;
  --IDController_avalon_slave_end_xfer assignment, which is an e_assign
  IDController_avalon_slave_end_xfer <= NOT ((IDController_avalon_slave_waits_for_read OR IDController_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_IDController_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_IDController_avalon_slave <= IDController_avalon_slave_end_xfer AND (((NOT IDController_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --IDController_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  IDController_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_IDController_avalon_slave AND IDController_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_IDController_avalon_slave AND NOT IDController_avalon_slave_non_bursting_master_requests));
  --IDController_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      IDController_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(IDController_avalon_slave_arb_counter_enable) = '1' then 
        IDController_avalon_slave_arb_share_counter <= IDController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --IDController_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      IDController_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((IDController_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_IDController_avalon_slave)) OR ((end_xfer_arb_share_counter_term_IDController_avalon_slave AND NOT IDController_avalon_slave_non_bursting_master_requests)))) = '1' then 
        IDController_avalon_slave_slavearbiterlockenable <= IDController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master IDController/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= IDController_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --IDController_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  IDController_avalon_slave_slavearbiterlockenable2 <= IDController_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master IDController/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= IDController_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --IDController_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  IDController_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_IDController_avalon_slave <= internal_cpu_data_master_requests_IDController_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_IDController_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_IDController_avalon_slave <= (internal_cpu_data_master_granted_IDController_avalon_slave AND cpu_data_master_read) AND NOT IDController_avalon_slave_waits_for_read;
  --WData_to_the_IDController mux, which is an e_mux
  WData_to_the_IDController <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_IDController_avalon_slave <= internal_cpu_data_master_qualified_request_IDController_avalon_slave;
  --cpu/data_master saved-grant IDController/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_IDController_avalon_slave <= internal_cpu_data_master_requests_IDController_avalon_slave;
  --allow new arb cycle for IDController/avalon_slave, which is an e_assign
  IDController_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  IDController_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  IDController_avalon_slave_master_qreq_vector <= std_logic'('1');
  --IDController_avalon_slave_firsttransfer first transaction, which is an e_assign
  IDController_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(IDController_avalon_slave_begins_xfer) = '1'), IDController_avalon_slave_unreg_firsttransfer, IDController_avalon_slave_reg_firsttransfer);
  --IDController_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  IDController_avalon_slave_unreg_firsttransfer <= NOT ((IDController_avalon_slave_slavearbiterlockenable AND IDController_avalon_slave_any_continuerequest));
  --IDController_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      IDController_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(IDController_avalon_slave_begins_xfer) = '1' then 
        IDController_avalon_slave_reg_firsttransfer <= IDController_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --IDController_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  IDController_avalon_slave_beginbursttransfer_internal <= IDController_avalon_slave_begins_xfer;
  --~WR_to_the_IDController assignment, which is an e_mux
  WR_to_the_IDController <= NOT ((internal_cpu_data_master_granted_IDController_avalon_slave AND cpu_data_master_write));
  shifted_address_to_IDController_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_IDController mux, which is an e_mux
  Address_to_the_IDController <= A_EXT (A_SRL(shifted_address_to_IDController_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_IDController_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_IDController_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_IDController_avalon_slave_end_xfer <= IDController_avalon_slave_end_xfer;
    end if;

  end process;

  --IDController_avalon_slave_waits_for_read in a cycle, which is an e_mux
  IDController_avalon_slave_waits_for_read <= IDController_avalon_slave_in_a_read_cycle AND IDController_avalon_slave_begins_xfer;
  --IDController_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  IDController_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_IDController_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= IDController_avalon_slave_in_a_read_cycle;
  --IDController_avalon_slave_waits_for_write in a cycle, which is an e_mux
  IDController_avalon_slave_waits_for_write <= IDController_avalon_slave_in_a_write_cycle AND wait_for_IDController_avalon_slave_counter;
  --IDController_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  IDController_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_IDController_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= IDController_avalon_slave_in_a_write_cycle;
  internal_IDController_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(IDController_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      IDController_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      IDController_avalon_slave_wait_counter <= IDController_avalon_slave_counter_load_value;
    end if;

  end process;

  IDController_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((IDController_avalon_slave_in_a_write_cycle AND IDController_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_IDController_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(IDController_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_IDController_avalon_slave_counter <= IDController_avalon_slave_begins_xfer OR NOT internal_IDController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  IDController_avalon_slave_wait_counter_eq_0 <= internal_IDController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_IDController_avalon_slave <= internal_cpu_data_master_granted_IDController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_IDController_avalon_slave <= internal_cpu_data_master_qualified_request_IDController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_IDController_avalon_slave <= internal_cpu_data_master_requests_IDController_avalon_slave;
--synthesis translate_off
    --IDController/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Indicator_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_to_the_Indicator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Indicator_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_Indicator : OUT STD_LOGIC;
                 signal cpu_data_master_granted_Indicator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_Indicator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Indicator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_Indicator_avalon_slave : OUT STD_LOGIC;
                 signal d1_Indicator_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity Indicator_avalon_slave_arbitrator;


architecture europa of Indicator_avalon_slave_arbitrator is
                signal Indicator_avalon_slave_allgrants :  STD_LOGIC;
                signal Indicator_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Indicator_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Indicator_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal Indicator_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal Indicator_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal Indicator_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal Indicator_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal Indicator_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Indicator_avalon_slave_begins_xfer :  STD_LOGIC;
                signal Indicator_avalon_slave_counter_load_value :  STD_LOGIC;
                signal Indicator_avalon_slave_end_xfer :  STD_LOGIC;
                signal Indicator_avalon_slave_firsttransfer :  STD_LOGIC;
                signal Indicator_avalon_slave_grant_vector :  STD_LOGIC;
                signal Indicator_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal Indicator_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal Indicator_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal Indicator_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Indicator_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal Indicator_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Indicator_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Indicator_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Indicator_avalon_slave_wait_counter :  STD_LOGIC;
                signal Indicator_avalon_slave_waits_for_read :  STD_LOGIC;
                signal Indicator_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_Indicator_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Indicator_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_Indicator_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_Indicator_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_Indicator_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_Indicator_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_Indicator_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_Indicator_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Indicator_avalon_slave_end_xfer;
    end if;

  end process;

  Indicator_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_Indicator_avalon_slave);
  internal_cpu_data_master_requests_Indicator_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110111100")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --Indicator_avalon_slave_arb_share_counter set values, which is an e_mux
  Indicator_avalon_slave_arb_share_set_values <= std_logic'('1');
  --Indicator_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  Indicator_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_Indicator_avalon_slave;
  --Indicator_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Indicator_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Indicator_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  Indicator_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(Indicator_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Indicator_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(Indicator_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Indicator_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --Indicator_avalon_slave_allgrants all slave grants, which is an e_mux
  Indicator_avalon_slave_allgrants <= Indicator_avalon_slave_grant_vector;
  --Indicator_avalon_slave_end_xfer assignment, which is an e_assign
  Indicator_avalon_slave_end_xfer <= NOT ((Indicator_avalon_slave_waits_for_read OR Indicator_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Indicator_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Indicator_avalon_slave <= Indicator_avalon_slave_end_xfer AND (((NOT Indicator_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Indicator_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Indicator_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Indicator_avalon_slave AND Indicator_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Indicator_avalon_slave AND NOT Indicator_avalon_slave_non_bursting_master_requests));
  --Indicator_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Indicator_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(Indicator_avalon_slave_arb_counter_enable) = '1' then 
        Indicator_avalon_slave_arb_share_counter <= Indicator_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Indicator_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Indicator_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Indicator_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Indicator_avalon_slave)) OR ((end_xfer_arb_share_counter_term_Indicator_avalon_slave AND NOT Indicator_avalon_slave_non_bursting_master_requests)))) = '1' then 
        Indicator_avalon_slave_slavearbiterlockenable <= Indicator_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master Indicator/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= Indicator_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --Indicator_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Indicator_avalon_slave_slavearbiterlockenable2 <= Indicator_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master Indicator/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= Indicator_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --Indicator_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Indicator_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_Indicator_avalon_slave <= internal_cpu_data_master_requests_Indicator_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_Indicator_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_Indicator_avalon_slave <= (internal_cpu_data_master_granted_Indicator_avalon_slave AND cpu_data_master_read) AND NOT Indicator_avalon_slave_waits_for_read;
  --Data_to_the_Indicator mux, which is an e_mux
  Data_to_the_Indicator <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_Indicator_avalon_slave <= internal_cpu_data_master_qualified_request_Indicator_avalon_slave;
  --cpu/data_master saved-grant Indicator/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_Indicator_avalon_slave <= internal_cpu_data_master_requests_Indicator_avalon_slave;
  --allow new arb cycle for Indicator/avalon_slave, which is an e_assign
  Indicator_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Indicator_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Indicator_avalon_slave_master_qreq_vector <= std_logic'('1');
  --Indicator_avalon_slave_firsttransfer first transaction, which is an e_assign
  Indicator_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Indicator_avalon_slave_begins_xfer) = '1'), Indicator_avalon_slave_unreg_firsttransfer, Indicator_avalon_slave_reg_firsttransfer);
  --Indicator_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  Indicator_avalon_slave_unreg_firsttransfer <= NOT ((Indicator_avalon_slave_slavearbiterlockenable AND Indicator_avalon_slave_any_continuerequest));
  --Indicator_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Indicator_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Indicator_avalon_slave_begins_xfer) = '1' then 
        Indicator_avalon_slave_reg_firsttransfer <= Indicator_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Indicator_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Indicator_avalon_slave_beginbursttransfer_internal <= Indicator_avalon_slave_begins_xfer;
  --~WR_to_the_Indicator assignment, which is an e_mux
  WR_to_the_Indicator <= NOT ((internal_cpu_data_master_granted_Indicator_avalon_slave AND cpu_data_master_write));
  shifted_address_to_Indicator_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_Indicator_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Indicator_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Indicator_avalon_slave_end_xfer <= Indicator_avalon_slave_end_xfer;
    end if;

  end process;

  --Indicator_avalon_slave_waits_for_read in a cycle, which is an e_mux
  Indicator_avalon_slave_waits_for_read <= Indicator_avalon_slave_in_a_read_cycle AND Indicator_avalon_slave_begins_xfer;
  --Indicator_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  Indicator_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_Indicator_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Indicator_avalon_slave_in_a_read_cycle;
  --Indicator_avalon_slave_waits_for_write in a cycle, which is an e_mux
  Indicator_avalon_slave_waits_for_write <= Indicator_avalon_slave_in_a_write_cycle AND wait_for_Indicator_avalon_slave_counter;
  --Indicator_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  Indicator_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_Indicator_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Indicator_avalon_slave_in_a_write_cycle;
  internal_Indicator_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Indicator_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Indicator_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      Indicator_avalon_slave_wait_counter <= Indicator_avalon_slave_counter_load_value;
    end if;

  end process;

  Indicator_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((Indicator_avalon_slave_in_a_write_cycle AND Indicator_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_Indicator_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Indicator_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_Indicator_avalon_slave_counter <= Indicator_avalon_slave_begins_xfer OR NOT internal_Indicator_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  Indicator_avalon_slave_wait_counter_eq_0 <= internal_Indicator_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_Indicator_avalon_slave <= internal_cpu_data_master_granted_Indicator_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_Indicator_avalon_slave <= internal_cpu_data_master_qualified_request_Indicator_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_Indicator_avalon_slave <= internal_cpu_data_master_requests_Indicator_avalon_slave;
--synthesis translate_off
    --Indicator/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity JTAG_UART_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal JTAG_UART_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal JTAG_UART_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
              );
end entity JTAG_UART_avalon_jtag_slave_arbitrator;


architecture europa of JTAG_UART_avalon_jtag_slave_arbitrator is
                signal JTAG_UART_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_share_counter :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal shifted_address_to_JTAG_UART_avalon_jtag_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_JTAG_UART_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT JTAG_UART_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  JTAG_UART_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave);
  --assign JTAG_UART_avalon_jtag_slave_readdata_from_sa = JTAG_UART_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_readdata_from_sa <= JTAG_UART_avalon_jtag_slave_readdata;
  internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000101100110110000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign JTAG_UART_avalon_jtag_slave_dataavailable_from_sa = JTAG_UART_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_dataavailable_from_sa <= JTAG_UART_avalon_jtag_slave_dataavailable;
  --assign JTAG_UART_avalon_jtag_slave_readyfordata_from_sa = JTAG_UART_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_readyfordata_from_sa <= JTAG_UART_avalon_jtag_slave_readyfordata;
  --assign JTAG_UART_avalon_jtag_slave_waitrequest_from_sa = JTAG_UART_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa <= JTAG_UART_avalon_jtag_slave_waitrequest;
  --JTAG_UART_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  JTAG_UART_avalon_jtag_slave_arb_share_set_values <= std_logic'('1');
  --JTAG_UART_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave;
  --JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(JTAG_UART_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(JTAG_UART_avalon_jtag_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(JTAG_UART_avalon_jtag_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(JTAG_UART_avalon_jtag_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --JTAG_UART_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  JTAG_UART_avalon_jtag_slave_allgrants <= JTAG_UART_avalon_jtag_slave_grant_vector;
  --JTAG_UART_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_end_xfer <= NOT ((JTAG_UART_avalon_jtag_slave_waits_for_read OR JTAG_UART_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave <= JTAG_UART_avalon_jtag_slave_end_xfer AND (((NOT JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --JTAG_UART_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  JTAG_UART_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND JTAG_UART_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND NOT JTAG_UART_avalon_jtag_slave_non_bursting_master_requests));
  --JTAG_UART_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_UART_avalon_jtag_slave_arb_counter_enable) = '1' then 
        JTAG_UART_avalon_jtag_slave_arb_share_counter <= JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((JTAG_UART_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND NOT JTAG_UART_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        JTAG_UART_avalon_jtag_slave_slavearbiterlockenable <= JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master JTAG_UART/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= JTAG_UART_avalon_jtag_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 <= JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value;
  --cpu/data_master JTAG_UART/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --JTAG_UART_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  JTAG_UART_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave, which is an e_mux
  cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave <= (internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave AND cpu_data_master_read) AND NOT JTAG_UART_avalon_jtag_slave_waits_for_read;
  --JTAG_UART_avalon_jtag_slave_writedata mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave;
  --cpu/data_master saved-grant JTAG_UART/avalon_jtag_slave, which is an e_assign
  cpu_data_master_saved_grant_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave;
  --allow new arb cycle for JTAG_UART/avalon_jtag_slave, which is an e_assign
  JTAG_UART_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  JTAG_UART_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  JTAG_UART_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --JTAG_UART_avalon_jtag_slave_reset_n assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_reset_n <= reset_n;
  JTAG_UART_avalon_jtag_slave_chipselect <= internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave;
  --JTAG_UART_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  JTAG_UART_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(JTAG_UART_avalon_jtag_slave_begins_xfer) = '1'), JTAG_UART_avalon_jtag_slave_unreg_firsttransfer, JTAG_UART_avalon_jtag_slave_reg_firsttransfer);
  --JTAG_UART_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  JTAG_UART_avalon_jtag_slave_unreg_firsttransfer <= NOT ((JTAG_UART_avalon_jtag_slave_slavearbiterlockenable AND JTAG_UART_avalon_jtag_slave_any_continuerequest));
  --JTAG_UART_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_UART_avalon_jtag_slave_begins_xfer) = '1' then 
        JTAG_UART_avalon_jtag_slave_reg_firsttransfer <= JTAG_UART_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal <= JTAG_UART_avalon_jtag_slave_begins_xfer;
  --~JTAG_UART_avalon_jtag_slave_read_n assignment, which is an e_mux
  JTAG_UART_avalon_jtag_slave_read_n <= NOT ((internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave AND cpu_data_master_read));
  --~JTAG_UART_avalon_jtag_slave_write_n assignment, which is an e_mux
  JTAG_UART_avalon_jtag_slave_write_n <= NOT ((internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave AND cpu_data_master_write));
  shifted_address_to_JTAG_UART_avalon_jtag_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --JTAG_UART_avalon_jtag_slave_address mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_JTAG_UART_avalon_jtag_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_JTAG_UART_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_JTAG_UART_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_JTAG_UART_avalon_jtag_slave_end_xfer <= JTAG_UART_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  JTAG_UART_avalon_jtag_slave_waits_for_read <= JTAG_UART_avalon_jtag_slave_in_a_read_cycle AND internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_UART_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= JTAG_UART_avalon_jtag_slave_in_a_read_cycle;
  --JTAG_UART_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  JTAG_UART_avalon_jtag_slave_waits_for_write <= JTAG_UART_avalon_jtag_slave_in_a_write_cycle AND internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_UART_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= JTAG_UART_avalon_jtag_slave_in_a_write_cycle;
  wait_for_JTAG_UART_avalon_jtag_slave_counter <= std_logic'('0');
  --assign JTAG_UART_avalon_jtag_slave_irq_from_sa = JTAG_UART_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_irq_from_sa <= JTAG_UART_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  JTAG_UART_avalon_jtag_slave_waitrequest_from_sa <= internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_data_master_granted_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_granted_JTAG_UART_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_JTAG_UART_avalon_jtag_slave <= internal_cpu_data_master_requests_JTAG_UART_avalon_jtag_slave;
--synthesis translate_off
    --JTAG_UART/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity KSController_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_KSController : OUT STD_LOGIC;
                 signal Data_to_the_KSController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal KSController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_KSController : OUT STD_LOGIC;
                 signal cpu_data_master_granted_KSController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_KSController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_KSController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_KSController_avalon_slave : OUT STD_LOGIC;
                 signal d1_KSController_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity KSController_avalon_slave_arbitrator;


architecture europa of KSController_avalon_slave_arbitrator is
                signal KSController_avalon_slave_allgrants :  STD_LOGIC;
                signal KSController_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal KSController_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal KSController_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal KSController_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal KSController_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal KSController_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal KSController_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal KSController_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal KSController_avalon_slave_begins_xfer :  STD_LOGIC;
                signal KSController_avalon_slave_counter_load_value :  STD_LOGIC;
                signal KSController_avalon_slave_end_xfer :  STD_LOGIC;
                signal KSController_avalon_slave_firsttransfer :  STD_LOGIC;
                signal KSController_avalon_slave_grant_vector :  STD_LOGIC;
                signal KSController_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal KSController_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal KSController_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal KSController_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal KSController_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal KSController_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal KSController_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal KSController_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal KSController_avalon_slave_wait_counter :  STD_LOGIC;
                signal KSController_avalon_slave_waits_for_read :  STD_LOGIC;
                signal KSController_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_KSController_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_KSController_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_KSController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_KSController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_KSController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_KSController_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_KSController_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_KSController_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT KSController_avalon_slave_end_xfer;
    end if;

  end process;

  KSController_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_KSController_avalon_slave);
  internal_cpu_data_master_requests_KSController_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100000001100110100000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --KSController_avalon_slave_arb_share_counter set values, which is an e_mux
  KSController_avalon_slave_arb_share_set_values <= std_logic'('1');
  --KSController_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  KSController_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_KSController_avalon_slave;
  --KSController_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  KSController_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --KSController_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  KSController_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(KSController_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KSController_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(KSController_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KSController_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --KSController_avalon_slave_allgrants all slave grants, which is an e_mux
  KSController_avalon_slave_allgrants <= KSController_avalon_slave_grant_vector;
  --KSController_avalon_slave_end_xfer assignment, which is an e_assign
  KSController_avalon_slave_end_xfer <= NOT ((KSController_avalon_slave_waits_for_read OR KSController_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_KSController_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_KSController_avalon_slave <= KSController_avalon_slave_end_xfer AND (((NOT KSController_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --KSController_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  KSController_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_KSController_avalon_slave AND KSController_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_KSController_avalon_slave AND NOT KSController_avalon_slave_non_bursting_master_requests));
  --KSController_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KSController_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(KSController_avalon_slave_arb_counter_enable) = '1' then 
        KSController_avalon_slave_arb_share_counter <= KSController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --KSController_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KSController_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((KSController_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_KSController_avalon_slave)) OR ((end_xfer_arb_share_counter_term_KSController_avalon_slave AND NOT KSController_avalon_slave_non_bursting_master_requests)))) = '1' then 
        KSController_avalon_slave_slavearbiterlockenable <= KSController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master KSController/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= KSController_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --KSController_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  KSController_avalon_slave_slavearbiterlockenable2 <= KSController_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master KSController/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= KSController_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --KSController_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  KSController_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_KSController_avalon_slave <= internal_cpu_data_master_requests_KSController_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_KSController_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_KSController_avalon_slave <= (internal_cpu_data_master_granted_KSController_avalon_slave AND cpu_data_master_read) AND NOT KSController_avalon_slave_waits_for_read;
  --Data_to_the_KSController mux, which is an e_mux
  Data_to_the_KSController <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_KSController_avalon_slave <= internal_cpu_data_master_qualified_request_KSController_avalon_slave;
  --cpu/data_master saved-grant KSController/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_KSController_avalon_slave <= internal_cpu_data_master_requests_KSController_avalon_slave;
  --allow new arb cycle for KSController/avalon_slave, which is an e_assign
  KSController_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  KSController_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  KSController_avalon_slave_master_qreq_vector <= std_logic'('1');
  --KSController_avalon_slave_firsttransfer first transaction, which is an e_assign
  KSController_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(KSController_avalon_slave_begins_xfer) = '1'), KSController_avalon_slave_unreg_firsttransfer, KSController_avalon_slave_reg_firsttransfer);
  --KSController_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  KSController_avalon_slave_unreg_firsttransfer <= NOT ((KSController_avalon_slave_slavearbiterlockenable AND KSController_avalon_slave_any_continuerequest));
  --KSController_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KSController_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(KSController_avalon_slave_begins_xfer) = '1' then 
        KSController_avalon_slave_reg_firsttransfer <= KSController_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --KSController_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  KSController_avalon_slave_beginbursttransfer_internal <= KSController_avalon_slave_begins_xfer;
  --~WR_to_the_KSController assignment, which is an e_mux
  WR_to_the_KSController <= NOT ((internal_cpu_data_master_granted_KSController_avalon_slave AND cpu_data_master_write));
  shifted_address_to_KSController_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_KSController mux, which is an e_mux
  Address_to_the_KSController <= Vector_To_Std_Logic(A_SRL(shifted_address_to_KSController_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_KSController_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_KSController_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_KSController_avalon_slave_end_xfer <= KSController_avalon_slave_end_xfer;
    end if;

  end process;

  --KSController_avalon_slave_waits_for_read in a cycle, which is an e_mux
  KSController_avalon_slave_waits_for_read <= KSController_avalon_slave_in_a_read_cycle AND KSController_avalon_slave_begins_xfer;
  --KSController_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  KSController_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_KSController_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= KSController_avalon_slave_in_a_read_cycle;
  --KSController_avalon_slave_waits_for_write in a cycle, which is an e_mux
  KSController_avalon_slave_waits_for_write <= KSController_avalon_slave_in_a_write_cycle AND wait_for_KSController_avalon_slave_counter;
  --KSController_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  KSController_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_KSController_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= KSController_avalon_slave_in_a_write_cycle;
  internal_KSController_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KSController_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KSController_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      KSController_avalon_slave_wait_counter <= KSController_avalon_slave_counter_load_value;
    end if;

  end process;

  KSController_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((KSController_avalon_slave_in_a_write_cycle AND KSController_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_KSController_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KSController_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_KSController_avalon_slave_counter <= KSController_avalon_slave_begins_xfer OR NOT internal_KSController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  KSController_avalon_slave_wait_counter_eq_0 <= internal_KSController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_KSController_avalon_slave <= internal_cpu_data_master_granted_KSController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_KSController_avalon_slave <= internal_cpu_data_master_qualified_request_KSController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_KSController_avalon_slave <= internal_cpu_data_master_requests_KSController_avalon_slave;
--synthesis translate_off
    --KSController/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity KontrolGenerator_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_to_the_KontrolGenerator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal KontrolGenerator_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_KontrolGenerator : OUT STD_LOGIC;
                 signal cpu_data_master_granted_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                 signal d1_KontrolGenerator_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity KontrolGenerator_avalon_slave_arbitrator;


architecture europa of KontrolGenerator_avalon_slave_arbitrator is
                signal KontrolGenerator_avalon_slave_allgrants :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_begins_xfer :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_counter_load_value :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_end_xfer :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_firsttransfer :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_grant_vector :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_wait_counter :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_waits_for_read :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_KontrolGenerator_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_KontrolGenerator_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_KontrolGenerator_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT KontrolGenerator_avalon_slave_end_xfer;
    end if;

  end process;

  KontrolGenerator_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_KontrolGenerator_avalon_slave);
  internal_cpu_data_master_requests_KontrolGenerator_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110111000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --KontrolGenerator_avalon_slave_arb_share_counter set values, which is an e_mux
  KontrolGenerator_avalon_slave_arb_share_set_values <= std_logic'('1');
  --KontrolGenerator_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  KontrolGenerator_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_KontrolGenerator_avalon_slave;
  --KontrolGenerator_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  KontrolGenerator_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --KontrolGenerator_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  KontrolGenerator_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(KontrolGenerator_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KontrolGenerator_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(KontrolGenerator_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KontrolGenerator_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --KontrolGenerator_avalon_slave_allgrants all slave grants, which is an e_mux
  KontrolGenerator_avalon_slave_allgrants <= KontrolGenerator_avalon_slave_grant_vector;
  --KontrolGenerator_avalon_slave_end_xfer assignment, which is an e_assign
  KontrolGenerator_avalon_slave_end_xfer <= NOT ((KontrolGenerator_avalon_slave_waits_for_read OR KontrolGenerator_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave <= KontrolGenerator_avalon_slave_end_xfer AND (((NOT KontrolGenerator_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --KontrolGenerator_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  KontrolGenerator_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave AND KontrolGenerator_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave AND NOT KontrolGenerator_avalon_slave_non_bursting_master_requests));
  --KontrolGenerator_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KontrolGenerator_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(KontrolGenerator_avalon_slave_arb_counter_enable) = '1' then 
        KontrolGenerator_avalon_slave_arb_share_counter <= KontrolGenerator_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --KontrolGenerator_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KontrolGenerator_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((KontrolGenerator_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave)) OR ((end_xfer_arb_share_counter_term_KontrolGenerator_avalon_slave AND NOT KontrolGenerator_avalon_slave_non_bursting_master_requests)))) = '1' then 
        KontrolGenerator_avalon_slave_slavearbiterlockenable <= KontrolGenerator_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master KontrolGenerator/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= KontrolGenerator_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --KontrolGenerator_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  KontrolGenerator_avalon_slave_slavearbiterlockenable2 <= KontrolGenerator_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master KontrolGenerator/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= KontrolGenerator_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --KontrolGenerator_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  KontrolGenerator_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_KontrolGenerator_avalon_slave <= internal_cpu_data_master_requests_KontrolGenerator_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave <= (internal_cpu_data_master_granted_KontrolGenerator_avalon_slave AND cpu_data_master_read) AND NOT KontrolGenerator_avalon_slave_waits_for_read;
  --Data_to_the_KontrolGenerator mux, which is an e_mux
  Data_to_the_KontrolGenerator <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_KontrolGenerator_avalon_slave <= internal_cpu_data_master_qualified_request_KontrolGenerator_avalon_slave;
  --cpu/data_master saved-grant KontrolGenerator/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_KontrolGenerator_avalon_slave <= internal_cpu_data_master_requests_KontrolGenerator_avalon_slave;
  --allow new arb cycle for KontrolGenerator/avalon_slave, which is an e_assign
  KontrolGenerator_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  KontrolGenerator_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  KontrolGenerator_avalon_slave_master_qreq_vector <= std_logic'('1');
  --KontrolGenerator_avalon_slave_firsttransfer first transaction, which is an e_assign
  KontrolGenerator_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(KontrolGenerator_avalon_slave_begins_xfer) = '1'), KontrolGenerator_avalon_slave_unreg_firsttransfer, KontrolGenerator_avalon_slave_reg_firsttransfer);
  --KontrolGenerator_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  KontrolGenerator_avalon_slave_unreg_firsttransfer <= NOT ((KontrolGenerator_avalon_slave_slavearbiterlockenable AND KontrolGenerator_avalon_slave_any_continuerequest));
  --KontrolGenerator_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KontrolGenerator_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(KontrolGenerator_avalon_slave_begins_xfer) = '1' then 
        KontrolGenerator_avalon_slave_reg_firsttransfer <= KontrolGenerator_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --KontrolGenerator_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  KontrolGenerator_avalon_slave_beginbursttransfer_internal <= KontrolGenerator_avalon_slave_begins_xfer;
  --~WR_to_the_KontrolGenerator assignment, which is an e_mux
  WR_to_the_KontrolGenerator <= NOT ((internal_cpu_data_master_granted_KontrolGenerator_avalon_slave AND cpu_data_master_write));
  shifted_address_to_KontrolGenerator_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_KontrolGenerator_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_KontrolGenerator_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_KontrolGenerator_avalon_slave_end_xfer <= KontrolGenerator_avalon_slave_end_xfer;
    end if;

  end process;

  --KontrolGenerator_avalon_slave_waits_for_read in a cycle, which is an e_mux
  KontrolGenerator_avalon_slave_waits_for_read <= KontrolGenerator_avalon_slave_in_a_read_cycle AND KontrolGenerator_avalon_slave_begins_xfer;
  --KontrolGenerator_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  KontrolGenerator_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_KontrolGenerator_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= KontrolGenerator_avalon_slave_in_a_read_cycle;
  --KontrolGenerator_avalon_slave_waits_for_write in a cycle, which is an e_mux
  KontrolGenerator_avalon_slave_waits_for_write <= KontrolGenerator_avalon_slave_in_a_write_cycle AND wait_for_KontrolGenerator_avalon_slave_counter;
  --KontrolGenerator_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  KontrolGenerator_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_KontrolGenerator_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= KontrolGenerator_avalon_slave_in_a_write_cycle;
  internal_KontrolGenerator_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KontrolGenerator_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      KontrolGenerator_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      KontrolGenerator_avalon_slave_wait_counter <= KontrolGenerator_avalon_slave_counter_load_value;
    end if;

  end process;

  KontrolGenerator_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((KontrolGenerator_avalon_slave_in_a_write_cycle AND KontrolGenerator_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_KontrolGenerator_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(KontrolGenerator_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_KontrolGenerator_avalon_slave_counter <= KontrolGenerator_avalon_slave_begins_xfer OR NOT internal_KontrolGenerator_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  KontrolGenerator_avalon_slave_wait_counter_eq_0 <= internal_KontrolGenerator_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_KontrolGenerator_avalon_slave <= internal_cpu_data_master_granted_KontrolGenerator_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_KontrolGenerator_avalon_slave <= internal_cpu_data_master_qualified_request_KontrolGenerator_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_KontrolGenerator_avalon_slave <= internal_cpu_data_master_requests_KontrolGenerator_avalon_slave;
--synthesis translate_off
    --KontrolGenerator/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LogicReader_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal Data_from_the_LogicReader : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_from_the_LogicReader_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal LogicReader_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal RD_to_the_LogicReader : OUT STD_LOGIC;
                 signal cpu_data_master_granted_LogicReader_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_LogicReader_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_LogicReader_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_LogicReader_avalon_slave : OUT STD_LOGIC;
                 signal d1_LogicReader_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity LogicReader_avalon_slave_arbitrator;


architecture europa of LogicReader_avalon_slave_arbitrator is
                signal LogicReader_avalon_slave_allgrants :  STD_LOGIC;
                signal LogicReader_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal LogicReader_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal LogicReader_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal LogicReader_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal LogicReader_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal LogicReader_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal LogicReader_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal LogicReader_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal LogicReader_avalon_slave_begins_xfer :  STD_LOGIC;
                signal LogicReader_avalon_slave_counter_load_value :  STD_LOGIC;
                signal LogicReader_avalon_slave_end_xfer :  STD_LOGIC;
                signal LogicReader_avalon_slave_firsttransfer :  STD_LOGIC;
                signal LogicReader_avalon_slave_grant_vector :  STD_LOGIC;
                signal LogicReader_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal LogicReader_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal LogicReader_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal LogicReader_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal LogicReader_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal LogicReader_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal LogicReader_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal LogicReader_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal LogicReader_avalon_slave_wait_counter :  STD_LOGIC;
                signal LogicReader_avalon_slave_waits_for_read :  STD_LOGIC;
                signal LogicReader_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_LogicReader_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_LogicReader_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_LogicReader_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_LogicReader_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_LogicReader_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_LogicReader_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_LogicReader_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_LogicReader_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT LogicReader_avalon_slave_end_xfer;
    end if;

  end process;

  LogicReader_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_LogicReader_avalon_slave);
  --assign Data_from_the_LogicReader_from_sa = Data_from_the_LogicReader so that symbol knows where to group signals which may go to master only, which is an e_assign
  Data_from_the_LogicReader_from_sa <= Data_from_the_LogicReader;
  internal_cpu_data_master_requests_LogicReader_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100111000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --LogicReader_avalon_slave_arb_share_counter set values, which is an e_mux
  LogicReader_avalon_slave_arb_share_set_values <= std_logic'('1');
  --LogicReader_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  LogicReader_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_LogicReader_avalon_slave;
  --LogicReader_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  LogicReader_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --LogicReader_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  LogicReader_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(LogicReader_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LogicReader_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(LogicReader_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LogicReader_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --LogicReader_avalon_slave_allgrants all slave grants, which is an e_mux
  LogicReader_avalon_slave_allgrants <= LogicReader_avalon_slave_grant_vector;
  --LogicReader_avalon_slave_end_xfer assignment, which is an e_assign
  LogicReader_avalon_slave_end_xfer <= NOT ((LogicReader_avalon_slave_waits_for_read OR LogicReader_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_LogicReader_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_LogicReader_avalon_slave <= LogicReader_avalon_slave_end_xfer AND (((NOT LogicReader_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --LogicReader_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  LogicReader_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_LogicReader_avalon_slave AND LogicReader_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_LogicReader_avalon_slave AND NOT LogicReader_avalon_slave_non_bursting_master_requests));
  --LogicReader_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LogicReader_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(LogicReader_avalon_slave_arb_counter_enable) = '1' then 
        LogicReader_avalon_slave_arb_share_counter <= LogicReader_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --LogicReader_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LogicReader_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((LogicReader_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_LogicReader_avalon_slave)) OR ((end_xfer_arb_share_counter_term_LogicReader_avalon_slave AND NOT LogicReader_avalon_slave_non_bursting_master_requests)))) = '1' then 
        LogicReader_avalon_slave_slavearbiterlockenable <= LogicReader_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master LogicReader/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= LogicReader_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --LogicReader_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  LogicReader_avalon_slave_slavearbiterlockenable2 <= LogicReader_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master LogicReader/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= LogicReader_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --LogicReader_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  LogicReader_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_LogicReader_avalon_slave <= internal_cpu_data_master_requests_LogicReader_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_LogicReader_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_LogicReader_avalon_slave <= (internal_cpu_data_master_granted_LogicReader_avalon_slave AND cpu_data_master_read) AND NOT LogicReader_avalon_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_LogicReader_avalon_slave <= internal_cpu_data_master_qualified_request_LogicReader_avalon_slave;
  --cpu/data_master saved-grant LogicReader/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_LogicReader_avalon_slave <= internal_cpu_data_master_requests_LogicReader_avalon_slave;
  --allow new arb cycle for LogicReader/avalon_slave, which is an e_assign
  LogicReader_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  LogicReader_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  LogicReader_avalon_slave_master_qreq_vector <= std_logic'('1');
  --LogicReader_avalon_slave_firsttransfer first transaction, which is an e_assign
  LogicReader_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(LogicReader_avalon_slave_begins_xfer) = '1'), LogicReader_avalon_slave_unreg_firsttransfer, LogicReader_avalon_slave_reg_firsttransfer);
  --LogicReader_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  LogicReader_avalon_slave_unreg_firsttransfer <= NOT ((LogicReader_avalon_slave_slavearbiterlockenable AND LogicReader_avalon_slave_any_continuerequest));
  --LogicReader_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LogicReader_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(LogicReader_avalon_slave_begins_xfer) = '1' then 
        LogicReader_avalon_slave_reg_firsttransfer <= LogicReader_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --LogicReader_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  LogicReader_avalon_slave_beginbursttransfer_internal <= LogicReader_avalon_slave_begins_xfer;
  --~RD_to_the_LogicReader assignment, which is an e_mux
  RD_to_the_LogicReader <= NOT ((internal_cpu_data_master_granted_LogicReader_avalon_slave AND cpu_data_master_read));
  shifted_address_to_LogicReader_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_LogicReader_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_LogicReader_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_LogicReader_avalon_slave_end_xfer <= LogicReader_avalon_slave_end_xfer;
    end if;

  end process;

  --LogicReader_avalon_slave_waits_for_read in a cycle, which is an e_mux
  LogicReader_avalon_slave_waits_for_read <= LogicReader_avalon_slave_in_a_read_cycle AND wait_for_LogicReader_avalon_slave_counter;
  --LogicReader_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  LogicReader_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_LogicReader_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= LogicReader_avalon_slave_in_a_read_cycle;
  --LogicReader_avalon_slave_waits_for_write in a cycle, which is an e_mux
  LogicReader_avalon_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LogicReader_avalon_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --LogicReader_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  LogicReader_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_LogicReader_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= LogicReader_avalon_slave_in_a_write_cycle;
  internal_LogicReader_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LogicReader_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LogicReader_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      LogicReader_avalon_slave_wait_counter <= LogicReader_avalon_slave_counter_load_value;
    end if;

  end process;

  LogicReader_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((LogicReader_avalon_slave_in_a_read_cycle AND LogicReader_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_LogicReader_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LogicReader_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_LogicReader_avalon_slave_counter <= LogicReader_avalon_slave_begins_xfer OR NOT internal_LogicReader_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  LogicReader_avalon_slave_wait_counter_eq_0 <= internal_LogicReader_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_LogicReader_avalon_slave <= internal_cpu_data_master_granted_LogicReader_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_LogicReader_avalon_slave <= internal_cpu_data_master_qualified_request_LogicReader_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_LogicReader_avalon_slave <= internal_cpu_data_master_requests_LogicReader_avalon_slave;
--synthesis translate_off
    --LogicReader/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ODController_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_ODController : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                 signal Data_to_the_ODController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ODController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_ODController : OUT STD_LOGIC;
                 signal cpu_data_master_granted_ODController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_ODController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ODController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_ODController_avalon_slave : OUT STD_LOGIC;
                 signal d1_ODController_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity ODController_avalon_slave_arbitrator;


architecture europa of ODController_avalon_slave_arbitrator is
                signal ODController_avalon_slave_allgrants :  STD_LOGIC;
                signal ODController_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal ODController_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ODController_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal ODController_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal ODController_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal ODController_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal ODController_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal ODController_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal ODController_avalon_slave_begins_xfer :  STD_LOGIC;
                signal ODController_avalon_slave_counter_load_value :  STD_LOGIC;
                signal ODController_avalon_slave_end_xfer :  STD_LOGIC;
                signal ODController_avalon_slave_firsttransfer :  STD_LOGIC;
                signal ODController_avalon_slave_grant_vector :  STD_LOGIC;
                signal ODController_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal ODController_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal ODController_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal ODController_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal ODController_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal ODController_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal ODController_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal ODController_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal ODController_avalon_slave_wait_counter :  STD_LOGIC;
                signal ODController_avalon_slave_waits_for_read :  STD_LOGIC;
                signal ODController_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_ODController_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ODController_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_ODController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_ODController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_ODController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_ODController_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_ODController_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_ODController_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ODController_avalon_slave_end_xfer;
    end if;

  end process;

  ODController_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_ODController_avalon_slave);
  internal_cpu_data_master_requests_ODController_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 7) & std_logic_vector'("0000000")) = std_logic_vector'("100000001100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --ODController_avalon_slave_arb_share_counter set values, which is an e_mux
  ODController_avalon_slave_arb_share_set_values <= std_logic'('1');
  --ODController_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  ODController_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_ODController_avalon_slave;
  --ODController_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  ODController_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --ODController_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  ODController_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ODController_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ODController_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ODController_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ODController_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ODController_avalon_slave_allgrants all slave grants, which is an e_mux
  ODController_avalon_slave_allgrants <= ODController_avalon_slave_grant_vector;
  --ODController_avalon_slave_end_xfer assignment, which is an e_assign
  ODController_avalon_slave_end_xfer <= NOT ((ODController_avalon_slave_waits_for_read OR ODController_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_ODController_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ODController_avalon_slave <= ODController_avalon_slave_end_xfer AND (((NOT ODController_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ODController_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  ODController_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ODController_avalon_slave AND ODController_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_ODController_avalon_slave AND NOT ODController_avalon_slave_non_bursting_master_requests));
  --ODController_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ODController_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ODController_avalon_slave_arb_counter_enable) = '1' then 
        ODController_avalon_slave_arb_share_counter <= ODController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ODController_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ODController_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ODController_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_ODController_avalon_slave)) OR ((end_xfer_arb_share_counter_term_ODController_avalon_slave AND NOT ODController_avalon_slave_non_bursting_master_requests)))) = '1' then 
        ODController_avalon_slave_slavearbiterlockenable <= ODController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master ODController/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ODController_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ODController_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ODController_avalon_slave_slavearbiterlockenable2 <= ODController_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master ODController/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ODController_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --ODController_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  ODController_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_ODController_avalon_slave <= internal_cpu_data_master_requests_ODController_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_ODController_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_ODController_avalon_slave <= (internal_cpu_data_master_granted_ODController_avalon_slave AND cpu_data_master_read) AND NOT ODController_avalon_slave_waits_for_read;
  --Data_to_the_ODController mux, which is an e_mux
  Data_to_the_ODController <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_ODController_avalon_slave <= internal_cpu_data_master_qualified_request_ODController_avalon_slave;
  --cpu/data_master saved-grant ODController/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_ODController_avalon_slave <= internal_cpu_data_master_requests_ODController_avalon_slave;
  --allow new arb cycle for ODController/avalon_slave, which is an e_assign
  ODController_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ODController_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ODController_avalon_slave_master_qreq_vector <= std_logic'('1');
  --ODController_avalon_slave_firsttransfer first transaction, which is an e_assign
  ODController_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(ODController_avalon_slave_begins_xfer) = '1'), ODController_avalon_slave_unreg_firsttransfer, ODController_avalon_slave_reg_firsttransfer);
  --ODController_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  ODController_avalon_slave_unreg_firsttransfer <= NOT ((ODController_avalon_slave_slavearbiterlockenable AND ODController_avalon_slave_any_continuerequest));
  --ODController_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ODController_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ODController_avalon_slave_begins_xfer) = '1' then 
        ODController_avalon_slave_reg_firsttransfer <= ODController_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ODController_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ODController_avalon_slave_beginbursttransfer_internal <= ODController_avalon_slave_begins_xfer;
  --~WR_to_the_ODController assignment, which is an e_mux
  WR_to_the_ODController <= NOT ((internal_cpu_data_master_granted_ODController_avalon_slave AND cpu_data_master_write));
  shifted_address_to_ODController_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_ODController mux, which is an e_mux
  Address_to_the_ODController <= A_EXT (A_SRL(shifted_address_to_ODController_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 5);
  --d1_ODController_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ODController_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ODController_avalon_slave_end_xfer <= ODController_avalon_slave_end_xfer;
    end if;

  end process;

  --ODController_avalon_slave_waits_for_read in a cycle, which is an e_mux
  ODController_avalon_slave_waits_for_read <= ODController_avalon_slave_in_a_read_cycle AND ODController_avalon_slave_begins_xfer;
  --ODController_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  ODController_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_ODController_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ODController_avalon_slave_in_a_read_cycle;
  --ODController_avalon_slave_waits_for_write in a cycle, which is an e_mux
  ODController_avalon_slave_waits_for_write <= ODController_avalon_slave_in_a_write_cycle AND wait_for_ODController_avalon_slave_counter;
  --ODController_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  ODController_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_ODController_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ODController_avalon_slave_in_a_write_cycle;
  internal_ODController_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ODController_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ODController_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      ODController_avalon_slave_wait_counter <= ODController_avalon_slave_counter_load_value;
    end if;

  end process;

  ODController_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((ODController_avalon_slave_in_a_write_cycle AND ODController_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_ODController_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ODController_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_ODController_avalon_slave_counter <= ODController_avalon_slave_begins_xfer OR NOT internal_ODController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  ODController_avalon_slave_wait_counter_eq_0 <= internal_ODController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_ODController_avalon_slave <= internal_cpu_data_master_granted_ODController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_ODController_avalon_slave <= internal_cpu_data_master_qualified_request_ODController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_ODController_avalon_slave <= internal_cpu_data_master_requests_ODController_avalon_slave;
--synthesis translate_off
    --ODController/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PairsCounter_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal Data_from_the_PairsCounter : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_from_the_PairsCounter_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PairsCounter_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal RD_to_the_PairsCounter : OUT STD_LOGIC;
                 signal cpu_data_master_granted_PairsCounter_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PairsCounter_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PairsCounter_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PairsCounter_avalon_slave : OUT STD_LOGIC;
                 signal d1_PairsCounter_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity PairsCounter_avalon_slave_arbitrator;


architecture europa of PairsCounter_avalon_slave_arbitrator is
                signal PairsCounter_avalon_slave_allgrants :  STD_LOGIC;
                signal PairsCounter_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal PairsCounter_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PairsCounter_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal PairsCounter_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal PairsCounter_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal PairsCounter_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal PairsCounter_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal PairsCounter_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal PairsCounter_avalon_slave_begins_xfer :  STD_LOGIC;
                signal PairsCounter_avalon_slave_counter_load_value :  STD_LOGIC;
                signal PairsCounter_avalon_slave_end_xfer :  STD_LOGIC;
                signal PairsCounter_avalon_slave_firsttransfer :  STD_LOGIC;
                signal PairsCounter_avalon_slave_grant_vector :  STD_LOGIC;
                signal PairsCounter_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal PairsCounter_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal PairsCounter_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal PairsCounter_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal PairsCounter_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal PairsCounter_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal PairsCounter_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal PairsCounter_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal PairsCounter_avalon_slave_wait_counter :  STD_LOGIC;
                signal PairsCounter_avalon_slave_waits_for_read :  STD_LOGIC;
                signal PairsCounter_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PairsCounter_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PairsCounter_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_PairsCounter_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PairsCounter_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PairsCounter_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PairsCounter_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_PairsCounter_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_PairsCounter_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PairsCounter_avalon_slave_end_xfer;
    end if;

  end process;

  PairsCounter_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PairsCounter_avalon_slave);
  --assign Data_from_the_PairsCounter_from_sa = Data_from_the_PairsCounter so that symbol knows where to group signals which may go to master only, which is an e_assign
  Data_from_the_PairsCounter_from_sa <= Data_from_the_PairsCounter;
  internal_cpu_data_master_requests_PairsCounter_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110110100")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --PairsCounter_avalon_slave_arb_share_counter set values, which is an e_mux
  PairsCounter_avalon_slave_arb_share_set_values <= std_logic'('1');
  --PairsCounter_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  PairsCounter_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_PairsCounter_avalon_slave;
  --PairsCounter_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  PairsCounter_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --PairsCounter_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  PairsCounter_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(PairsCounter_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PairsCounter_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(PairsCounter_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PairsCounter_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --PairsCounter_avalon_slave_allgrants all slave grants, which is an e_mux
  PairsCounter_avalon_slave_allgrants <= PairsCounter_avalon_slave_grant_vector;
  --PairsCounter_avalon_slave_end_xfer assignment, which is an e_assign
  PairsCounter_avalon_slave_end_xfer <= NOT ((PairsCounter_avalon_slave_waits_for_read OR PairsCounter_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_PairsCounter_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PairsCounter_avalon_slave <= PairsCounter_avalon_slave_end_xfer AND (((NOT PairsCounter_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PairsCounter_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  PairsCounter_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PairsCounter_avalon_slave AND PairsCounter_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_PairsCounter_avalon_slave AND NOT PairsCounter_avalon_slave_non_bursting_master_requests));
  --PairsCounter_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PairsCounter_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(PairsCounter_avalon_slave_arb_counter_enable) = '1' then 
        PairsCounter_avalon_slave_arb_share_counter <= PairsCounter_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PairsCounter_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PairsCounter_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PairsCounter_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_PairsCounter_avalon_slave)) OR ((end_xfer_arb_share_counter_term_PairsCounter_avalon_slave AND NOT PairsCounter_avalon_slave_non_bursting_master_requests)))) = '1' then 
        PairsCounter_avalon_slave_slavearbiterlockenable <= PairsCounter_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master PairsCounter/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PairsCounter_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PairsCounter_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PairsCounter_avalon_slave_slavearbiterlockenable2 <= PairsCounter_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master PairsCounter/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PairsCounter_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PairsCounter_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  PairsCounter_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PairsCounter_avalon_slave <= internal_cpu_data_master_requests_PairsCounter_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_PairsCounter_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_PairsCounter_avalon_slave <= (internal_cpu_data_master_granted_PairsCounter_avalon_slave AND cpu_data_master_read) AND NOT PairsCounter_avalon_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_PairsCounter_avalon_slave <= internal_cpu_data_master_qualified_request_PairsCounter_avalon_slave;
  --cpu/data_master saved-grant PairsCounter/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_PairsCounter_avalon_slave <= internal_cpu_data_master_requests_PairsCounter_avalon_slave;
  --allow new arb cycle for PairsCounter/avalon_slave, which is an e_assign
  PairsCounter_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PairsCounter_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PairsCounter_avalon_slave_master_qreq_vector <= std_logic'('1');
  --PairsCounter_avalon_slave_firsttransfer first transaction, which is an e_assign
  PairsCounter_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(PairsCounter_avalon_slave_begins_xfer) = '1'), PairsCounter_avalon_slave_unreg_firsttransfer, PairsCounter_avalon_slave_reg_firsttransfer);
  --PairsCounter_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  PairsCounter_avalon_slave_unreg_firsttransfer <= NOT ((PairsCounter_avalon_slave_slavearbiterlockenable AND PairsCounter_avalon_slave_any_continuerequest));
  --PairsCounter_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PairsCounter_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PairsCounter_avalon_slave_begins_xfer) = '1' then 
        PairsCounter_avalon_slave_reg_firsttransfer <= PairsCounter_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PairsCounter_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PairsCounter_avalon_slave_beginbursttransfer_internal <= PairsCounter_avalon_slave_begins_xfer;
  --~RD_to_the_PairsCounter assignment, which is an e_mux
  RD_to_the_PairsCounter <= NOT ((internal_cpu_data_master_granted_PairsCounter_avalon_slave AND cpu_data_master_read));
  shifted_address_to_PairsCounter_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_PairsCounter_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PairsCounter_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PairsCounter_avalon_slave_end_xfer <= PairsCounter_avalon_slave_end_xfer;
    end if;

  end process;

  --PairsCounter_avalon_slave_waits_for_read in a cycle, which is an e_mux
  PairsCounter_avalon_slave_waits_for_read <= PairsCounter_avalon_slave_in_a_read_cycle AND wait_for_PairsCounter_avalon_slave_counter;
  --PairsCounter_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  PairsCounter_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_PairsCounter_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PairsCounter_avalon_slave_in_a_read_cycle;
  --PairsCounter_avalon_slave_waits_for_write in a cycle, which is an e_mux
  PairsCounter_avalon_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PairsCounter_avalon_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PairsCounter_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  PairsCounter_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_PairsCounter_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PairsCounter_avalon_slave_in_a_write_cycle;
  internal_PairsCounter_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PairsCounter_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PairsCounter_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      PairsCounter_avalon_slave_wait_counter <= PairsCounter_avalon_slave_counter_load_value;
    end if;

  end process;

  PairsCounter_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((PairsCounter_avalon_slave_in_a_read_cycle AND PairsCounter_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_PairsCounter_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PairsCounter_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_PairsCounter_avalon_slave_counter <= PairsCounter_avalon_slave_begins_xfer OR NOT internal_PairsCounter_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  PairsCounter_avalon_slave_wait_counter_eq_0 <= internal_PairsCounter_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_PairsCounter_avalon_slave <= internal_cpu_data_master_granted_PairsCounter_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PairsCounter_avalon_slave <= internal_cpu_data_master_qualified_request_PairsCounter_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PairsCounter_avalon_slave <= internal_cpu_data_master_requests_PairsCounter_avalon_slave;
--synthesis translate_off
    --PairsCounter/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PriorityController_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_PriorityController : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_PriorityController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PriorityController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_PriorityController : OUT STD_LOGIC;
                 signal cpu_data_master_granted_PriorityController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_PriorityController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PriorityController_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_PriorityController_avalon_slave : OUT STD_LOGIC;
                 signal d1_PriorityController_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity PriorityController_avalon_slave_arbitrator;


architecture europa of PriorityController_avalon_slave_arbitrator is
                signal PriorityController_avalon_slave_allgrants :  STD_LOGIC;
                signal PriorityController_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal PriorityController_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PriorityController_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal PriorityController_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal PriorityController_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal PriorityController_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal PriorityController_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal PriorityController_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal PriorityController_avalon_slave_begins_xfer :  STD_LOGIC;
                signal PriorityController_avalon_slave_counter_load_value :  STD_LOGIC;
                signal PriorityController_avalon_slave_end_xfer :  STD_LOGIC;
                signal PriorityController_avalon_slave_firsttransfer :  STD_LOGIC;
                signal PriorityController_avalon_slave_grant_vector :  STD_LOGIC;
                signal PriorityController_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal PriorityController_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal PriorityController_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal PriorityController_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal PriorityController_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal PriorityController_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal PriorityController_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal PriorityController_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal PriorityController_avalon_slave_wait_counter :  STD_LOGIC;
                signal PriorityController_avalon_slave_waits_for_read :  STD_LOGIC;
                signal PriorityController_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_PriorityController_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PriorityController_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_PriorityController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_PriorityController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_PriorityController_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_PriorityController_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_PriorityController_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_PriorityController_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PriorityController_avalon_slave_end_xfer;
    end if;

  end process;

  PriorityController_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_PriorityController_avalon_slave);
  internal_cpu_data_master_requests_PriorityController_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100110010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --PriorityController_avalon_slave_arb_share_counter set values, which is an e_mux
  PriorityController_avalon_slave_arb_share_set_values <= std_logic'('1');
  --PriorityController_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  PriorityController_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_PriorityController_avalon_slave;
  --PriorityController_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  PriorityController_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --PriorityController_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  PriorityController_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(PriorityController_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PriorityController_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(PriorityController_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PriorityController_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --PriorityController_avalon_slave_allgrants all slave grants, which is an e_mux
  PriorityController_avalon_slave_allgrants <= PriorityController_avalon_slave_grant_vector;
  --PriorityController_avalon_slave_end_xfer assignment, which is an e_assign
  PriorityController_avalon_slave_end_xfer <= NOT ((PriorityController_avalon_slave_waits_for_read OR PriorityController_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_PriorityController_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PriorityController_avalon_slave <= PriorityController_avalon_slave_end_xfer AND (((NOT PriorityController_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PriorityController_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  PriorityController_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PriorityController_avalon_slave AND PriorityController_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_PriorityController_avalon_slave AND NOT PriorityController_avalon_slave_non_bursting_master_requests));
  --PriorityController_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PriorityController_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(PriorityController_avalon_slave_arb_counter_enable) = '1' then 
        PriorityController_avalon_slave_arb_share_counter <= PriorityController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PriorityController_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PriorityController_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PriorityController_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_PriorityController_avalon_slave)) OR ((end_xfer_arb_share_counter_term_PriorityController_avalon_slave AND NOT PriorityController_avalon_slave_non_bursting_master_requests)))) = '1' then 
        PriorityController_avalon_slave_slavearbiterlockenable <= PriorityController_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master PriorityController/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= PriorityController_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --PriorityController_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PriorityController_avalon_slave_slavearbiterlockenable2 <= PriorityController_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master PriorityController/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= PriorityController_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --PriorityController_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  PriorityController_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_PriorityController_avalon_slave <= internal_cpu_data_master_requests_PriorityController_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_PriorityController_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_PriorityController_avalon_slave <= (internal_cpu_data_master_granted_PriorityController_avalon_slave AND cpu_data_master_read) AND NOT PriorityController_avalon_slave_waits_for_read;
  --Data_to_the_PriorityController mux, which is an e_mux
  Data_to_the_PriorityController <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_PriorityController_avalon_slave <= internal_cpu_data_master_qualified_request_PriorityController_avalon_slave;
  --cpu/data_master saved-grant PriorityController/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_PriorityController_avalon_slave <= internal_cpu_data_master_requests_PriorityController_avalon_slave;
  --allow new arb cycle for PriorityController/avalon_slave, which is an e_assign
  PriorityController_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PriorityController_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PriorityController_avalon_slave_master_qreq_vector <= std_logic'('1');
  --PriorityController_avalon_slave_firsttransfer first transaction, which is an e_assign
  PriorityController_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(PriorityController_avalon_slave_begins_xfer) = '1'), PriorityController_avalon_slave_unreg_firsttransfer, PriorityController_avalon_slave_reg_firsttransfer);
  --PriorityController_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  PriorityController_avalon_slave_unreg_firsttransfer <= NOT ((PriorityController_avalon_slave_slavearbiterlockenable AND PriorityController_avalon_slave_any_continuerequest));
  --PriorityController_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PriorityController_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PriorityController_avalon_slave_begins_xfer) = '1' then 
        PriorityController_avalon_slave_reg_firsttransfer <= PriorityController_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PriorityController_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PriorityController_avalon_slave_beginbursttransfer_internal <= PriorityController_avalon_slave_begins_xfer;
  --~WR_to_the_PriorityController assignment, which is an e_mux
  WR_to_the_PriorityController <= NOT ((internal_cpu_data_master_granted_PriorityController_avalon_slave AND cpu_data_master_write));
  shifted_address_to_PriorityController_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_PriorityController mux, which is an e_mux
  Address_to_the_PriorityController <= A_EXT (A_SRL(shifted_address_to_PriorityController_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PriorityController_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PriorityController_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PriorityController_avalon_slave_end_xfer <= PriorityController_avalon_slave_end_xfer;
    end if;

  end process;

  --PriorityController_avalon_slave_waits_for_read in a cycle, which is an e_mux
  PriorityController_avalon_slave_waits_for_read <= PriorityController_avalon_slave_in_a_read_cycle AND PriorityController_avalon_slave_begins_xfer;
  --PriorityController_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  PriorityController_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_PriorityController_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PriorityController_avalon_slave_in_a_read_cycle;
  --PriorityController_avalon_slave_waits_for_write in a cycle, which is an e_mux
  PriorityController_avalon_slave_waits_for_write <= PriorityController_avalon_slave_in_a_write_cycle AND wait_for_PriorityController_avalon_slave_counter;
  --PriorityController_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  PriorityController_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_PriorityController_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PriorityController_avalon_slave_in_a_write_cycle;
  internal_PriorityController_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PriorityController_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PriorityController_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      PriorityController_avalon_slave_wait_counter <= PriorityController_avalon_slave_counter_load_value;
    end if;

  end process;

  PriorityController_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((PriorityController_avalon_slave_in_a_write_cycle AND PriorityController_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_PriorityController_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PriorityController_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_PriorityController_avalon_slave_counter <= PriorityController_avalon_slave_begins_xfer OR NOT internal_PriorityController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  PriorityController_avalon_slave_wait_counter_eq_0 <= internal_PriorityController_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_PriorityController_avalon_slave <= internal_cpu_data_master_granted_PriorityController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_PriorityController_avalon_slave <= internal_cpu_data_master_qualified_request_PriorityController_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_PriorityController_avalon_slave <= internal_cpu_data_master_requests_PriorityController_avalon_slave;
--synthesis translate_off
    --PriorityController/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ReplyDelay_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal Data_from_the_ReplyDelay : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Address_to_the_ReplyDelay : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_from_the_ReplyDelay_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_ReplyDelay : OUT STD_LOGIC;
                 signal ReplyDelay_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal cpu_data_master_granted_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                 signal d1_ReplyDelay_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity ReplyDelay_avalon_slave_arbitrator;


architecture europa of ReplyDelay_avalon_slave_arbitrator is
                signal ReplyDelay_avalon_slave_allgrants :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_begins_xfer :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_counter_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ReplyDelay_avalon_slave_end_xfer :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_firsttransfer :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_grant_vector :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_wait_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ReplyDelay_avalon_slave_waits_for_read :  STD_LOGIC;
                signal ReplyDelay_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_ReplyDelay_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_ReplyDelay_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_ReplyDelay_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ReplyDelay_avalon_slave_end_xfer;
    end if;

  end process;

  ReplyDelay_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_ReplyDelay_avalon_slave);
  --assign Data_from_the_ReplyDelay_from_sa = Data_from_the_ReplyDelay so that symbol knows where to group signals which may go to master only, which is an e_assign
  Data_from_the_ReplyDelay_from_sa <= Data_from_the_ReplyDelay;
  internal_cpu_data_master_requests_ReplyDelay_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100110000000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --ReplyDelay_avalon_slave_arb_share_counter set values, which is an e_mux
  ReplyDelay_avalon_slave_arb_share_set_values <= std_logic'('1');
  --ReplyDelay_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  ReplyDelay_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_ReplyDelay_avalon_slave;
  --ReplyDelay_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  ReplyDelay_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --ReplyDelay_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  ReplyDelay_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ReplyDelay_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ReplyDelay_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ReplyDelay_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ReplyDelay_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ReplyDelay_avalon_slave_allgrants all slave grants, which is an e_mux
  ReplyDelay_avalon_slave_allgrants <= ReplyDelay_avalon_slave_grant_vector;
  --ReplyDelay_avalon_slave_end_xfer assignment, which is an e_assign
  ReplyDelay_avalon_slave_end_xfer <= NOT ((ReplyDelay_avalon_slave_waits_for_read OR ReplyDelay_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave <= ReplyDelay_avalon_slave_end_xfer AND (((NOT ReplyDelay_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ReplyDelay_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  ReplyDelay_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave AND ReplyDelay_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave AND NOT ReplyDelay_avalon_slave_non_bursting_master_requests));
  --ReplyDelay_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ReplyDelay_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ReplyDelay_avalon_slave_arb_counter_enable) = '1' then 
        ReplyDelay_avalon_slave_arb_share_counter <= ReplyDelay_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ReplyDelay_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ReplyDelay_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ReplyDelay_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave)) OR ((end_xfer_arb_share_counter_term_ReplyDelay_avalon_slave AND NOT ReplyDelay_avalon_slave_non_bursting_master_requests)))) = '1' then 
        ReplyDelay_avalon_slave_slavearbiterlockenable <= ReplyDelay_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master ReplyDelay/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ReplyDelay_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ReplyDelay_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ReplyDelay_avalon_slave_slavearbiterlockenable2 <= ReplyDelay_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master ReplyDelay/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ReplyDelay_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --ReplyDelay_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  ReplyDelay_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_ReplyDelay_avalon_slave <= internal_cpu_data_master_requests_ReplyDelay_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_ReplyDelay_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_ReplyDelay_avalon_slave <= (internal_cpu_data_master_granted_ReplyDelay_avalon_slave AND cpu_data_master_read) AND NOT ReplyDelay_avalon_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_ReplyDelay_avalon_slave <= internal_cpu_data_master_qualified_request_ReplyDelay_avalon_slave;
  --cpu/data_master saved-grant ReplyDelay/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_ReplyDelay_avalon_slave <= internal_cpu_data_master_requests_ReplyDelay_avalon_slave;
  --allow new arb cycle for ReplyDelay/avalon_slave, which is an e_assign
  ReplyDelay_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ReplyDelay_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ReplyDelay_avalon_slave_master_qreq_vector <= std_logic'('1');
  --ReplyDelay_avalon_slave_firsttransfer first transaction, which is an e_assign
  ReplyDelay_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(ReplyDelay_avalon_slave_begins_xfer) = '1'), ReplyDelay_avalon_slave_unreg_firsttransfer, ReplyDelay_avalon_slave_reg_firsttransfer);
  --ReplyDelay_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  ReplyDelay_avalon_slave_unreg_firsttransfer <= NOT ((ReplyDelay_avalon_slave_slavearbiterlockenable AND ReplyDelay_avalon_slave_any_continuerequest));
  --ReplyDelay_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ReplyDelay_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ReplyDelay_avalon_slave_begins_xfer) = '1' then 
        ReplyDelay_avalon_slave_reg_firsttransfer <= ReplyDelay_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ReplyDelay_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ReplyDelay_avalon_slave_beginbursttransfer_internal <= ReplyDelay_avalon_slave_begins_xfer;
  --~RD_to_the_ReplyDelay assignment, which is an e_mux
  RD_to_the_ReplyDelay <= NOT ((internal_cpu_data_master_granted_ReplyDelay_avalon_slave AND cpu_data_master_read));
  shifted_address_to_ReplyDelay_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --Address_to_the_ReplyDelay mux, which is an e_mux
  Address_to_the_ReplyDelay <= A_EXT (A_SRL(shifted_address_to_ReplyDelay_avalon_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_ReplyDelay_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ReplyDelay_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ReplyDelay_avalon_slave_end_xfer <= ReplyDelay_avalon_slave_end_xfer;
    end if;

  end process;

  --ReplyDelay_avalon_slave_waits_for_read in a cycle, which is an e_mux
  ReplyDelay_avalon_slave_waits_for_read <= ReplyDelay_avalon_slave_in_a_read_cycle AND wait_for_ReplyDelay_avalon_slave_counter;
  --ReplyDelay_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  ReplyDelay_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_ReplyDelay_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ReplyDelay_avalon_slave_in_a_read_cycle;
  --ReplyDelay_avalon_slave_waits_for_write in a cycle, which is an e_mux
  ReplyDelay_avalon_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ReplyDelay_avalon_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --ReplyDelay_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  ReplyDelay_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_ReplyDelay_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ReplyDelay_avalon_slave_in_a_write_cycle;
  internal_ReplyDelay_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("000000000000000000000000000000") & (ReplyDelay_avalon_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ReplyDelay_avalon_slave_wait_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      ReplyDelay_avalon_slave_wait_counter <= ReplyDelay_avalon_slave_counter_load_value;
    end if;

  end process;

  ReplyDelay_avalon_slave_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((ReplyDelay_avalon_slave_in_a_read_cycle AND ReplyDelay_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((NOT internal_ReplyDelay_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("0000000000000000000000000000000") & (ReplyDelay_avalon_slave_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  wait_for_ReplyDelay_avalon_slave_counter <= ReplyDelay_avalon_slave_begins_xfer OR NOT internal_ReplyDelay_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  ReplyDelay_avalon_slave_wait_counter_eq_0 <= internal_ReplyDelay_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_ReplyDelay_avalon_slave <= internal_cpu_data_master_granted_ReplyDelay_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_ReplyDelay_avalon_slave <= internal_cpu_data_master_qualified_request_ReplyDelay_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_ReplyDelay_avalon_slave <= internal_cpu_data_master_requests_ReplyDelay_avalon_slave;
--synthesis translate_off
    --ReplyDelay/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SPI_FRAM_spi_control_port_arbitrator is 
        port (
              -- inputs:
                 signal SPI_FRAM_spi_control_port_dataavailable : IN STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_endofpacket : IN STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_FRAM_spi_control_port_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal SPI_FRAM_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal SPI_FRAM_spi_control_port_chipselect : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_read_n : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_FRAM_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_reset_n : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_write_n : OUT STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_granted_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_requests_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                 signal d1_SPI_FRAM_spi_control_port_end_xfer : OUT STD_LOGIC
              );
end entity SPI_FRAM_spi_control_port_arbitrator;


architecture europa of SPI_FRAM_spi_control_port_arbitrator is
                signal SPI_FRAM_spi_control_port_allgrants :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_any_continuerequest :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_arb_counter_enable :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_arb_share_counter :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_arb_share_counter_next_value :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_arb_share_set_values :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_begins_xfer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_end_xfer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_firsttransfer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_grant_vector :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_in_a_read_cycle :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_in_a_write_cycle :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_master_qreq_vector :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_reg_firsttransfer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_waits_for_read :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_requests_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal shifted_address_to_SPI_FRAM_spi_control_port_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_SPI_FRAM_spi_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SPI_FRAM_spi_control_port_end_xfer;
    end if;

  end process;

  SPI_FRAM_spi_control_port_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_SPI_FRAM_spi_control_port);
  --assign SPI_FRAM_spi_control_port_readdata_from_sa = SPI_FRAM_spi_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_FRAM_spi_control_port_readdata_from_sa <= SPI_FRAM_spi_control_port_readdata;
  internal_cpu_data_master_requests_SPI_FRAM_spi_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100010100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign SPI_FRAM_spi_control_port_dataavailable_from_sa = SPI_FRAM_spi_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_FRAM_spi_control_port_dataavailable_from_sa <= SPI_FRAM_spi_control_port_dataavailable;
  --assign SPI_FRAM_spi_control_port_readyfordata_from_sa = SPI_FRAM_spi_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_FRAM_spi_control_port_readyfordata_from_sa <= SPI_FRAM_spi_control_port_readyfordata;
  --SPI_FRAM_spi_control_port_arb_share_counter set values, which is an e_mux
  SPI_FRAM_spi_control_port_arb_share_set_values <= std_logic'('1');
  --SPI_FRAM_spi_control_port_non_bursting_master_requests mux, which is an e_mux
  SPI_FRAM_spi_control_port_non_bursting_master_requests <= internal_cpu_data_master_requests_SPI_FRAM_spi_control_port;
  --SPI_FRAM_spi_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  SPI_FRAM_spi_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --SPI_FRAM_spi_control_port_arb_share_counter_next_value assignment, which is an e_assign
  SPI_FRAM_spi_control_port_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(SPI_FRAM_spi_control_port_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_FRAM_spi_control_port_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(SPI_FRAM_spi_control_port_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_FRAM_spi_control_port_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --SPI_FRAM_spi_control_port_allgrants all slave grants, which is an e_mux
  SPI_FRAM_spi_control_port_allgrants <= SPI_FRAM_spi_control_port_grant_vector;
  --SPI_FRAM_spi_control_port_end_xfer assignment, which is an e_assign
  SPI_FRAM_spi_control_port_end_xfer <= NOT ((SPI_FRAM_spi_control_port_waits_for_read OR SPI_FRAM_spi_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port <= SPI_FRAM_spi_control_port_end_xfer AND (((NOT SPI_FRAM_spi_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SPI_FRAM_spi_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  SPI_FRAM_spi_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port AND SPI_FRAM_spi_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port AND NOT SPI_FRAM_spi_control_port_non_bursting_master_requests));
  --SPI_FRAM_spi_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_FRAM_spi_control_port_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_FRAM_spi_control_port_arb_counter_enable) = '1' then 
        SPI_FRAM_spi_control_port_arb_share_counter <= SPI_FRAM_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SPI_FRAM_spi_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_FRAM_spi_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((SPI_FRAM_spi_control_port_master_qreq_vector AND end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port)) OR ((end_xfer_arb_share_counter_term_SPI_FRAM_spi_control_port AND NOT SPI_FRAM_spi_control_port_non_bursting_master_requests)))) = '1' then 
        SPI_FRAM_spi_control_port_slavearbiterlockenable <= SPI_FRAM_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master SPI_FRAM/spi_control_port arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= SPI_FRAM_spi_control_port_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --SPI_FRAM_spi_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SPI_FRAM_spi_control_port_slavearbiterlockenable2 <= SPI_FRAM_spi_control_port_arb_share_counter_next_value;
  --cpu/data_master SPI_FRAM/spi_control_port arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= SPI_FRAM_spi_control_port_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --SPI_FRAM_spi_control_port_any_continuerequest at least one master continues requesting, which is an e_assign
  SPI_FRAM_spi_control_port_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_SPI_FRAM_spi_control_port <= internal_cpu_data_master_requests_SPI_FRAM_spi_control_port AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port, which is an e_mux
  cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port <= (internal_cpu_data_master_granted_SPI_FRAM_spi_control_port AND cpu_data_master_read) AND NOT SPI_FRAM_spi_control_port_waits_for_read;
  --SPI_FRAM_spi_control_port_writedata mux, which is an e_mux
  SPI_FRAM_spi_control_port_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --assign SPI_FRAM_spi_control_port_endofpacket_from_sa = SPI_FRAM_spi_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_FRAM_spi_control_port_endofpacket_from_sa <= SPI_FRAM_spi_control_port_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_SPI_FRAM_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_FRAM_spi_control_port;
  --cpu/data_master saved-grant SPI_FRAM/spi_control_port, which is an e_assign
  cpu_data_master_saved_grant_SPI_FRAM_spi_control_port <= internal_cpu_data_master_requests_SPI_FRAM_spi_control_port;
  --allow new arb cycle for SPI_FRAM/spi_control_port, which is an e_assign
  SPI_FRAM_spi_control_port_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  SPI_FRAM_spi_control_port_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  SPI_FRAM_spi_control_port_master_qreq_vector <= std_logic'('1');
  --SPI_FRAM_spi_control_port_reset_n assignment, which is an e_assign
  SPI_FRAM_spi_control_port_reset_n <= reset_n;
  SPI_FRAM_spi_control_port_chipselect <= internal_cpu_data_master_granted_SPI_FRAM_spi_control_port;
  --SPI_FRAM_spi_control_port_firsttransfer first transaction, which is an e_assign
  SPI_FRAM_spi_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(SPI_FRAM_spi_control_port_begins_xfer) = '1'), SPI_FRAM_spi_control_port_unreg_firsttransfer, SPI_FRAM_spi_control_port_reg_firsttransfer);
  --SPI_FRAM_spi_control_port_unreg_firsttransfer first transaction, which is an e_assign
  SPI_FRAM_spi_control_port_unreg_firsttransfer <= NOT ((SPI_FRAM_spi_control_port_slavearbiterlockenable AND SPI_FRAM_spi_control_port_any_continuerequest));
  --SPI_FRAM_spi_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_FRAM_spi_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_FRAM_spi_control_port_begins_xfer) = '1' then 
        SPI_FRAM_spi_control_port_reg_firsttransfer <= SPI_FRAM_spi_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SPI_FRAM_spi_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SPI_FRAM_spi_control_port_beginbursttransfer_internal <= SPI_FRAM_spi_control_port_begins_xfer;
  --~SPI_FRAM_spi_control_port_read_n assignment, which is an e_mux
  SPI_FRAM_spi_control_port_read_n <= NOT ((internal_cpu_data_master_granted_SPI_FRAM_spi_control_port AND cpu_data_master_read));
  --~SPI_FRAM_spi_control_port_write_n assignment, which is an e_mux
  SPI_FRAM_spi_control_port_write_n <= NOT ((internal_cpu_data_master_granted_SPI_FRAM_spi_control_port AND cpu_data_master_write));
  shifted_address_to_SPI_FRAM_spi_control_port_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --SPI_FRAM_spi_control_port_address mux, which is an e_mux
  SPI_FRAM_spi_control_port_address <= A_EXT (A_SRL(shifted_address_to_SPI_FRAM_spi_control_port_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_SPI_FRAM_spi_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SPI_FRAM_spi_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SPI_FRAM_spi_control_port_end_xfer <= SPI_FRAM_spi_control_port_end_xfer;
    end if;

  end process;

  --SPI_FRAM_spi_control_port_waits_for_read in a cycle, which is an e_mux
  SPI_FRAM_spi_control_port_waits_for_read <= SPI_FRAM_spi_control_port_in_a_read_cycle AND SPI_FRAM_spi_control_port_begins_xfer;
  --SPI_FRAM_spi_control_port_in_a_read_cycle assignment, which is an e_assign
  SPI_FRAM_spi_control_port_in_a_read_cycle <= internal_cpu_data_master_granted_SPI_FRAM_spi_control_port AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SPI_FRAM_spi_control_port_in_a_read_cycle;
  --SPI_FRAM_spi_control_port_waits_for_write in a cycle, which is an e_mux
  SPI_FRAM_spi_control_port_waits_for_write <= SPI_FRAM_spi_control_port_in_a_write_cycle AND SPI_FRAM_spi_control_port_begins_xfer;
  --SPI_FRAM_spi_control_port_in_a_write_cycle assignment, which is an e_assign
  SPI_FRAM_spi_control_port_in_a_write_cycle <= internal_cpu_data_master_granted_SPI_FRAM_spi_control_port AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SPI_FRAM_spi_control_port_in_a_write_cycle;
  wait_for_SPI_FRAM_spi_control_port_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_SPI_FRAM_spi_control_port <= internal_cpu_data_master_granted_SPI_FRAM_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_SPI_FRAM_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_FRAM_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_requests_SPI_FRAM_spi_control_port <= internal_cpu_data_master_requests_SPI_FRAM_spi_control_port;
--synthesis translate_off
    --SPI_FRAM/spi_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SPI_Flash_spi_control_port_arbitrator is 
        port (
              -- inputs:
                 signal SPI_Flash_spi_control_port_dataavailable : IN STD_LOGIC;
                 signal SPI_Flash_spi_control_port_endofpacket : IN STD_LOGIC;
                 signal SPI_Flash_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Flash_spi_control_port_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal SPI_Flash_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal SPI_Flash_spi_control_port_chipselect : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_read_n : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Flash_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_reset_n : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_write_n : OUT STD_LOGIC;
                 signal SPI_Flash_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_granted_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_requests_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                 signal d1_SPI_Flash_spi_control_port_end_xfer : OUT STD_LOGIC
              );
end entity SPI_Flash_spi_control_port_arbitrator;


architecture europa of SPI_Flash_spi_control_port_arbitrator is
                signal SPI_Flash_spi_control_port_allgrants :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_any_continuerequest :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_arb_counter_enable :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_arb_share_counter :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_arb_share_counter_next_value :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_arb_share_set_values :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_begins_xfer :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_end_xfer :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_firsttransfer :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_grant_vector :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_in_a_read_cycle :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_in_a_write_cycle :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_master_qreq_vector :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_reg_firsttransfer :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_waits_for_read :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_requests_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal shifted_address_to_SPI_Flash_spi_control_port_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_SPI_Flash_spi_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SPI_Flash_spi_control_port_end_xfer;
    end if;

  end process;

  SPI_Flash_spi_control_port_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_SPI_Flash_spi_control_port);
  --assign SPI_Flash_spi_control_port_readdata_from_sa = SPI_Flash_spi_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Flash_spi_control_port_readdata_from_sa <= SPI_Flash_spi_control_port_readdata;
  internal_cpu_data_master_requests_SPI_Flash_spi_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100010000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign SPI_Flash_spi_control_port_dataavailable_from_sa = SPI_Flash_spi_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Flash_spi_control_port_dataavailable_from_sa <= SPI_Flash_spi_control_port_dataavailable;
  --assign SPI_Flash_spi_control_port_readyfordata_from_sa = SPI_Flash_spi_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Flash_spi_control_port_readyfordata_from_sa <= SPI_Flash_spi_control_port_readyfordata;
  --SPI_Flash_spi_control_port_arb_share_counter set values, which is an e_mux
  SPI_Flash_spi_control_port_arb_share_set_values <= std_logic'('1');
  --SPI_Flash_spi_control_port_non_bursting_master_requests mux, which is an e_mux
  SPI_Flash_spi_control_port_non_bursting_master_requests <= internal_cpu_data_master_requests_SPI_Flash_spi_control_port;
  --SPI_Flash_spi_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  SPI_Flash_spi_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --SPI_Flash_spi_control_port_arb_share_counter_next_value assignment, which is an e_assign
  SPI_Flash_spi_control_port_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(SPI_Flash_spi_control_port_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_Flash_spi_control_port_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(SPI_Flash_spi_control_port_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_Flash_spi_control_port_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --SPI_Flash_spi_control_port_allgrants all slave grants, which is an e_mux
  SPI_Flash_spi_control_port_allgrants <= SPI_Flash_spi_control_port_grant_vector;
  --SPI_Flash_spi_control_port_end_xfer assignment, which is an e_assign
  SPI_Flash_spi_control_port_end_xfer <= NOT ((SPI_Flash_spi_control_port_waits_for_read OR SPI_Flash_spi_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port <= SPI_Flash_spi_control_port_end_xfer AND (((NOT SPI_Flash_spi_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SPI_Flash_spi_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  SPI_Flash_spi_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port AND SPI_Flash_spi_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port AND NOT SPI_Flash_spi_control_port_non_bursting_master_requests));
  --SPI_Flash_spi_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Flash_spi_control_port_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_Flash_spi_control_port_arb_counter_enable) = '1' then 
        SPI_Flash_spi_control_port_arb_share_counter <= SPI_Flash_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SPI_Flash_spi_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Flash_spi_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((SPI_Flash_spi_control_port_master_qreq_vector AND end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port)) OR ((end_xfer_arb_share_counter_term_SPI_Flash_spi_control_port AND NOT SPI_Flash_spi_control_port_non_bursting_master_requests)))) = '1' then 
        SPI_Flash_spi_control_port_slavearbiterlockenable <= SPI_Flash_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master SPI_Flash/spi_control_port arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= SPI_Flash_spi_control_port_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --SPI_Flash_spi_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SPI_Flash_spi_control_port_slavearbiterlockenable2 <= SPI_Flash_spi_control_port_arb_share_counter_next_value;
  --cpu/data_master SPI_Flash/spi_control_port arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= SPI_Flash_spi_control_port_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --SPI_Flash_spi_control_port_any_continuerequest at least one master continues requesting, which is an e_assign
  SPI_Flash_spi_control_port_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_SPI_Flash_spi_control_port <= internal_cpu_data_master_requests_SPI_Flash_spi_control_port AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_SPI_Flash_spi_control_port, which is an e_mux
  cpu_data_master_read_data_valid_SPI_Flash_spi_control_port <= (internal_cpu_data_master_granted_SPI_Flash_spi_control_port AND cpu_data_master_read) AND NOT SPI_Flash_spi_control_port_waits_for_read;
  --SPI_Flash_spi_control_port_writedata mux, which is an e_mux
  SPI_Flash_spi_control_port_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --assign SPI_Flash_spi_control_port_endofpacket_from_sa = SPI_Flash_spi_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Flash_spi_control_port_endofpacket_from_sa <= SPI_Flash_spi_control_port_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_SPI_Flash_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_Flash_spi_control_port;
  --cpu/data_master saved-grant SPI_Flash/spi_control_port, which is an e_assign
  cpu_data_master_saved_grant_SPI_Flash_spi_control_port <= internal_cpu_data_master_requests_SPI_Flash_spi_control_port;
  --allow new arb cycle for SPI_Flash/spi_control_port, which is an e_assign
  SPI_Flash_spi_control_port_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  SPI_Flash_spi_control_port_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  SPI_Flash_spi_control_port_master_qreq_vector <= std_logic'('1');
  --SPI_Flash_spi_control_port_reset_n assignment, which is an e_assign
  SPI_Flash_spi_control_port_reset_n <= reset_n;
  SPI_Flash_spi_control_port_chipselect <= internal_cpu_data_master_granted_SPI_Flash_spi_control_port;
  --SPI_Flash_spi_control_port_firsttransfer first transaction, which is an e_assign
  SPI_Flash_spi_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(SPI_Flash_spi_control_port_begins_xfer) = '1'), SPI_Flash_spi_control_port_unreg_firsttransfer, SPI_Flash_spi_control_port_reg_firsttransfer);
  --SPI_Flash_spi_control_port_unreg_firsttransfer first transaction, which is an e_assign
  SPI_Flash_spi_control_port_unreg_firsttransfer <= NOT ((SPI_Flash_spi_control_port_slavearbiterlockenable AND SPI_Flash_spi_control_port_any_continuerequest));
  --SPI_Flash_spi_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Flash_spi_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_Flash_spi_control_port_begins_xfer) = '1' then 
        SPI_Flash_spi_control_port_reg_firsttransfer <= SPI_Flash_spi_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SPI_Flash_spi_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SPI_Flash_spi_control_port_beginbursttransfer_internal <= SPI_Flash_spi_control_port_begins_xfer;
  --~SPI_Flash_spi_control_port_read_n assignment, which is an e_mux
  SPI_Flash_spi_control_port_read_n <= NOT ((internal_cpu_data_master_granted_SPI_Flash_spi_control_port AND cpu_data_master_read));
  --~SPI_Flash_spi_control_port_write_n assignment, which is an e_mux
  SPI_Flash_spi_control_port_write_n <= NOT ((internal_cpu_data_master_granted_SPI_Flash_spi_control_port AND cpu_data_master_write));
  shifted_address_to_SPI_Flash_spi_control_port_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --SPI_Flash_spi_control_port_address mux, which is an e_mux
  SPI_Flash_spi_control_port_address <= A_EXT (A_SRL(shifted_address_to_SPI_Flash_spi_control_port_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_SPI_Flash_spi_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SPI_Flash_spi_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SPI_Flash_spi_control_port_end_xfer <= SPI_Flash_spi_control_port_end_xfer;
    end if;

  end process;

  --SPI_Flash_spi_control_port_waits_for_read in a cycle, which is an e_mux
  SPI_Flash_spi_control_port_waits_for_read <= SPI_Flash_spi_control_port_in_a_read_cycle AND SPI_Flash_spi_control_port_begins_xfer;
  --SPI_Flash_spi_control_port_in_a_read_cycle assignment, which is an e_assign
  SPI_Flash_spi_control_port_in_a_read_cycle <= internal_cpu_data_master_granted_SPI_Flash_spi_control_port AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SPI_Flash_spi_control_port_in_a_read_cycle;
  --SPI_Flash_spi_control_port_waits_for_write in a cycle, which is an e_mux
  SPI_Flash_spi_control_port_waits_for_write <= SPI_Flash_spi_control_port_in_a_write_cycle AND SPI_Flash_spi_control_port_begins_xfer;
  --SPI_Flash_spi_control_port_in_a_write_cycle assignment, which is an e_assign
  SPI_Flash_spi_control_port_in_a_write_cycle <= internal_cpu_data_master_granted_SPI_Flash_spi_control_port AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SPI_Flash_spi_control_port_in_a_write_cycle;
  wait_for_SPI_Flash_spi_control_port_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_SPI_Flash_spi_control_port <= internal_cpu_data_master_granted_SPI_Flash_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_SPI_Flash_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_Flash_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_requests_SPI_Flash_spi_control_port <= internal_cpu_data_master_requests_SPI_Flash_spi_control_port;
--synthesis translate_off
    --SPI_Flash/spi_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SPI_Synthesizer_spi_control_port_arbitrator is 
        port (
              -- inputs:
                 signal SPI_Synthesizer_spi_control_port_dataavailable : IN STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_endofpacket : IN STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Synthesizer_spi_control_port_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal SPI_Synthesizer_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal SPI_Synthesizer_spi_control_port_chipselect : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_read_n : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Synthesizer_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_reset_n : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_write_n : OUT STD_LOGIC;
                 signal SPI_Synthesizer_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_granted_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_requests_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                 signal d1_SPI_Synthesizer_spi_control_port_end_xfer : OUT STD_LOGIC
              );
end entity SPI_Synthesizer_spi_control_port_arbitrator;


architecture europa of SPI_Synthesizer_spi_control_port_arbitrator is
                signal SPI_Synthesizer_spi_control_port_allgrants :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_any_continuerequest :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_arb_counter_enable :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_arb_share_counter :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_arb_share_counter_next_value :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_arb_share_set_values :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_begins_xfer :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_end_xfer :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_firsttransfer :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_grant_vector :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_in_a_read_cycle :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_in_a_write_cycle :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_master_qreq_vector :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_reg_firsttransfer :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_waits_for_read :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal shifted_address_to_SPI_Synthesizer_spi_control_port_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_SPI_Synthesizer_spi_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SPI_Synthesizer_spi_control_port_end_xfer;
    end if;

  end process;

  SPI_Synthesizer_spi_control_port_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port);
  --assign SPI_Synthesizer_spi_control_port_readdata_from_sa = SPI_Synthesizer_spi_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Synthesizer_spi_control_port_readdata_from_sa <= SPI_Synthesizer_spi_control_port_readdata;
  internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100011000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign SPI_Synthesizer_spi_control_port_dataavailable_from_sa = SPI_Synthesizer_spi_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Synthesizer_spi_control_port_dataavailable_from_sa <= SPI_Synthesizer_spi_control_port_dataavailable;
  --assign SPI_Synthesizer_spi_control_port_readyfordata_from_sa = SPI_Synthesizer_spi_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Synthesizer_spi_control_port_readyfordata_from_sa <= SPI_Synthesizer_spi_control_port_readyfordata;
  --SPI_Synthesizer_spi_control_port_arb_share_counter set values, which is an e_mux
  SPI_Synthesizer_spi_control_port_arb_share_set_values <= std_logic'('1');
  --SPI_Synthesizer_spi_control_port_non_bursting_master_requests mux, which is an e_mux
  SPI_Synthesizer_spi_control_port_non_bursting_master_requests <= internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port;
  --SPI_Synthesizer_spi_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  SPI_Synthesizer_spi_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --SPI_Synthesizer_spi_control_port_arb_share_counter_next_value assignment, which is an e_assign
  SPI_Synthesizer_spi_control_port_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(SPI_Synthesizer_spi_control_port_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_Synthesizer_spi_control_port_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(SPI_Synthesizer_spi_control_port_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SPI_Synthesizer_spi_control_port_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --SPI_Synthesizer_spi_control_port_allgrants all slave grants, which is an e_mux
  SPI_Synthesizer_spi_control_port_allgrants <= SPI_Synthesizer_spi_control_port_grant_vector;
  --SPI_Synthesizer_spi_control_port_end_xfer assignment, which is an e_assign
  SPI_Synthesizer_spi_control_port_end_xfer <= NOT ((SPI_Synthesizer_spi_control_port_waits_for_read OR SPI_Synthesizer_spi_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port <= SPI_Synthesizer_spi_control_port_end_xfer AND (((NOT SPI_Synthesizer_spi_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SPI_Synthesizer_spi_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  SPI_Synthesizer_spi_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port AND SPI_Synthesizer_spi_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port AND NOT SPI_Synthesizer_spi_control_port_non_bursting_master_requests));
  --SPI_Synthesizer_spi_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Synthesizer_spi_control_port_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_Synthesizer_spi_control_port_arb_counter_enable) = '1' then 
        SPI_Synthesizer_spi_control_port_arb_share_counter <= SPI_Synthesizer_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SPI_Synthesizer_spi_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Synthesizer_spi_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((SPI_Synthesizer_spi_control_port_master_qreq_vector AND end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port)) OR ((end_xfer_arb_share_counter_term_SPI_Synthesizer_spi_control_port AND NOT SPI_Synthesizer_spi_control_port_non_bursting_master_requests)))) = '1' then 
        SPI_Synthesizer_spi_control_port_slavearbiterlockenable <= SPI_Synthesizer_spi_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master SPI_Synthesizer/spi_control_port arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= SPI_Synthesizer_spi_control_port_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --SPI_Synthesizer_spi_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SPI_Synthesizer_spi_control_port_slavearbiterlockenable2 <= SPI_Synthesizer_spi_control_port_arb_share_counter_next_value;
  --cpu/data_master SPI_Synthesizer/spi_control_port arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= SPI_Synthesizer_spi_control_port_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --SPI_Synthesizer_spi_control_port_any_continuerequest at least one master continues requesting, which is an e_assign
  SPI_Synthesizer_spi_control_port_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port, which is an e_mux
  cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port <= (internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port AND cpu_data_master_read) AND NOT SPI_Synthesizer_spi_control_port_waits_for_read;
  --SPI_Synthesizer_spi_control_port_writedata mux, which is an e_mux
  SPI_Synthesizer_spi_control_port_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --assign SPI_Synthesizer_spi_control_port_endofpacket_from_sa = SPI_Synthesizer_spi_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  SPI_Synthesizer_spi_control_port_endofpacket_from_sa <= SPI_Synthesizer_spi_control_port_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port;
  --cpu/data_master saved-grant SPI_Synthesizer/spi_control_port, which is an e_assign
  cpu_data_master_saved_grant_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port;
  --allow new arb cycle for SPI_Synthesizer/spi_control_port, which is an e_assign
  SPI_Synthesizer_spi_control_port_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  SPI_Synthesizer_spi_control_port_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  SPI_Synthesizer_spi_control_port_master_qreq_vector <= std_logic'('1');
  --SPI_Synthesizer_spi_control_port_reset_n assignment, which is an e_assign
  SPI_Synthesizer_spi_control_port_reset_n <= reset_n;
  SPI_Synthesizer_spi_control_port_chipselect <= internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port;
  --SPI_Synthesizer_spi_control_port_firsttransfer first transaction, which is an e_assign
  SPI_Synthesizer_spi_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(SPI_Synthesizer_spi_control_port_begins_xfer) = '1'), SPI_Synthesizer_spi_control_port_unreg_firsttransfer, SPI_Synthesizer_spi_control_port_reg_firsttransfer);
  --SPI_Synthesizer_spi_control_port_unreg_firsttransfer first transaction, which is an e_assign
  SPI_Synthesizer_spi_control_port_unreg_firsttransfer <= NOT ((SPI_Synthesizer_spi_control_port_slavearbiterlockenable AND SPI_Synthesizer_spi_control_port_any_continuerequest));
  --SPI_Synthesizer_spi_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SPI_Synthesizer_spi_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SPI_Synthesizer_spi_control_port_begins_xfer) = '1' then 
        SPI_Synthesizer_spi_control_port_reg_firsttransfer <= SPI_Synthesizer_spi_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SPI_Synthesizer_spi_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SPI_Synthesizer_spi_control_port_beginbursttransfer_internal <= SPI_Synthesizer_spi_control_port_begins_xfer;
  --~SPI_Synthesizer_spi_control_port_read_n assignment, which is an e_mux
  SPI_Synthesizer_spi_control_port_read_n <= NOT ((internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port AND cpu_data_master_read));
  --~SPI_Synthesizer_spi_control_port_write_n assignment, which is an e_mux
  SPI_Synthesizer_spi_control_port_write_n <= NOT ((internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port AND cpu_data_master_write));
  shifted_address_to_SPI_Synthesizer_spi_control_port_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --SPI_Synthesizer_spi_control_port_address mux, which is an e_mux
  SPI_Synthesizer_spi_control_port_address <= A_EXT (A_SRL(shifted_address_to_SPI_Synthesizer_spi_control_port_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_SPI_Synthesizer_spi_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SPI_Synthesizer_spi_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SPI_Synthesizer_spi_control_port_end_xfer <= SPI_Synthesizer_spi_control_port_end_xfer;
    end if;

  end process;

  --SPI_Synthesizer_spi_control_port_waits_for_read in a cycle, which is an e_mux
  SPI_Synthesizer_spi_control_port_waits_for_read <= SPI_Synthesizer_spi_control_port_in_a_read_cycle AND SPI_Synthesizer_spi_control_port_begins_xfer;
  --SPI_Synthesizer_spi_control_port_in_a_read_cycle assignment, which is an e_assign
  SPI_Synthesizer_spi_control_port_in_a_read_cycle <= internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SPI_Synthesizer_spi_control_port_in_a_read_cycle;
  --SPI_Synthesizer_spi_control_port_waits_for_write in a cycle, which is an e_mux
  SPI_Synthesizer_spi_control_port_waits_for_write <= SPI_Synthesizer_spi_control_port_in_a_write_cycle AND SPI_Synthesizer_spi_control_port_begins_xfer;
  --SPI_Synthesizer_spi_control_port_in_a_write_cycle assignment, which is an e_assign
  SPI_Synthesizer_spi_control_port_in_a_write_cycle <= internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SPI_Synthesizer_spi_control_port_in_a_write_cycle;
  wait_for_SPI_Synthesizer_spi_control_port_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_granted_SPI_Synthesizer_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_requests_SPI_Synthesizer_spi_control_port <= internal_cpu_data_master_requests_SPI_Synthesizer_spi_control_port;
--synthesis translate_off
    --SPI_Synthesizer/spi_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SelectMuxChannel_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_to_the_SelectMuxChannel : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal SelectMuxChannel_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal WR_to_the_SelectMuxChannel : OUT STD_LOGIC;
                 signal cpu_data_master_granted_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                 signal d1_SelectMuxChannel_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity SelectMuxChannel_avalon_slave_arbitrator;


architecture europa of SelectMuxChannel_avalon_slave_arbitrator is
                signal SelectMuxChannel_avalon_slave_allgrants :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_begins_xfer :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_counter_load_value :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_end_xfer :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_firsttransfer :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_grant_vector :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_wait_counter :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_waits_for_read :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_SelectMuxChannel_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_SelectMuxChannel_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_SelectMuxChannel_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SelectMuxChannel_avalon_slave_end_xfer;
    end if;

  end process;

  SelectMuxChannel_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave);
  internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110110000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_write;
  --SelectMuxChannel_avalon_slave_arb_share_counter set values, which is an e_mux
  SelectMuxChannel_avalon_slave_arb_share_set_values <= std_logic'('1');
  --SelectMuxChannel_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  SelectMuxChannel_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave;
  --SelectMuxChannel_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  SelectMuxChannel_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --SelectMuxChannel_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  SelectMuxChannel_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(SelectMuxChannel_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SelectMuxChannel_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(SelectMuxChannel_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SelectMuxChannel_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --SelectMuxChannel_avalon_slave_allgrants all slave grants, which is an e_mux
  SelectMuxChannel_avalon_slave_allgrants <= SelectMuxChannel_avalon_slave_grant_vector;
  --SelectMuxChannel_avalon_slave_end_xfer assignment, which is an e_assign
  SelectMuxChannel_avalon_slave_end_xfer <= NOT ((SelectMuxChannel_avalon_slave_waits_for_read OR SelectMuxChannel_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave <= SelectMuxChannel_avalon_slave_end_xfer AND (((NOT SelectMuxChannel_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SelectMuxChannel_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  SelectMuxChannel_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave AND SelectMuxChannel_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave AND NOT SelectMuxChannel_avalon_slave_non_bursting_master_requests));
  --SelectMuxChannel_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SelectMuxChannel_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(SelectMuxChannel_avalon_slave_arb_counter_enable) = '1' then 
        SelectMuxChannel_avalon_slave_arb_share_counter <= SelectMuxChannel_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SelectMuxChannel_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SelectMuxChannel_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((SelectMuxChannel_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave)) OR ((end_xfer_arb_share_counter_term_SelectMuxChannel_avalon_slave AND NOT SelectMuxChannel_avalon_slave_non_bursting_master_requests)))) = '1' then 
        SelectMuxChannel_avalon_slave_slavearbiterlockenable <= SelectMuxChannel_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master SelectMuxChannel/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= SelectMuxChannel_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --SelectMuxChannel_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SelectMuxChannel_avalon_slave_slavearbiterlockenable2 <= SelectMuxChannel_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master SelectMuxChannel/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= SelectMuxChannel_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --SelectMuxChannel_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  SelectMuxChannel_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave;
  --local readdatavalid cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave <= (internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave AND cpu_data_master_read) AND NOT SelectMuxChannel_avalon_slave_waits_for_read;
  --Data_to_the_SelectMuxChannel mux, which is an e_mux
  Data_to_the_SelectMuxChannel <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave;
  --cpu/data_master saved-grant SelectMuxChannel/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave;
  --allow new arb cycle for SelectMuxChannel/avalon_slave, which is an e_assign
  SelectMuxChannel_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  SelectMuxChannel_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  SelectMuxChannel_avalon_slave_master_qreq_vector <= std_logic'('1');
  --SelectMuxChannel_avalon_slave_firsttransfer first transaction, which is an e_assign
  SelectMuxChannel_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(SelectMuxChannel_avalon_slave_begins_xfer) = '1'), SelectMuxChannel_avalon_slave_unreg_firsttransfer, SelectMuxChannel_avalon_slave_reg_firsttransfer);
  --SelectMuxChannel_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  SelectMuxChannel_avalon_slave_unreg_firsttransfer <= NOT ((SelectMuxChannel_avalon_slave_slavearbiterlockenable AND SelectMuxChannel_avalon_slave_any_continuerequest));
  --SelectMuxChannel_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SelectMuxChannel_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SelectMuxChannel_avalon_slave_begins_xfer) = '1' then 
        SelectMuxChannel_avalon_slave_reg_firsttransfer <= SelectMuxChannel_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SelectMuxChannel_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SelectMuxChannel_avalon_slave_beginbursttransfer_internal <= SelectMuxChannel_avalon_slave_begins_xfer;
  --~WR_to_the_SelectMuxChannel assignment, which is an e_mux
  WR_to_the_SelectMuxChannel <= NOT ((internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave AND cpu_data_master_write));
  shifted_address_to_SelectMuxChannel_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_SelectMuxChannel_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SelectMuxChannel_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SelectMuxChannel_avalon_slave_end_xfer <= SelectMuxChannel_avalon_slave_end_xfer;
    end if;

  end process;

  --SelectMuxChannel_avalon_slave_waits_for_read in a cycle, which is an e_mux
  SelectMuxChannel_avalon_slave_waits_for_read <= SelectMuxChannel_avalon_slave_in_a_read_cycle AND SelectMuxChannel_avalon_slave_begins_xfer;
  --SelectMuxChannel_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  SelectMuxChannel_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SelectMuxChannel_avalon_slave_in_a_read_cycle;
  --SelectMuxChannel_avalon_slave_waits_for_write in a cycle, which is an e_mux
  SelectMuxChannel_avalon_slave_waits_for_write <= SelectMuxChannel_avalon_slave_in_a_write_cycle AND wait_for_SelectMuxChannel_avalon_slave_counter;
  --SelectMuxChannel_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  SelectMuxChannel_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SelectMuxChannel_avalon_slave_in_a_write_cycle;
  internal_SelectMuxChannel_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SelectMuxChannel_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SelectMuxChannel_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      SelectMuxChannel_avalon_slave_wait_counter <= SelectMuxChannel_avalon_slave_counter_load_value;
    end if;

  end process;

  SelectMuxChannel_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((SelectMuxChannel_avalon_slave_in_a_write_cycle AND SelectMuxChannel_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_SelectMuxChannel_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SelectMuxChannel_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_SelectMuxChannel_avalon_slave_counter <= SelectMuxChannel_avalon_slave_begins_xfer OR NOT internal_SelectMuxChannel_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  SelectMuxChannel_avalon_slave_wait_counter_eq_0 <= internal_SelectMuxChannel_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_granted_SelectMuxChannel_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_SelectMuxChannel_avalon_slave <= internal_cpu_data_master_requests_SelectMuxChannel_avalon_slave;
--synthesis translate_off
    --SelectMuxChannel/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Synthesizer_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal Data_from_the_Synthesizer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal Data_from_the_Synthesizer_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_Synthesizer : OUT STD_LOGIC;
                 signal Synthesizer_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal cpu_data_master_granted_Synthesizer_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_Synthesizer_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Synthesizer_avalon_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_Synthesizer_avalon_slave : OUT STD_LOGIC;
                 signal d1_Synthesizer_avalon_slave_end_xfer : OUT STD_LOGIC
              );
end entity Synthesizer_avalon_slave_arbitrator;


architecture europa of Synthesizer_avalon_slave_arbitrator is
                signal Synthesizer_avalon_slave_allgrants :  STD_LOGIC;
                signal Synthesizer_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Synthesizer_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Synthesizer_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal Synthesizer_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal Synthesizer_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal Synthesizer_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal Synthesizer_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal Synthesizer_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Synthesizer_avalon_slave_begins_xfer :  STD_LOGIC;
                signal Synthesizer_avalon_slave_counter_load_value :  STD_LOGIC;
                signal Synthesizer_avalon_slave_end_xfer :  STD_LOGIC;
                signal Synthesizer_avalon_slave_firsttransfer :  STD_LOGIC;
                signal Synthesizer_avalon_slave_grant_vector :  STD_LOGIC;
                signal Synthesizer_avalon_slave_in_a_read_cycle :  STD_LOGIC;
                signal Synthesizer_avalon_slave_in_a_write_cycle :  STD_LOGIC;
                signal Synthesizer_avalon_slave_master_qreq_vector :  STD_LOGIC;
                signal Synthesizer_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Synthesizer_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal Synthesizer_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Synthesizer_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Synthesizer_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Synthesizer_avalon_slave_wait_counter :  STD_LOGIC;
                signal Synthesizer_avalon_slave_waits_for_read :  STD_LOGIC;
                signal Synthesizer_avalon_slave_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_Synthesizer_avalon_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Synthesizer_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_Synthesizer_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_Synthesizer_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_Synthesizer_avalon_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_Synthesizer_avalon_slave :  STD_LOGIC;
                signal shifted_address_to_Synthesizer_avalon_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_Synthesizer_avalon_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Synthesizer_avalon_slave_end_xfer;
    end if;

  end process;

  Synthesizer_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_Synthesizer_avalon_slave);
  --assign Data_from_the_Synthesizer_from_sa = Data_from_the_Synthesizer so that symbol knows where to group signals which may go to master only, which is an e_assign
  Data_from_the_Synthesizer_from_sa <= Data_from_the_Synthesizer;
  internal_cpu_data_master_requests_Synthesizer_avalon_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 2) & std_logic_vector'("00")) = std_logic_vector'("100000001100110101100")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --Synthesizer_avalon_slave_arb_share_counter set values, which is an e_mux
  Synthesizer_avalon_slave_arb_share_set_values <= std_logic'('1');
  --Synthesizer_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  Synthesizer_avalon_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_Synthesizer_avalon_slave;
  --Synthesizer_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Synthesizer_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Synthesizer_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  Synthesizer_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(Synthesizer_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Synthesizer_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(Synthesizer_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Synthesizer_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --Synthesizer_avalon_slave_allgrants all slave grants, which is an e_mux
  Synthesizer_avalon_slave_allgrants <= Synthesizer_avalon_slave_grant_vector;
  --Synthesizer_avalon_slave_end_xfer assignment, which is an e_assign
  Synthesizer_avalon_slave_end_xfer <= NOT ((Synthesizer_avalon_slave_waits_for_read OR Synthesizer_avalon_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Synthesizer_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Synthesizer_avalon_slave <= Synthesizer_avalon_slave_end_xfer AND (((NOT Synthesizer_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Synthesizer_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Synthesizer_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Synthesizer_avalon_slave AND Synthesizer_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Synthesizer_avalon_slave AND NOT Synthesizer_avalon_slave_non_bursting_master_requests));
  --Synthesizer_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Synthesizer_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(Synthesizer_avalon_slave_arb_counter_enable) = '1' then 
        Synthesizer_avalon_slave_arb_share_counter <= Synthesizer_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Synthesizer_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Synthesizer_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Synthesizer_avalon_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Synthesizer_avalon_slave)) OR ((end_xfer_arb_share_counter_term_Synthesizer_avalon_slave AND NOT Synthesizer_avalon_slave_non_bursting_master_requests)))) = '1' then 
        Synthesizer_avalon_slave_slavearbiterlockenable <= Synthesizer_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master Synthesizer/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= Synthesizer_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --Synthesizer_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Synthesizer_avalon_slave_slavearbiterlockenable2 <= Synthesizer_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master Synthesizer/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= Synthesizer_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --Synthesizer_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Synthesizer_avalon_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_Synthesizer_avalon_slave <= internal_cpu_data_master_requests_Synthesizer_avalon_slave AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_Synthesizer_avalon_slave, which is an e_mux
  cpu_data_master_read_data_valid_Synthesizer_avalon_slave <= (internal_cpu_data_master_granted_Synthesizer_avalon_slave AND cpu_data_master_read) AND NOT Synthesizer_avalon_slave_waits_for_read;
  --master is always granted when requested
  internal_cpu_data_master_granted_Synthesizer_avalon_slave <= internal_cpu_data_master_qualified_request_Synthesizer_avalon_slave;
  --cpu/data_master saved-grant Synthesizer/avalon_slave, which is an e_assign
  cpu_data_master_saved_grant_Synthesizer_avalon_slave <= internal_cpu_data_master_requests_Synthesizer_avalon_slave;
  --allow new arb cycle for Synthesizer/avalon_slave, which is an e_assign
  Synthesizer_avalon_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Synthesizer_avalon_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Synthesizer_avalon_slave_master_qreq_vector <= std_logic'('1');
  --Synthesizer_avalon_slave_firsttransfer first transaction, which is an e_assign
  Synthesizer_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Synthesizer_avalon_slave_begins_xfer) = '1'), Synthesizer_avalon_slave_unreg_firsttransfer, Synthesizer_avalon_slave_reg_firsttransfer);
  --Synthesizer_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  Synthesizer_avalon_slave_unreg_firsttransfer <= NOT ((Synthesizer_avalon_slave_slavearbiterlockenable AND Synthesizer_avalon_slave_any_continuerequest));
  --Synthesizer_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Synthesizer_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Synthesizer_avalon_slave_begins_xfer) = '1' then 
        Synthesizer_avalon_slave_reg_firsttransfer <= Synthesizer_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Synthesizer_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Synthesizer_avalon_slave_beginbursttransfer_internal <= Synthesizer_avalon_slave_begins_xfer;
  --~RD_to_the_Synthesizer assignment, which is an e_mux
  RD_to_the_Synthesizer <= NOT ((internal_cpu_data_master_granted_Synthesizer_avalon_slave AND cpu_data_master_read));
  shifted_address_to_Synthesizer_avalon_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --d1_Synthesizer_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Synthesizer_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Synthesizer_avalon_slave_end_xfer <= Synthesizer_avalon_slave_end_xfer;
    end if;

  end process;

  --Synthesizer_avalon_slave_waits_for_read in a cycle, which is an e_mux
  Synthesizer_avalon_slave_waits_for_read <= Synthesizer_avalon_slave_in_a_read_cycle AND wait_for_Synthesizer_avalon_slave_counter;
  --Synthesizer_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  Synthesizer_avalon_slave_in_a_read_cycle <= internal_cpu_data_master_granted_Synthesizer_avalon_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Synthesizer_avalon_slave_in_a_read_cycle;
  --Synthesizer_avalon_slave_waits_for_write in a cycle, which is an e_mux
  Synthesizer_avalon_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Synthesizer_avalon_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Synthesizer_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  Synthesizer_avalon_slave_in_a_write_cycle <= internal_cpu_data_master_granted_Synthesizer_avalon_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Synthesizer_avalon_slave_in_a_write_cycle;
  internal_Synthesizer_avalon_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Synthesizer_avalon_slave_wait_counter))) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Synthesizer_avalon_slave_wait_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      Synthesizer_avalon_slave_wait_counter <= Synthesizer_avalon_slave_counter_load_value;
    end if;

  end process;

  Synthesizer_avalon_slave_counter_load_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((Synthesizer_avalon_slave_in_a_read_cycle AND Synthesizer_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_Synthesizer_avalon_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Synthesizer_avalon_slave_wait_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  wait_for_Synthesizer_avalon_slave_counter <= Synthesizer_avalon_slave_begins_xfer OR NOT internal_Synthesizer_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  Synthesizer_avalon_slave_wait_counter_eq_0 <= internal_Synthesizer_avalon_slave_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_Synthesizer_avalon_slave <= internal_cpu_data_master_granted_Synthesizer_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_Synthesizer_avalon_slave <= internal_cpu_data_master_qualified_request_Synthesizer_avalon_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_Synthesizer_avalon_slave <= internal_cpu_data_master_requests_Synthesizer_avalon_slave;
--synthesis translate_off
    --Synthesizer/avalon_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity TriStateBridge_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal SRAM_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal address_to_the_SRAM : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                 signal be_n_to_the_SRAM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_granted_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_SRAM_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_SRAM_s1 : OUT STD_LOGIC;
                 signal d1_TriStateBridge_avalon_slave_end_xfer : OUT STD_LOGIC;
                 signal data_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal incoming_data_to_and_from_the_SRAM : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal read_n_to_the_SRAM : OUT STD_LOGIC;
                 signal select_n_to_the_SRAM : OUT STD_LOGIC;
                 signal write_n_to_the_SRAM : OUT STD_LOGIC
              );
end entity TriStateBridge_avalon_slave_arbitrator;


architecture europa of TriStateBridge_avalon_slave_arbitrator is
                signal SRAM_s1_counter_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_s1_in_a_read_cycle :  STD_LOGIC;
                signal SRAM_s1_in_a_write_cycle :  STD_LOGIC;
                signal SRAM_s1_wait_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_s1_waits_for_read :  STD_LOGIC;
                signal SRAM_s1_waits_for_write :  STD_LOGIC;
                signal SRAM_s1_with_write_latency :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_allgrants :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_arb_share_counter :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_arb_share_set_values :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_arbitration_holdoff_internal :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_begins_xfer :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal TriStateBridge_avalon_slave_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_end_xfer :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_firsttransfer :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_read_pending :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal TriStateBridge_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal TriStateBridge_avalon_slave_write_pending :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SRAM_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_read_data_valid_SRAM_s1_shift_register_in :  STD_LOGIC;
                signal cpu_data_master_saved_grant_SRAM_s1 :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_SRAM_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_read_data_valid_SRAM_s1_shift_register_in :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_SRAM_s1 :  STD_LOGIC;
                signal d1_in_a_write_cycle :  STD_LOGIC;
                signal d1_outgoing_data_to_and_from_the_SRAM :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_SRAM_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_SRAM_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_SRAM_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_SRAM_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_SRAM_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_SRAM_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_SRAM_s1 :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_SRAM_s1 :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_SRAM_s1 :  STD_LOGIC;
                signal outgoing_data_to_and_from_the_SRAM :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal p1_address_to_the_SRAM :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal p1_be_n_to_the_SRAM :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p1_cpu_data_master_read_data_valid_SRAM_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_instruction_master_read_data_valid_SRAM_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_read_n_to_the_SRAM :  STD_LOGIC;
                signal p1_select_n_to_the_SRAM :  STD_LOGIC;
                signal p1_write_n_to_the_SRAM :  STD_LOGIC;
                signal time_to_write :  STD_LOGIC;
                signal wait_for_SRAM_s1_counter :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of address_to_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of be_n_to_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_in_a_write_cycle : signal is "FAST_OUTPUT_ENABLE_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_outgoing_data_to_and_from_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of incoming_data_to_and_from_the_SRAM : signal is "FAST_INPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of read_n_to_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of select_n_to_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of write_n_to_the_SRAM : signal is "FAST_OUTPUT_REGISTER=ON";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT TriStateBridge_avalon_slave_end_xfer;
    end if;

  end process;

  TriStateBridge_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_SRAM_s1 OR internal_cpu_instruction_master_qualified_request_SRAM_s1));
  internal_cpu_data_master_requests_SRAM_s1 <= to_std_logic(((Std_Logic_Vector'(A_ToStdLogicVector(cpu_data_master_address_to_slave(20)) & std_logic_vector'("00000000000000000000")) = std_logic_vector'("000000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --~select_n_to_the_SRAM of type chipselect to ~p1_select_n_to_the_SRAM, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      select_n_to_the_SRAM <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      select_n_to_the_SRAM <= p1_select_n_to_the_SRAM;
    end if;

  end process;

  TriStateBridge_avalon_slave_write_pending <= std_logic'('0');
  --TriStateBridge/avalon_slave read pending calc, which is an e_assign
  TriStateBridge_avalon_slave_read_pending <= std_logic'('0');
  --TriStateBridge_avalon_slave_arb_share_counter set values, which is an e_mux
  TriStateBridge_avalon_slave_arb_share_set_values <= std_logic'('1');
  --TriStateBridge_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  TriStateBridge_avalon_slave_non_bursting_master_requests <= ((internal_cpu_data_master_requests_SRAM_s1 OR internal_cpu_instruction_master_requests_SRAM_s1) OR internal_cpu_data_master_requests_SRAM_s1) OR internal_cpu_instruction_master_requests_SRAM_s1;
  --TriStateBridge_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  TriStateBridge_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --TriStateBridge_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  TriStateBridge_avalon_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(TriStateBridge_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(TriStateBridge_avalon_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(TriStateBridge_avalon_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(TriStateBridge_avalon_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --TriStateBridge_avalon_slave_allgrants all slave grants, which is an e_mux
  TriStateBridge_avalon_slave_allgrants <= (((or_reduce(TriStateBridge_avalon_slave_grant_vector)) OR (or_reduce(TriStateBridge_avalon_slave_grant_vector))) OR (or_reduce(TriStateBridge_avalon_slave_grant_vector))) OR (or_reduce(TriStateBridge_avalon_slave_grant_vector));
  --TriStateBridge_avalon_slave_end_xfer assignment, which is an e_assign
  TriStateBridge_avalon_slave_end_xfer <= NOT ((SRAM_s1_waits_for_read OR SRAM_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave <= TriStateBridge_avalon_slave_end_xfer AND (((NOT TriStateBridge_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --TriStateBridge_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  TriStateBridge_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave AND TriStateBridge_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave AND NOT TriStateBridge_avalon_slave_non_bursting_master_requests));
  --TriStateBridge_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      TriStateBridge_avalon_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(TriStateBridge_avalon_slave_arb_counter_enable) = '1' then 
        TriStateBridge_avalon_slave_arb_share_counter <= TriStateBridge_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --TriStateBridge_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      TriStateBridge_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(TriStateBridge_avalon_slave_master_qreq_vector) AND end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave)) OR ((end_xfer_arb_share_counter_term_TriStateBridge_avalon_slave AND NOT TriStateBridge_avalon_slave_non_bursting_master_requests)))) = '1' then 
        TriStateBridge_avalon_slave_slavearbiterlockenable <= TriStateBridge_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master TriStateBridge/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= TriStateBridge_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --TriStateBridge_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  TriStateBridge_avalon_slave_slavearbiterlockenable2 <= TriStateBridge_avalon_slave_arb_share_counter_next_value;
  --cpu/data_master TriStateBridge/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= TriStateBridge_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master TriStateBridge/avalon_slave arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= TriStateBridge_avalon_slave_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master TriStateBridge/avalon_slave arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= TriStateBridge_avalon_slave_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted SRAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_SRAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_SRAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_SRAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((TriStateBridge_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_SRAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_SRAM_s1))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_SRAM_s1 AND internal_cpu_instruction_master_requests_SRAM_s1;
  --TriStateBridge_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  TriStateBridge_avalon_slave_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_SRAM_s1 <= internal_cpu_data_master_requests_SRAM_s1 AND NOT (((((cpu_data_master_read AND (((TriStateBridge_avalon_slave_write_pending OR (TriStateBridge_avalon_slave_read_pending)) OR to_std_logic(((std_logic_vector'("00000000000000000000000000000010")<(std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter))))))))) OR (((TriStateBridge_avalon_slave_read_pending) AND cpu_data_master_write))) OR cpu_instruction_master_arbiterlock));
  --cpu_data_master_read_data_valid_SRAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_data_master_read_data_valid_SRAM_s1_shift_register_in <= (internal_cpu_data_master_granted_SRAM_s1 AND cpu_data_master_read) AND NOT SRAM_s1_waits_for_read;
  --shift register p1 cpu_data_master_read_data_valid_SRAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_data_master_read_data_valid_SRAM_s1_shift_register <= A_EXT ((cpu_data_master_read_data_valid_SRAM_s1_shift_register & A_ToStdLogicVector(cpu_data_master_read_data_valid_SRAM_s1_shift_register_in)), 2);
  --cpu_data_master_read_data_valid_SRAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_data_valid_SRAM_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_data_master_read_data_valid_SRAM_s1_shift_register <= p1_cpu_data_master_read_data_valid_SRAM_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_data_master_read_data_valid_SRAM_s1, which is an e_mux
  cpu_data_master_read_data_valid_SRAM_s1 <= cpu_data_master_read_data_valid_SRAM_s1_shift_register(1);
  --data_to_and_from_the_SRAM register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      incoming_data_to_and_from_the_SRAM <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      incoming_data_to_and_from_the_SRAM <= data_to_and_from_the_SRAM;
    end if;

  end process;

  --SRAM_s1_with_write_latency assignment, which is an e_assign
  SRAM_s1_with_write_latency <= in_a_write_cycle AND ((internal_cpu_data_master_qualified_request_SRAM_s1 OR internal_cpu_instruction_master_qualified_request_SRAM_s1));
  --time to write the data, which is an e_mux
  time_to_write <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((SRAM_s1_with_write_latency)) = '1'), std_logic_vector'("00000000000000000000000000000001"), std_logic_vector'("00000000000000000000000000000000")));
  --d1_outgoing_data_to_and_from_the_SRAM register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_outgoing_data_to_and_from_the_SRAM <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      d1_outgoing_data_to_and_from_the_SRAM <= outgoing_data_to_and_from_the_SRAM;
    end if;

  end process;

  --write cycle delayed by 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_in_a_write_cycle <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_in_a_write_cycle <= time_to_write;
    end if;

  end process;

  --d1_outgoing_data_to_and_from_the_SRAM tristate driver, which is an e_assign
  data_to_and_from_the_SRAM <= A_WE_StdLogicVector((std_logic'((d1_in_a_write_cycle)) = '1'), d1_outgoing_data_to_and_from_the_SRAM, A_REP(std_logic'('Z'), 32));
  --outgoing_data_to_and_from_the_SRAM mux, which is an e_mux
  outgoing_data_to_and_from_the_SRAM <= cpu_data_master_writedata;
  internal_cpu_instruction_master_requests_SRAM_s1 <= ((to_std_logic(((Std_Logic_Vector'(A_ToStdLogicVector(cpu_instruction_master_address_to_slave(20)) & std_logic_vector'("00000000000000000000")) = std_logic_vector'("000000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted SRAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_SRAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_SRAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_SRAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((TriStateBridge_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_SRAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_SRAM_s1))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_SRAM_s1 AND internal_cpu_data_master_requests_SRAM_s1;
  internal_cpu_instruction_master_qualified_request_SRAM_s1 <= internal_cpu_instruction_master_requests_SRAM_s1 AND NOT ((((cpu_instruction_master_read AND (((TriStateBridge_avalon_slave_write_pending OR (TriStateBridge_avalon_slave_read_pending)) OR to_std_logic(((std_logic_vector'("00000000000000000000000000000010")<(std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter))))))))) OR cpu_data_master_arbiterlock));
  --cpu_instruction_master_read_data_valid_SRAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_instruction_master_read_data_valid_SRAM_s1_shift_register_in <= (internal_cpu_instruction_master_granted_SRAM_s1 AND cpu_instruction_master_read) AND NOT SRAM_s1_waits_for_read;
  --shift register p1 cpu_instruction_master_read_data_valid_SRAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_instruction_master_read_data_valid_SRAM_s1_shift_register <= A_EXT ((cpu_instruction_master_read_data_valid_SRAM_s1_shift_register & A_ToStdLogicVector(cpu_instruction_master_read_data_valid_SRAM_s1_shift_register_in)), 2);
  --cpu_instruction_master_read_data_valid_SRAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_read_data_valid_SRAM_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_instruction_master_read_data_valid_SRAM_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_SRAM_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_instruction_master_read_data_valid_SRAM_s1, which is an e_mux
  cpu_instruction_master_read_data_valid_SRAM_s1 <= cpu_instruction_master_read_data_valid_SRAM_s1_shift_register(1);
  --allow new arb cycle for TriStateBridge/avalon_slave, which is an e_assign
  TriStateBridge_avalon_slave_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for SRAM/s1, which is an e_assign
  TriStateBridge_avalon_slave_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_SRAM_s1;
  --cpu/instruction_master grant SRAM/s1, which is an e_assign
  internal_cpu_instruction_master_granted_SRAM_s1 <= TriStateBridge_avalon_slave_grant_vector(0);
  --cpu/instruction_master saved-grant SRAM/s1, which is an e_assign
  cpu_instruction_master_saved_grant_SRAM_s1 <= TriStateBridge_avalon_slave_arb_winner(0) AND internal_cpu_instruction_master_requests_SRAM_s1;
  --cpu/data_master assignment into master qualified-requests vector for SRAM/s1, which is an e_assign
  TriStateBridge_avalon_slave_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_SRAM_s1;
  --cpu/data_master grant SRAM/s1, which is an e_assign
  internal_cpu_data_master_granted_SRAM_s1 <= TriStateBridge_avalon_slave_grant_vector(1);
  --cpu/data_master saved-grant SRAM/s1, which is an e_assign
  cpu_data_master_saved_grant_SRAM_s1 <= TriStateBridge_avalon_slave_arb_winner(1) AND internal_cpu_data_master_requests_SRAM_s1;
  --TriStateBridge/avalon_slave chosen-master double-vector, which is an e_assign
  TriStateBridge_avalon_slave_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((TriStateBridge_avalon_slave_master_qreq_vector & TriStateBridge_avalon_slave_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT TriStateBridge_avalon_slave_master_qreq_vector & NOT TriStateBridge_avalon_slave_master_qreq_vector))) + (std_logic_vector'("000") & (TriStateBridge_avalon_slave_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  TriStateBridge_avalon_slave_arb_winner <= A_WE_StdLogicVector((std_logic'(((TriStateBridge_avalon_slave_allow_new_arb_cycle AND or_reduce(TriStateBridge_avalon_slave_grant_vector)))) = '1'), TriStateBridge_avalon_slave_grant_vector, TriStateBridge_avalon_slave_saved_chosen_master_vector);
  --saved TriStateBridge_avalon_slave_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      TriStateBridge_avalon_slave_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(TriStateBridge_avalon_slave_allow_new_arb_cycle) = '1' then 
        TriStateBridge_avalon_slave_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(TriStateBridge_avalon_slave_grant_vector)) = '1'), TriStateBridge_avalon_slave_grant_vector, TriStateBridge_avalon_slave_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  TriStateBridge_avalon_slave_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((TriStateBridge_avalon_slave_chosen_master_double_vector(1) OR TriStateBridge_avalon_slave_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((TriStateBridge_avalon_slave_chosen_master_double_vector(0) OR TriStateBridge_avalon_slave_chosen_master_double_vector(2)))));
  --TriStateBridge/avalon_slave chosen master rotated left, which is an e_assign
  TriStateBridge_avalon_slave_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(TriStateBridge_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(TriStateBridge_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --TriStateBridge/avalon_slave's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      TriStateBridge_avalon_slave_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(TriStateBridge_avalon_slave_grant_vector)) = '1' then 
        TriStateBridge_avalon_slave_arb_addend <= A_WE_StdLogicVector((std_logic'(TriStateBridge_avalon_slave_end_xfer) = '1'), TriStateBridge_avalon_slave_chosen_master_rot_left, TriStateBridge_avalon_slave_grant_vector);
      end if;
    end if;

  end process;

  p1_select_n_to_the_SRAM <= NOT ((internal_cpu_data_master_granted_SRAM_s1 OR internal_cpu_instruction_master_granted_SRAM_s1));
  --TriStateBridge_avalon_slave_firsttransfer first transaction, which is an e_assign
  TriStateBridge_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(TriStateBridge_avalon_slave_begins_xfer) = '1'), TriStateBridge_avalon_slave_unreg_firsttransfer, TriStateBridge_avalon_slave_reg_firsttransfer);
  --TriStateBridge_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  TriStateBridge_avalon_slave_unreg_firsttransfer <= NOT ((TriStateBridge_avalon_slave_slavearbiterlockenable AND TriStateBridge_avalon_slave_any_continuerequest));
  --TriStateBridge_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      TriStateBridge_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(TriStateBridge_avalon_slave_begins_xfer) = '1' then 
        TriStateBridge_avalon_slave_reg_firsttransfer <= TriStateBridge_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --TriStateBridge_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  TriStateBridge_avalon_slave_beginbursttransfer_internal <= TriStateBridge_avalon_slave_begins_xfer;
  --TriStateBridge_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  TriStateBridge_avalon_slave_arbitration_holdoff_internal <= TriStateBridge_avalon_slave_begins_xfer AND TriStateBridge_avalon_slave_firsttransfer;
  --~read_n_to_the_SRAM of type read to ~p1_read_n_to_the_SRAM, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      read_n_to_the_SRAM <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      read_n_to_the_SRAM <= p1_read_n_to_the_SRAM;
    end if;

  end process;

  --~p1_read_n_to_the_SRAM assignment, which is an e_mux
  p1_read_n_to_the_SRAM <= NOT ((((((internal_cpu_data_master_granted_SRAM_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_SRAM_s1 AND cpu_instruction_master_read)))) AND NOT TriStateBridge_avalon_slave_begins_xfer));
  --~write_n_to_the_SRAM of type write to ~p1_write_n_to_the_SRAM, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      write_n_to_the_SRAM <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      write_n_to_the_SRAM <= p1_write_n_to_the_SRAM;
    end if;

  end process;

  --~be_n_to_the_SRAM of type byteenable to ~p1_be_n_to_the_SRAM, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      be_n_to_the_SRAM <= A_EXT (NOT std_logic_vector'("00000000000000000000000000000000"), 4);
    elsif clk'event and clk = '1' then
      be_n_to_the_SRAM <= p1_be_n_to_the_SRAM;
    end if;

  end process;

  --~p1_write_n_to_the_SRAM assignment, which is an e_mux
  p1_write_n_to_the_SRAM <= NOT (((((internal_cpu_data_master_granted_SRAM_s1 AND cpu_data_master_write)) AND NOT TriStateBridge_avalon_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (SRAM_s1_wait_counter))>=std_logic_vector'("00000000000000000000000000000001"))))));
  --address_to_the_SRAM of type address to p1_address_to_the_SRAM, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      address_to_the_SRAM <= std_logic_vector'("00000000000000000000");
    elsif clk'event and clk = '1' then
      address_to_the_SRAM <= p1_address_to_the_SRAM;
    end if;

  end process;

  --p1_address_to_the_SRAM mux, which is an e_mux
  p1_address_to_the_SRAM <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_SRAM_s1)) = '1'), cpu_data_master_address_to_slave, cpu_instruction_master_address_to_slave), 20);
  --d1_TriStateBridge_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_TriStateBridge_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_TriStateBridge_avalon_slave_end_xfer <= TriStateBridge_avalon_slave_end_xfer;
    end if;

  end process;

  --SRAM_s1_waits_for_read in a cycle, which is an e_mux
  SRAM_s1_waits_for_read <= SRAM_s1_in_a_read_cycle AND wait_for_SRAM_s1_counter;
  --SRAM_s1_in_a_read_cycle assignment, which is an e_assign
  SRAM_s1_in_a_read_cycle <= ((internal_cpu_data_master_granted_SRAM_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_SRAM_s1 AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SRAM_s1_in_a_read_cycle;
  --SRAM_s1_waits_for_write in a cycle, which is an e_mux
  SRAM_s1_waits_for_write <= SRAM_s1_in_a_write_cycle AND wait_for_SRAM_s1_counter;
  --SRAM_s1_in_a_write_cycle assignment, which is an e_assign
  SRAM_s1_in_a_write_cycle <= internal_cpu_data_master_granted_SRAM_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SRAM_s1_in_a_write_cycle;
  internal_SRAM_s1_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("000000000000000000000000000000") & (SRAM_s1_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_s1_wait_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      SRAM_s1_wait_counter <= SRAM_s1_counter_load_value;
    end if;

  end process;

  SRAM_s1_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((SRAM_s1_in_a_write_cycle AND TriStateBridge_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'(((SRAM_s1_in_a_read_cycle AND TriStateBridge_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((NOT internal_SRAM_s1_wait_counter_eq_0)) = '1'), ((std_logic_vector'("0000000000000000000000000000000") & (SRAM_s1_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 2);
  wait_for_SRAM_s1_counter <= TriStateBridge_avalon_slave_begins_xfer OR NOT internal_SRAM_s1_wait_counter_eq_0;
  --~p1_be_n_to_the_SRAM byte enable port mux, which is an e_mux
  p1_be_n_to_the_SRAM <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_SRAM_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 4);
  --vhdl renameroo for output signals
  SRAM_s1_wait_counter_eq_0 <= internal_SRAM_s1_wait_counter_eq_0;
  --vhdl renameroo for output signals
  cpu_data_master_granted_SRAM_s1 <= internal_cpu_data_master_granted_SRAM_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_SRAM_s1 <= internal_cpu_data_master_qualified_request_SRAM_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_SRAM_s1 <= internal_cpu_data_master_requests_SRAM_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_SRAM_s1 <= internal_cpu_instruction_master_granted_SRAM_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_SRAM_s1 <= internal_cpu_instruction_master_qualified_request_SRAM_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_SRAM_s1 <= internal_cpu_instruction_master_requests_SRAM_s1;
--synthesis translate_off
    --SRAM/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_SRAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_SRAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_SRAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_SRAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TriStateBridge_bridge_arbitrator is 
end entity TriStateBridge_bridge_arbitrator;


architecture europa of TriStateBridge_bridge_arbitrator is

begin


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity UART_1_s1_arbitrator is 
        port (
              -- inputs:
                 signal UART_1_s1_dataavailable : IN STD_LOGIC;
                 signal UART_1_s1_irq : IN STD_LOGIC;
                 signal UART_1_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal UART_1_s1_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal UART_1_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal UART_1_s1_begintransfer : OUT STD_LOGIC;
                 signal UART_1_s1_chipselect : OUT STD_LOGIC;
                 signal UART_1_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal UART_1_s1_irq_from_sa : OUT STD_LOGIC;
                 signal UART_1_s1_read_n : OUT STD_LOGIC;
                 signal UART_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal UART_1_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal UART_1_s1_reset_n : OUT STD_LOGIC;
                 signal UART_1_s1_write_n : OUT STD_LOGIC;
                 signal UART_1_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_granted_UART_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_UART_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_UART_1_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_UART_1_s1 : OUT STD_LOGIC;
                 signal d1_UART_1_s1_end_xfer : OUT STD_LOGIC
              );
end entity UART_1_s1_arbitrator;


architecture europa of UART_1_s1_arbitrator is
                signal UART_1_s1_allgrants :  STD_LOGIC;
                signal UART_1_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal UART_1_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal UART_1_s1_any_continuerequest :  STD_LOGIC;
                signal UART_1_s1_arb_counter_enable :  STD_LOGIC;
                signal UART_1_s1_arb_share_counter :  STD_LOGIC;
                signal UART_1_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal UART_1_s1_arb_share_set_values :  STD_LOGIC;
                signal UART_1_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal UART_1_s1_begins_xfer :  STD_LOGIC;
                signal UART_1_s1_end_xfer :  STD_LOGIC;
                signal UART_1_s1_firsttransfer :  STD_LOGIC;
                signal UART_1_s1_grant_vector :  STD_LOGIC;
                signal UART_1_s1_in_a_read_cycle :  STD_LOGIC;
                signal UART_1_s1_in_a_write_cycle :  STD_LOGIC;
                signal UART_1_s1_master_qreq_vector :  STD_LOGIC;
                signal UART_1_s1_non_bursting_master_requests :  STD_LOGIC;
                signal UART_1_s1_reg_firsttransfer :  STD_LOGIC;
                signal UART_1_s1_slavearbiterlockenable :  STD_LOGIC;
                signal UART_1_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal UART_1_s1_unreg_firsttransfer :  STD_LOGIC;
                signal UART_1_s1_waits_for_read :  STD_LOGIC;
                signal UART_1_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_UART_1_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_UART_1_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_UART_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_UART_1_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_UART_1_s1 :  STD_LOGIC;
                signal shifted_address_to_UART_1_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_UART_1_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT UART_1_s1_end_xfer;
    end if;

  end process;

  UART_1_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_UART_1_s1);
  --assign UART_1_s1_readdata_from_sa = UART_1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_1_s1_readdata_from_sa <= UART_1_s1_readdata;
  internal_cpu_data_master_requests_UART_1_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100011100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign UART_1_s1_dataavailable_from_sa = UART_1_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_1_s1_dataavailable_from_sa <= UART_1_s1_dataavailable;
  --assign UART_1_s1_readyfordata_from_sa = UART_1_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_1_s1_readyfordata_from_sa <= UART_1_s1_readyfordata;
  --UART_1_s1_arb_share_counter set values, which is an e_mux
  UART_1_s1_arb_share_set_values <= std_logic'('1');
  --UART_1_s1_non_bursting_master_requests mux, which is an e_mux
  UART_1_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_UART_1_s1;
  --UART_1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  UART_1_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --UART_1_s1_arb_share_counter_next_value assignment, which is an e_assign
  UART_1_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(UART_1_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(UART_1_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(UART_1_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(UART_1_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --UART_1_s1_allgrants all slave grants, which is an e_mux
  UART_1_s1_allgrants <= UART_1_s1_grant_vector;
  --UART_1_s1_end_xfer assignment, which is an e_assign
  UART_1_s1_end_xfer <= NOT ((UART_1_s1_waits_for_read OR UART_1_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_UART_1_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_UART_1_s1 <= UART_1_s1_end_xfer AND (((NOT UART_1_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --UART_1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  UART_1_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_UART_1_s1 AND UART_1_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_UART_1_s1 AND NOT UART_1_s1_non_bursting_master_requests));
  --UART_1_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_1_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(UART_1_s1_arb_counter_enable) = '1' then 
        UART_1_s1_arb_share_counter <= UART_1_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --UART_1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_1_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((UART_1_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_UART_1_s1)) OR ((end_xfer_arb_share_counter_term_UART_1_s1 AND NOT UART_1_s1_non_bursting_master_requests)))) = '1' then 
        UART_1_s1_slavearbiterlockenable <= UART_1_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master UART_1/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= UART_1_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --UART_1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  UART_1_s1_slavearbiterlockenable2 <= UART_1_s1_arb_share_counter_next_value;
  --cpu/data_master UART_1/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= UART_1_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --UART_1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  UART_1_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_UART_1_s1 <= internal_cpu_data_master_requests_UART_1_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_UART_1_s1, which is an e_mux
  cpu_data_master_read_data_valid_UART_1_s1 <= (internal_cpu_data_master_granted_UART_1_s1 AND cpu_data_master_read) AND NOT UART_1_s1_waits_for_read;
  --UART_1_s1_writedata mux, which is an e_mux
  UART_1_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_UART_1_s1 <= internal_cpu_data_master_qualified_request_UART_1_s1;
  --cpu/data_master saved-grant UART_1/s1, which is an e_assign
  cpu_data_master_saved_grant_UART_1_s1 <= internal_cpu_data_master_requests_UART_1_s1;
  --allow new arb cycle for UART_1/s1, which is an e_assign
  UART_1_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  UART_1_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  UART_1_s1_master_qreq_vector <= std_logic'('1');
  UART_1_s1_begintransfer <= UART_1_s1_begins_xfer;
  --UART_1_s1_reset_n assignment, which is an e_assign
  UART_1_s1_reset_n <= reset_n;
  UART_1_s1_chipselect <= internal_cpu_data_master_granted_UART_1_s1;
  --UART_1_s1_firsttransfer first transaction, which is an e_assign
  UART_1_s1_firsttransfer <= A_WE_StdLogic((std_logic'(UART_1_s1_begins_xfer) = '1'), UART_1_s1_unreg_firsttransfer, UART_1_s1_reg_firsttransfer);
  --UART_1_s1_unreg_firsttransfer first transaction, which is an e_assign
  UART_1_s1_unreg_firsttransfer <= NOT ((UART_1_s1_slavearbiterlockenable AND UART_1_s1_any_continuerequest));
  --UART_1_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_1_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(UART_1_s1_begins_xfer) = '1' then 
        UART_1_s1_reg_firsttransfer <= UART_1_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --UART_1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  UART_1_s1_beginbursttransfer_internal <= UART_1_s1_begins_xfer;
  --~UART_1_s1_read_n assignment, which is an e_mux
  UART_1_s1_read_n <= NOT ((internal_cpu_data_master_granted_UART_1_s1 AND cpu_data_master_read));
  --~UART_1_s1_write_n assignment, which is an e_mux
  UART_1_s1_write_n <= NOT ((internal_cpu_data_master_granted_UART_1_s1 AND cpu_data_master_write));
  shifted_address_to_UART_1_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --UART_1_s1_address mux, which is an e_mux
  UART_1_s1_address <= A_EXT (A_SRL(shifted_address_to_UART_1_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_UART_1_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_UART_1_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_UART_1_s1_end_xfer <= UART_1_s1_end_xfer;
    end if;

  end process;

  --UART_1_s1_waits_for_read in a cycle, which is an e_mux
  UART_1_s1_waits_for_read <= UART_1_s1_in_a_read_cycle AND UART_1_s1_begins_xfer;
  --UART_1_s1_in_a_read_cycle assignment, which is an e_assign
  UART_1_s1_in_a_read_cycle <= internal_cpu_data_master_granted_UART_1_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= UART_1_s1_in_a_read_cycle;
  --UART_1_s1_waits_for_write in a cycle, which is an e_mux
  UART_1_s1_waits_for_write <= UART_1_s1_in_a_write_cycle AND UART_1_s1_begins_xfer;
  --UART_1_s1_in_a_write_cycle assignment, which is an e_assign
  UART_1_s1_in_a_write_cycle <= internal_cpu_data_master_granted_UART_1_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= UART_1_s1_in_a_write_cycle;
  wait_for_UART_1_s1_counter <= std_logic'('0');
  --assign UART_1_s1_irq_from_sa = UART_1_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_1_s1_irq_from_sa <= UART_1_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_UART_1_s1 <= internal_cpu_data_master_granted_UART_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_UART_1_s1 <= internal_cpu_data_master_qualified_request_UART_1_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_UART_1_s1 <= internal_cpu_data_master_requests_UART_1_s1;
--synthesis translate_off
    --UART_1/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity UART_13_s1_arbitrator is 
        port (
              -- inputs:
                 signal UART_13_s1_dataavailable : IN STD_LOGIC;
                 signal UART_13_s1_irq : IN STD_LOGIC;
                 signal UART_13_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal UART_13_s1_readyfordata : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal UART_13_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal UART_13_s1_begintransfer : OUT STD_LOGIC;
                 signal UART_13_s1_chipselect : OUT STD_LOGIC;
                 signal UART_13_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal UART_13_s1_irq_from_sa : OUT STD_LOGIC;
                 signal UART_13_s1_read_n : OUT STD_LOGIC;
                 signal UART_13_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal UART_13_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal UART_13_s1_reset_n : OUT STD_LOGIC;
                 signal UART_13_s1_write_n : OUT STD_LOGIC;
                 signal UART_13_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_granted_UART_13_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_UART_13_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_UART_13_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_UART_13_s1 : OUT STD_LOGIC;
                 signal d1_UART_13_s1_end_xfer : OUT STD_LOGIC
              );
end entity UART_13_s1_arbitrator;


architecture europa of UART_13_s1_arbitrator is
                signal UART_13_s1_allgrants :  STD_LOGIC;
                signal UART_13_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal UART_13_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal UART_13_s1_any_continuerequest :  STD_LOGIC;
                signal UART_13_s1_arb_counter_enable :  STD_LOGIC;
                signal UART_13_s1_arb_share_counter :  STD_LOGIC;
                signal UART_13_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal UART_13_s1_arb_share_set_values :  STD_LOGIC;
                signal UART_13_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal UART_13_s1_begins_xfer :  STD_LOGIC;
                signal UART_13_s1_end_xfer :  STD_LOGIC;
                signal UART_13_s1_firsttransfer :  STD_LOGIC;
                signal UART_13_s1_grant_vector :  STD_LOGIC;
                signal UART_13_s1_in_a_read_cycle :  STD_LOGIC;
                signal UART_13_s1_in_a_write_cycle :  STD_LOGIC;
                signal UART_13_s1_master_qreq_vector :  STD_LOGIC;
                signal UART_13_s1_non_bursting_master_requests :  STD_LOGIC;
                signal UART_13_s1_reg_firsttransfer :  STD_LOGIC;
                signal UART_13_s1_slavearbiterlockenable :  STD_LOGIC;
                signal UART_13_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal UART_13_s1_unreg_firsttransfer :  STD_LOGIC;
                signal UART_13_s1_waits_for_read :  STD_LOGIC;
                signal UART_13_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_UART_13_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_UART_13_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_UART_13_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_UART_13_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_UART_13_s1 :  STD_LOGIC;
                signal shifted_address_to_UART_13_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_UART_13_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT UART_13_s1_end_xfer;
    end if;

  end process;

  UART_13_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_UART_13_s1);
  --assign UART_13_s1_readdata_from_sa = UART_13_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_13_s1_readdata_from_sa <= UART_13_s1_readdata;
  internal_cpu_data_master_requests_UART_13_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("100000001100100000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign UART_13_s1_dataavailable_from_sa = UART_13_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_13_s1_dataavailable_from_sa <= UART_13_s1_dataavailable;
  --assign UART_13_s1_readyfordata_from_sa = UART_13_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_13_s1_readyfordata_from_sa <= UART_13_s1_readyfordata;
  --UART_13_s1_arb_share_counter set values, which is an e_mux
  UART_13_s1_arb_share_set_values <= std_logic'('1');
  --UART_13_s1_non_bursting_master_requests mux, which is an e_mux
  UART_13_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_UART_13_s1;
  --UART_13_s1_any_bursting_master_saved_grant mux, which is an e_mux
  UART_13_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --UART_13_s1_arb_share_counter_next_value assignment, which is an e_assign
  UART_13_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(UART_13_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(UART_13_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(UART_13_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(UART_13_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --UART_13_s1_allgrants all slave grants, which is an e_mux
  UART_13_s1_allgrants <= UART_13_s1_grant_vector;
  --UART_13_s1_end_xfer assignment, which is an e_assign
  UART_13_s1_end_xfer <= NOT ((UART_13_s1_waits_for_read OR UART_13_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_UART_13_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_UART_13_s1 <= UART_13_s1_end_xfer AND (((NOT UART_13_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --UART_13_s1_arb_share_counter arbitration counter enable, which is an e_assign
  UART_13_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_UART_13_s1 AND UART_13_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_UART_13_s1 AND NOT UART_13_s1_non_bursting_master_requests));
  --UART_13_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_13_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(UART_13_s1_arb_counter_enable) = '1' then 
        UART_13_s1_arb_share_counter <= UART_13_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --UART_13_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_13_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((UART_13_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_UART_13_s1)) OR ((end_xfer_arb_share_counter_term_UART_13_s1 AND NOT UART_13_s1_non_bursting_master_requests)))) = '1' then 
        UART_13_s1_slavearbiterlockenable <= UART_13_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master UART_13/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= UART_13_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --UART_13_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  UART_13_s1_slavearbiterlockenable2 <= UART_13_s1_arb_share_counter_next_value;
  --cpu/data_master UART_13/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= UART_13_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --UART_13_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  UART_13_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_UART_13_s1 <= internal_cpu_data_master_requests_UART_13_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_UART_13_s1, which is an e_mux
  cpu_data_master_read_data_valid_UART_13_s1 <= (internal_cpu_data_master_granted_UART_13_s1 AND cpu_data_master_read) AND NOT UART_13_s1_waits_for_read;
  --UART_13_s1_writedata mux, which is an e_mux
  UART_13_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_UART_13_s1 <= internal_cpu_data_master_qualified_request_UART_13_s1;
  --cpu/data_master saved-grant UART_13/s1, which is an e_assign
  cpu_data_master_saved_grant_UART_13_s1 <= internal_cpu_data_master_requests_UART_13_s1;
  --allow new arb cycle for UART_13/s1, which is an e_assign
  UART_13_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  UART_13_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  UART_13_s1_master_qreq_vector <= std_logic'('1');
  UART_13_s1_begintransfer <= UART_13_s1_begins_xfer;
  --UART_13_s1_reset_n assignment, which is an e_assign
  UART_13_s1_reset_n <= reset_n;
  UART_13_s1_chipselect <= internal_cpu_data_master_granted_UART_13_s1;
  --UART_13_s1_firsttransfer first transaction, which is an e_assign
  UART_13_s1_firsttransfer <= A_WE_StdLogic((std_logic'(UART_13_s1_begins_xfer) = '1'), UART_13_s1_unreg_firsttransfer, UART_13_s1_reg_firsttransfer);
  --UART_13_s1_unreg_firsttransfer first transaction, which is an e_assign
  UART_13_s1_unreg_firsttransfer <= NOT ((UART_13_s1_slavearbiterlockenable AND UART_13_s1_any_continuerequest));
  --UART_13_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      UART_13_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(UART_13_s1_begins_xfer) = '1' then 
        UART_13_s1_reg_firsttransfer <= UART_13_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --UART_13_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  UART_13_s1_beginbursttransfer_internal <= UART_13_s1_begins_xfer;
  --~UART_13_s1_read_n assignment, which is an e_mux
  UART_13_s1_read_n <= NOT ((internal_cpu_data_master_granted_UART_13_s1 AND cpu_data_master_read));
  --~UART_13_s1_write_n assignment, which is an e_mux
  UART_13_s1_write_n <= NOT ((internal_cpu_data_master_granted_UART_13_s1 AND cpu_data_master_write));
  shifted_address_to_UART_13_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --UART_13_s1_address mux, which is an e_mux
  UART_13_s1_address <= A_EXT (A_SRL(shifted_address_to_UART_13_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_UART_13_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_UART_13_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_UART_13_s1_end_xfer <= UART_13_s1_end_xfer;
    end if;

  end process;

  --UART_13_s1_waits_for_read in a cycle, which is an e_mux
  UART_13_s1_waits_for_read <= UART_13_s1_in_a_read_cycle AND UART_13_s1_begins_xfer;
  --UART_13_s1_in_a_read_cycle assignment, which is an e_assign
  UART_13_s1_in_a_read_cycle <= internal_cpu_data_master_granted_UART_13_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= UART_13_s1_in_a_read_cycle;
  --UART_13_s1_waits_for_write in a cycle, which is an e_mux
  UART_13_s1_waits_for_write <= UART_13_s1_in_a_write_cycle AND UART_13_s1_begins_xfer;
  --UART_13_s1_in_a_write_cycle assignment, which is an e_assign
  UART_13_s1_in_a_write_cycle <= internal_cpu_data_master_granted_UART_13_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= UART_13_s1_in_a_write_cycle;
  wait_for_UART_13_s1_counter <= std_logic'('0');
  --assign UART_13_s1_irq_from_sa = UART_13_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  UART_13_s1_irq_from_sa <= UART_13_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_UART_13_s1 <= internal_cpu_data_master_granted_UART_13_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_UART_13_s1 <= internal_cpu_data_master_qualified_request_UART_13_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_UART_13_s1 <= internal_cpu_data_master_requests_UART_13_s1;
--synthesis translate_off
    --UART_13/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity cpu_jtag_debug_module_arbitrator;


architecture europa of cpu_jtag_debug_module_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_counter :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_set_values :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_cpu_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  cpu_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_cpu_jtag_debug_module OR internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  --assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_readdata_from_sa <= cpu_jtag_debug_module_readdata;
  internal_cpu_data_master_requests_cpu_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000011000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_jtag_debug_module_arb_share_set_values <= std_logic'('1');
  --cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_data_master_requests_cpu_jtag_debug_module OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module) OR internal_cpu_data_master_requests_cpu_jtag_debug_module) OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_jtag_debug_module_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_jtag_debug_module_allgrants <= (((or_reduce(cpu_jtag_debug_module_grant_vector)) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector));
  --cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_jtag_debug_module_end_xfer <= NOT ((cpu_jtag_debug_module_waits_for_read OR cpu_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_jtag_debug_module <= cpu_jtag_debug_module_end_xfer AND (((NOT cpu_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND cpu_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests));
  --cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_jtag_debug_module_slavearbiterlockenable <= cpu_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_jtag_debug_module_slavearbiterlockenable2 <= cpu_jtag_debug_module_arb_share_counter_next_value;
  --cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_jtag_debug_module_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module AND NOT ((((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_instruction_master_arbiterlock));
  --local readdatavalid cpu_data_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  cpu_data_master_read_data_valid_cpu_jtag_debug_module <= (internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read) AND NOT cpu_jtag_debug_module_waits_for_read;
  --cpu_jtag_debug_module_writedata mux, which is an e_mux
  cpu_jtag_debug_module_writedata <= cpu_data_master_writedata;
  internal_cpu_instruction_master_requests_cpu_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000011000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module AND NOT ((((cpu_instruction_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_data_master_arbiterlock));
  --local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  cpu_instruction_master_read_data_valid_cpu_jtag_debug_module <= (internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read) AND NOT cpu_jtag_debug_module_waits_for_read;
  --allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_instruction_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(0);
  --cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_instruction_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(0) AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_data_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(1);
  --cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_data_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(1) AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_jtag_debug_module_master_qreq_vector & cpu_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_jtag_debug_module_master_qreq_vector & NOT cpu_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_jtag_debug_module_grant_vector)))) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(1) OR cpu_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(0) OR cpu_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1' then 
        cpu_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_end_xfer) = '1'), cpu_jtag_debug_module_chosen_master_rot_left, cpu_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_jtag_debug_module_begintransfer <= cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  cpu_jtag_debug_module_reset_n <= reset_n;
  --assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_resetrequest_from_sa <= cpu_jtag_debug_module_resetrequest;
  cpu_jtag_debug_module_chipselect <= internal_cpu_data_master_granted_cpu_jtag_debug_module OR internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_jtag_debug_module_begins_xfer) = '1'), cpu_jtag_debug_module_unreg_firsttransfer, cpu_jtag_debug_module_reg_firsttransfer);
  --cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_jtag_debug_module_slavearbiterlockenable AND cpu_jtag_debug_module_any_continuerequest));
  --cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_begins_xfer) = '1' then 
        cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_jtag_debug_module_beginbursttransfer_internal <= cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_jtag_debug_module_arbitration_holdoff_internal <= cpu_jtag_debug_module_begins_xfer AND cpu_jtag_debug_module_firsttransfer;
  --cpu_jtag_debug_module_write assignment, which is an e_mux
  cpu_jtag_debug_module_write <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --cpu_jtag_debug_module_address mux, which is an e_mux
  cpu_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  --cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_read <= cpu_jtag_debug_module_in_a_read_cycle AND cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_jtag_debug_module_in_a_read_cycle;
  --cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_write_cycle <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_jtag_debug_module_counter <= std_logic'('0');
  --cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  cpu_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  cpu_data_master_granted_cpu_jtag_debug_module <= internal_cpu_data_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_requests_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_cpu_jtag_debug_module <= internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
--synthesis translate_off
    --cpu/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_data_master_arbitrator is 
        port (
              -- inputs:
                 signal ADCSamples1_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal ADCSamples2_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal DACSamples_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal Data_from_the_LogicReader_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Data_from_the_PairsCounter_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Data_from_the_ReplyDelay_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Data_from_the_Synthesizer_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Decoder_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal Deterctor_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal HIPController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal IDController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal Indicator_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal KSController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal KontrolGenerator_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal LogicReader_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal ODController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal PairsCounter_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal PriorityController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal RData_from_the_ADCSamples1_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RData_from_the_ADCSamples2_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ReplyDelay_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal SPI_FRAM_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Flash_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SPI_Synthesizer_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal SelectMuxChannel_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal Synthesizer_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal UART_13_s1_irq_from_sa : IN STD_LOGIC;
                 signal UART_13_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal UART_1_s1_irq_from_sa : IN STD_LOGIC;
                 signal UART_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_granted_ADCSamples1_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_ADCSamples2_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_DACSamples_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_Decoder_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_Deterctor_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_HIPController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_IDController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_Indicator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_KSController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_LogicReader_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_ODController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_PairsCounter_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_PriorityController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_ReplyDelay_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_granted_SPI_Flash_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_granted_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_granted_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_Synthesizer_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_UART_13_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_UART_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_granted_inp_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_out_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_ADCSamples1_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_ADCSamples2_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_DACSamples_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_Decoder_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_Deterctor_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_HIPController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_IDController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_Indicator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_KSController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_LogicReader_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_ODController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PairsCounter_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_PriorityController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_ReplyDelay_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_Flash_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_Synthesizer_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_UART_13_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_UART_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_inp_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_out_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_DACSamples_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Decoder_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Deterctor_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_HIPController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_IDController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Indicator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_KSController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_LogicReader_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ODController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PairsCounter_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_PriorityController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ReplyDelay_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_Flash_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_Synthesizer_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_UART_13_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_UART_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_inp_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_out_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_ADCSamples1_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_ADCSamples2_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_DACSamples_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_Decoder_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_Deterctor_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_HIPController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_IDController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_Indicator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_KSController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_LogicReader_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_ODController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_PairsCounter_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_PriorityController_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_ReplyDelay_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_requests_SPI_Flash_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_requests_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                 signal cpu_data_master_requests_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_Synthesizer_avalon_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_UART_13_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_UART_1_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_data_master_requests_inp_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_out_pio_s1 : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_ADCSamples1_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_ADCSamples2_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_DACSamples_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Decoder_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Deterctor_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_HIPController_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_IDController_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Indicator_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_KSController_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_KontrolGenerator_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_LogicReader_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_ODController_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_PairsCounter_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_PriorityController_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_ReplyDelay_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_SPI_FRAM_spi_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_SPI_Flash_spi_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_SPI_Synthesizer_spi_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_SelectMuxChannel_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Synthesizer_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_TriStateBridge_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_UART_13_s1_end_xfer : IN STD_LOGIC;
                 signal d1_UART_1_s1_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal d1_inp_pio_s1_end_xfer : IN STD_LOGIC;
                 signal d1_out_pio_s1_end_xfer : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal incoming_data_to_and_from_the_SRAM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal inp_pio_s1_irq_from_sa : IN STD_LOGIC;
                 signal inp_pio_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal out_pio_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_data_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_data_master_arbitrator;


architecture europa of cpu_data_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_data_master_address_last_time :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_data_master_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_data_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_data_master_read_last_time :  STD_LOGIC;
                signal cpu_data_master_run :  STD_LOGIC;
                signal cpu_data_master_write_last_time :  STD_LOGIC;
                signal cpu_data_master_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal internal_cpu_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pre_flush_cpu_data_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;
                signal r_5 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_ADCSamples1_avalon_slave OR NOT cpu_data_master_requests_ADCSamples1_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ADCSamples1_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ADCSamples1_avalon_slave_wait_counter_eq_0 AND NOT d1_ADCSamples1_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ADCSamples1_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ADCSamples1_avalon_slave_wait_counter_eq_0 AND NOT d1_ADCSamples1_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_ADCSamples2_avalon_slave OR NOT cpu_data_master_requests_ADCSamples2_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ADCSamples2_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ADCSamples2_avalon_slave_wait_counter_eq_0 AND NOT d1_ADCSamples2_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ADCSamples2_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ADCSamples2_avalon_slave_wait_counter_eq_0 AND NOT d1_ADCSamples2_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_DACSamples_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_DACSamples_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_DACSamples_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((DACSamples_avalon_slave_wait_counter_eq_0 AND NOT d1_DACSamples_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Decoder_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_Decoder_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Decoder_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((Decoder_avalon_slave_wait_counter_eq_0 AND NOT d1_Decoder_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Deterctor_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_Deterctor_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Deterctor_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((Deterctor_avalon_slave_wait_counter_eq_0 AND NOT d1_Deterctor_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_HIPController_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_HIPController_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_HIPController_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((HIPController_avalon_slave_wait_counter_eq_0 AND NOT d1_HIPController_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_data_master_run <= ((((r_0 AND r_1) AND r_2) AND r_3) AND r_4) AND r_5;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_IDController_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_IDController_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_IDController_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((IDController_avalon_slave_wait_counter_eq_0 AND NOT d1_IDController_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Indicator_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_Indicator_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Indicator_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((Indicator_avalon_slave_wait_counter_eq_0 AND NOT d1_Indicator_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT cpu_data_master_requests_JTAG_UART_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_UART_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_UART_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_KSController_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_KSController_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_KSController_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((KSController_avalon_slave_wait_counter_eq_0 AND NOT d1_KSController_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_KontrolGenerator_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_KontrolGenerator_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_KontrolGenerator_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((KontrolGenerator_avalon_slave_wait_counter_eq_0 AND NOT d1_KontrolGenerator_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_LogicReader_avalon_slave OR NOT cpu_data_master_requests_LogicReader_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_LogicReader_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((LogicReader_avalon_slave_wait_counter_eq_0 AND NOT d1_LogicReader_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_LogicReader_avalon_slave OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ODController_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_ODController_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ODController_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ODController_avalon_slave_wait_counter_eq_0 AND NOT d1_ODController_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_PairsCounter_avalon_slave OR NOT cpu_data_master_requests_PairsCounter_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PairsCounter_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((PairsCounter_avalon_slave_wait_counter_eq_0 AND NOT d1_PairsCounter_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PairsCounter_avalon_slave OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PriorityController_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_PriorityController_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_PriorityController_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((PriorityController_avalon_slave_wait_counter_eq_0 AND NOT d1_PriorityController_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_ReplyDelay_avalon_slave OR NOT cpu_data_master_requests_ReplyDelay_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ReplyDelay_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((ReplyDelay_avalon_slave_wait_counter_eq_0 AND NOT d1_ReplyDelay_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ReplyDelay_avalon_slave OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_SPI_FRAM_spi_control_port OR NOT cpu_data_master_requests_SPI_FRAM_spi_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_FRAM_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_FRAM_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_FRAM_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_FRAM_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_SPI_Flash_spi_control_port OR NOT cpu_data_master_requests_SPI_Flash_spi_control_port)))))));
  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_Flash_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_Flash_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_Flash_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_Flash_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port OR NOT cpu_data_master_requests_SPI_Synthesizer_spi_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_Synthesizer_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SPI_Synthesizer_spi_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_SelectMuxChannel_avalon_slave_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((SelectMuxChannel_avalon_slave_wait_counter_eq_0 AND NOT d1_SelectMuxChannel_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_Synthesizer_avalon_slave OR NOT cpu_data_master_requests_Synthesizer_avalon_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Synthesizer_avalon_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((Synthesizer_avalon_slave_wait_counter_eq_0 AND NOT d1_Synthesizer_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_Synthesizer_avalon_slave OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_SRAM_s1 OR NOT cpu_data_master_requests_SRAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_SRAM_s1 OR NOT cpu_data_master_qualified_request_SRAM_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SRAM_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((SRAM_s1_wait_counter_eq_0 AND NOT d1_TriStateBridge_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_SRAM_s1 OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((SRAM_s1_wait_counter_eq_0 AND NOT d1_TriStateBridge_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_UART_1_s1 OR NOT cpu_data_master_requests_UART_1_s1)))))));
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_UART_1_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_UART_1_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_UART_1_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_UART_1_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_UART_13_s1 OR NOT cpu_data_master_requests_UART_13_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_UART_13_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_UART_13_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_UART_13_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_UART_13_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_cpu_jtag_debug_module OR NOT cpu_data_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT cpu_data_master_requests_epcs_flash_controller_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_epcs_flash_controller_epcs_control_port OR NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_inp_pio_s1 OR NOT cpu_data_master_requests_inp_pio_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_inp_pio_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_inp_pio_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_inp_pio_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --r_5 master_run cascaded wait assignment, which is an e_assign
  r_5 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_out_pio_s1 OR NOT cpu_data_master_requests_out_pio_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_out_pio_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_out_pio_s1_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_out_pio_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_data_master_address_to_slave <= cpu_data_master_address(20 DOWNTO 0);
  --cpu_data_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_data_master_read_but_no_slave_selected <= (cpu_data_master_read AND cpu_data_master_run) AND NOT cpu_data_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_data_master_is_granted_some_slave <= ((((((((((((((((((((((((((cpu_data_master_granted_ADCSamples1_avalon_slave OR cpu_data_master_granted_ADCSamples2_avalon_slave) OR cpu_data_master_granted_DACSamples_avalon_slave) OR cpu_data_master_granted_Decoder_avalon_slave) OR cpu_data_master_granted_Deterctor_avalon_slave) OR cpu_data_master_granted_HIPController_avalon_slave) OR cpu_data_master_granted_IDController_avalon_slave) OR cpu_data_master_granted_Indicator_avalon_slave) OR cpu_data_master_granted_JTAG_UART_avalon_jtag_slave) OR cpu_data_master_granted_KSController_avalon_slave) OR cpu_data_master_granted_KontrolGenerator_avalon_slave) OR cpu_data_master_granted_LogicReader_avalon_slave) OR cpu_data_master_granted_ODController_avalon_slave) OR cpu_data_master_granted_PairsCounter_avalon_slave) OR cpu_data_master_granted_PriorityController_avalon_slave) OR cpu_data_master_granted_ReplyDelay_avalon_slave) OR cpu_data_master_granted_SPI_FRAM_spi_control_port) OR cpu_data_master_granted_SPI_Flash_spi_control_port) OR cpu_data_master_granted_SPI_Synthesizer_spi_control_port) OR cpu_data_master_granted_SelectMuxChannel_avalon_slave) OR cpu_data_master_granted_Synthesizer_avalon_slave) OR cpu_data_master_granted_SRAM_s1) OR cpu_data_master_granted_UART_1_s1) OR cpu_data_master_granted_UART_13_s1) OR cpu_data_master_granted_cpu_jtag_debug_module) OR cpu_data_master_granted_epcs_flash_controller_epcs_control_port) OR cpu_data_master_granted_inp_pio_s1) OR cpu_data_master_granted_out_pio_s1;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_data_master_readdatavalid <= (cpu_data_master_read_data_valid_ADCSamples1_avalon_slave OR cpu_data_master_read_data_valid_ADCSamples2_avalon_slave) OR cpu_data_master_read_data_valid_SRAM_s1;
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_data_master_readdatavalid <= (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((cpu_data_master_read_but_no_slave_selected OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_DACSamples_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_Decoder_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_Deterctor_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_HIPController_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_IDController_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_Indicator_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_KSController_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_LogicReader_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_ODController_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PairsCounter_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_PriorityController_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_ReplyDelay_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_SPI_Flash_spi_control_port) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_Synthesizer_avalon_slave) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_UART_1_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_UART_13_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_cpu_jtag_debug_module) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_inp_pio_s1) OR cpu_data_master_read_but_no_slave_selected) OR pre_flush_cpu_data_master_readdatavalid) OR cpu_data_master_read_data_valid_out_pio_s1;
  --cpu/data_master readdata mux, which is an e_mux
  cpu_data_master_readdata <= (((((((((((((((((A_REP(NOT cpu_data_master_read_data_valid_ADCSamples1_avalon_slave, 32) OR RData_from_the_ADCSamples1_from_sa)) AND ((A_REP(NOT cpu_data_master_read_data_valid_ADCSamples2_avalon_slave, 32) OR RData_from_the_ADCSamples2_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave AND cpu_data_master_read)) , 32) OR JTAG_UART_avalon_jtag_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_LogicReader_avalon_slave AND cpu_data_master_read)) , 32) OR Data_from_the_LogicReader_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_PairsCounter_avalon_slave AND cpu_data_master_read)) , 32) OR Data_from_the_PairsCounter_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_ReplyDelay_avalon_slave AND cpu_data_master_read)) , 32) OR Data_from_the_ReplyDelay_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_SPI_FRAM_spi_control_port AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (SPI_FRAM_spi_control_port_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_SPI_Flash_spi_control_port AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (SPI_Flash_spi_control_port_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (SPI_Synthesizer_spi_control_port_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_Synthesizer_avalon_slave AND cpu_data_master_read)) , 32) OR Data_from_the_Synthesizer_from_sa))) AND ((A_REP(NOT cpu_data_master_read_data_valid_SRAM_s1, 32) OR incoming_data_to_and_from_the_SRAM))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_UART_1_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (UART_1_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_UART_13_s1 AND cpu_data_master_read)) , 32) OR (std_logic_vector'("0000000000000000") & (UART_13_s1_readdata_from_sa))))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_cpu_jtag_debug_module AND cpu_data_master_read)) , 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) , 32) OR epcs_flash_controller_epcs_control_port_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_inp_pio_s1 AND cpu_data_master_read)) , 32) OR inp_pio_s1_readdata_from_sa))) AND ((A_REP(NOT ((cpu_data_master_qualified_request_out_pio_s1 AND cpu_data_master_read)) , 32) OR out_pio_s1_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_cpu_data_master_waitrequest <= NOT cpu_data_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_latency_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      internal_cpu_data_master_latency_counter <= p1_cpu_data_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_data_master_latency_counter <= A_EXT (A_WE_StdLogicVector((std_logic'(((cpu_data_master_run AND cpu_data_master_read))) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (latency_load_value)), A_WE_StdLogicVector((((internal_cpu_data_master_latency_counter)) /= std_logic_vector'("00")), ((std_logic_vector'("0000000000000000000000000000000") & (internal_cpu_data_master_latency_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --read latency load values, which is an e_mux
  latency_load_value <= A_EXT ((((((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_data_master_requests_ADCSamples1_avalon_slave, 2))) AND std_logic_vector'("00000000000000000000000000000001"))) OR (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_data_master_requests_ADCSamples2_avalon_slave, 2))) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_data_master_requests_SRAM_s1, 2))) AND std_logic_vector'("00000000000000000000000000000010")))), 2);
  --irq assign, which is an e_assign
  cpu_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(inp_pio_s1_irq_from_sa) & A_ToStdLogicVector(UART_13_s1_irq_from_sa) & A_ToStdLogicVector(UART_1_s1_irq_from_sa) & A_ToStdLogicVector(JTAG_UART_avalon_jtag_slave_irq_from_sa) & A_ToStdLogicVector(epcs_flash_controller_epcs_control_port_irq_from_sa));
  --vhdl renameroo for output signals
  cpu_data_master_address_to_slave <= internal_cpu_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_data_master_latency_counter <= internal_cpu_data_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_data_master_waitrequest <= internal_cpu_data_master_waitrequest;
--synthesis translate_off
    --cpu_data_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_address_last_time <= std_logic_vector'("000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_data_master_address_last_time <= cpu_data_master_address;
      end if;

    end process;

    --cpu/data_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_data_master_waitrequest AND ((cpu_data_master_read OR cpu_data_master_write));
      end if;

    end process;

    --cpu_data_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_address /= cpu_data_master_address_last_time))))) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("cpu_data_master_address did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        cpu_data_master_byteenable_last_time <= cpu_data_master_byteenable;
      end if;

    end process;

    --cpu_data_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_byteenable /= cpu_data_master_byteenable_last_time))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("cpu_data_master_byteenable did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_data_master_read_last_time <= cpu_data_master_read;
      end if;

    end process;

    --cpu_data_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_data_master_read) /= std_logic'(cpu_data_master_read_last_time)))))) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("cpu_data_master_read did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_data_master_write_last_time <= cpu_data_master_write;
      end if;

    end process;

    --cpu_data_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_data_master_write) /= std_logic'(cpu_data_master_write_last_time)))))) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("cpu_data_master_write did not heed wait!!!"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_data_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_data_master_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_data_master_writedata_last_time <= cpu_data_master_writedata;
      end if;

    end process;

    --cpu_data_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((cpu_data_master_writedata /= cpu_data_master_writedata_last_time)))) AND cpu_data_master_write)) = '1' then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("cpu_data_master_writedata did not heed wait!!!"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal SRAM_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_instruction_master_granted_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_SRAM_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_TriStateBridge_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal incoming_data_to_and_from_the_SRAM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_instruction_master_arbitrator;


architecture europa of cpu_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_instruction_master_address_last_time :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_instruction_master_run :  STD_LOGIC;
                signal internal_cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal internal_cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal pre_flush_cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal r_4 :  STD_LOGIC;

begin

  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_SRAM_s1 OR NOT cpu_instruction_master_requests_SRAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_SRAM_s1 OR NOT cpu_instruction_master_qualified_request_SRAM_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_SRAM_s1 OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((SRAM_s1_wait_counter_eq_0 AND NOT d1_TriStateBridge_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_instruction_master_run <= r_3 AND r_4;
  --r_4 master_run cascaded wait assignment, which is an e_assign
  r_4 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_cpu_jtag_debug_module OR NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port OR NOT cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port OR NOT (cpu_instruction_master_read))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_epcs_flash_controller_epcs_control_port_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_read))))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_instruction_master_address_to_slave <= cpu_instruction_master_address(20 DOWNTO 0);
  --cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_instruction_master_read_but_no_slave_selected <= (cpu_instruction_master_read AND cpu_instruction_master_run) AND NOT cpu_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_instruction_master_is_granted_some_slave <= (cpu_instruction_master_granted_SRAM_s1 OR cpu_instruction_master_granted_cpu_jtag_debug_module) OR cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_instruction_master_readdatavalid <= cpu_instruction_master_read_data_valid_SRAM_s1;
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_instruction_master_readdatavalid <= ((((((cpu_instruction_master_read_but_no_slave_selected OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_data_valid_cpu_jtag_debug_module) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port;
  --cpu/instruction_master readdata mux, which is an e_mux
  cpu_instruction_master_readdata <= (((A_REP(NOT cpu_instruction_master_read_data_valid_SRAM_s1, 32) OR incoming_data_to_and_from_the_SRAM)) AND ((A_REP(NOT ((cpu_instruction_master_qualified_request_cpu_jtag_debug_module AND cpu_instruction_master_read)) , 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT ((cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read)) , 32) OR epcs_flash_controller_epcs_control_port_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_cpu_instruction_master_waitrequest <= NOT cpu_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_latency_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      internal_cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_instruction_master_latency_counter <= A_EXT (A_WE_StdLogicVector((std_logic'(((cpu_instruction_master_run AND cpu_instruction_master_read))) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (latency_load_value)), A_WE_StdLogicVector((((internal_cpu_instruction_master_latency_counter)) /= std_logic_vector'("00")), ((std_logic_vector'("0000000000000000000000000000000") & (internal_cpu_instruction_master_latency_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --read latency load values, which is an e_mux
  latency_load_value <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_instruction_master_requests_SRAM_s1, 2))) AND std_logic_vector'("00000000000000000000000000000010")), 2);
  --vhdl renameroo for output signals
  cpu_instruction_master_address_to_slave <= internal_cpu_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_latency_counter <= internal_cpu_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_instruction_master_waitrequest <= internal_cpu_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_address_last_time <= std_logic_vector'("000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
      end if;

    end process;

    --cpu/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_instruction_master_waitrequest AND (cpu_instruction_master_read);
      end if;

    end process;

    --cpu_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_instruction_master_address /= cpu_instruction_master_address_last_time))))) = '1' then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("cpu_instruction_master_address did not heed wait!!!"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
      end if;

    end process;

    --cpu_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line10 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_instruction_master_read) /= std_logic'(cpu_instruction_master_read_last_time)))))) = '1' then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("cpu_instruction_master_read did not heed wait!!!"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity epcs_flash_controller_epcs_control_port_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_dataavailable : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_endofpacket : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_irq : IN STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_readyfordata : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                 signal d1_epcs_flash_controller_epcs_control_port_end_xfer : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_chipselect : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_read_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_reset_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_write_n : OUT STD_LOGIC;
                 signal epcs_flash_controller_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity epcs_flash_controller_epcs_control_port_arbitrator;


architecture europa of epcs_flash_controller_epcs_control_port_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_allgrants :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_allow_new_arb_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_any_continuerequest :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arb_counter_enable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_share_counter :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_share_counter_next_value :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_share_set_values :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_beginbursttransfer_internal :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_begins_xfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_end_xfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_in_a_read_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_in_a_write_cycle :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_non_bursting_master_requests :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_reg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_slavearbiterlockenable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_unreg_firsttransfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_waits_for_read :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_waits_for_write :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_epcs_flash_controller_epcs_control_port_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT epcs_flash_controller_epcs_control_port_end_xfer;
    end if;

  end process;

  epcs_flash_controller_epcs_control_port_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port));
  --assign epcs_flash_controller_epcs_control_port_readdata_from_sa = epcs_flash_controller_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_readdata_from_sa <= epcs_flash_controller_epcs_control_port_readdata;
  internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000011100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign epcs_flash_controller_epcs_control_port_dataavailable_from_sa = epcs_flash_controller_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_dataavailable_from_sa <= epcs_flash_controller_epcs_control_port_dataavailable;
  --assign epcs_flash_controller_epcs_control_port_readyfordata_from_sa = epcs_flash_controller_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_readyfordata_from_sa <= epcs_flash_controller_epcs_control_port_readyfordata;
  --epcs_flash_controller_epcs_control_port_arb_share_counter set values, which is an e_mux
  epcs_flash_controller_epcs_control_port_arb_share_set_values <= std_logic'('1');
  --epcs_flash_controller_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_non_bursting_master_requests <= ((internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port) OR internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port) OR internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant <= std_logic'('0');
  --epcs_flash_controller_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(epcs_flash_controller_epcs_control_port_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(epcs_flash_controller_epcs_control_port_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(epcs_flash_controller_epcs_control_port_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(epcs_flash_controller_epcs_control_port_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --epcs_flash_controller_epcs_control_port_allgrants all slave grants, which is an e_mux
  epcs_flash_controller_epcs_control_port_allgrants <= (((or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector))) OR (or_reduce(epcs_flash_controller_epcs_control_port_grant_vector));
  --epcs_flash_controller_epcs_control_port_end_xfer assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_end_xfer <= NOT ((epcs_flash_controller_epcs_control_port_waits_for_read OR epcs_flash_controller_epcs_control_port_waits_for_write));
  --end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_end_xfer AND (((NOT epcs_flash_controller_epcs_control_port_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --epcs_flash_controller_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  epcs_flash_controller_epcs_control_port_arb_counter_enable <= ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND epcs_flash_controller_epcs_control_port_allgrants)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND NOT epcs_flash_controller_epcs_control_port_non_bursting_master_requests));
  --epcs_flash_controller_epcs_control_port_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_arb_counter_enable) = '1' then 
        epcs_flash_controller_epcs_control_port_arb_share_counter <= epcs_flash_controller_epcs_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(epcs_flash_controller_epcs_control_port_master_qreq_vector) AND end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port)) OR ((end_xfer_arb_share_counter_term_epcs_flash_controller_epcs_control_port AND NOT epcs_flash_controller_epcs_control_port_non_bursting_master_requests)))) = '1' then 
        epcs_flash_controller_epcs_control_port_slavearbiterlockenable <= epcs_flash_controller_epcs_control_port_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master epcs_flash_controller/epcs_control_port arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 <= epcs_flash_controller_epcs_control_port_arb_share_counter_next_value;
  --cpu/data_master epcs_flash_controller/epcs_control_port arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master epcs_flash_controller/epcs_control_port arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master epcs_flash_controller/epcs_control_port arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= epcs_flash_controller_epcs_control_port_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted epcs_flash_controller/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_epcs_flash_controller_epcs_control_port AND internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  epcs_flash_controller_epcs_control_port_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port AND NOT ((((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_instruction_master_arbiterlock));
  --local readdatavalid cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port, which is an e_mux
  cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port <= (internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read) AND NOT epcs_flash_controller_epcs_control_port_waits_for_read;
  --epcs_flash_controller_epcs_control_port_writedata mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_writedata <= cpu_data_master_writedata;
  --assign epcs_flash_controller_epcs_control_port_endofpacket_from_sa = epcs_flash_controller_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_endofpacket_from_sa <= epcs_flash_controller_epcs_control_port_endofpacket;
  internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(20 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000011100000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted epcs_flash_controller/epcs_control_port last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_epcs_flash_controller_epcs_control_port AND internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port AND NOT ((((cpu_instruction_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))))) OR cpu_data_master_arbiterlock));
  --local readdatavalid cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port, which is an e_mux
  cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port <= (internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read) AND NOT epcs_flash_controller_epcs_control_port_waits_for_read;
  --allow new arb cycle for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --cpu/instruction_master grant epcs_flash_controller/epcs_control_port, which is an e_assign
  internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_grant_vector(0);
  --cpu/instruction_master saved-grant epcs_flash_controller/epcs_control_port, which is an e_assign
  cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_arb_winner(0) AND internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
  --cpu/data_master assignment into master qualified-requests vector for epcs_flash_controller/epcs_control_port, which is an e_assign
  epcs_flash_controller_epcs_control_port_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --cpu/data_master grant epcs_flash_controller/epcs_control_port, which is an e_assign
  internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_grant_vector(1);
  --cpu/data_master saved-grant epcs_flash_controller/epcs_control_port, which is an e_assign
  cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port <= epcs_flash_controller_epcs_control_port_arb_winner(1) AND internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller/epcs_control_port chosen-master double-vector, which is an e_assign
  epcs_flash_controller_epcs_control_port_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((epcs_flash_controller_epcs_control_port_master_qreq_vector & epcs_flash_controller_epcs_control_port_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT epcs_flash_controller_epcs_control_port_master_qreq_vector & NOT epcs_flash_controller_epcs_control_port_master_qreq_vector))) + (std_logic_vector'("000") & (epcs_flash_controller_epcs_control_port_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  epcs_flash_controller_epcs_control_port_arb_winner <= A_WE_StdLogicVector((std_logic'(((epcs_flash_controller_epcs_control_port_allow_new_arb_cycle AND or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)))) = '1'), epcs_flash_controller_epcs_control_port_grant_vector, epcs_flash_controller_epcs_control_port_saved_chosen_master_vector);
  --saved epcs_flash_controller_epcs_control_port_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_allow_new_arb_cycle) = '1' then 
        epcs_flash_controller_epcs_control_port_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) = '1'), epcs_flash_controller_epcs_control_port_grant_vector, epcs_flash_controller_epcs_control_port_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  epcs_flash_controller_epcs_control_port_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((epcs_flash_controller_epcs_control_port_chosen_master_double_vector(1) OR epcs_flash_controller_epcs_control_port_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((epcs_flash_controller_epcs_control_port_chosen_master_double_vector(0) OR epcs_flash_controller_epcs_control_port_chosen_master_double_vector(2)))));
  --epcs_flash_controller/epcs_control_port chosen master rotated left, which is an e_assign
  epcs_flash_controller_epcs_control_port_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(epcs_flash_controller_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(epcs_flash_controller_epcs_control_port_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --epcs_flash_controller/epcs_control_port's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(epcs_flash_controller_epcs_control_port_grant_vector)) = '1' then 
        epcs_flash_controller_epcs_control_port_arb_addend <= A_WE_StdLogicVector((std_logic'(epcs_flash_controller_epcs_control_port_end_xfer) = '1'), epcs_flash_controller_epcs_control_port_chosen_master_rot_left, epcs_flash_controller_epcs_control_port_grant_vector);
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_reset_n assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_reset_n <= reset_n;
  epcs_flash_controller_epcs_control_port_chipselect <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port OR internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --epcs_flash_controller_epcs_control_port_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_epcs_control_port_firsttransfer <= A_WE_StdLogic((std_logic'(epcs_flash_controller_epcs_control_port_begins_xfer) = '1'), epcs_flash_controller_epcs_control_port_unreg_firsttransfer, epcs_flash_controller_epcs_control_port_reg_firsttransfer);
  --epcs_flash_controller_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  epcs_flash_controller_epcs_control_port_unreg_firsttransfer <= NOT ((epcs_flash_controller_epcs_control_port_slavearbiterlockenable AND epcs_flash_controller_epcs_control_port_any_continuerequest));
  --epcs_flash_controller_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      epcs_flash_controller_epcs_control_port_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(epcs_flash_controller_epcs_control_port_begins_xfer) = '1' then 
        epcs_flash_controller_epcs_control_port_reg_firsttransfer <= epcs_flash_controller_epcs_control_port_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  epcs_flash_controller_epcs_control_port_beginbursttransfer_internal <= epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  epcs_flash_controller_epcs_control_port_arbitration_holdoff_internal <= epcs_flash_controller_epcs_control_port_begins_xfer AND epcs_flash_controller_epcs_control_port_firsttransfer;
  --~epcs_flash_controller_epcs_control_port_read_n assignment, which is an e_mux
  epcs_flash_controller_epcs_control_port_read_n <= NOT ((((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read))));
  --~epcs_flash_controller_epcs_control_port_write_n assignment, which is an e_mux
  epcs_flash_controller_epcs_control_port_write_n <= NOT ((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_write));
  shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --epcs_flash_controller_epcs_control_port_address mux, which is an e_mux
  epcs_flash_controller_epcs_control_port_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port)) = '1'), (A_SRL(shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_epcs_flash_controller_epcs_control_port_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_epcs_flash_controller_epcs_control_port_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_epcs_flash_controller_epcs_control_port_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_epcs_flash_controller_epcs_control_port_end_xfer <= epcs_flash_controller_epcs_control_port_end_xfer;
    end if;

  end process;

  --epcs_flash_controller_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  epcs_flash_controller_epcs_control_port_waits_for_read <= epcs_flash_controller_epcs_control_port_in_a_read_cycle AND epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_in_a_read_cycle <= ((internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= epcs_flash_controller_epcs_control_port_in_a_read_cycle;
  --epcs_flash_controller_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  epcs_flash_controller_epcs_control_port_waits_for_write <= epcs_flash_controller_epcs_control_port_in_a_write_cycle AND epcs_flash_controller_epcs_control_port_begins_xfer;
  --epcs_flash_controller_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  epcs_flash_controller_epcs_control_port_in_a_write_cycle <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= epcs_flash_controller_epcs_control_port_in_a_write_cycle;
  wait_for_epcs_flash_controller_epcs_control_port_counter <= std_logic'('0');
  --assign epcs_flash_controller_epcs_control_port_irq_from_sa = epcs_flash_controller_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  epcs_flash_controller_epcs_control_port_irq_from_sa <= epcs_flash_controller_epcs_control_port_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_data_master_requests_epcs_flash_controller_epcs_control_port <= internal_cpu_data_master_requests_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port <= internal_cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port;
--synthesis translate_off
    --epcs_flash_controller/epcs_control_port enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line11 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_epcs_flash_controller_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line11, now);
          write(write_line11, string'(": "));
          write(write_line11, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line11.all);
          deallocate (write_line11);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line12 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_epcs_flash_controller_epcs_control_port))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_epcs_flash_controller_epcs_control_port))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line12, now);
          write(write_line12, string'(": "));
          write(write_line12, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line12.all);
          deallocate (write_line12);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity inp_pio_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal inp_pio_s1_irq : IN STD_LOGIC;
                 signal inp_pio_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_inp_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_inp_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_inp_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_inp_pio_s1 : OUT STD_LOGIC;
                 signal d1_inp_pio_s1_end_xfer : OUT STD_LOGIC;
                 signal inp_pio_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal inp_pio_s1_chipselect : OUT STD_LOGIC;
                 signal inp_pio_s1_irq_from_sa : OUT STD_LOGIC;
                 signal inp_pio_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal inp_pio_s1_reset_n : OUT STD_LOGIC;
                 signal inp_pio_s1_write_n : OUT STD_LOGIC;
                 signal inp_pio_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity inp_pio_s1_arbitrator;


architecture europa of inp_pio_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_inp_pio_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_inp_pio_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal inp_pio_s1_allgrants :  STD_LOGIC;
                signal inp_pio_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal inp_pio_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal inp_pio_s1_any_continuerequest :  STD_LOGIC;
                signal inp_pio_s1_arb_counter_enable :  STD_LOGIC;
                signal inp_pio_s1_arb_share_counter :  STD_LOGIC;
                signal inp_pio_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal inp_pio_s1_arb_share_set_values :  STD_LOGIC;
                signal inp_pio_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal inp_pio_s1_begins_xfer :  STD_LOGIC;
                signal inp_pio_s1_end_xfer :  STD_LOGIC;
                signal inp_pio_s1_firsttransfer :  STD_LOGIC;
                signal inp_pio_s1_grant_vector :  STD_LOGIC;
                signal inp_pio_s1_in_a_read_cycle :  STD_LOGIC;
                signal inp_pio_s1_in_a_write_cycle :  STD_LOGIC;
                signal inp_pio_s1_master_qreq_vector :  STD_LOGIC;
                signal inp_pio_s1_non_bursting_master_requests :  STD_LOGIC;
                signal inp_pio_s1_reg_firsttransfer :  STD_LOGIC;
                signal inp_pio_s1_slavearbiterlockenable :  STD_LOGIC;
                signal inp_pio_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal inp_pio_s1_unreg_firsttransfer :  STD_LOGIC;
                signal inp_pio_s1_waits_for_read :  STD_LOGIC;
                signal inp_pio_s1_waits_for_write :  STD_LOGIC;
                signal internal_cpu_data_master_granted_inp_pio_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_inp_pio_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_inp_pio_s1 :  STD_LOGIC;
                signal shifted_address_to_inp_pio_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_inp_pio_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT inp_pio_s1_end_xfer;
    end if;

  end process;

  inp_pio_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_inp_pio_s1);
  --assign inp_pio_s1_readdata_from_sa = inp_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  inp_pio_s1_readdata_from_sa <= inp_pio_s1_readdata;
  internal_cpu_data_master_requests_inp_pio_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100101000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --inp_pio_s1_arb_share_counter set values, which is an e_mux
  inp_pio_s1_arb_share_set_values <= std_logic'('1');
  --inp_pio_s1_non_bursting_master_requests mux, which is an e_mux
  inp_pio_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_inp_pio_s1;
  --inp_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  inp_pio_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --inp_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  inp_pio_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(inp_pio_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(inp_pio_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(inp_pio_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(inp_pio_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --inp_pio_s1_allgrants all slave grants, which is an e_mux
  inp_pio_s1_allgrants <= inp_pio_s1_grant_vector;
  --inp_pio_s1_end_xfer assignment, which is an e_assign
  inp_pio_s1_end_xfer <= NOT ((inp_pio_s1_waits_for_read OR inp_pio_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_inp_pio_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_inp_pio_s1 <= inp_pio_s1_end_xfer AND (((NOT inp_pio_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --inp_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  inp_pio_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_inp_pio_s1 AND inp_pio_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_inp_pio_s1 AND NOT inp_pio_s1_non_bursting_master_requests));
  --inp_pio_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      inp_pio_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(inp_pio_s1_arb_counter_enable) = '1' then 
        inp_pio_s1_arb_share_counter <= inp_pio_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --inp_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      inp_pio_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((inp_pio_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_inp_pio_s1)) OR ((end_xfer_arb_share_counter_term_inp_pio_s1 AND NOT inp_pio_s1_non_bursting_master_requests)))) = '1' then 
        inp_pio_s1_slavearbiterlockenable <= inp_pio_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master inp_pio/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= inp_pio_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --inp_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  inp_pio_s1_slavearbiterlockenable2 <= inp_pio_s1_arb_share_counter_next_value;
  --cpu/data_master inp_pio/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= inp_pio_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --inp_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  inp_pio_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_inp_pio_s1 <= internal_cpu_data_master_requests_inp_pio_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_inp_pio_s1, which is an e_mux
  cpu_data_master_read_data_valid_inp_pio_s1 <= (internal_cpu_data_master_granted_inp_pio_s1 AND cpu_data_master_read) AND NOT inp_pio_s1_waits_for_read;
  --inp_pio_s1_writedata mux, which is an e_mux
  inp_pio_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_inp_pio_s1 <= internal_cpu_data_master_qualified_request_inp_pio_s1;
  --cpu/data_master saved-grant inp_pio/s1, which is an e_assign
  cpu_data_master_saved_grant_inp_pio_s1 <= internal_cpu_data_master_requests_inp_pio_s1;
  --allow new arb cycle for inp_pio/s1, which is an e_assign
  inp_pio_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  inp_pio_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  inp_pio_s1_master_qreq_vector <= std_logic'('1');
  --inp_pio_s1_reset_n assignment, which is an e_assign
  inp_pio_s1_reset_n <= reset_n;
  inp_pio_s1_chipselect <= internal_cpu_data_master_granted_inp_pio_s1;
  --inp_pio_s1_firsttransfer first transaction, which is an e_assign
  inp_pio_s1_firsttransfer <= A_WE_StdLogic((std_logic'(inp_pio_s1_begins_xfer) = '1'), inp_pio_s1_unreg_firsttransfer, inp_pio_s1_reg_firsttransfer);
  --inp_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  inp_pio_s1_unreg_firsttransfer <= NOT ((inp_pio_s1_slavearbiterlockenable AND inp_pio_s1_any_continuerequest));
  --inp_pio_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      inp_pio_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(inp_pio_s1_begins_xfer) = '1' then 
        inp_pio_s1_reg_firsttransfer <= inp_pio_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --inp_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  inp_pio_s1_beginbursttransfer_internal <= inp_pio_s1_begins_xfer;
  --~inp_pio_s1_write_n assignment, which is an e_mux
  inp_pio_s1_write_n <= NOT ((internal_cpu_data_master_granted_inp_pio_s1 AND cpu_data_master_write));
  shifted_address_to_inp_pio_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --inp_pio_s1_address mux, which is an e_mux
  inp_pio_s1_address <= A_EXT (A_SRL(shifted_address_to_inp_pio_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_inp_pio_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_inp_pio_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_inp_pio_s1_end_xfer <= inp_pio_s1_end_xfer;
    end if;

  end process;

  --inp_pio_s1_waits_for_read in a cycle, which is an e_mux
  inp_pio_s1_waits_for_read <= inp_pio_s1_in_a_read_cycle AND inp_pio_s1_begins_xfer;
  --inp_pio_s1_in_a_read_cycle assignment, which is an e_assign
  inp_pio_s1_in_a_read_cycle <= internal_cpu_data_master_granted_inp_pio_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= inp_pio_s1_in_a_read_cycle;
  --inp_pio_s1_waits_for_write in a cycle, which is an e_mux
  inp_pio_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(inp_pio_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --inp_pio_s1_in_a_write_cycle assignment, which is an e_assign
  inp_pio_s1_in_a_write_cycle <= internal_cpu_data_master_granted_inp_pio_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= inp_pio_s1_in_a_write_cycle;
  wait_for_inp_pio_s1_counter <= std_logic'('0');
  --assign inp_pio_s1_irq_from_sa = inp_pio_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  inp_pio_s1_irq_from_sa <= inp_pio_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_inp_pio_s1 <= internal_cpu_data_master_granted_inp_pio_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_inp_pio_s1 <= internal_cpu_data_master_qualified_request_inp_pio_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_inp_pio_s1 <= internal_cpu_data_master_requests_inp_pio_s1;
--synthesis translate_off
    --inp_pio/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity out_pio_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                 signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal out_pio_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_out_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_out_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_out_pio_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_out_pio_s1 : OUT STD_LOGIC;
                 signal d1_out_pio_s1_end_xfer : OUT STD_LOGIC;
                 signal out_pio_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal out_pio_s1_chipselect : OUT STD_LOGIC;
                 signal out_pio_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal out_pio_s1_reset_n : OUT STD_LOGIC;
                 signal out_pio_s1_write_n : OUT STD_LOGIC;
                 signal out_pio_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity out_pio_s1_arbitrator;


architecture europa of out_pio_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_out_pio_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_out_pio_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_out_pio_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_out_pio_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_out_pio_s1 :  STD_LOGIC;
                signal out_pio_s1_allgrants :  STD_LOGIC;
                signal out_pio_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal out_pio_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal out_pio_s1_any_continuerequest :  STD_LOGIC;
                signal out_pio_s1_arb_counter_enable :  STD_LOGIC;
                signal out_pio_s1_arb_share_counter :  STD_LOGIC;
                signal out_pio_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal out_pio_s1_arb_share_set_values :  STD_LOGIC;
                signal out_pio_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal out_pio_s1_begins_xfer :  STD_LOGIC;
                signal out_pio_s1_end_xfer :  STD_LOGIC;
                signal out_pio_s1_firsttransfer :  STD_LOGIC;
                signal out_pio_s1_grant_vector :  STD_LOGIC;
                signal out_pio_s1_in_a_read_cycle :  STD_LOGIC;
                signal out_pio_s1_in_a_write_cycle :  STD_LOGIC;
                signal out_pio_s1_master_qreq_vector :  STD_LOGIC;
                signal out_pio_s1_non_bursting_master_requests :  STD_LOGIC;
                signal out_pio_s1_reg_firsttransfer :  STD_LOGIC;
                signal out_pio_s1_slavearbiterlockenable :  STD_LOGIC;
                signal out_pio_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal out_pio_s1_unreg_firsttransfer :  STD_LOGIC;
                signal out_pio_s1_waits_for_read :  STD_LOGIC;
                signal out_pio_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_out_pio_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal wait_for_out_pio_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT out_pio_s1_end_xfer;
    end if;

  end process;

  out_pio_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_out_pio_s1);
  --assign out_pio_s1_readdata_from_sa = out_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  out_pio_s1_readdata_from_sa <= out_pio_s1_readdata;
  internal_cpu_data_master_requests_out_pio_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(20 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100000001100101110000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --out_pio_s1_arb_share_counter set values, which is an e_mux
  out_pio_s1_arb_share_set_values <= std_logic'('1');
  --out_pio_s1_non_bursting_master_requests mux, which is an e_mux
  out_pio_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_out_pio_s1;
  --out_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  out_pio_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --out_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  out_pio_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(out_pio_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(out_pio_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(out_pio_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(out_pio_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --out_pio_s1_allgrants all slave grants, which is an e_mux
  out_pio_s1_allgrants <= out_pio_s1_grant_vector;
  --out_pio_s1_end_xfer assignment, which is an e_assign
  out_pio_s1_end_xfer <= NOT ((out_pio_s1_waits_for_read OR out_pio_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_out_pio_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_out_pio_s1 <= out_pio_s1_end_xfer AND (((NOT out_pio_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --out_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  out_pio_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_out_pio_s1 AND out_pio_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_out_pio_s1 AND NOT out_pio_s1_non_bursting_master_requests));
  --out_pio_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_pio_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(out_pio_s1_arb_counter_enable) = '1' then 
        out_pio_s1_arb_share_counter <= out_pio_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --out_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_pio_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((out_pio_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_out_pio_s1)) OR ((end_xfer_arb_share_counter_term_out_pio_s1 AND NOT out_pio_s1_non_bursting_master_requests)))) = '1' then 
        out_pio_s1_slavearbiterlockenable <= out_pio_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu/data_master out_pio/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= out_pio_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --out_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  out_pio_s1_slavearbiterlockenable2 <= out_pio_s1_arb_share_counter_next_value;
  --cpu/data_master out_pio/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= out_pio_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --out_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  out_pio_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_out_pio_s1 <= internal_cpu_data_master_requests_out_pio_s1 AND NOT ((cpu_data_master_read AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))))));
  --local readdatavalid cpu_data_master_read_data_valid_out_pio_s1, which is an e_mux
  cpu_data_master_read_data_valid_out_pio_s1 <= (internal_cpu_data_master_granted_out_pio_s1 AND cpu_data_master_read) AND NOT out_pio_s1_waits_for_read;
  --out_pio_s1_writedata mux, which is an e_mux
  out_pio_s1_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_out_pio_s1 <= internal_cpu_data_master_qualified_request_out_pio_s1;
  --cpu/data_master saved-grant out_pio/s1, which is an e_assign
  cpu_data_master_saved_grant_out_pio_s1 <= internal_cpu_data_master_requests_out_pio_s1;
  --allow new arb cycle for out_pio/s1, which is an e_assign
  out_pio_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  out_pio_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  out_pio_s1_master_qreq_vector <= std_logic'('1');
  --out_pio_s1_reset_n assignment, which is an e_assign
  out_pio_s1_reset_n <= reset_n;
  out_pio_s1_chipselect <= internal_cpu_data_master_granted_out_pio_s1;
  --out_pio_s1_firsttransfer first transaction, which is an e_assign
  out_pio_s1_firsttransfer <= A_WE_StdLogic((std_logic'(out_pio_s1_begins_xfer) = '1'), out_pio_s1_unreg_firsttransfer, out_pio_s1_reg_firsttransfer);
  --out_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  out_pio_s1_unreg_firsttransfer <= NOT ((out_pio_s1_slavearbiterlockenable AND out_pio_s1_any_continuerequest));
  --out_pio_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      out_pio_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(out_pio_s1_begins_xfer) = '1' then 
        out_pio_s1_reg_firsttransfer <= out_pio_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --out_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  out_pio_s1_beginbursttransfer_internal <= out_pio_s1_begins_xfer;
  --~out_pio_s1_write_n assignment, which is an e_mux
  out_pio_s1_write_n <= NOT ((internal_cpu_data_master_granted_out_pio_s1 AND cpu_data_master_write));
  shifted_address_to_out_pio_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --out_pio_s1_address mux, which is an e_mux
  out_pio_s1_address <= A_EXT (A_SRL(shifted_address_to_out_pio_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_out_pio_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_out_pio_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_out_pio_s1_end_xfer <= out_pio_s1_end_xfer;
    end if;

  end process;

  --out_pio_s1_waits_for_read in a cycle, which is an e_mux
  out_pio_s1_waits_for_read <= out_pio_s1_in_a_read_cycle AND out_pio_s1_begins_xfer;
  --out_pio_s1_in_a_read_cycle assignment, which is an e_assign
  out_pio_s1_in_a_read_cycle <= internal_cpu_data_master_granted_out_pio_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= out_pio_s1_in_a_read_cycle;
  --out_pio_s1_waits_for_write in a cycle, which is an e_mux
  out_pio_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(out_pio_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --out_pio_s1_in_a_write_cycle assignment, which is an e_assign
  out_pio_s1_in_a_write_cycle <= internal_cpu_data_master_granted_out_pio_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= out_pio_s1_in_a_write_cycle;
  wait_for_out_pio_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_out_pio_s1 <= internal_cpu_data_master_granted_out_pio_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_out_pio_s1 <= internal_cpu_data_master_qualified_request_out_pio_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_out_pio_s1 <= internal_cpu_data_master_requests_out_pio_s1;
--synthesis translate_off
    --out_pio/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DME_ControllerUnit_reset_CLK_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity DME_ControllerUnit_reset_CLK_domain_synch_module;


architecture europa of DME_ControllerUnit_reset_CLK_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DME_ControllerUnit is 
        port (
              -- 1) global signals:
                 signal CLK : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_ADCSamples1_avalon_slave
                 signal Address_to_the_ADCSamples1 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal RD_to_the_ADCSamples1 : OUT STD_LOGIC;
                 signal RData_from_the_ADCSamples1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- the_ADCSamples2_avalon_slave
                 signal Address_to_the_ADCSamples2 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal RD_to_the_ADCSamples2 : OUT STD_LOGIC;
                 signal RData_from_the_ADCSamples2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- the_DACSamples_avalon_slave
                 signal Address_to_the_DACSamples : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal Data_to_the_DACSamples : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_DACSamples : OUT STD_LOGIC;

              -- the_Decoder_avalon_slave
                 signal Address_to_the_Decoder : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_Decoder : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_Decoder : OUT STD_LOGIC;

              -- the_Deterctor_avalon_slave
                 signal Address_to_the_Deterctor : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_Deterctor : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_Deterctor : OUT STD_LOGIC;

              -- the_HIPController_avalon_slave
                 signal Data_to_the_HIPController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_HIPController : OUT STD_LOGIC;

              -- the_IDController_avalon_slave
                 signal Address_to_the_IDController : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal WData_to_the_IDController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_IDController : OUT STD_LOGIC;

              -- the_Indicator_avalon_slave
                 signal Data_to_the_Indicator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_Indicator : OUT STD_LOGIC;

              -- the_KSController_avalon_slave
                 signal Address_to_the_KSController : OUT STD_LOGIC;
                 signal Data_to_the_KSController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_KSController : OUT STD_LOGIC;

              -- the_KontrolGenerator_avalon_slave
                 signal Data_to_the_KontrolGenerator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_KontrolGenerator : OUT STD_LOGIC;

              -- the_LogicReader_avalon_slave
                 signal Data_from_the_LogicReader : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_LogicReader : OUT STD_LOGIC;

              -- the_ODController_avalon_slave
                 signal Address_to_the_ODController : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                 signal Data_to_the_ODController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_ODController : OUT STD_LOGIC;

              -- the_PairsCounter_avalon_slave
                 signal Data_from_the_PairsCounter : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_PairsCounter : OUT STD_LOGIC;

              -- the_PriorityController_avalon_slave
                 signal Address_to_the_PriorityController : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_to_the_PriorityController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_PriorityController : OUT STD_LOGIC;

              -- the_ReplyDelay_avalon_slave
                 signal Address_to_the_ReplyDelay : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Data_from_the_ReplyDelay : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_ReplyDelay : OUT STD_LOGIC;

              -- the_SPI_FRAM
                 signal MISO_to_the_SPI_FRAM : IN STD_LOGIC;
                 signal MOSI_from_the_SPI_FRAM : OUT STD_LOGIC;
                 signal SCLK_from_the_SPI_FRAM : OUT STD_LOGIC;
                 signal SS_n_from_the_SPI_FRAM : OUT STD_LOGIC;

              -- the_SPI_Flash
                 signal MISO_to_the_SPI_Flash : IN STD_LOGIC;
                 signal MOSI_from_the_SPI_Flash : OUT STD_LOGIC;
                 signal SCLK_from_the_SPI_Flash : OUT STD_LOGIC;
                 signal SS_n_from_the_SPI_Flash : OUT STD_LOGIC;

              -- the_SPI_Synthesizer
                 signal MISO_to_the_SPI_Synthesizer : IN STD_LOGIC;
                 signal MOSI_from_the_SPI_Synthesizer : OUT STD_LOGIC;
                 signal SCLK_from_the_SPI_Synthesizer : OUT STD_LOGIC;
                 signal SS_n_from_the_SPI_Synthesizer : OUT STD_LOGIC;

              -- the_SelectMuxChannel_avalon_slave
                 signal Data_to_the_SelectMuxChannel : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal WR_to_the_SelectMuxChannel : OUT STD_LOGIC;

              -- the_Synthesizer_avalon_slave
                 signal Data_from_the_Synthesizer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RD_to_the_Synthesizer : OUT STD_LOGIC;

              -- the_TriStateBridge_avalon_slave
                 signal address_to_the_SRAM : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                 signal be_n_to_the_SRAM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal data_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal read_n_to_the_SRAM : OUT STD_LOGIC;
                 signal select_n_to_the_SRAM : OUT STD_LOGIC;
                 signal write_n_to_the_SRAM : OUT STD_LOGIC;

              -- the_UART_1
                 signal rxd_to_the_UART_1 : IN STD_LOGIC;
                 signal txd_from_the_UART_1 : OUT STD_LOGIC;

              -- the_UART_13
                 signal rxd_to_the_UART_13 : IN STD_LOGIC;
                 signal txd_from_the_UART_13 : OUT STD_LOGIC;

              -- the_inp_pio
                 signal in_port_to_the_inp_pio : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- the_out_pio
                 signal out_port_from_the_out_pio : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity DME_ControllerUnit;


architecture europa of DME_ControllerUnit is
component ADCSamples1_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal RData_from_the_ADCSamples1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal ADCSamples1_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal Address_to_the_ADCSamples1 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal RD_to_the_ADCSamples1 : OUT STD_LOGIC;
                    signal RData_from_the_ADCSamples1_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_ADCSamples1_avalon_slave : OUT STD_LOGIC;
                    signal d1_ADCSamples1_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component ADCSamples1_avalon_slave_arbitrator;

component ADCSamples2_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal RData_from_the_ADCSamples2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal ADCSamples2_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal Address_to_the_ADCSamples2 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal RD_to_the_ADCSamples2 : OUT STD_LOGIC;
                    signal RData_from_the_ADCSamples2_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_ADCSamples2_avalon_slave : OUT STD_LOGIC;
                    signal d1_ADCSamples2_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component ADCSamples2_avalon_slave_arbitrator;

component DACSamples_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_DACSamples : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal DACSamples_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal Data_to_the_DACSamples : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_DACSamples : OUT STD_LOGIC;
                    signal cpu_data_master_granted_DACSamples_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_DACSamples_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_DACSamples_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_DACSamples_avalon_slave : OUT STD_LOGIC;
                    signal d1_DACSamples_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component DACSamples_avalon_slave_arbitrator;

component Decoder_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_Decoder : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_Decoder : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Decoder_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_Decoder : OUT STD_LOGIC;
                    signal cpu_data_master_granted_Decoder_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_Decoder_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Decoder_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_Decoder_avalon_slave : OUT STD_LOGIC;
                    signal d1_Decoder_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component Decoder_avalon_slave_arbitrator;

component Deterctor_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_Deterctor : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_Deterctor : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Deterctor_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_Deterctor : OUT STD_LOGIC;
                    signal cpu_data_master_granted_Deterctor_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_Deterctor_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Deterctor_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_Deterctor_avalon_slave : OUT STD_LOGIC;
                    signal d1_Deterctor_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component Deterctor_avalon_slave_arbitrator;

component HIPController_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_to_the_HIPController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HIPController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_HIPController : OUT STD_LOGIC;
                    signal cpu_data_master_granted_HIPController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_HIPController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_HIPController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_HIPController_avalon_slave : OUT STD_LOGIC;
                    signal d1_HIPController_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component HIPController_avalon_slave_arbitrator;

component IDController_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_IDController : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal IDController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WData_to_the_IDController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_IDController : OUT STD_LOGIC;
                    signal cpu_data_master_granted_IDController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_IDController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_IDController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_IDController_avalon_slave : OUT STD_LOGIC;
                    signal d1_IDController_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component IDController_avalon_slave_arbitrator;

component Indicator_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_to_the_Indicator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Indicator_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_Indicator : OUT STD_LOGIC;
                    signal cpu_data_master_granted_Indicator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_Indicator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Indicator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_Indicator_avalon_slave : OUT STD_LOGIC;
                    signal d1_Indicator_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component Indicator_avalon_slave_arbitrator;

component JTAG_UART_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal JTAG_UART_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal JTAG_UART_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
                 );
end component JTAG_UART_avalon_jtag_slave_arbitrator;

component JTAG_UART is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component JTAG_UART;

component KSController_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_KSController : OUT STD_LOGIC;
                    signal Data_to_the_KSController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal KSController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_KSController : OUT STD_LOGIC;
                    signal cpu_data_master_granted_KSController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_KSController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_KSController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_KSController_avalon_slave : OUT STD_LOGIC;
                    signal d1_KSController_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component KSController_avalon_slave_arbitrator;

component KontrolGenerator_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_to_the_KontrolGenerator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal KontrolGenerator_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_KontrolGenerator : OUT STD_LOGIC;
                    signal cpu_data_master_granted_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_KontrolGenerator_avalon_slave : OUT STD_LOGIC;
                    signal d1_KontrolGenerator_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component KontrolGenerator_avalon_slave_arbitrator;

component LogicReader_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal Data_from_the_LogicReader : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_from_the_LogicReader_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal LogicReader_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal RD_to_the_LogicReader : OUT STD_LOGIC;
                    signal cpu_data_master_granted_LogicReader_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_LogicReader_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_LogicReader_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_LogicReader_avalon_slave : OUT STD_LOGIC;
                    signal d1_LogicReader_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component LogicReader_avalon_slave_arbitrator;

component ODController_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_ODController : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal Data_to_the_ODController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ODController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_ODController : OUT STD_LOGIC;
                    signal cpu_data_master_granted_ODController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_ODController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ODController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_ODController_avalon_slave : OUT STD_LOGIC;
                    signal d1_ODController_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component ODController_avalon_slave_arbitrator;

component PairsCounter_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal Data_from_the_PairsCounter : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_from_the_PairsCounter_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PairsCounter_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal RD_to_the_PairsCounter : OUT STD_LOGIC;
                    signal cpu_data_master_granted_PairsCounter_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PairsCounter_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PairsCounter_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PairsCounter_avalon_slave : OUT STD_LOGIC;
                    signal d1_PairsCounter_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component PairsCounter_avalon_slave_arbitrator;

component PriorityController_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_PriorityController : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_PriorityController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PriorityController_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_PriorityController : OUT STD_LOGIC;
                    signal cpu_data_master_granted_PriorityController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_PriorityController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PriorityController_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_PriorityController_avalon_slave : OUT STD_LOGIC;
                    signal d1_PriorityController_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component PriorityController_avalon_slave_arbitrator;

component ReplyDelay_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal Data_from_the_ReplyDelay : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Address_to_the_ReplyDelay : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_from_the_ReplyDelay_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_ReplyDelay : OUT STD_LOGIC;
                    signal ReplyDelay_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal cpu_data_master_granted_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_ReplyDelay_avalon_slave : OUT STD_LOGIC;
                    signal d1_ReplyDelay_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component ReplyDelay_avalon_slave_arbitrator;

component SPI_FRAM_spi_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal SPI_FRAM_spi_control_port_dataavailable : IN STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_endofpacket : IN STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_FRAM_spi_control_port_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal SPI_FRAM_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal SPI_FRAM_spi_control_port_chipselect : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_read_n : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_FRAM_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_reset_n : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_write_n : OUT STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_granted_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_requests_SPI_FRAM_spi_control_port : OUT STD_LOGIC;
                    signal d1_SPI_FRAM_spi_control_port_end_xfer : OUT STD_LOGIC
                 );
end component SPI_FRAM_spi_control_port_arbitrator;

component SPI_FRAM is 
           port (
                 -- inputs:
                    signal MISO : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_from_cpu : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal mem_addr : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal spi_select : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal MOSI : OUT STD_LOGIC;
                    signal SCLK : OUT STD_LOGIC;
                    signal SS_n : OUT STD_LOGIC;
                    signal data_to_cpu : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal dataavailable : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component SPI_FRAM;

component SPI_Flash_spi_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal SPI_Flash_spi_control_port_dataavailable : IN STD_LOGIC;
                    signal SPI_Flash_spi_control_port_endofpacket : IN STD_LOGIC;
                    signal SPI_Flash_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Flash_spi_control_port_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal SPI_Flash_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal SPI_Flash_spi_control_port_chipselect : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_read_n : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Flash_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_reset_n : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_write_n : OUT STD_LOGIC;
                    signal SPI_Flash_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_granted_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_requests_SPI_Flash_spi_control_port : OUT STD_LOGIC;
                    signal d1_SPI_Flash_spi_control_port_end_xfer : OUT STD_LOGIC
                 );
end component SPI_Flash_spi_control_port_arbitrator;

component SPI_Flash is 
           port (
                 -- inputs:
                    signal MISO : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_from_cpu : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal mem_addr : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal spi_select : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal MOSI : OUT STD_LOGIC;
                    signal SCLK : OUT STD_LOGIC;
                    signal SS_n : OUT STD_LOGIC;
                    signal data_to_cpu : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal dataavailable : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component SPI_Flash;

component SPI_Synthesizer_spi_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal SPI_Synthesizer_spi_control_port_dataavailable : IN STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_endofpacket : IN STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Synthesizer_spi_control_port_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal SPI_Synthesizer_spi_control_port_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal SPI_Synthesizer_spi_control_port_chipselect : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_read_n : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Synthesizer_spi_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_reset_n : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_write_n : OUT STD_LOGIC;
                    signal SPI_Synthesizer_spi_control_port_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_granted_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_requests_SPI_Synthesizer_spi_control_port : OUT STD_LOGIC;
                    signal d1_SPI_Synthesizer_spi_control_port_end_xfer : OUT STD_LOGIC
                 );
end component SPI_Synthesizer_spi_control_port_arbitrator;

component SPI_Synthesizer is 
           port (
                 -- inputs:
                    signal MISO : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_from_cpu : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal mem_addr : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal spi_select : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal MOSI : OUT STD_LOGIC;
                    signal SCLK : OUT STD_LOGIC;
                    signal SS_n : OUT STD_LOGIC;
                    signal data_to_cpu : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal dataavailable : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component SPI_Synthesizer;

component SelectMuxChannel_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_to_the_SelectMuxChannel : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal SelectMuxChannel_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal WR_to_the_SelectMuxChannel : OUT STD_LOGIC;
                    signal cpu_data_master_granted_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_SelectMuxChannel_avalon_slave : OUT STD_LOGIC;
                    signal d1_SelectMuxChannel_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component SelectMuxChannel_avalon_slave_arbitrator;

component Synthesizer_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal Data_from_the_Synthesizer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal Data_from_the_Synthesizer_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_Synthesizer : OUT STD_LOGIC;
                    signal Synthesizer_avalon_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal cpu_data_master_granted_Synthesizer_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_Synthesizer_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Synthesizer_avalon_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_Synthesizer_avalon_slave : OUT STD_LOGIC;
                    signal d1_Synthesizer_avalon_slave_end_xfer : OUT STD_LOGIC
                 );
end component Synthesizer_avalon_slave_arbitrator;

component TriStateBridge_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal SRAM_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal address_to_the_SRAM : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal be_n_to_the_SRAM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_granted_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_SRAM_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_SRAM_s1 : OUT STD_LOGIC;
                    signal d1_TriStateBridge_avalon_slave_end_xfer : OUT STD_LOGIC;
                    signal data_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal incoming_data_to_and_from_the_SRAM : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal read_n_to_the_SRAM : OUT STD_LOGIC;
                    signal select_n_to_the_SRAM : OUT STD_LOGIC;
                    signal write_n_to_the_SRAM : OUT STD_LOGIC
                 );
end component TriStateBridge_avalon_slave_arbitrator;

component TriStateBridge is 
end component TriStateBridge;

component TriStateBridge_bridge_arbitrator is 
end component TriStateBridge_bridge_arbitrator;

component UART_1_s1_arbitrator is 
           port (
                 -- inputs:
                    signal UART_1_s1_dataavailable : IN STD_LOGIC;
                    signal UART_1_s1_irq : IN STD_LOGIC;
                    signal UART_1_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal UART_1_s1_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal UART_1_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal UART_1_s1_begintransfer : OUT STD_LOGIC;
                    signal UART_1_s1_chipselect : OUT STD_LOGIC;
                    signal UART_1_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal UART_1_s1_irq_from_sa : OUT STD_LOGIC;
                    signal UART_1_s1_read_n : OUT STD_LOGIC;
                    signal UART_1_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal UART_1_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal UART_1_s1_reset_n : OUT STD_LOGIC;
                    signal UART_1_s1_write_n : OUT STD_LOGIC;
                    signal UART_1_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_granted_UART_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_UART_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_UART_1_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_UART_1_s1 : OUT STD_LOGIC;
                    signal d1_UART_1_s1_end_xfer : OUT STD_LOGIC
                 );
end component UART_1_s1_arbitrator;

component UART_1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component UART_1;

component UART_13_s1_arbitrator is 
           port (
                 -- inputs:
                    signal UART_13_s1_dataavailable : IN STD_LOGIC;
                    signal UART_13_s1_irq : IN STD_LOGIC;
                    signal UART_13_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal UART_13_s1_readyfordata : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal UART_13_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal UART_13_s1_begintransfer : OUT STD_LOGIC;
                    signal UART_13_s1_chipselect : OUT STD_LOGIC;
                    signal UART_13_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal UART_13_s1_irq_from_sa : OUT STD_LOGIC;
                    signal UART_13_s1_read_n : OUT STD_LOGIC;
                    signal UART_13_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal UART_13_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal UART_13_s1_reset_n : OUT STD_LOGIC;
                    signal UART_13_s1_write_n : OUT STD_LOGIC;
                    signal UART_13_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_granted_UART_13_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_UART_13_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_UART_13_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_UART_13_s1 : OUT STD_LOGIC;
                    signal d1_UART_13_s1_end_xfer : OUT STD_LOGIC
                 );
end component UART_13_s1_arbitrator;

component UART_13 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component UART_13;

component cpu_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_jtag_debug_module_arbitrator;

component cpu_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal ADCSamples1_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal ADCSamples2_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal DACSamples_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal Data_from_the_LogicReader_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Data_from_the_PairsCounter_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Data_from_the_ReplyDelay_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Data_from_the_Synthesizer_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Decoder_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal Deterctor_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal HIPController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal IDController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal Indicator_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal KSController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal KontrolGenerator_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal LogicReader_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal ODController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal PairsCounter_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal PriorityController_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal RData_from_the_ADCSamples1_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RData_from_the_ADCSamples2_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ReplyDelay_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal SPI_FRAM_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Flash_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SPI_Synthesizer_spi_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal SelectMuxChannel_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal Synthesizer_avalon_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal UART_13_s1_irq_from_sa : IN STD_LOGIC;
                    signal UART_13_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal UART_1_s1_irq_from_sa : IN STD_LOGIC;
                    signal UART_1_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_granted_ADCSamples1_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_ADCSamples2_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_DACSamples_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_Decoder_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_Deterctor_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_HIPController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_IDController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_Indicator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_KSController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_LogicReader_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_ODController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_PairsCounter_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_PriorityController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_ReplyDelay_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_granted_SPI_Flash_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_granted_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_granted_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_Synthesizer_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_UART_13_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_UART_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_granted_inp_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_out_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_ADCSamples1_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_ADCSamples2_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_DACSamples_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_Decoder_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_Deterctor_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_HIPController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_IDController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_Indicator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_KSController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_LogicReader_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_ODController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PairsCounter_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_PriorityController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_ReplyDelay_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_Flash_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_Synthesizer_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_UART_13_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_UART_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_inp_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_out_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_DACSamples_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Decoder_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Deterctor_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_HIPController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_IDController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Indicator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_KSController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_LogicReader_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ODController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PairsCounter_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_PriorityController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ReplyDelay_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_Flash_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_Synthesizer_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_UART_13_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_UART_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_inp_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_out_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_ADCSamples1_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_ADCSamples2_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_DACSamples_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_Decoder_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_Deterctor_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_HIPController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_IDController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_Indicator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_KSController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_KontrolGenerator_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_LogicReader_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_ODController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_PairsCounter_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_PriorityController_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_ReplyDelay_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_SPI_FRAM_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_requests_SPI_Flash_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_requests_SPI_Synthesizer_spi_control_port : IN STD_LOGIC;
                    signal cpu_data_master_requests_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_SelectMuxChannel_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_Synthesizer_avalon_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_UART_13_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_UART_1_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_data_master_requests_inp_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_out_pio_s1 : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_ADCSamples1_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_ADCSamples2_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_DACSamples_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Decoder_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Deterctor_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_HIPController_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_IDController_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Indicator_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_KSController_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_KontrolGenerator_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_LogicReader_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_ODController_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_PairsCounter_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_PriorityController_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_ReplyDelay_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_SPI_FRAM_spi_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_SPI_Flash_spi_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_SPI_Synthesizer_spi_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_SelectMuxChannel_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Synthesizer_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_TriStateBridge_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_UART_13_s1_end_xfer : IN STD_LOGIC;
                    signal d1_UART_1_s1_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal d1_inp_pio_s1_end_xfer : IN STD_LOGIC;
                    signal d1_out_pio_s1_end_xfer : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_irq_from_sa : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal incoming_data_to_and_from_the_SRAM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal inp_pio_s1_irq_from_sa : IN STD_LOGIC;
                    signal inp_pio_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal out_pio_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_data_master_arbitrator;

component cpu_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal SRAM_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_instruction_master_granted_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_SRAM_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_TriStateBridge_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal incoming_data_to_and_from_the_SRAM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_instruction_master_arbitrator;

component cpu is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdatavalid : IN STD_LOGIC;
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_readdatavalid : IN STD_LOGIC;
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu;

component epcs_flash_controller_epcs_control_port_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_dataavailable : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_endofpacket : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_irq : IN STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_readyfordata : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port : OUT STD_LOGIC;
                    signal d1_epcs_flash_controller_epcs_control_port_end_xfer : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_chipselect : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_irq_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_read_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_reset_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_write_n : OUT STD_LOGIC;
                    signal epcs_flash_controller_epcs_control_port_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component epcs_flash_controller_epcs_control_port_arbitrator;

component epcs_flash_controller is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal endofpacket : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC
                 );
end component epcs_flash_controller;

component inp_pio_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal inp_pio_s1_irq : IN STD_LOGIC;
                    signal inp_pio_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_inp_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_inp_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_inp_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_inp_pio_s1 : OUT STD_LOGIC;
                    signal d1_inp_pio_s1_end_xfer : OUT STD_LOGIC;
                    signal inp_pio_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal inp_pio_s1_chipselect : OUT STD_LOGIC;
                    signal inp_pio_s1_irq_from_sa : OUT STD_LOGIC;
                    signal inp_pio_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal inp_pio_s1_reset_n : OUT STD_LOGIC;
                    signal inp_pio_s1_write_n : OUT STD_LOGIC;
                    signal inp_pio_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component inp_pio_s1_arbitrator;

component inp_pio is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component inp_pio;

component out_pio_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
                    signal cpu_data_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal out_pio_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_out_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_out_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_out_pio_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_out_pio_s1 : OUT STD_LOGIC;
                    signal d1_out_pio_s1_end_xfer : OUT STD_LOGIC;
                    signal out_pio_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal out_pio_s1_chipselect : OUT STD_LOGIC;
                    signal out_pio_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal out_pio_s1_reset_n : OUT STD_LOGIC;
                    signal out_pio_s1_write_n : OUT STD_LOGIC;
                    signal out_pio_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component out_pio_s1_arbitrator;

component out_pio is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component out_pio;

component DME_ControllerUnit_reset_CLK_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component DME_ControllerUnit_reset_CLK_domain_synch_module;

                signal ADCSamples1_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal ADCSamples2_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal CLK_reset_n :  STD_LOGIC;
                signal DACSamples_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal Data_from_the_LogicReader_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_PairsCounter_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_ReplyDelay_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_Synthesizer_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Decoder_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal Deterctor_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal HIPController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal IDController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal Indicator_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_address :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_irq :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal KSController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal KontrolGenerator_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal LogicReader_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal ODController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal PairsCounter_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal PriorityController_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal RData_from_the_ADCSamples1_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal RData_from_the_ADCSamples2_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal ReplyDelay_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal SPI_FRAM_spi_control_port_chipselect :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_dataavailable :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_endofpacket :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_irq :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_read_n :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_FRAM_spi_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_FRAM_spi_control_port_readyfordata :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_reset_n :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_write_n :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Flash_spi_control_port_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal SPI_Flash_spi_control_port_chipselect :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_dataavailable :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_endofpacket :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_irq :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_read_n :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Flash_spi_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Flash_spi_control_port_readyfordata :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_reset_n :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_write_n :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Synthesizer_spi_control_port_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal SPI_Synthesizer_spi_control_port_chipselect :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_dataavailable :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_endofpacket :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_irq :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_read_n :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Synthesizer_spi_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SPI_Synthesizer_spi_control_port_readyfordata :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_reset_n :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_write_n :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal SelectMuxChannel_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal Synthesizer_avalon_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal UART_13_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal UART_13_s1_begintransfer :  STD_LOGIC;
                signal UART_13_s1_chipselect :  STD_LOGIC;
                signal UART_13_s1_dataavailable :  STD_LOGIC;
                signal UART_13_s1_dataavailable_from_sa :  STD_LOGIC;
                signal UART_13_s1_irq :  STD_LOGIC;
                signal UART_13_s1_irq_from_sa :  STD_LOGIC;
                signal UART_13_s1_read_n :  STD_LOGIC;
                signal UART_13_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal UART_13_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal UART_13_s1_readyfordata :  STD_LOGIC;
                signal UART_13_s1_readyfordata_from_sa :  STD_LOGIC;
                signal UART_13_s1_reset_n :  STD_LOGIC;
                signal UART_13_s1_write_n :  STD_LOGIC;
                signal UART_13_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal UART_1_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal UART_1_s1_begintransfer :  STD_LOGIC;
                signal UART_1_s1_chipselect :  STD_LOGIC;
                signal UART_1_s1_dataavailable :  STD_LOGIC;
                signal UART_1_s1_dataavailable_from_sa :  STD_LOGIC;
                signal UART_1_s1_irq :  STD_LOGIC;
                signal UART_1_s1_irq_from_sa :  STD_LOGIC;
                signal UART_1_s1_read_n :  STD_LOGIC;
                signal UART_1_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal UART_1_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal UART_1_s1_readyfordata :  STD_LOGIC;
                signal UART_1_s1_readyfordata_from_sa :  STD_LOGIC;
                signal UART_1_s1_reset_n :  STD_LOGIC;
                signal UART_1_s1_write_n :  STD_LOGIC;
                signal UART_1_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_data_master_address :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_debugaccess :  STD_LOGIC;
                signal cpu_data_master_granted_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_DACSamples_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_Decoder_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_Deterctor_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_HIPController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_IDController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_Indicator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_granted_KSController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_LogicReader_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_ODController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_PairsCounter_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_PriorityController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_granted_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_granted_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_granted_SRAM_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_Synthesizer_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_granted_UART_13_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_UART_1_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_granted_inp_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_out_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_qualified_request_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_DACSamples_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_Decoder_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_Deterctor_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_HIPController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_IDController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_Indicator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_KSController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_LogicReader_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_ODController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PairsCounter_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_PriorityController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_qualified_request_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_qualified_request_SRAM_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_Synthesizer_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_UART_13_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_UART_1_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_qualified_request_inp_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_out_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_read :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_DACSamples_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_Decoder_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_Deterctor_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_HIPController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_IDController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_Indicator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_KSController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_LogicReader_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ODController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PairsCounter_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_PriorityController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SRAM_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_Synthesizer_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_UART_13_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_UART_1_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_inp_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_out_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_readdatavalid :  STD_LOGIC;
                signal cpu_data_master_requests_ADCSamples1_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_ADCSamples2_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_DACSamples_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_Decoder_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_Deterctor_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_HIPController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_IDController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_Indicator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_requests_KSController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_KontrolGenerator_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_LogicReader_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_ODController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_PairsCounter_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_PriorityController_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_ReplyDelay_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_SPI_FRAM_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_requests_SPI_Flash_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_requests_SPI_Synthesizer_spi_control_port :  STD_LOGIC;
                signal cpu_data_master_requests_SRAM_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_SelectMuxChannel_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_Synthesizer_avalon_slave :  STD_LOGIC;
                signal cpu_data_master_requests_UART_13_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_UART_1_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_data_master_requests_inp_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_out_pio_s1 :  STD_LOGIC;
                signal cpu_data_master_waitrequest :  STD_LOGIC;
                signal cpu_data_master_write :  STD_LOGIC;
                signal cpu_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_address :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (20 DOWNTO 0);
                signal cpu_instruction_master_granted_SRAM_s1 :  STD_LOGIC;
                signal cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_qualified_request_SRAM_s1 :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_read :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_SRAM_s1 :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal cpu_instruction_master_requests_SRAM_s1 :  STD_LOGIC;
                signal cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port :  STD_LOGIC;
                signal cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_reset_n :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_ADCSamples1_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_ADCSamples2_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_DACSamples_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_Decoder_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_Deterctor_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_HIPController_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_IDController_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_Indicator_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_JTAG_UART_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_KSController_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_KontrolGenerator_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_LogicReader_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_ODController_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_PairsCounter_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_PriorityController_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_ReplyDelay_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_SPI_FRAM_spi_control_port_end_xfer :  STD_LOGIC;
                signal d1_SPI_Flash_spi_control_port_end_xfer :  STD_LOGIC;
                signal d1_SPI_Synthesizer_spi_control_port_end_xfer :  STD_LOGIC;
                signal d1_SelectMuxChannel_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_Synthesizer_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_TriStateBridge_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_UART_13_s1_end_xfer :  STD_LOGIC;
                signal d1_UART_1_s1_end_xfer :  STD_LOGIC;
                signal d1_cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_epcs_flash_controller_epcs_control_port_end_xfer :  STD_LOGIC;
                signal d1_inp_pio_s1_end_xfer :  STD_LOGIC;
                signal d1_out_pio_s1_end_xfer :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_chipselect :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_dataavailable :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_irq :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_irq_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_read_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_readyfordata :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_reset_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_write_n :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal incoming_data_to_and_from_the_SRAM :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal inp_pio_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal inp_pio_s1_chipselect :  STD_LOGIC;
                signal inp_pio_s1_irq :  STD_LOGIC;
                signal inp_pio_s1_irq_from_sa :  STD_LOGIC;
                signal inp_pio_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal inp_pio_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal inp_pio_s1_reset_n :  STD_LOGIC;
                signal inp_pio_s1_write_n :  STD_LOGIC;
                signal inp_pio_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Address_to_the_ADCSamples1 :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal internal_Address_to_the_ADCSamples2 :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal internal_Address_to_the_DACSamples :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal internal_Address_to_the_Decoder :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_Address_to_the_Deterctor :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_Address_to_the_IDController :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal internal_Address_to_the_KSController :  STD_LOGIC;
                signal internal_Address_to_the_ODController :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal internal_Address_to_the_PriorityController :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_Address_to_the_ReplyDelay :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_Data_to_the_DACSamples :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_Decoder :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_Deterctor :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_HIPController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_Indicator :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_KSController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_KontrolGenerator :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_ODController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_PriorityController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_Data_to_the_SelectMuxChannel :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_MOSI_from_the_SPI_FRAM :  STD_LOGIC;
                signal internal_MOSI_from_the_SPI_Flash :  STD_LOGIC;
                signal internal_MOSI_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal internal_RD_to_the_ADCSamples1 :  STD_LOGIC;
                signal internal_RD_to_the_ADCSamples2 :  STD_LOGIC;
                signal internal_RD_to_the_LogicReader :  STD_LOGIC;
                signal internal_RD_to_the_PairsCounter :  STD_LOGIC;
                signal internal_RD_to_the_ReplyDelay :  STD_LOGIC;
                signal internal_RD_to_the_Synthesizer :  STD_LOGIC;
                signal internal_SCLK_from_the_SPI_FRAM :  STD_LOGIC;
                signal internal_SCLK_from_the_SPI_Flash :  STD_LOGIC;
                signal internal_SCLK_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal internal_SS_n_from_the_SPI_FRAM :  STD_LOGIC;
                signal internal_SS_n_from_the_SPI_Flash :  STD_LOGIC;
                signal internal_SS_n_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal internal_WData_to_the_IDController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_WR_to_the_DACSamples :  STD_LOGIC;
                signal internal_WR_to_the_Decoder :  STD_LOGIC;
                signal internal_WR_to_the_Deterctor :  STD_LOGIC;
                signal internal_WR_to_the_HIPController :  STD_LOGIC;
                signal internal_WR_to_the_IDController :  STD_LOGIC;
                signal internal_WR_to_the_Indicator :  STD_LOGIC;
                signal internal_WR_to_the_KSController :  STD_LOGIC;
                signal internal_WR_to_the_KontrolGenerator :  STD_LOGIC;
                signal internal_WR_to_the_ODController :  STD_LOGIC;
                signal internal_WR_to_the_PriorityController :  STD_LOGIC;
                signal internal_WR_to_the_SelectMuxChannel :  STD_LOGIC;
                signal internal_address_to_the_SRAM :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal internal_be_n_to_the_SRAM :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal internal_out_port_from_the_out_pio :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_read_n_to_the_SRAM :  STD_LOGIC;
                signal internal_select_n_to_the_SRAM :  STD_LOGIC;
                signal internal_txd_from_the_UART_1 :  STD_LOGIC;
                signal internal_txd_from_the_UART_13 :  STD_LOGIC;
                signal internal_write_n_to_the_SRAM :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal out_pio_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal out_pio_s1_chipselect :  STD_LOGIC;
                signal out_pio_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal out_pio_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal out_pio_s1_reset_n :  STD_LOGIC;
                signal out_pio_s1_write_n :  STD_LOGIC;
                signal out_pio_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;

begin

  --the_ADCSamples1_avalon_slave, which is an e_instance
  the_ADCSamples1_avalon_slave : ADCSamples1_avalon_slave_arbitrator
    port map(
      ADCSamples1_avalon_slave_wait_counter_eq_0 => ADCSamples1_avalon_slave_wait_counter_eq_0,
      Address_to_the_ADCSamples1 => internal_Address_to_the_ADCSamples1,
      RD_to_the_ADCSamples1 => internal_RD_to_the_ADCSamples1,
      RData_from_the_ADCSamples1_from_sa => RData_from_the_ADCSamples1_from_sa,
      cpu_data_master_granted_ADCSamples1_avalon_slave => cpu_data_master_granted_ADCSamples1_avalon_slave,
      cpu_data_master_qualified_request_ADCSamples1_avalon_slave => cpu_data_master_qualified_request_ADCSamples1_avalon_slave,
      cpu_data_master_read_data_valid_ADCSamples1_avalon_slave => cpu_data_master_read_data_valid_ADCSamples1_avalon_slave,
      cpu_data_master_requests_ADCSamples1_avalon_slave => cpu_data_master_requests_ADCSamples1_avalon_slave,
      d1_ADCSamples1_avalon_slave_end_xfer => d1_ADCSamples1_avalon_slave_end_xfer,
      RData_from_the_ADCSamples1 => RData_from_the_ADCSamples1,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_ADCSamples2_avalon_slave, which is an e_instance
  the_ADCSamples2_avalon_slave : ADCSamples2_avalon_slave_arbitrator
    port map(
      ADCSamples2_avalon_slave_wait_counter_eq_0 => ADCSamples2_avalon_slave_wait_counter_eq_0,
      Address_to_the_ADCSamples2 => internal_Address_to_the_ADCSamples2,
      RD_to_the_ADCSamples2 => internal_RD_to_the_ADCSamples2,
      RData_from_the_ADCSamples2_from_sa => RData_from_the_ADCSamples2_from_sa,
      cpu_data_master_granted_ADCSamples2_avalon_slave => cpu_data_master_granted_ADCSamples2_avalon_slave,
      cpu_data_master_qualified_request_ADCSamples2_avalon_slave => cpu_data_master_qualified_request_ADCSamples2_avalon_slave,
      cpu_data_master_read_data_valid_ADCSamples2_avalon_slave => cpu_data_master_read_data_valid_ADCSamples2_avalon_slave,
      cpu_data_master_requests_ADCSamples2_avalon_slave => cpu_data_master_requests_ADCSamples2_avalon_slave,
      d1_ADCSamples2_avalon_slave_end_xfer => d1_ADCSamples2_avalon_slave_end_xfer,
      RData_from_the_ADCSamples2 => RData_from_the_ADCSamples2,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_DACSamples_avalon_slave, which is an e_instance
  the_DACSamples_avalon_slave : DACSamples_avalon_slave_arbitrator
    port map(
      Address_to_the_DACSamples => internal_Address_to_the_DACSamples,
      DACSamples_avalon_slave_wait_counter_eq_0 => DACSamples_avalon_slave_wait_counter_eq_0,
      Data_to_the_DACSamples => internal_Data_to_the_DACSamples,
      WR_to_the_DACSamples => internal_WR_to_the_DACSamples,
      cpu_data_master_granted_DACSamples_avalon_slave => cpu_data_master_granted_DACSamples_avalon_slave,
      cpu_data_master_qualified_request_DACSamples_avalon_slave => cpu_data_master_qualified_request_DACSamples_avalon_slave,
      cpu_data_master_read_data_valid_DACSamples_avalon_slave => cpu_data_master_read_data_valid_DACSamples_avalon_slave,
      cpu_data_master_requests_DACSamples_avalon_slave => cpu_data_master_requests_DACSamples_avalon_slave,
      d1_DACSamples_avalon_slave_end_xfer => d1_DACSamples_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_Decoder_avalon_slave, which is an e_instance
  the_Decoder_avalon_slave : Decoder_avalon_slave_arbitrator
    port map(
      Address_to_the_Decoder => internal_Address_to_the_Decoder,
      Data_to_the_Decoder => internal_Data_to_the_Decoder,
      Decoder_avalon_slave_wait_counter_eq_0 => Decoder_avalon_slave_wait_counter_eq_0,
      WR_to_the_Decoder => internal_WR_to_the_Decoder,
      cpu_data_master_granted_Decoder_avalon_slave => cpu_data_master_granted_Decoder_avalon_slave,
      cpu_data_master_qualified_request_Decoder_avalon_slave => cpu_data_master_qualified_request_Decoder_avalon_slave,
      cpu_data_master_read_data_valid_Decoder_avalon_slave => cpu_data_master_read_data_valid_Decoder_avalon_slave,
      cpu_data_master_requests_Decoder_avalon_slave => cpu_data_master_requests_Decoder_avalon_slave,
      d1_Decoder_avalon_slave_end_xfer => d1_Decoder_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_Deterctor_avalon_slave, which is an e_instance
  the_Deterctor_avalon_slave : Deterctor_avalon_slave_arbitrator
    port map(
      Address_to_the_Deterctor => internal_Address_to_the_Deterctor,
      Data_to_the_Deterctor => internal_Data_to_the_Deterctor,
      Deterctor_avalon_slave_wait_counter_eq_0 => Deterctor_avalon_slave_wait_counter_eq_0,
      WR_to_the_Deterctor => internal_WR_to_the_Deterctor,
      cpu_data_master_granted_Deterctor_avalon_slave => cpu_data_master_granted_Deterctor_avalon_slave,
      cpu_data_master_qualified_request_Deterctor_avalon_slave => cpu_data_master_qualified_request_Deterctor_avalon_slave,
      cpu_data_master_read_data_valid_Deterctor_avalon_slave => cpu_data_master_read_data_valid_Deterctor_avalon_slave,
      cpu_data_master_requests_Deterctor_avalon_slave => cpu_data_master_requests_Deterctor_avalon_slave,
      d1_Deterctor_avalon_slave_end_xfer => d1_Deterctor_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_HIPController_avalon_slave, which is an e_instance
  the_HIPController_avalon_slave : HIPController_avalon_slave_arbitrator
    port map(
      Data_to_the_HIPController => internal_Data_to_the_HIPController,
      HIPController_avalon_slave_wait_counter_eq_0 => HIPController_avalon_slave_wait_counter_eq_0,
      WR_to_the_HIPController => internal_WR_to_the_HIPController,
      cpu_data_master_granted_HIPController_avalon_slave => cpu_data_master_granted_HIPController_avalon_slave,
      cpu_data_master_qualified_request_HIPController_avalon_slave => cpu_data_master_qualified_request_HIPController_avalon_slave,
      cpu_data_master_read_data_valid_HIPController_avalon_slave => cpu_data_master_read_data_valid_HIPController_avalon_slave,
      cpu_data_master_requests_HIPController_avalon_slave => cpu_data_master_requests_HIPController_avalon_slave,
      d1_HIPController_avalon_slave_end_xfer => d1_HIPController_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_IDController_avalon_slave, which is an e_instance
  the_IDController_avalon_slave : IDController_avalon_slave_arbitrator
    port map(
      Address_to_the_IDController => internal_Address_to_the_IDController,
      IDController_avalon_slave_wait_counter_eq_0 => IDController_avalon_slave_wait_counter_eq_0,
      WData_to_the_IDController => internal_WData_to_the_IDController,
      WR_to_the_IDController => internal_WR_to_the_IDController,
      cpu_data_master_granted_IDController_avalon_slave => cpu_data_master_granted_IDController_avalon_slave,
      cpu_data_master_qualified_request_IDController_avalon_slave => cpu_data_master_qualified_request_IDController_avalon_slave,
      cpu_data_master_read_data_valid_IDController_avalon_slave => cpu_data_master_read_data_valid_IDController_avalon_slave,
      cpu_data_master_requests_IDController_avalon_slave => cpu_data_master_requests_IDController_avalon_slave,
      d1_IDController_avalon_slave_end_xfer => d1_IDController_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_Indicator_avalon_slave, which is an e_instance
  the_Indicator_avalon_slave : Indicator_avalon_slave_arbitrator
    port map(
      Data_to_the_Indicator => internal_Data_to_the_Indicator,
      Indicator_avalon_slave_wait_counter_eq_0 => Indicator_avalon_slave_wait_counter_eq_0,
      WR_to_the_Indicator => internal_WR_to_the_Indicator,
      cpu_data_master_granted_Indicator_avalon_slave => cpu_data_master_granted_Indicator_avalon_slave,
      cpu_data_master_qualified_request_Indicator_avalon_slave => cpu_data_master_qualified_request_Indicator_avalon_slave,
      cpu_data_master_read_data_valid_Indicator_avalon_slave => cpu_data_master_read_data_valid_Indicator_avalon_slave,
      cpu_data_master_requests_Indicator_avalon_slave => cpu_data_master_requests_Indicator_avalon_slave,
      d1_Indicator_avalon_slave_end_xfer => d1_Indicator_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_JTAG_UART_avalon_jtag_slave, which is an e_instance
  the_JTAG_UART_avalon_jtag_slave : JTAG_UART_avalon_jtag_slave_arbitrator
    port map(
      JTAG_UART_avalon_jtag_slave_address => JTAG_UART_avalon_jtag_slave_address,
      JTAG_UART_avalon_jtag_slave_chipselect => JTAG_UART_avalon_jtag_slave_chipselect,
      JTAG_UART_avalon_jtag_slave_dataavailable_from_sa => JTAG_UART_avalon_jtag_slave_dataavailable_from_sa,
      JTAG_UART_avalon_jtag_slave_irq_from_sa => JTAG_UART_avalon_jtag_slave_irq_from_sa,
      JTAG_UART_avalon_jtag_slave_read_n => JTAG_UART_avalon_jtag_slave_read_n,
      JTAG_UART_avalon_jtag_slave_readdata_from_sa => JTAG_UART_avalon_jtag_slave_readdata_from_sa,
      JTAG_UART_avalon_jtag_slave_readyfordata_from_sa => JTAG_UART_avalon_jtag_slave_readyfordata_from_sa,
      JTAG_UART_avalon_jtag_slave_reset_n => JTAG_UART_avalon_jtag_slave_reset_n,
      JTAG_UART_avalon_jtag_slave_waitrequest_from_sa => JTAG_UART_avalon_jtag_slave_waitrequest_from_sa,
      JTAG_UART_avalon_jtag_slave_write_n => JTAG_UART_avalon_jtag_slave_write_n,
      JTAG_UART_avalon_jtag_slave_writedata => JTAG_UART_avalon_jtag_slave_writedata,
      cpu_data_master_granted_JTAG_UART_avalon_jtag_slave => cpu_data_master_granted_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave => cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave => cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_requests_JTAG_UART_avalon_jtag_slave => cpu_data_master_requests_JTAG_UART_avalon_jtag_slave,
      d1_JTAG_UART_avalon_jtag_slave_end_xfer => d1_JTAG_UART_avalon_jtag_slave_end_xfer,
      JTAG_UART_avalon_jtag_slave_dataavailable => JTAG_UART_avalon_jtag_slave_dataavailable,
      JTAG_UART_avalon_jtag_slave_irq => JTAG_UART_avalon_jtag_slave_irq,
      JTAG_UART_avalon_jtag_slave_readdata => JTAG_UART_avalon_jtag_slave_readdata,
      JTAG_UART_avalon_jtag_slave_readyfordata => JTAG_UART_avalon_jtag_slave_readyfordata,
      JTAG_UART_avalon_jtag_slave_waitrequest => JTAG_UART_avalon_jtag_slave_waitrequest,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_JTAG_UART, which is an e_ptf_instance
  the_JTAG_UART : JTAG_UART
    port map(
      av_irq => JTAG_UART_avalon_jtag_slave_irq,
      av_readdata => JTAG_UART_avalon_jtag_slave_readdata,
      av_waitrequest => JTAG_UART_avalon_jtag_slave_waitrequest,
      dataavailable => JTAG_UART_avalon_jtag_slave_dataavailable,
      readyfordata => JTAG_UART_avalon_jtag_slave_readyfordata,
      av_address => JTAG_UART_avalon_jtag_slave_address,
      av_chipselect => JTAG_UART_avalon_jtag_slave_chipselect,
      av_read_n => JTAG_UART_avalon_jtag_slave_read_n,
      av_write_n => JTAG_UART_avalon_jtag_slave_write_n,
      av_writedata => JTAG_UART_avalon_jtag_slave_writedata,
      clk => CLK,
      rst_n => JTAG_UART_avalon_jtag_slave_reset_n
    );


  --the_KSController_avalon_slave, which is an e_instance
  the_KSController_avalon_slave : KSController_avalon_slave_arbitrator
    port map(
      Address_to_the_KSController => internal_Address_to_the_KSController,
      Data_to_the_KSController => internal_Data_to_the_KSController,
      KSController_avalon_slave_wait_counter_eq_0 => KSController_avalon_slave_wait_counter_eq_0,
      WR_to_the_KSController => internal_WR_to_the_KSController,
      cpu_data_master_granted_KSController_avalon_slave => cpu_data_master_granted_KSController_avalon_slave,
      cpu_data_master_qualified_request_KSController_avalon_slave => cpu_data_master_qualified_request_KSController_avalon_slave,
      cpu_data_master_read_data_valid_KSController_avalon_slave => cpu_data_master_read_data_valid_KSController_avalon_slave,
      cpu_data_master_requests_KSController_avalon_slave => cpu_data_master_requests_KSController_avalon_slave,
      d1_KSController_avalon_slave_end_xfer => d1_KSController_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_KontrolGenerator_avalon_slave, which is an e_instance
  the_KontrolGenerator_avalon_slave : KontrolGenerator_avalon_slave_arbitrator
    port map(
      Data_to_the_KontrolGenerator => internal_Data_to_the_KontrolGenerator,
      KontrolGenerator_avalon_slave_wait_counter_eq_0 => KontrolGenerator_avalon_slave_wait_counter_eq_0,
      WR_to_the_KontrolGenerator => internal_WR_to_the_KontrolGenerator,
      cpu_data_master_granted_KontrolGenerator_avalon_slave => cpu_data_master_granted_KontrolGenerator_avalon_slave,
      cpu_data_master_qualified_request_KontrolGenerator_avalon_slave => cpu_data_master_qualified_request_KontrolGenerator_avalon_slave,
      cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave => cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave,
      cpu_data_master_requests_KontrolGenerator_avalon_slave => cpu_data_master_requests_KontrolGenerator_avalon_slave,
      d1_KontrolGenerator_avalon_slave_end_xfer => d1_KontrolGenerator_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_LogicReader_avalon_slave, which is an e_instance
  the_LogicReader_avalon_slave : LogicReader_avalon_slave_arbitrator
    port map(
      Data_from_the_LogicReader_from_sa => Data_from_the_LogicReader_from_sa,
      LogicReader_avalon_slave_wait_counter_eq_0 => LogicReader_avalon_slave_wait_counter_eq_0,
      RD_to_the_LogicReader => internal_RD_to_the_LogicReader,
      cpu_data_master_granted_LogicReader_avalon_slave => cpu_data_master_granted_LogicReader_avalon_slave,
      cpu_data_master_qualified_request_LogicReader_avalon_slave => cpu_data_master_qualified_request_LogicReader_avalon_slave,
      cpu_data_master_read_data_valid_LogicReader_avalon_slave => cpu_data_master_read_data_valid_LogicReader_avalon_slave,
      cpu_data_master_requests_LogicReader_avalon_slave => cpu_data_master_requests_LogicReader_avalon_slave,
      d1_LogicReader_avalon_slave_end_xfer => d1_LogicReader_avalon_slave_end_xfer,
      Data_from_the_LogicReader => Data_from_the_LogicReader,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_ODController_avalon_slave, which is an e_instance
  the_ODController_avalon_slave : ODController_avalon_slave_arbitrator
    port map(
      Address_to_the_ODController => internal_Address_to_the_ODController,
      Data_to_the_ODController => internal_Data_to_the_ODController,
      ODController_avalon_slave_wait_counter_eq_0 => ODController_avalon_slave_wait_counter_eq_0,
      WR_to_the_ODController => internal_WR_to_the_ODController,
      cpu_data_master_granted_ODController_avalon_slave => cpu_data_master_granted_ODController_avalon_slave,
      cpu_data_master_qualified_request_ODController_avalon_slave => cpu_data_master_qualified_request_ODController_avalon_slave,
      cpu_data_master_read_data_valid_ODController_avalon_slave => cpu_data_master_read_data_valid_ODController_avalon_slave,
      cpu_data_master_requests_ODController_avalon_slave => cpu_data_master_requests_ODController_avalon_slave,
      d1_ODController_avalon_slave_end_xfer => d1_ODController_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_PairsCounter_avalon_slave, which is an e_instance
  the_PairsCounter_avalon_slave : PairsCounter_avalon_slave_arbitrator
    port map(
      Data_from_the_PairsCounter_from_sa => Data_from_the_PairsCounter_from_sa,
      PairsCounter_avalon_slave_wait_counter_eq_0 => PairsCounter_avalon_slave_wait_counter_eq_0,
      RD_to_the_PairsCounter => internal_RD_to_the_PairsCounter,
      cpu_data_master_granted_PairsCounter_avalon_slave => cpu_data_master_granted_PairsCounter_avalon_slave,
      cpu_data_master_qualified_request_PairsCounter_avalon_slave => cpu_data_master_qualified_request_PairsCounter_avalon_slave,
      cpu_data_master_read_data_valid_PairsCounter_avalon_slave => cpu_data_master_read_data_valid_PairsCounter_avalon_slave,
      cpu_data_master_requests_PairsCounter_avalon_slave => cpu_data_master_requests_PairsCounter_avalon_slave,
      d1_PairsCounter_avalon_slave_end_xfer => d1_PairsCounter_avalon_slave_end_xfer,
      Data_from_the_PairsCounter => Data_from_the_PairsCounter,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_PriorityController_avalon_slave, which is an e_instance
  the_PriorityController_avalon_slave : PriorityController_avalon_slave_arbitrator
    port map(
      Address_to_the_PriorityController => internal_Address_to_the_PriorityController,
      Data_to_the_PriorityController => internal_Data_to_the_PriorityController,
      PriorityController_avalon_slave_wait_counter_eq_0 => PriorityController_avalon_slave_wait_counter_eq_0,
      WR_to_the_PriorityController => internal_WR_to_the_PriorityController,
      cpu_data_master_granted_PriorityController_avalon_slave => cpu_data_master_granted_PriorityController_avalon_slave,
      cpu_data_master_qualified_request_PriorityController_avalon_slave => cpu_data_master_qualified_request_PriorityController_avalon_slave,
      cpu_data_master_read_data_valid_PriorityController_avalon_slave => cpu_data_master_read_data_valid_PriorityController_avalon_slave,
      cpu_data_master_requests_PriorityController_avalon_slave => cpu_data_master_requests_PriorityController_avalon_slave,
      d1_PriorityController_avalon_slave_end_xfer => d1_PriorityController_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_ReplyDelay_avalon_slave, which is an e_instance
  the_ReplyDelay_avalon_slave : ReplyDelay_avalon_slave_arbitrator
    port map(
      Address_to_the_ReplyDelay => internal_Address_to_the_ReplyDelay,
      Data_from_the_ReplyDelay_from_sa => Data_from_the_ReplyDelay_from_sa,
      RD_to_the_ReplyDelay => internal_RD_to_the_ReplyDelay,
      ReplyDelay_avalon_slave_wait_counter_eq_0 => ReplyDelay_avalon_slave_wait_counter_eq_0,
      cpu_data_master_granted_ReplyDelay_avalon_slave => cpu_data_master_granted_ReplyDelay_avalon_slave,
      cpu_data_master_qualified_request_ReplyDelay_avalon_slave => cpu_data_master_qualified_request_ReplyDelay_avalon_slave,
      cpu_data_master_read_data_valid_ReplyDelay_avalon_slave => cpu_data_master_read_data_valid_ReplyDelay_avalon_slave,
      cpu_data_master_requests_ReplyDelay_avalon_slave => cpu_data_master_requests_ReplyDelay_avalon_slave,
      d1_ReplyDelay_avalon_slave_end_xfer => d1_ReplyDelay_avalon_slave_end_xfer,
      Data_from_the_ReplyDelay => Data_from_the_ReplyDelay,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_SPI_FRAM_spi_control_port, which is an e_instance
  the_SPI_FRAM_spi_control_port : SPI_FRAM_spi_control_port_arbitrator
    port map(
      SPI_FRAM_spi_control_port_address => SPI_FRAM_spi_control_port_address,
      SPI_FRAM_spi_control_port_chipselect => SPI_FRAM_spi_control_port_chipselect,
      SPI_FRAM_spi_control_port_dataavailable_from_sa => SPI_FRAM_spi_control_port_dataavailable_from_sa,
      SPI_FRAM_spi_control_port_endofpacket_from_sa => SPI_FRAM_spi_control_port_endofpacket_from_sa,
      SPI_FRAM_spi_control_port_read_n => SPI_FRAM_spi_control_port_read_n,
      SPI_FRAM_spi_control_port_readdata_from_sa => SPI_FRAM_spi_control_port_readdata_from_sa,
      SPI_FRAM_spi_control_port_readyfordata_from_sa => SPI_FRAM_spi_control_port_readyfordata_from_sa,
      SPI_FRAM_spi_control_port_reset_n => SPI_FRAM_spi_control_port_reset_n,
      SPI_FRAM_spi_control_port_write_n => SPI_FRAM_spi_control_port_write_n,
      SPI_FRAM_spi_control_port_writedata => SPI_FRAM_spi_control_port_writedata,
      cpu_data_master_granted_SPI_FRAM_spi_control_port => cpu_data_master_granted_SPI_FRAM_spi_control_port,
      cpu_data_master_qualified_request_SPI_FRAM_spi_control_port => cpu_data_master_qualified_request_SPI_FRAM_spi_control_port,
      cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port => cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port,
      cpu_data_master_requests_SPI_FRAM_spi_control_port => cpu_data_master_requests_SPI_FRAM_spi_control_port,
      d1_SPI_FRAM_spi_control_port_end_xfer => d1_SPI_FRAM_spi_control_port_end_xfer,
      SPI_FRAM_spi_control_port_dataavailable => SPI_FRAM_spi_control_port_dataavailable,
      SPI_FRAM_spi_control_port_endofpacket => SPI_FRAM_spi_control_port_endofpacket,
      SPI_FRAM_spi_control_port_readdata => SPI_FRAM_spi_control_port_readdata,
      SPI_FRAM_spi_control_port_readyfordata => SPI_FRAM_spi_control_port_readyfordata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_SPI_FRAM, which is an e_ptf_instance
  the_SPI_FRAM : SPI_FRAM
    port map(
      MOSI => internal_MOSI_from_the_SPI_FRAM,
      SCLK => internal_SCLK_from_the_SPI_FRAM,
      SS_n => internal_SS_n_from_the_SPI_FRAM,
      data_to_cpu => SPI_FRAM_spi_control_port_readdata,
      dataavailable => SPI_FRAM_spi_control_port_dataavailable,
      endofpacket => SPI_FRAM_spi_control_port_endofpacket,
      irq => SPI_FRAM_spi_control_port_irq,
      readyfordata => SPI_FRAM_spi_control_port_readyfordata,
      MISO => MISO_to_the_SPI_FRAM,
      clk => CLK,
      data_from_cpu => SPI_FRAM_spi_control_port_writedata,
      mem_addr => SPI_FRAM_spi_control_port_address,
      read_n => SPI_FRAM_spi_control_port_read_n,
      reset_n => SPI_FRAM_spi_control_port_reset_n,
      spi_select => SPI_FRAM_spi_control_port_chipselect,
      write_n => SPI_FRAM_spi_control_port_write_n
    );


  --the_SPI_Flash_spi_control_port, which is an e_instance
  the_SPI_Flash_spi_control_port : SPI_Flash_spi_control_port_arbitrator
    port map(
      SPI_Flash_spi_control_port_address => SPI_Flash_spi_control_port_address,
      SPI_Flash_spi_control_port_chipselect => SPI_Flash_spi_control_port_chipselect,
      SPI_Flash_spi_control_port_dataavailable_from_sa => SPI_Flash_spi_control_port_dataavailable_from_sa,
      SPI_Flash_spi_control_port_endofpacket_from_sa => SPI_Flash_spi_control_port_endofpacket_from_sa,
      SPI_Flash_spi_control_port_read_n => SPI_Flash_spi_control_port_read_n,
      SPI_Flash_spi_control_port_readdata_from_sa => SPI_Flash_spi_control_port_readdata_from_sa,
      SPI_Flash_spi_control_port_readyfordata_from_sa => SPI_Flash_spi_control_port_readyfordata_from_sa,
      SPI_Flash_spi_control_port_reset_n => SPI_Flash_spi_control_port_reset_n,
      SPI_Flash_spi_control_port_write_n => SPI_Flash_spi_control_port_write_n,
      SPI_Flash_spi_control_port_writedata => SPI_Flash_spi_control_port_writedata,
      cpu_data_master_granted_SPI_Flash_spi_control_port => cpu_data_master_granted_SPI_Flash_spi_control_port,
      cpu_data_master_qualified_request_SPI_Flash_spi_control_port => cpu_data_master_qualified_request_SPI_Flash_spi_control_port,
      cpu_data_master_read_data_valid_SPI_Flash_spi_control_port => cpu_data_master_read_data_valid_SPI_Flash_spi_control_port,
      cpu_data_master_requests_SPI_Flash_spi_control_port => cpu_data_master_requests_SPI_Flash_spi_control_port,
      d1_SPI_Flash_spi_control_port_end_xfer => d1_SPI_Flash_spi_control_port_end_xfer,
      SPI_Flash_spi_control_port_dataavailable => SPI_Flash_spi_control_port_dataavailable,
      SPI_Flash_spi_control_port_endofpacket => SPI_Flash_spi_control_port_endofpacket,
      SPI_Flash_spi_control_port_readdata => SPI_Flash_spi_control_port_readdata,
      SPI_Flash_spi_control_port_readyfordata => SPI_Flash_spi_control_port_readyfordata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_SPI_Flash, which is an e_ptf_instance
  the_SPI_Flash : SPI_Flash
    port map(
      MOSI => internal_MOSI_from_the_SPI_Flash,
      SCLK => internal_SCLK_from_the_SPI_Flash,
      SS_n => internal_SS_n_from_the_SPI_Flash,
      data_to_cpu => SPI_Flash_spi_control_port_readdata,
      dataavailable => SPI_Flash_spi_control_port_dataavailable,
      endofpacket => SPI_Flash_spi_control_port_endofpacket,
      irq => SPI_Flash_spi_control_port_irq,
      readyfordata => SPI_Flash_spi_control_port_readyfordata,
      MISO => MISO_to_the_SPI_Flash,
      clk => CLK,
      data_from_cpu => SPI_Flash_spi_control_port_writedata,
      mem_addr => SPI_Flash_spi_control_port_address,
      read_n => SPI_Flash_spi_control_port_read_n,
      reset_n => SPI_Flash_spi_control_port_reset_n,
      spi_select => SPI_Flash_spi_control_port_chipselect,
      write_n => SPI_Flash_spi_control_port_write_n
    );


  --the_SPI_Synthesizer_spi_control_port, which is an e_instance
  the_SPI_Synthesizer_spi_control_port : SPI_Synthesizer_spi_control_port_arbitrator
    port map(
      SPI_Synthesizer_spi_control_port_address => SPI_Synthesizer_spi_control_port_address,
      SPI_Synthesizer_spi_control_port_chipselect => SPI_Synthesizer_spi_control_port_chipselect,
      SPI_Synthesizer_spi_control_port_dataavailable_from_sa => SPI_Synthesizer_spi_control_port_dataavailable_from_sa,
      SPI_Synthesizer_spi_control_port_endofpacket_from_sa => SPI_Synthesizer_spi_control_port_endofpacket_from_sa,
      SPI_Synthesizer_spi_control_port_read_n => SPI_Synthesizer_spi_control_port_read_n,
      SPI_Synthesizer_spi_control_port_readdata_from_sa => SPI_Synthesizer_spi_control_port_readdata_from_sa,
      SPI_Synthesizer_spi_control_port_readyfordata_from_sa => SPI_Synthesizer_spi_control_port_readyfordata_from_sa,
      SPI_Synthesizer_spi_control_port_reset_n => SPI_Synthesizer_spi_control_port_reset_n,
      SPI_Synthesizer_spi_control_port_write_n => SPI_Synthesizer_spi_control_port_write_n,
      SPI_Synthesizer_spi_control_port_writedata => SPI_Synthesizer_spi_control_port_writedata,
      cpu_data_master_granted_SPI_Synthesizer_spi_control_port => cpu_data_master_granted_SPI_Synthesizer_spi_control_port,
      cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port => cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port,
      cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port => cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port,
      cpu_data_master_requests_SPI_Synthesizer_spi_control_port => cpu_data_master_requests_SPI_Synthesizer_spi_control_port,
      d1_SPI_Synthesizer_spi_control_port_end_xfer => d1_SPI_Synthesizer_spi_control_port_end_xfer,
      SPI_Synthesizer_spi_control_port_dataavailable => SPI_Synthesizer_spi_control_port_dataavailable,
      SPI_Synthesizer_spi_control_port_endofpacket => SPI_Synthesizer_spi_control_port_endofpacket,
      SPI_Synthesizer_spi_control_port_readdata => SPI_Synthesizer_spi_control_port_readdata,
      SPI_Synthesizer_spi_control_port_readyfordata => SPI_Synthesizer_spi_control_port_readyfordata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_SPI_Synthesizer, which is an e_ptf_instance
  the_SPI_Synthesizer : SPI_Synthesizer
    port map(
      MOSI => internal_MOSI_from_the_SPI_Synthesizer,
      SCLK => internal_SCLK_from_the_SPI_Synthesizer,
      SS_n => internal_SS_n_from_the_SPI_Synthesizer,
      data_to_cpu => SPI_Synthesizer_spi_control_port_readdata,
      dataavailable => SPI_Synthesizer_spi_control_port_dataavailable,
      endofpacket => SPI_Synthesizer_spi_control_port_endofpacket,
      irq => SPI_Synthesizer_spi_control_port_irq,
      readyfordata => SPI_Synthesizer_spi_control_port_readyfordata,
      MISO => MISO_to_the_SPI_Synthesizer,
      clk => CLK,
      data_from_cpu => SPI_Synthesizer_spi_control_port_writedata,
      mem_addr => SPI_Synthesizer_spi_control_port_address,
      read_n => SPI_Synthesizer_spi_control_port_read_n,
      reset_n => SPI_Synthesizer_spi_control_port_reset_n,
      spi_select => SPI_Synthesizer_spi_control_port_chipselect,
      write_n => SPI_Synthesizer_spi_control_port_write_n
    );


  --the_SelectMuxChannel_avalon_slave, which is an e_instance
  the_SelectMuxChannel_avalon_slave : SelectMuxChannel_avalon_slave_arbitrator
    port map(
      Data_to_the_SelectMuxChannel => internal_Data_to_the_SelectMuxChannel,
      SelectMuxChannel_avalon_slave_wait_counter_eq_0 => SelectMuxChannel_avalon_slave_wait_counter_eq_0,
      WR_to_the_SelectMuxChannel => internal_WR_to_the_SelectMuxChannel,
      cpu_data_master_granted_SelectMuxChannel_avalon_slave => cpu_data_master_granted_SelectMuxChannel_avalon_slave,
      cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave => cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave,
      cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave => cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave,
      cpu_data_master_requests_SelectMuxChannel_avalon_slave => cpu_data_master_requests_SelectMuxChannel_avalon_slave,
      d1_SelectMuxChannel_avalon_slave_end_xfer => d1_SelectMuxChannel_avalon_slave_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_Synthesizer_avalon_slave, which is an e_instance
  the_Synthesizer_avalon_slave : Synthesizer_avalon_slave_arbitrator
    port map(
      Data_from_the_Synthesizer_from_sa => Data_from_the_Synthesizer_from_sa,
      RD_to_the_Synthesizer => internal_RD_to_the_Synthesizer,
      Synthesizer_avalon_slave_wait_counter_eq_0 => Synthesizer_avalon_slave_wait_counter_eq_0,
      cpu_data_master_granted_Synthesizer_avalon_slave => cpu_data_master_granted_Synthesizer_avalon_slave,
      cpu_data_master_qualified_request_Synthesizer_avalon_slave => cpu_data_master_qualified_request_Synthesizer_avalon_slave,
      cpu_data_master_read_data_valid_Synthesizer_avalon_slave => cpu_data_master_read_data_valid_Synthesizer_avalon_slave,
      cpu_data_master_requests_Synthesizer_avalon_slave => cpu_data_master_requests_Synthesizer_avalon_slave,
      d1_Synthesizer_avalon_slave_end_xfer => d1_Synthesizer_avalon_slave_end_xfer,
      Data_from_the_Synthesizer => Data_from_the_Synthesizer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => CLK_reset_n
    );


  --the_TriStateBridge_avalon_slave, which is an e_instance
  the_TriStateBridge_avalon_slave : TriStateBridge_avalon_slave_arbitrator
    port map(
      SRAM_s1_wait_counter_eq_0 => SRAM_s1_wait_counter_eq_0,
      address_to_the_SRAM => internal_address_to_the_SRAM,
      be_n_to_the_SRAM => internal_be_n_to_the_SRAM,
      cpu_data_master_granted_SRAM_s1 => cpu_data_master_granted_SRAM_s1,
      cpu_data_master_qualified_request_SRAM_s1 => cpu_data_master_qualified_request_SRAM_s1,
      cpu_data_master_read_data_valid_SRAM_s1 => cpu_data_master_read_data_valid_SRAM_s1,
      cpu_data_master_requests_SRAM_s1 => cpu_data_master_requests_SRAM_s1,
      cpu_instruction_master_granted_SRAM_s1 => cpu_instruction_master_granted_SRAM_s1,
      cpu_instruction_master_qualified_request_SRAM_s1 => cpu_instruction_master_qualified_request_SRAM_s1,
      cpu_instruction_master_read_data_valid_SRAM_s1 => cpu_instruction_master_read_data_valid_SRAM_s1,
      cpu_instruction_master_requests_SRAM_s1 => cpu_instruction_master_requests_SRAM_s1,
      d1_TriStateBridge_avalon_slave_end_xfer => d1_TriStateBridge_avalon_slave_end_xfer,
      data_to_and_from_the_SRAM => data_to_and_from_the_SRAM,
      incoming_data_to_and_from_the_SRAM => incoming_data_to_and_from_the_SRAM,
      read_n_to_the_SRAM => internal_read_n_to_the_SRAM,
      select_n_to_the_SRAM => internal_select_n_to_the_SRAM,
      write_n_to_the_SRAM => internal_write_n_to_the_SRAM,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      reset_n => CLK_reset_n
    );


  --the_UART_1_s1, which is an e_instance
  the_UART_1_s1 : UART_1_s1_arbitrator
    port map(
      UART_1_s1_address => UART_1_s1_address,
      UART_1_s1_begintransfer => UART_1_s1_begintransfer,
      UART_1_s1_chipselect => UART_1_s1_chipselect,
      UART_1_s1_dataavailable_from_sa => UART_1_s1_dataavailable_from_sa,
      UART_1_s1_irq_from_sa => UART_1_s1_irq_from_sa,
      UART_1_s1_read_n => UART_1_s1_read_n,
      UART_1_s1_readdata_from_sa => UART_1_s1_readdata_from_sa,
      UART_1_s1_readyfordata_from_sa => UART_1_s1_readyfordata_from_sa,
      UART_1_s1_reset_n => UART_1_s1_reset_n,
      UART_1_s1_write_n => UART_1_s1_write_n,
      UART_1_s1_writedata => UART_1_s1_writedata,
      cpu_data_master_granted_UART_1_s1 => cpu_data_master_granted_UART_1_s1,
      cpu_data_master_qualified_request_UART_1_s1 => cpu_data_master_qualified_request_UART_1_s1,
      cpu_data_master_read_data_valid_UART_1_s1 => cpu_data_master_read_data_valid_UART_1_s1,
      cpu_data_master_requests_UART_1_s1 => cpu_data_master_requests_UART_1_s1,
      d1_UART_1_s1_end_xfer => d1_UART_1_s1_end_xfer,
      UART_1_s1_dataavailable => UART_1_s1_dataavailable,
      UART_1_s1_irq => UART_1_s1_irq,
      UART_1_s1_readdata => UART_1_s1_readdata,
      UART_1_s1_readyfordata => UART_1_s1_readyfordata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_UART_1, which is an e_ptf_instance
  the_UART_1 : UART_1
    port map(
      dataavailable => UART_1_s1_dataavailable,
      irq => UART_1_s1_irq,
      readdata => UART_1_s1_readdata,
      readyfordata => UART_1_s1_readyfordata,
      txd => internal_txd_from_the_UART_1,
      address => UART_1_s1_address,
      begintransfer => UART_1_s1_begintransfer,
      chipselect => UART_1_s1_chipselect,
      clk => CLK,
      read_n => UART_1_s1_read_n,
      reset_n => UART_1_s1_reset_n,
      rxd => rxd_to_the_UART_1,
      write_n => UART_1_s1_write_n,
      writedata => UART_1_s1_writedata
    );


  --the_UART_13_s1, which is an e_instance
  the_UART_13_s1 : UART_13_s1_arbitrator
    port map(
      UART_13_s1_address => UART_13_s1_address,
      UART_13_s1_begintransfer => UART_13_s1_begintransfer,
      UART_13_s1_chipselect => UART_13_s1_chipselect,
      UART_13_s1_dataavailable_from_sa => UART_13_s1_dataavailable_from_sa,
      UART_13_s1_irq_from_sa => UART_13_s1_irq_from_sa,
      UART_13_s1_read_n => UART_13_s1_read_n,
      UART_13_s1_readdata_from_sa => UART_13_s1_readdata_from_sa,
      UART_13_s1_readyfordata_from_sa => UART_13_s1_readyfordata_from_sa,
      UART_13_s1_reset_n => UART_13_s1_reset_n,
      UART_13_s1_write_n => UART_13_s1_write_n,
      UART_13_s1_writedata => UART_13_s1_writedata,
      cpu_data_master_granted_UART_13_s1 => cpu_data_master_granted_UART_13_s1,
      cpu_data_master_qualified_request_UART_13_s1 => cpu_data_master_qualified_request_UART_13_s1,
      cpu_data_master_read_data_valid_UART_13_s1 => cpu_data_master_read_data_valid_UART_13_s1,
      cpu_data_master_requests_UART_13_s1 => cpu_data_master_requests_UART_13_s1,
      d1_UART_13_s1_end_xfer => d1_UART_13_s1_end_xfer,
      UART_13_s1_dataavailable => UART_13_s1_dataavailable,
      UART_13_s1_irq => UART_13_s1_irq,
      UART_13_s1_readdata => UART_13_s1_readdata,
      UART_13_s1_readyfordata => UART_13_s1_readyfordata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => CLK_reset_n
    );


  --the_UART_13, which is an e_ptf_instance
  the_UART_13 : UART_13
    port map(
      dataavailable => UART_13_s1_dataavailable,
      irq => UART_13_s1_irq,
      readdata => UART_13_s1_readdata,
      readyfordata => UART_13_s1_readyfordata,
      txd => internal_txd_from_the_UART_13,
      address => UART_13_s1_address,
      begintransfer => UART_13_s1_begintransfer,
      chipselect => UART_13_s1_chipselect,
      clk => CLK,
      read_n => UART_13_s1_read_n,
      reset_n => UART_13_s1_reset_n,
      rxd => rxd_to_the_UART_13,
      write_n => UART_13_s1_write_n,
      writedata => UART_13_s1_writedata
    );


  --the_cpu_jtag_debug_module, which is an e_instance
  the_cpu_jtag_debug_module : cpu_jtag_debug_module_arbitrator
    port map(
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_jtag_debug_module_address => cpu_jtag_debug_module_address,
      cpu_jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      cpu_jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      cpu_jtag_debug_module_chipselect => cpu_jtag_debug_module_chipselect,
      cpu_jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      cpu_jtag_debug_module_reset_n => cpu_jtag_debug_module_reset_n,
      cpu_jtag_debug_module_resetrequest_from_sa => cpu_jtag_debug_module_resetrequest_from_sa,
      cpu_jtag_debug_module_write => cpu_jtag_debug_module_write,
      cpu_jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_debugaccess => cpu_data_master_debugaccess,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      cpu_jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      reset_n => CLK_reset_n
    );


  --the_cpu_data_master, which is an e_instance
  the_cpu_data_master : cpu_data_master_arbitrator
    port map(
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_irq => cpu_data_master_irq,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_readdata => cpu_data_master_readdata,
      cpu_data_master_readdatavalid => cpu_data_master_readdatavalid,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      ADCSamples1_avalon_slave_wait_counter_eq_0 => ADCSamples1_avalon_slave_wait_counter_eq_0,
      ADCSamples2_avalon_slave_wait_counter_eq_0 => ADCSamples2_avalon_slave_wait_counter_eq_0,
      DACSamples_avalon_slave_wait_counter_eq_0 => DACSamples_avalon_slave_wait_counter_eq_0,
      Data_from_the_LogicReader_from_sa => Data_from_the_LogicReader_from_sa,
      Data_from_the_PairsCounter_from_sa => Data_from_the_PairsCounter_from_sa,
      Data_from_the_ReplyDelay_from_sa => Data_from_the_ReplyDelay_from_sa,
      Data_from_the_Synthesizer_from_sa => Data_from_the_Synthesizer_from_sa,
      Decoder_avalon_slave_wait_counter_eq_0 => Decoder_avalon_slave_wait_counter_eq_0,
      Deterctor_avalon_slave_wait_counter_eq_0 => Deterctor_avalon_slave_wait_counter_eq_0,
      HIPController_avalon_slave_wait_counter_eq_0 => HIPController_avalon_slave_wait_counter_eq_0,
      IDController_avalon_slave_wait_counter_eq_0 => IDController_avalon_slave_wait_counter_eq_0,
      Indicator_avalon_slave_wait_counter_eq_0 => Indicator_avalon_slave_wait_counter_eq_0,
      JTAG_UART_avalon_jtag_slave_irq_from_sa => JTAG_UART_avalon_jtag_slave_irq_from_sa,
      JTAG_UART_avalon_jtag_slave_readdata_from_sa => JTAG_UART_avalon_jtag_slave_readdata_from_sa,
      JTAG_UART_avalon_jtag_slave_waitrequest_from_sa => JTAG_UART_avalon_jtag_slave_waitrequest_from_sa,
      KSController_avalon_slave_wait_counter_eq_0 => KSController_avalon_slave_wait_counter_eq_0,
      KontrolGenerator_avalon_slave_wait_counter_eq_0 => KontrolGenerator_avalon_slave_wait_counter_eq_0,
      LogicReader_avalon_slave_wait_counter_eq_0 => LogicReader_avalon_slave_wait_counter_eq_0,
      ODController_avalon_slave_wait_counter_eq_0 => ODController_avalon_slave_wait_counter_eq_0,
      PairsCounter_avalon_slave_wait_counter_eq_0 => PairsCounter_avalon_slave_wait_counter_eq_0,
      PriorityController_avalon_slave_wait_counter_eq_0 => PriorityController_avalon_slave_wait_counter_eq_0,
      RData_from_the_ADCSamples1_from_sa => RData_from_the_ADCSamples1_from_sa,
      RData_from_the_ADCSamples2_from_sa => RData_from_the_ADCSamples2_from_sa,
      ReplyDelay_avalon_slave_wait_counter_eq_0 => ReplyDelay_avalon_slave_wait_counter_eq_0,
      SPI_FRAM_spi_control_port_readdata_from_sa => SPI_FRAM_spi_control_port_readdata_from_sa,
      SPI_Flash_spi_control_port_readdata_from_sa => SPI_Flash_spi_control_port_readdata_from_sa,
      SPI_Synthesizer_spi_control_port_readdata_from_sa => SPI_Synthesizer_spi_control_port_readdata_from_sa,
      SRAM_s1_wait_counter_eq_0 => SRAM_s1_wait_counter_eq_0,
      SelectMuxChannel_avalon_slave_wait_counter_eq_0 => SelectMuxChannel_avalon_slave_wait_counter_eq_0,
      Synthesizer_avalon_slave_wait_counter_eq_0 => Synthesizer_avalon_slave_wait_counter_eq_0,
      UART_13_s1_irq_from_sa => UART_13_s1_irq_from_sa,
      UART_13_s1_readdata_from_sa => UART_13_s1_readdata_from_sa,
      UART_1_s1_irq_from_sa => UART_1_s1_irq_from_sa,
      UART_1_s1_readdata_from_sa => UART_1_s1_readdata_from_sa,
      clk => CLK,
      cpu_data_master_address => cpu_data_master_address,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_granted_ADCSamples1_avalon_slave => cpu_data_master_granted_ADCSamples1_avalon_slave,
      cpu_data_master_granted_ADCSamples2_avalon_slave => cpu_data_master_granted_ADCSamples2_avalon_slave,
      cpu_data_master_granted_DACSamples_avalon_slave => cpu_data_master_granted_DACSamples_avalon_slave,
      cpu_data_master_granted_Decoder_avalon_slave => cpu_data_master_granted_Decoder_avalon_slave,
      cpu_data_master_granted_Deterctor_avalon_slave => cpu_data_master_granted_Deterctor_avalon_slave,
      cpu_data_master_granted_HIPController_avalon_slave => cpu_data_master_granted_HIPController_avalon_slave,
      cpu_data_master_granted_IDController_avalon_slave => cpu_data_master_granted_IDController_avalon_slave,
      cpu_data_master_granted_Indicator_avalon_slave => cpu_data_master_granted_Indicator_avalon_slave,
      cpu_data_master_granted_JTAG_UART_avalon_jtag_slave => cpu_data_master_granted_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_granted_KSController_avalon_slave => cpu_data_master_granted_KSController_avalon_slave,
      cpu_data_master_granted_KontrolGenerator_avalon_slave => cpu_data_master_granted_KontrolGenerator_avalon_slave,
      cpu_data_master_granted_LogicReader_avalon_slave => cpu_data_master_granted_LogicReader_avalon_slave,
      cpu_data_master_granted_ODController_avalon_slave => cpu_data_master_granted_ODController_avalon_slave,
      cpu_data_master_granted_PairsCounter_avalon_slave => cpu_data_master_granted_PairsCounter_avalon_slave,
      cpu_data_master_granted_PriorityController_avalon_slave => cpu_data_master_granted_PriorityController_avalon_slave,
      cpu_data_master_granted_ReplyDelay_avalon_slave => cpu_data_master_granted_ReplyDelay_avalon_slave,
      cpu_data_master_granted_SPI_FRAM_spi_control_port => cpu_data_master_granted_SPI_FRAM_spi_control_port,
      cpu_data_master_granted_SPI_Flash_spi_control_port => cpu_data_master_granted_SPI_Flash_spi_control_port,
      cpu_data_master_granted_SPI_Synthesizer_spi_control_port => cpu_data_master_granted_SPI_Synthesizer_spi_control_port,
      cpu_data_master_granted_SRAM_s1 => cpu_data_master_granted_SRAM_s1,
      cpu_data_master_granted_SelectMuxChannel_avalon_slave => cpu_data_master_granted_SelectMuxChannel_avalon_slave,
      cpu_data_master_granted_Synthesizer_avalon_slave => cpu_data_master_granted_Synthesizer_avalon_slave,
      cpu_data_master_granted_UART_13_s1 => cpu_data_master_granted_UART_13_s1,
      cpu_data_master_granted_UART_1_s1 => cpu_data_master_granted_UART_1_s1,
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_granted_epcs_flash_controller_epcs_control_port => cpu_data_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_data_master_granted_inp_pio_s1 => cpu_data_master_granted_inp_pio_s1,
      cpu_data_master_granted_out_pio_s1 => cpu_data_master_granted_out_pio_s1,
      cpu_data_master_qualified_request_ADCSamples1_avalon_slave => cpu_data_master_qualified_request_ADCSamples1_avalon_slave,
      cpu_data_master_qualified_request_ADCSamples2_avalon_slave => cpu_data_master_qualified_request_ADCSamples2_avalon_slave,
      cpu_data_master_qualified_request_DACSamples_avalon_slave => cpu_data_master_qualified_request_DACSamples_avalon_slave,
      cpu_data_master_qualified_request_Decoder_avalon_slave => cpu_data_master_qualified_request_Decoder_avalon_slave,
      cpu_data_master_qualified_request_Deterctor_avalon_slave => cpu_data_master_qualified_request_Deterctor_avalon_slave,
      cpu_data_master_qualified_request_HIPController_avalon_slave => cpu_data_master_qualified_request_HIPController_avalon_slave,
      cpu_data_master_qualified_request_IDController_avalon_slave => cpu_data_master_qualified_request_IDController_avalon_slave,
      cpu_data_master_qualified_request_Indicator_avalon_slave => cpu_data_master_qualified_request_Indicator_avalon_slave,
      cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave => cpu_data_master_qualified_request_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_qualified_request_KSController_avalon_slave => cpu_data_master_qualified_request_KSController_avalon_slave,
      cpu_data_master_qualified_request_KontrolGenerator_avalon_slave => cpu_data_master_qualified_request_KontrolGenerator_avalon_slave,
      cpu_data_master_qualified_request_LogicReader_avalon_slave => cpu_data_master_qualified_request_LogicReader_avalon_slave,
      cpu_data_master_qualified_request_ODController_avalon_slave => cpu_data_master_qualified_request_ODController_avalon_slave,
      cpu_data_master_qualified_request_PairsCounter_avalon_slave => cpu_data_master_qualified_request_PairsCounter_avalon_slave,
      cpu_data_master_qualified_request_PriorityController_avalon_slave => cpu_data_master_qualified_request_PriorityController_avalon_slave,
      cpu_data_master_qualified_request_ReplyDelay_avalon_slave => cpu_data_master_qualified_request_ReplyDelay_avalon_slave,
      cpu_data_master_qualified_request_SPI_FRAM_spi_control_port => cpu_data_master_qualified_request_SPI_FRAM_spi_control_port,
      cpu_data_master_qualified_request_SPI_Flash_spi_control_port => cpu_data_master_qualified_request_SPI_Flash_spi_control_port,
      cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port => cpu_data_master_qualified_request_SPI_Synthesizer_spi_control_port,
      cpu_data_master_qualified_request_SRAM_s1 => cpu_data_master_qualified_request_SRAM_s1,
      cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave => cpu_data_master_qualified_request_SelectMuxChannel_avalon_slave,
      cpu_data_master_qualified_request_Synthesizer_avalon_slave => cpu_data_master_qualified_request_Synthesizer_avalon_slave,
      cpu_data_master_qualified_request_UART_13_s1 => cpu_data_master_qualified_request_UART_13_s1,
      cpu_data_master_qualified_request_UART_1_s1 => cpu_data_master_qualified_request_UART_1_s1,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_data_master_qualified_request_inp_pio_s1 => cpu_data_master_qualified_request_inp_pio_s1,
      cpu_data_master_qualified_request_out_pio_s1 => cpu_data_master_qualified_request_out_pio_s1,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_read_data_valid_ADCSamples1_avalon_slave => cpu_data_master_read_data_valid_ADCSamples1_avalon_slave,
      cpu_data_master_read_data_valid_ADCSamples2_avalon_slave => cpu_data_master_read_data_valid_ADCSamples2_avalon_slave,
      cpu_data_master_read_data_valid_DACSamples_avalon_slave => cpu_data_master_read_data_valid_DACSamples_avalon_slave,
      cpu_data_master_read_data_valid_Decoder_avalon_slave => cpu_data_master_read_data_valid_Decoder_avalon_slave,
      cpu_data_master_read_data_valid_Deterctor_avalon_slave => cpu_data_master_read_data_valid_Deterctor_avalon_slave,
      cpu_data_master_read_data_valid_HIPController_avalon_slave => cpu_data_master_read_data_valid_HIPController_avalon_slave,
      cpu_data_master_read_data_valid_IDController_avalon_slave => cpu_data_master_read_data_valid_IDController_avalon_slave,
      cpu_data_master_read_data_valid_Indicator_avalon_slave => cpu_data_master_read_data_valid_Indicator_avalon_slave,
      cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave => cpu_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_read_data_valid_KSController_avalon_slave => cpu_data_master_read_data_valid_KSController_avalon_slave,
      cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave => cpu_data_master_read_data_valid_KontrolGenerator_avalon_slave,
      cpu_data_master_read_data_valid_LogicReader_avalon_slave => cpu_data_master_read_data_valid_LogicReader_avalon_slave,
      cpu_data_master_read_data_valid_ODController_avalon_slave => cpu_data_master_read_data_valid_ODController_avalon_slave,
      cpu_data_master_read_data_valid_PairsCounter_avalon_slave => cpu_data_master_read_data_valid_PairsCounter_avalon_slave,
      cpu_data_master_read_data_valid_PriorityController_avalon_slave => cpu_data_master_read_data_valid_PriorityController_avalon_slave,
      cpu_data_master_read_data_valid_ReplyDelay_avalon_slave => cpu_data_master_read_data_valid_ReplyDelay_avalon_slave,
      cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port => cpu_data_master_read_data_valid_SPI_FRAM_spi_control_port,
      cpu_data_master_read_data_valid_SPI_Flash_spi_control_port => cpu_data_master_read_data_valid_SPI_Flash_spi_control_port,
      cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port => cpu_data_master_read_data_valid_SPI_Synthesizer_spi_control_port,
      cpu_data_master_read_data_valid_SRAM_s1 => cpu_data_master_read_data_valid_SRAM_s1,
      cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave => cpu_data_master_read_data_valid_SelectMuxChannel_avalon_slave,
      cpu_data_master_read_data_valid_Synthesizer_avalon_slave => cpu_data_master_read_data_valid_Synthesizer_avalon_slave,
      cpu_data_master_read_data_valid_UART_13_s1 => cpu_data_master_read_data_valid_UART_13_s1,
      cpu_data_master_read_data_valid_UART_1_s1 => cpu_data_master_read_data_valid_UART_1_s1,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_data_master_read_data_valid_inp_pio_s1 => cpu_data_master_read_data_valid_inp_pio_s1,
      cpu_data_master_read_data_valid_out_pio_s1 => cpu_data_master_read_data_valid_out_pio_s1,
      cpu_data_master_requests_ADCSamples1_avalon_slave => cpu_data_master_requests_ADCSamples1_avalon_slave,
      cpu_data_master_requests_ADCSamples2_avalon_slave => cpu_data_master_requests_ADCSamples2_avalon_slave,
      cpu_data_master_requests_DACSamples_avalon_slave => cpu_data_master_requests_DACSamples_avalon_slave,
      cpu_data_master_requests_Decoder_avalon_slave => cpu_data_master_requests_Decoder_avalon_slave,
      cpu_data_master_requests_Deterctor_avalon_slave => cpu_data_master_requests_Deterctor_avalon_slave,
      cpu_data_master_requests_HIPController_avalon_slave => cpu_data_master_requests_HIPController_avalon_slave,
      cpu_data_master_requests_IDController_avalon_slave => cpu_data_master_requests_IDController_avalon_slave,
      cpu_data_master_requests_Indicator_avalon_slave => cpu_data_master_requests_Indicator_avalon_slave,
      cpu_data_master_requests_JTAG_UART_avalon_jtag_slave => cpu_data_master_requests_JTAG_UART_avalon_jtag_slave,
      cpu_data_master_requests_KSController_avalon_slave => cpu_data_master_requests_KSController_avalon_slave,
      cpu_data_master_requests_KontrolGenerator_avalon_slave => cpu_data_master_requests_KontrolGenerator_avalon_slave,
      cpu_data_master_requests_LogicReader_avalon_slave => cpu_data_master_requests_LogicReader_avalon_slave,
      cpu_data_master_requests_ODController_avalon_slave => cpu_data_master_requests_ODController_avalon_slave,
      cpu_data_master_requests_PairsCounter_avalon_slave => cpu_data_master_requests_PairsCounter_avalon_slave,
      cpu_data_master_requests_PriorityController_avalon_slave => cpu_data_master_requests_PriorityController_avalon_slave,
      cpu_data_master_requests_ReplyDelay_avalon_slave => cpu_data_master_requests_ReplyDelay_avalon_slave,
      cpu_data_master_requests_SPI_FRAM_spi_control_port => cpu_data_master_requests_SPI_FRAM_spi_control_port,
      cpu_data_master_requests_SPI_Flash_spi_control_port => cpu_data_master_requests_SPI_Flash_spi_control_port,
      cpu_data_master_requests_SPI_Synthesizer_spi_control_port => cpu_data_master_requests_SPI_Synthesizer_spi_control_port,
      cpu_data_master_requests_SRAM_s1 => cpu_data_master_requests_SRAM_s1,
      cpu_data_master_requests_SelectMuxChannel_avalon_slave => cpu_data_master_requests_SelectMuxChannel_avalon_slave,
      cpu_data_master_requests_Synthesizer_avalon_slave => cpu_data_master_requests_Synthesizer_avalon_slave,
      cpu_data_master_requests_UART_13_s1 => cpu_data_master_requests_UART_13_s1,
      cpu_data_master_requests_UART_1_s1 => cpu_data_master_requests_UART_1_s1,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_data_master_requests_epcs_flash_controller_epcs_control_port => cpu_data_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_data_master_requests_inp_pio_s1 => cpu_data_master_requests_inp_pio_s1,
      cpu_data_master_requests_out_pio_s1 => cpu_data_master_requests_out_pio_s1,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_ADCSamples1_avalon_slave_end_xfer => d1_ADCSamples1_avalon_slave_end_xfer,
      d1_ADCSamples2_avalon_slave_end_xfer => d1_ADCSamples2_avalon_slave_end_xfer,
      d1_DACSamples_avalon_slave_end_xfer => d1_DACSamples_avalon_slave_end_xfer,
      d1_Decoder_avalon_slave_end_xfer => d1_Decoder_avalon_slave_end_xfer,
      d1_Deterctor_avalon_slave_end_xfer => d1_Deterctor_avalon_slave_end_xfer,
      d1_HIPController_avalon_slave_end_xfer => d1_HIPController_avalon_slave_end_xfer,
      d1_IDController_avalon_slave_end_xfer => d1_IDController_avalon_slave_end_xfer,
      d1_Indicator_avalon_slave_end_xfer => d1_Indicator_avalon_slave_end_xfer,
      d1_JTAG_UART_avalon_jtag_slave_end_xfer => d1_JTAG_UART_avalon_jtag_slave_end_xfer,
      d1_KSController_avalon_slave_end_xfer => d1_KSController_avalon_slave_end_xfer,
      d1_KontrolGenerator_avalon_slave_end_xfer => d1_KontrolGenerator_avalon_slave_end_xfer,
      d1_LogicReader_avalon_slave_end_xfer => d1_LogicReader_avalon_slave_end_xfer,
      d1_ODController_avalon_slave_end_xfer => d1_ODController_avalon_slave_end_xfer,
      d1_PairsCounter_avalon_slave_end_xfer => d1_PairsCounter_avalon_slave_end_xfer,
      d1_PriorityController_avalon_slave_end_xfer => d1_PriorityController_avalon_slave_end_xfer,
      d1_ReplyDelay_avalon_slave_end_xfer => d1_ReplyDelay_avalon_slave_end_xfer,
      d1_SPI_FRAM_spi_control_port_end_xfer => d1_SPI_FRAM_spi_control_port_end_xfer,
      d1_SPI_Flash_spi_control_port_end_xfer => d1_SPI_Flash_spi_control_port_end_xfer,
      d1_SPI_Synthesizer_spi_control_port_end_xfer => d1_SPI_Synthesizer_spi_control_port_end_xfer,
      d1_SelectMuxChannel_avalon_slave_end_xfer => d1_SelectMuxChannel_avalon_slave_end_xfer,
      d1_Synthesizer_avalon_slave_end_xfer => d1_Synthesizer_avalon_slave_end_xfer,
      d1_TriStateBridge_avalon_slave_end_xfer => d1_TriStateBridge_avalon_slave_end_xfer,
      d1_UART_13_s1_end_xfer => d1_UART_13_s1_end_xfer,
      d1_UART_1_s1_end_xfer => d1_UART_1_s1_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      d1_inp_pio_s1_end_xfer => d1_inp_pio_s1_end_xfer,
      d1_out_pio_s1_end_xfer => d1_out_pio_s1_end_xfer,
      epcs_flash_controller_epcs_control_port_irq_from_sa => epcs_flash_controller_epcs_control_port_irq_from_sa,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      incoming_data_to_and_from_the_SRAM => incoming_data_to_and_from_the_SRAM,
      inp_pio_s1_irq_from_sa => inp_pio_s1_irq_from_sa,
      inp_pio_s1_readdata_from_sa => inp_pio_s1_readdata_from_sa,
      out_pio_s1_readdata_from_sa => out_pio_s1_readdata_from_sa,
      reset_n => CLK_reset_n
    );


  --the_cpu_instruction_master, which is an e_instance
  the_cpu_instruction_master : cpu_instruction_master_arbitrator
    port map(
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_readdata => cpu_instruction_master_readdata,
      cpu_instruction_master_readdatavalid => cpu_instruction_master_readdatavalid,
      cpu_instruction_master_waitrequest => cpu_instruction_master_waitrequest,
      SRAM_s1_wait_counter_eq_0 => SRAM_s1_wait_counter_eq_0,
      clk => CLK,
      cpu_instruction_master_address => cpu_instruction_master_address,
      cpu_instruction_master_granted_SRAM_s1 => cpu_instruction_master_granted_SRAM_s1,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port => cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_qualified_request_SRAM_s1 => cpu_instruction_master_qualified_request_SRAM_s1,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_SRAM_s1 => cpu_instruction_master_read_data_valid_SRAM_s1,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_requests_SRAM_s1 => cpu_instruction_master_requests_SRAM_s1,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port => cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_TriStateBridge_avalon_slave_end_xfer => d1_TriStateBridge_avalon_slave_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      incoming_data_to_and_from_the_SRAM => incoming_data_to_and_from_the_SRAM,
      reset_n => CLK_reset_n
    );


  --the_cpu, which is an e_ptf_instance
  the_cpu : cpu
    port map(
      d_address => cpu_data_master_address,
      d_byteenable => cpu_data_master_byteenable,
      d_read => cpu_data_master_read,
      d_write => cpu_data_master_write,
      d_writedata => cpu_data_master_writedata,
      i_address => cpu_instruction_master_address,
      i_read => cpu_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      clk => CLK,
      d_irq => cpu_data_master_irq,
      d_readdata => cpu_data_master_readdata,
      d_readdatavalid => cpu_data_master_readdatavalid,
      d_waitrequest => cpu_data_master_waitrequest,
      i_readdata => cpu_instruction_master_readdata,
      i_readdatavalid => cpu_instruction_master_readdatavalid,
      i_waitrequest => cpu_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      jtag_debug_module_select => cpu_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      reset_n => cpu_jtag_debug_module_reset_n
    );


  --the_epcs_flash_controller_epcs_control_port, which is an e_instance
  the_epcs_flash_controller_epcs_control_port : epcs_flash_controller_epcs_control_port_arbitrator
    port map(
      cpu_data_master_granted_epcs_flash_controller_epcs_control_port => cpu_data_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_data_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_data_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_data_master_requests_epcs_flash_controller_epcs_control_port => cpu_data_master_requests_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port => cpu_instruction_master_granted_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port => cpu_instruction_master_qualified_request_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port => cpu_instruction_master_read_data_valid_epcs_flash_controller_epcs_control_port,
      cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port => cpu_instruction_master_requests_epcs_flash_controller_epcs_control_port,
      d1_epcs_flash_controller_epcs_control_port_end_xfer => d1_epcs_flash_controller_epcs_control_port_end_xfer,
      epcs_flash_controller_epcs_control_port_address => epcs_flash_controller_epcs_control_port_address,
      epcs_flash_controller_epcs_control_port_chipselect => epcs_flash_controller_epcs_control_port_chipselect,
      epcs_flash_controller_epcs_control_port_dataavailable_from_sa => epcs_flash_controller_epcs_control_port_dataavailable_from_sa,
      epcs_flash_controller_epcs_control_port_endofpacket_from_sa => epcs_flash_controller_epcs_control_port_endofpacket_from_sa,
      epcs_flash_controller_epcs_control_port_irq_from_sa => epcs_flash_controller_epcs_control_port_irq_from_sa,
      epcs_flash_controller_epcs_control_port_read_n => epcs_flash_controller_epcs_control_port_read_n,
      epcs_flash_controller_epcs_control_port_readdata_from_sa => epcs_flash_controller_epcs_control_port_readdata_from_sa,
      epcs_flash_controller_epcs_control_port_readyfordata_from_sa => epcs_flash_controller_epcs_control_port_readyfordata_from_sa,
      epcs_flash_controller_epcs_control_port_reset_n => epcs_flash_controller_epcs_control_port_reset_n,
      epcs_flash_controller_epcs_control_port_write_n => epcs_flash_controller_epcs_control_port_write_n,
      epcs_flash_controller_epcs_control_port_writedata => epcs_flash_controller_epcs_control_port_writedata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      epcs_flash_controller_epcs_control_port_dataavailable => epcs_flash_controller_epcs_control_port_dataavailable,
      epcs_flash_controller_epcs_control_port_endofpacket => epcs_flash_controller_epcs_control_port_endofpacket,
      epcs_flash_controller_epcs_control_port_irq => epcs_flash_controller_epcs_control_port_irq,
      epcs_flash_controller_epcs_control_port_readdata => epcs_flash_controller_epcs_control_port_readdata,
      epcs_flash_controller_epcs_control_port_readyfordata => epcs_flash_controller_epcs_control_port_readyfordata,
      reset_n => CLK_reset_n
    );


  --the_epcs_flash_controller, which is an e_ptf_instance
  the_epcs_flash_controller : epcs_flash_controller
    port map(
      dataavailable => epcs_flash_controller_epcs_control_port_dataavailable,
      endofpacket => epcs_flash_controller_epcs_control_port_endofpacket,
      irq => epcs_flash_controller_epcs_control_port_irq,
      readdata => epcs_flash_controller_epcs_control_port_readdata,
      readyfordata => epcs_flash_controller_epcs_control_port_readyfordata,
      address => epcs_flash_controller_epcs_control_port_address,
      chipselect => epcs_flash_controller_epcs_control_port_chipselect,
      clk => CLK,
      read_n => epcs_flash_controller_epcs_control_port_read_n,
      reset_n => epcs_flash_controller_epcs_control_port_reset_n,
      write_n => epcs_flash_controller_epcs_control_port_write_n,
      writedata => epcs_flash_controller_epcs_control_port_writedata
    );


  --the_inp_pio_s1, which is an e_instance
  the_inp_pio_s1 : inp_pio_s1_arbitrator
    port map(
      cpu_data_master_granted_inp_pio_s1 => cpu_data_master_granted_inp_pio_s1,
      cpu_data_master_qualified_request_inp_pio_s1 => cpu_data_master_qualified_request_inp_pio_s1,
      cpu_data_master_read_data_valid_inp_pio_s1 => cpu_data_master_read_data_valid_inp_pio_s1,
      cpu_data_master_requests_inp_pio_s1 => cpu_data_master_requests_inp_pio_s1,
      d1_inp_pio_s1_end_xfer => d1_inp_pio_s1_end_xfer,
      inp_pio_s1_address => inp_pio_s1_address,
      inp_pio_s1_chipselect => inp_pio_s1_chipselect,
      inp_pio_s1_irq_from_sa => inp_pio_s1_irq_from_sa,
      inp_pio_s1_readdata_from_sa => inp_pio_s1_readdata_from_sa,
      inp_pio_s1_reset_n => inp_pio_s1_reset_n,
      inp_pio_s1_write_n => inp_pio_s1_write_n,
      inp_pio_s1_writedata => inp_pio_s1_writedata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      inp_pio_s1_irq => inp_pio_s1_irq,
      inp_pio_s1_readdata => inp_pio_s1_readdata,
      reset_n => CLK_reset_n
    );


  --the_inp_pio, which is an e_ptf_instance
  the_inp_pio : inp_pio
    port map(
      irq => inp_pio_s1_irq,
      readdata => inp_pio_s1_readdata,
      address => inp_pio_s1_address,
      chipselect => inp_pio_s1_chipselect,
      clk => CLK,
      in_port => in_port_to_the_inp_pio,
      reset_n => inp_pio_s1_reset_n,
      write_n => inp_pio_s1_write_n,
      writedata => inp_pio_s1_writedata
    );


  --the_out_pio_s1, which is an e_instance
  the_out_pio_s1 : out_pio_s1_arbitrator
    port map(
      cpu_data_master_granted_out_pio_s1 => cpu_data_master_granted_out_pio_s1,
      cpu_data_master_qualified_request_out_pio_s1 => cpu_data_master_qualified_request_out_pio_s1,
      cpu_data_master_read_data_valid_out_pio_s1 => cpu_data_master_read_data_valid_out_pio_s1,
      cpu_data_master_requests_out_pio_s1 => cpu_data_master_requests_out_pio_s1,
      d1_out_pio_s1_end_xfer => d1_out_pio_s1_end_xfer,
      out_pio_s1_address => out_pio_s1_address,
      out_pio_s1_chipselect => out_pio_s1_chipselect,
      out_pio_s1_readdata_from_sa => out_pio_s1_readdata_from_sa,
      out_pio_s1_reset_n => out_pio_s1_reset_n,
      out_pio_s1_write_n => out_pio_s1_write_n,
      out_pio_s1_writedata => out_pio_s1_writedata,
      clk => CLK,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_latency_counter => cpu_data_master_latency_counter,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      out_pio_s1_readdata => out_pio_s1_readdata,
      reset_n => CLK_reset_n
    );


  --the_out_pio, which is an e_ptf_instance
  the_out_pio : out_pio
    port map(
      out_port => internal_out_port_from_the_out_pio,
      readdata => out_pio_s1_readdata,
      address => out_pio_s1_address,
      chipselect => out_pio_s1_chipselect,
      clk => CLK,
      reset_n => out_pio_s1_reset_n,
      write_n => out_pio_s1_write_n,
      writedata => out_pio_s1_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  DME_ControllerUnit_reset_CLK_domain_synch : DME_ControllerUnit_reset_CLK_domain_synch_module
    port map(
      data_out => CLK_reset_n,
      clk => CLK,
      data_in => module_input,
      reset_n => reset_n_sources
    );

  module_input <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa))))));
  --vhdl renameroo for output signals
  Address_to_the_ADCSamples1 <= internal_Address_to_the_ADCSamples1;
  --vhdl renameroo for output signals
  Address_to_the_ADCSamples2 <= internal_Address_to_the_ADCSamples2;
  --vhdl renameroo for output signals
  Address_to_the_DACSamples <= internal_Address_to_the_DACSamples;
  --vhdl renameroo for output signals
  Address_to_the_Decoder <= internal_Address_to_the_Decoder;
  --vhdl renameroo for output signals
  Address_to_the_Deterctor <= internal_Address_to_the_Deterctor;
  --vhdl renameroo for output signals
  Address_to_the_IDController <= internal_Address_to_the_IDController;
  --vhdl renameroo for output signals
  Address_to_the_KSController <= internal_Address_to_the_KSController;
  --vhdl renameroo for output signals
  Address_to_the_ODController <= internal_Address_to_the_ODController;
  --vhdl renameroo for output signals
  Address_to_the_PriorityController <= internal_Address_to_the_PriorityController;
  --vhdl renameroo for output signals
  Address_to_the_ReplyDelay <= internal_Address_to_the_ReplyDelay;
  --vhdl renameroo for output signals
  Data_to_the_DACSamples <= internal_Data_to_the_DACSamples;
  --vhdl renameroo for output signals
  Data_to_the_Decoder <= internal_Data_to_the_Decoder;
  --vhdl renameroo for output signals
  Data_to_the_Deterctor <= internal_Data_to_the_Deterctor;
  --vhdl renameroo for output signals
  Data_to_the_HIPController <= internal_Data_to_the_HIPController;
  --vhdl renameroo for output signals
  Data_to_the_Indicator <= internal_Data_to_the_Indicator;
  --vhdl renameroo for output signals
  Data_to_the_KSController <= internal_Data_to_the_KSController;
  --vhdl renameroo for output signals
  Data_to_the_KontrolGenerator <= internal_Data_to_the_KontrolGenerator;
  --vhdl renameroo for output signals
  Data_to_the_ODController <= internal_Data_to_the_ODController;
  --vhdl renameroo for output signals
  Data_to_the_PriorityController <= internal_Data_to_the_PriorityController;
  --vhdl renameroo for output signals
  Data_to_the_SelectMuxChannel <= internal_Data_to_the_SelectMuxChannel;
  --vhdl renameroo for output signals
  MOSI_from_the_SPI_FRAM <= internal_MOSI_from_the_SPI_FRAM;
  --vhdl renameroo for output signals
  MOSI_from_the_SPI_Flash <= internal_MOSI_from_the_SPI_Flash;
  --vhdl renameroo for output signals
  MOSI_from_the_SPI_Synthesizer <= internal_MOSI_from_the_SPI_Synthesizer;
  --vhdl renameroo for output signals
  RD_to_the_ADCSamples1 <= internal_RD_to_the_ADCSamples1;
  --vhdl renameroo for output signals
  RD_to_the_ADCSamples2 <= internal_RD_to_the_ADCSamples2;
  --vhdl renameroo for output signals
  RD_to_the_LogicReader <= internal_RD_to_the_LogicReader;
  --vhdl renameroo for output signals
  RD_to_the_PairsCounter <= internal_RD_to_the_PairsCounter;
  --vhdl renameroo for output signals
  RD_to_the_ReplyDelay <= internal_RD_to_the_ReplyDelay;
  --vhdl renameroo for output signals
  RD_to_the_Synthesizer <= internal_RD_to_the_Synthesizer;
  --vhdl renameroo for output signals
  SCLK_from_the_SPI_FRAM <= internal_SCLK_from_the_SPI_FRAM;
  --vhdl renameroo for output signals
  SCLK_from_the_SPI_Flash <= internal_SCLK_from_the_SPI_Flash;
  --vhdl renameroo for output signals
  SCLK_from_the_SPI_Synthesizer <= internal_SCLK_from_the_SPI_Synthesizer;
  --vhdl renameroo for output signals
  SS_n_from_the_SPI_FRAM <= internal_SS_n_from_the_SPI_FRAM;
  --vhdl renameroo for output signals
  SS_n_from_the_SPI_Flash <= internal_SS_n_from_the_SPI_Flash;
  --vhdl renameroo for output signals
  SS_n_from_the_SPI_Synthesizer <= internal_SS_n_from_the_SPI_Synthesizer;
  --vhdl renameroo for output signals
  WData_to_the_IDController <= internal_WData_to_the_IDController;
  --vhdl renameroo for output signals
  WR_to_the_DACSamples <= internal_WR_to_the_DACSamples;
  --vhdl renameroo for output signals
  WR_to_the_Decoder <= internal_WR_to_the_Decoder;
  --vhdl renameroo for output signals
  WR_to_the_Deterctor <= internal_WR_to_the_Deterctor;
  --vhdl renameroo for output signals
  WR_to_the_HIPController <= internal_WR_to_the_HIPController;
  --vhdl renameroo for output signals
  WR_to_the_IDController <= internal_WR_to_the_IDController;
  --vhdl renameroo for output signals
  WR_to_the_Indicator <= internal_WR_to_the_Indicator;
  --vhdl renameroo for output signals
  WR_to_the_KSController <= internal_WR_to_the_KSController;
  --vhdl renameroo for output signals
  WR_to_the_KontrolGenerator <= internal_WR_to_the_KontrolGenerator;
  --vhdl renameroo for output signals
  WR_to_the_ODController <= internal_WR_to_the_ODController;
  --vhdl renameroo for output signals
  WR_to_the_PriorityController <= internal_WR_to_the_PriorityController;
  --vhdl renameroo for output signals
  WR_to_the_SelectMuxChannel <= internal_WR_to_the_SelectMuxChannel;
  --vhdl renameroo for output signals
  address_to_the_SRAM <= internal_address_to_the_SRAM;
  --vhdl renameroo for output signals
  be_n_to_the_SRAM <= internal_be_n_to_the_SRAM;
  --vhdl renameroo for output signals
  out_port_from_the_out_pio <= internal_out_port_from_the_out_pio;
  --vhdl renameroo for output signals
  read_n_to_the_SRAM <= internal_read_n_to_the_SRAM;
  --vhdl renameroo for output signals
  select_n_to_the_SRAM <= internal_select_n_to_the_SRAM;
  --vhdl renameroo for output signals
  txd_from_the_UART_1 <= internal_txd_from_the_UART_1;
  --vhdl renameroo for output signals
  txd_from_the_UART_13 <= internal_txd_from_the_UART_13;
  --vhdl renameroo for output signals
  write_n_to_the_SRAM <= internal_write_n_to_the_SRAM;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SRAM_lane0_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity SRAM_lane0_module;


architecture europa of SRAM_lane0_module is
              signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (17 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "SRAM_lane0.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 262144) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity SRAM_lane0_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity SRAM_lane0_module;
--
--
--architecture europa of SRAM_lane0_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "SRAM_lane0.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 18,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SRAM_lane1_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity SRAM_lane1_module;


architecture europa of SRAM_lane1_module is
              signal internal_q1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (17 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "SRAM_lane1.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 262144) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity SRAM_lane1_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity SRAM_lane1_module;
--
--
--architecture europa of SRAM_lane1_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "SRAM_lane1.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 18,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q1,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q1;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SRAM_lane2_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity SRAM_lane2_module;


architecture europa of SRAM_lane2_module is
              signal internal_q2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (17 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "SRAM_lane2.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 262144) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity SRAM_lane2_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity SRAM_lane2_module;
--
--
--architecture europa of SRAM_lane2_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "SRAM_lane2.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 18,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q2,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q2;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SRAM_lane3_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity SRAM_lane3_module;


architecture europa of SRAM_lane3_module is
              signal internal_q3 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (17 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "SRAM_lane3.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 262144) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity SRAM_lane3_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity SRAM_lane3_module;
--
--
--architecture europa of SRAM_lane3_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q3 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 262143 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "SRAM_lane3.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 18,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q3,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q3;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SRAM is 
        port (
              -- inputs:
                 signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal be_n : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal read_n : IN STD_LOGIC;
                 signal select_n : IN STD_LOGIC;
                 signal write_n : IN STD_LOGIC;

              -- outputs:
                 signal data : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity SRAM;


architecture europa of SRAM is
--synthesis translate_off
component SRAM_lane0_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component SRAM_lane0_module;

component SRAM_lane1_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component SRAM_lane1_module;

component SRAM_lane2_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component SRAM_lane2_module;

component SRAM_lane3_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component SRAM_lane3_module;

--synthesis translate_on
                signal data_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal data_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal data_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal data_3 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal logic_vector_gasket :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal q_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal q_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal q_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal q_3 :  STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

  --s1, which is an e_ptf_slave
--synthesis translate_off
    logic_vector_gasket <= data;
    data_0 <= logic_vector_gasket(7 DOWNTO 0);
    --SRAM_lane0, which is an e_ram
    SRAM_lane0 : SRAM_lane0_module
      port map(
        q => q_0,
        data => data_0,
        rdaddress => address,
        rdclken => module_input1,
        wraddress => address,
        wrclock => write_n,
        wren => module_input2
      );

    module_input1 <= std_logic'('1');
    module_input2 <= NOT select_n AND NOT be_n(0);

    data_1 <= logic_vector_gasket(15 DOWNTO 8);
    --SRAM_lane1, which is an e_ram
    SRAM_lane1 : SRAM_lane1_module
      port map(
        q => q_1,
        data => data_1,
        rdaddress => address,
        rdclken => module_input3,
        wraddress => address,
        wrclock => write_n,
        wren => module_input4
      );

    module_input3 <= std_logic'('1');
    module_input4 <= NOT select_n AND NOT be_n(1);

    data_2 <= logic_vector_gasket(23 DOWNTO 16);
    --SRAM_lane2, which is an e_ram
    SRAM_lane2 : SRAM_lane2_module
      port map(
        q => q_2,
        data => data_2,
        rdaddress => address,
        rdclken => module_input5,
        wraddress => address,
        wrclock => write_n,
        wren => module_input6
      );

    module_input5 <= std_logic'('1');
    module_input6 <= NOT select_n AND NOT be_n(2);

    data_3 <= logic_vector_gasket(31 DOWNTO 24);
    --SRAM_lane3, which is an e_ram
    SRAM_lane3 : SRAM_lane3_module
      port map(
        q => q_3,
        data => data_3,
        rdaddress => address,
        rdclken => module_input7,
        wraddress => address,
        wrclock => write_n,
        wren => module_input8
      );

    module_input7 <= std_logic'('1');
    module_input8 <= NOT select_n AND NOT be_n(3);

    data <= A_WE_StdLogicVector((std_logic'(((NOT select_n AND NOT read_n))) = '1'), (q_3 & q_2 & q_1 & q_0), A_REP(std_logic'('Z'), 32));
--synthesis translate_on

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component DME_ControllerUnit is 
           port (
                 -- 1) global signals:
                    signal CLK : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_ADCSamples1_avalon_slave
                    signal Address_to_the_ADCSamples1 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal RD_to_the_ADCSamples1 : OUT STD_LOGIC;
                    signal RData_from_the_ADCSamples1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- the_ADCSamples2_avalon_slave
                    signal Address_to_the_ADCSamples2 : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal RD_to_the_ADCSamples2 : OUT STD_LOGIC;
                    signal RData_from_the_ADCSamples2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- the_DACSamples_avalon_slave
                    signal Address_to_the_DACSamples : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal Data_to_the_DACSamples : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_DACSamples : OUT STD_LOGIC;

                 -- the_Decoder_avalon_slave
                    signal Address_to_the_Decoder : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_Decoder : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_Decoder : OUT STD_LOGIC;

                 -- the_Deterctor_avalon_slave
                    signal Address_to_the_Deterctor : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_Deterctor : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_Deterctor : OUT STD_LOGIC;

                 -- the_HIPController_avalon_slave
                    signal Data_to_the_HIPController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_HIPController : OUT STD_LOGIC;

                 -- the_IDController_avalon_slave
                    signal Address_to_the_IDController : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal WData_to_the_IDController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_IDController : OUT STD_LOGIC;

                 -- the_Indicator_avalon_slave
                    signal Data_to_the_Indicator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_Indicator : OUT STD_LOGIC;

                 -- the_KSController_avalon_slave
                    signal Address_to_the_KSController : OUT STD_LOGIC;
                    signal Data_to_the_KSController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_KSController : OUT STD_LOGIC;

                 -- the_KontrolGenerator_avalon_slave
                    signal Data_to_the_KontrolGenerator : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_KontrolGenerator : OUT STD_LOGIC;

                 -- the_LogicReader_avalon_slave
                    signal Data_from_the_LogicReader : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_LogicReader : OUT STD_LOGIC;

                 -- the_ODController_avalon_slave
                    signal Address_to_the_ODController : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal Data_to_the_ODController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_ODController : OUT STD_LOGIC;

                 -- the_PairsCounter_avalon_slave
                    signal Data_from_the_PairsCounter : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_PairsCounter : OUT STD_LOGIC;

                 -- the_PriorityController_avalon_slave
                    signal Address_to_the_PriorityController : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_to_the_PriorityController : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_PriorityController : OUT STD_LOGIC;

                 -- the_ReplyDelay_avalon_slave
                    signal Address_to_the_ReplyDelay : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Data_from_the_ReplyDelay : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_ReplyDelay : OUT STD_LOGIC;

                 -- the_SPI_FRAM
                    signal MISO_to_the_SPI_FRAM : IN STD_LOGIC;
                    signal MOSI_from_the_SPI_FRAM : OUT STD_LOGIC;
                    signal SCLK_from_the_SPI_FRAM : OUT STD_LOGIC;
                    signal SS_n_from_the_SPI_FRAM : OUT STD_LOGIC;

                 -- the_SPI_Flash
                    signal MISO_to_the_SPI_Flash : IN STD_LOGIC;
                    signal MOSI_from_the_SPI_Flash : OUT STD_LOGIC;
                    signal SCLK_from_the_SPI_Flash : OUT STD_LOGIC;
                    signal SS_n_from_the_SPI_Flash : OUT STD_LOGIC;

                 -- the_SPI_Synthesizer
                    signal MISO_to_the_SPI_Synthesizer : IN STD_LOGIC;
                    signal MOSI_from_the_SPI_Synthesizer : OUT STD_LOGIC;
                    signal SCLK_from_the_SPI_Synthesizer : OUT STD_LOGIC;
                    signal SS_n_from_the_SPI_Synthesizer : OUT STD_LOGIC;

                 -- the_SelectMuxChannel_avalon_slave
                    signal Data_to_the_SelectMuxChannel : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal WR_to_the_SelectMuxChannel : OUT STD_LOGIC;

                 -- the_Synthesizer_avalon_slave
                    signal Data_from_the_Synthesizer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RD_to_the_Synthesizer : OUT STD_LOGIC;

                 -- the_TriStateBridge_avalon_slave
                    signal address_to_the_SRAM : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
                    signal be_n_to_the_SRAM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal data_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal read_n_to_the_SRAM : OUT STD_LOGIC;
                    signal select_n_to_the_SRAM : OUT STD_LOGIC;
                    signal write_n_to_the_SRAM : OUT STD_LOGIC;

                 -- the_UART_1
                    signal rxd_to_the_UART_1 : IN STD_LOGIC;
                    signal txd_from_the_UART_1 : OUT STD_LOGIC;

                 -- the_UART_13
                    signal rxd_to_the_UART_13 : IN STD_LOGIC;
                    signal txd_from_the_UART_13 : OUT STD_LOGIC;

                 -- the_inp_pio
                    signal in_port_to_the_inp_pio : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- the_out_pio
                    signal out_port_from_the_out_pio : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component DME_ControllerUnit;

component SRAM is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal be_n : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal select_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal data : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component SRAM;

                signal Address_to_the_ADCSamples1 :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal Address_to_the_ADCSamples2 :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal Address_to_the_DACSamples :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal Address_to_the_Decoder :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Address_to_the_Deterctor :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Address_to_the_IDController :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal Address_to_the_KSController :  STD_LOGIC;
                signal Address_to_the_ODController :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal Address_to_the_PriorityController :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Address_to_the_ReplyDelay :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CLK :  STD_LOGIC;
                signal Data_from_the_LogicReader :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_PairsCounter :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_ReplyDelay :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_from_the_Synthesizer :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_DACSamples :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_Decoder :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_Deterctor :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_HIPController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_Indicator :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_KSController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_KontrolGenerator :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_ODController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_PriorityController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Data_to_the_SelectMuxChannel :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal MISO_to_the_SPI_FRAM :  STD_LOGIC;
                signal MISO_to_the_SPI_Flash :  STD_LOGIC;
                signal MISO_to_the_SPI_Synthesizer :  STD_LOGIC;
                signal MOSI_from_the_SPI_FRAM :  STD_LOGIC;
                signal MOSI_from_the_SPI_Flash :  STD_LOGIC;
                signal MOSI_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal RD_to_the_ADCSamples1 :  STD_LOGIC;
                signal RD_to_the_ADCSamples2 :  STD_LOGIC;
                signal RD_to_the_LogicReader :  STD_LOGIC;
                signal RD_to_the_PairsCounter :  STD_LOGIC;
                signal RD_to_the_ReplyDelay :  STD_LOGIC;
                signal RD_to_the_Synthesizer :  STD_LOGIC;
                signal RData_from_the_ADCSamples1 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal RData_from_the_ADCSamples2 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal SCLK_from_the_SPI_FRAM :  STD_LOGIC;
                signal SCLK_from_the_SPI_Flash :  STD_LOGIC;
                signal SCLK_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_irq :  STD_LOGIC;
                signal SPI_FRAM_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_irq :  STD_LOGIC;
                signal SPI_Flash_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_irq :  STD_LOGIC;
                signal SPI_Synthesizer_spi_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal SS_n_from_the_SPI_FRAM :  STD_LOGIC;
                signal SS_n_from_the_SPI_Flash :  STD_LOGIC;
                signal SS_n_from_the_SPI_Synthesizer :  STD_LOGIC;
                signal UART_13_s1_dataavailable_from_sa :  STD_LOGIC;
                signal UART_13_s1_readyfordata_from_sa :  STD_LOGIC;
                signal UART_1_s1_dataavailable_from_sa :  STD_LOGIC;
                signal UART_1_s1_readyfordata_from_sa :  STD_LOGIC;
                signal WData_to_the_IDController :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal WR_to_the_DACSamples :  STD_LOGIC;
                signal WR_to_the_Decoder :  STD_LOGIC;
                signal WR_to_the_Deterctor :  STD_LOGIC;
                signal WR_to_the_HIPController :  STD_LOGIC;
                signal WR_to_the_IDController :  STD_LOGIC;
                signal WR_to_the_Indicator :  STD_LOGIC;
                signal WR_to_the_KSController :  STD_LOGIC;
                signal WR_to_the_KontrolGenerator :  STD_LOGIC;
                signal WR_to_the_ODController :  STD_LOGIC;
                signal WR_to_the_PriorityController :  STD_LOGIC;
                signal WR_to_the_SelectMuxChannel :  STD_LOGIC;
                signal address_to_the_SRAM :  STD_LOGIC_VECTOR (19 DOWNTO 0);
                signal be_n_to_the_SRAM :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clk :  STD_LOGIC;
                signal data_to_and_from_the_SRAM :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal epcs_flash_controller_epcs_control_port_dataavailable_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_endofpacket_from_sa :  STD_LOGIC;
                signal epcs_flash_controller_epcs_control_port_readyfordata_from_sa :  STD_LOGIC;
                signal in_port_to_the_inp_pio :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input9 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal out_port_from_the_out_pio :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal read_n_to_the_SRAM :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal rxd_to_the_UART_1 :  STD_LOGIC;
                signal rxd_to_the_UART_13 :  STD_LOGIC;
                signal select_n_to_the_SRAM :  STD_LOGIC;
                signal txd_from_the_UART_1 :  STD_LOGIC;
                signal txd_from_the_UART_13 :  STD_LOGIC;
                signal write_n_to_the_SRAM :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : DME_ControllerUnit
    port map(
      Address_to_the_ADCSamples1 => Address_to_the_ADCSamples1,
      Address_to_the_ADCSamples2 => Address_to_the_ADCSamples2,
      Address_to_the_DACSamples => Address_to_the_DACSamples,
      Address_to_the_Decoder => Address_to_the_Decoder,
      Address_to_the_Deterctor => Address_to_the_Deterctor,
      Address_to_the_IDController => Address_to_the_IDController,
      Address_to_the_KSController => Address_to_the_KSController,
      Address_to_the_ODController => Address_to_the_ODController,
      Address_to_the_PriorityController => Address_to_the_PriorityController,
      Address_to_the_ReplyDelay => Address_to_the_ReplyDelay,
      Data_to_the_DACSamples => Data_to_the_DACSamples,
      Data_to_the_Decoder => Data_to_the_Decoder,
      Data_to_the_Deterctor => Data_to_the_Deterctor,
      Data_to_the_HIPController => Data_to_the_HIPController,
      Data_to_the_Indicator => Data_to_the_Indicator,
      Data_to_the_KSController => Data_to_the_KSController,
      Data_to_the_KontrolGenerator => Data_to_the_KontrolGenerator,
      Data_to_the_ODController => Data_to_the_ODController,
      Data_to_the_PriorityController => Data_to_the_PriorityController,
      Data_to_the_SelectMuxChannel => Data_to_the_SelectMuxChannel,
      MOSI_from_the_SPI_FRAM => MOSI_from_the_SPI_FRAM,
      MOSI_from_the_SPI_Flash => MOSI_from_the_SPI_Flash,
      MOSI_from_the_SPI_Synthesizer => MOSI_from_the_SPI_Synthesizer,
      RD_to_the_ADCSamples1 => RD_to_the_ADCSamples1,
      RD_to_the_ADCSamples2 => RD_to_the_ADCSamples2,
      RD_to_the_LogicReader => RD_to_the_LogicReader,
      RD_to_the_PairsCounter => RD_to_the_PairsCounter,
      RD_to_the_ReplyDelay => RD_to_the_ReplyDelay,
      RD_to_the_Synthesizer => RD_to_the_Synthesizer,
      SCLK_from_the_SPI_FRAM => SCLK_from_the_SPI_FRAM,
      SCLK_from_the_SPI_Flash => SCLK_from_the_SPI_Flash,
      SCLK_from_the_SPI_Synthesizer => SCLK_from_the_SPI_Synthesizer,
      SS_n_from_the_SPI_FRAM => SS_n_from_the_SPI_FRAM,
      SS_n_from_the_SPI_Flash => SS_n_from_the_SPI_Flash,
      SS_n_from_the_SPI_Synthesizer => SS_n_from_the_SPI_Synthesizer,
      WData_to_the_IDController => WData_to_the_IDController,
      WR_to_the_DACSamples => WR_to_the_DACSamples,
      WR_to_the_Decoder => WR_to_the_Decoder,
      WR_to_the_Deterctor => WR_to_the_Deterctor,
      WR_to_the_HIPController => WR_to_the_HIPController,
      WR_to_the_IDController => WR_to_the_IDController,
      WR_to_the_Indicator => WR_to_the_Indicator,
      WR_to_the_KSController => WR_to_the_KSController,
      WR_to_the_KontrolGenerator => WR_to_the_KontrolGenerator,
      WR_to_the_ODController => WR_to_the_ODController,
      WR_to_the_PriorityController => WR_to_the_PriorityController,
      WR_to_the_SelectMuxChannel => WR_to_the_SelectMuxChannel,
      address_to_the_SRAM => address_to_the_SRAM,
      be_n_to_the_SRAM => be_n_to_the_SRAM,
      data_to_and_from_the_SRAM => data_to_and_from_the_SRAM,
      out_port_from_the_out_pio => out_port_from_the_out_pio,
      read_n_to_the_SRAM => read_n_to_the_SRAM,
      select_n_to_the_SRAM => select_n_to_the_SRAM,
      txd_from_the_UART_1 => txd_from_the_UART_1,
      txd_from_the_UART_13 => txd_from_the_UART_13,
      write_n_to_the_SRAM => write_n_to_the_SRAM,
      CLK => CLK,
      Data_from_the_LogicReader => Data_from_the_LogicReader,
      Data_from_the_PairsCounter => Data_from_the_PairsCounter,
      Data_from_the_ReplyDelay => Data_from_the_ReplyDelay,
      Data_from_the_Synthesizer => Data_from_the_Synthesizer,
      MISO_to_the_SPI_FRAM => MISO_to_the_SPI_FRAM,
      MISO_to_the_SPI_Flash => MISO_to_the_SPI_Flash,
      MISO_to_the_SPI_Synthesizer => MISO_to_the_SPI_Synthesizer,
      RData_from_the_ADCSamples1 => RData_from_the_ADCSamples1,
      RData_from_the_ADCSamples2 => RData_from_the_ADCSamples2,
      in_port_to_the_inp_pio => in_port_to_the_inp_pio,
      reset_n => reset_n,
      rxd_to_the_UART_1 => rxd_to_the_UART_1,
      rxd_to_the_UART_13 => rxd_to_the_UART_13
    );


  --the_SRAM, which is an e_ptf_instance
  the_SRAM : SRAM
    port map(
      data => data_to_and_from_the_SRAM,
      address => module_input9,
      be_n => be_n_to_the_SRAM,
      read_n => read_n_to_the_SRAM,
      select_n => select_n_to_the_SRAM,
      write_n => write_n_to_the_SRAM
    );

  module_input9 <= address_to_the_SRAM(19 DOWNTO 2);

  process
  begin
    CLK <= '0';
    loop
       if (CLK = '1') then
          wait for 6 ns;
          CLK <= not CLK;
       else
          wait for 7 ns;
          CLK <= not CLK;
       end if;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 125 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
