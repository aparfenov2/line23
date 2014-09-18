-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity proc_control is
	port
	(
		OE : in std_logic;
		sram_cs : in std_logic;
		sram_we : in std_logic;
		CTS_10 : in std_logic;
		CTS_11 : in std_logic;
		CTS_12 : in std_logic;
		CTS_7 : in std_logic;
		CTS_8 : in std_logic;
		DSR_10 : in std_logic;
		DSR_11 : in std_logic;
		DTR_10 : in std_logic;
		DTR_11 : in std_logic;
		RTS_10 : in std_logic;
		RTS_11 : in std_logic;
		RTS_12 : in std_logic;
		RTS_7 : in std_logic;
		RTS_8 : in std_logic;
		RxD_1 : in std_logic;
		RxD_10 : in std_logic;
		RxD_11 : in std_logic;
		RxD_12 : in std_logic;
		RxD_13 : in std_logic;
		RxD_14 : in std_logic;
		RxD_2 : in std_logic;
		RxD_3 : in std_logic;
		RxD_4 : in std_logic;
		RxD_5 : in std_logic;
		RxD_6 : in std_logic;
		RxD_7 : in std_logic;
		RxD_8 : in std_logic;
		RxD_9 : in std_logic;
		TxD_1 : in std_logic;
		TxD_10 : in std_logic;
		TxD_11 : in std_logic;
		TxD_12 : in std_logic;
		TxD_13 : in std_logic;
		TxD_14 : in std_logic;
		TxD_2 : in std_logic;
		TxD_3 : in std_logic;
		TxD_4 : in std_logic;
		TxD_5 : in std_logic;
		TxD_6 : in std_logic;
		TxD_7 : in std_logic;
		TxD_8 : in std_logic;
		TxD_9 : in std_logic;
		alarm_ind : in std_logic;
		button_otl : in std_logic;
		clr_watch_dog : in std_logic;
		damage_ind : in std_logic;
		du_ind : in std_logic;
		fm_ss_n : in std_logic;
		inp_clk : in std_logic;
		lock : in std_logic;
		log_miso : in std_logic;
		log_mosi : in std_logic;
		log_sclk : in std_logic;
		log_ss_n : in std_logic;
		miso : in std_logic;
		mosi : in std_logic;
		mu_ind : in std_logic;
		norm_du_ind : in std_logic;
		norm_ind : in std_logic;
		reset_inp : in std_logic;
		rtc_ss_n : in std_logic;
		sclk : in std_logic;
		uu_miso : in std_logic;
		uu_sclk : in std_logic;
		uu_ss_n : in std_logic;
		work1_ind : in std_logic;
		work2_ind : in std_logic;
		A : in std_logic_vector(2 to 19);
		D : in std_logic_vector(0 to 31);
		sram_be : in std_logic_vector(0 to 3);
		inp : in std_logic_vector(0 to 15);
		out : in std_logic_vector(0 to 15)
	);

end proc_control;

architecture ppl_type of proc_control is

begin

end;
