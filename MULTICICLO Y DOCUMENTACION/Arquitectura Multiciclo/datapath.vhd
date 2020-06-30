Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity datapath is

	generic 
	(
		DATA_WIDTH : natural := 21;
		ADDR_WIDTH : natural := 9
	);
	Port
	(
		Clk: in std_logic;
		Button1: in std_logic;
		Button2: in std_logic;
		Button3: in std_logic;
		Button4: in std_logic;
		min1: out std_logic_vector(6 downto 0);
		min2: out std_logic_vector(6 downto 0);
		trashState: out natural;
		led: out std_logic
	);

End Entity;

Architecture Behaviour of datapath is

	Component Inputs
		port
		(
			Button1: in std_logic;
		Button2: in std_logic;
		Button3: in std_logic;
		Button4: in std_logic;
		conf: out std_logic_vector(15 downto 0);
		clk: in std_logic
		);

	End Component;
	
	Component Decode 
	port(
		Inmin : in std_logic_vector(15 downto 0);
		outmin : out std_logic_vector(6 downto 0)
		);
	end Component;

	Component pc
	port
	(	inp : in std_logic_vector(8 downto 0);
		ou : out std_logic_vector(8 downto 0);
		clk : std_logic;
		sig: std_logic
	);
	End Component;
	component Divider
	port
	(
		Clkin: in std_logic;
		Clkout: out std_logic
	);
	
	End Component;
	
	Component instregister
		port
	(	inp : in std_logic_vector(20 downto 0);
		ou : out std_logic_vector(20 downto 0);
		clk : std_logic;
		sig : std_logic
	);
	End Component;
	
	Component registerFile
	port
	(
		Clk : in std_logic;
		RS,RT,RD : in std_logic_vector(3 downto 0);
		WE : in std_logic;
		Data : in std_logic_vector(15 downto 0);
		A,B : out std_logic_vector(15 downto 0);
		outmin1, outmin2: out std_logic_vector(15 downto 0);
	
		
		conf: in std_logic_vector(15 downto 0)
	);
	End Component;
	
	Component ALU
	port
	(
		ALU_OP : in std_logic_vector(2 downto 0);
		A,B : in std_logic_vector(15 downto 0);
		OU1: out std_logic_vector(15 downto 0);
		Branch: out std_logic
	);
	End Component;
	
	Component instrucMem
		port 
	(
		clk		: in std_logic;
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '0';
		re    : in std_logic := '0';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
	End Component;
	
	Component reg
	port
	(	inp : in std_logic_vector(15 downto 0);
		ou : out std_logic_vector(15 downto 0);
		clk : std_logic
	);
	End Component;
	
	Component State
		port
		(
			clk : in	std_logic;
			inp	 : in	std_logic_vector(3 downto 0);
			reset	 : in	std_logic;
			pcwritecon : out std_logic;
			pcwrite : out std_logic;
			iord : out std_logic;
			memread : out std_logic;
			memwrite : out std_logic;
			irwrite : out std_logic;
			regdes : out std_logic_vector(1 downto 0);
			memtoreg : out std_logic_vector(1 downto 0);
			regwrite : out std_logic;
			aluop : out std_logic_vector(2 downto 0);
			alusrcb : out std_logic;
			pcsource : out std_logic_vector(1 downto 0);
			Estado: out natural;
			mdrsig: out std_logic;
			Mux: out std_logic_vector(1 downto 0)
		);
	End Component;
	
	Component adder
		port
		(
			Inp: in std_logic_vector(8 downto 0);
			ou: out std_logic_vector(8 downto 0)
		);
		
	End Component;
	
	Component mdr
		port
		(	
			inp : in std_logic_vector(15 downto 0);
			ou : out std_logic_vector(15 downto 0);
			clk : std_logic;
			mdrsig: std_logic
		);
	
	End Component;
	
	Signal ledt : std_logic;
	
	Signal BMux: std_logic_vector(1 downto 0);
	Signal BMuxOut: std_logic_vector(15 downto 0);
	Signal conf: std_logic_vector(15 downto 0);
	Signal Inmin1: std_logic_vector(15 downto 0);
	Signal Inmin2: std_logic_vector(15 downto 0);
	Signal Inputset : std_logic;
	Signal pcwritecon : std_logic;
	Signal pcwrite : std_logic;
	Signal iord : std_logic;
	Signal memread : std_logic;
	Signal memwrite : std_logic;
	Signal irwrite : std_logic;
	Signal regdes : std_logic_vector(1 downto 0);
	Signal memtoreg : std_logic_vector(1 downto 0);
	Signal regwrite : std_logic;
	Signal aluop : std_logic_vector(2 downto 0);
	Signal alusrcb : std_logic;
	Signal pcsource : std_logic_vector(1 downto 0);
	Signal Memoryout: std_logic_vector(20 downto 0);
	Signal IorDMux: std_logic_vector(8 downto 0);
	Signal Pcin: std_logic_vector(8 downto 0);
	Signal Pcout: std_logic_vector(8 downto 0);
	Signal ALUOUT: std_logic_vector(15 downto 0);
	Signal Memoryin: std_logic_vector(20 downto 0);
	Signal IRout: std_logic_vector(20 downto 0);
	Signal MDROUT: std_logic_vector(15 downto 0);
	Signal MemtoregMUX: std_logic_vector(15 downto 0);
	Signal regdesMUX: std_logic_vector(3 downto 0);
	Signal RegA: std_logic_vector(15 downto 0);
	Signal RegB: std_logic_vector(15 downto 0);
	Signal RegAOut: std_logic_vector(15 downto 0);
	Signal RegBOut: std_logic_vector(15 downto 0);
	Signal alusrcbMUX: std_logic_vector(15 downto 0);
	Signal AluTemp: std_logic_vector(15 downto 0);
	Signal Reset1: std_logic;
	Signal PcAdderSig: std_logic;
	Signal PcAdderOut: std_logic_vector(8 downto 0);
	Signal PcsourceMUX: std_logic_vector(8 downto 0);
	Signal mdrsig: std_logic;
	Signal ALUBranch: std_logic;
	Signal BranchSig: std_logic;
	Signal pcWriteSignal: std_logic;
	Signal clkt: std_logic;
	
	Attribute keep: Boolean;
	Attribute keep of Inmin1: signal is true;
	Attribute keep of ledt: signal is true;
	Attribute keep of Inmin2: signal is true;
	Attribute keep of conf: signal is true;
	Attribute keep of ALuOUT: signal is true;
	Attribute keep of memoryout: signal is true;
	Attribute keep of memoryin: signal is true;
	Attribute keep of PcsourceMUX: signal is true;
	Attribute keep of Irout: signal is true;
	Attribute keep of iorDMux: signal is true;
	Attribute keep of RegAOut: signal is true;
	Attribute keep of RegBOut: signal is true;
	Attribute keep of alusrcbMUX: signal is true;
	Attribute keep of memread: signal is true;
	Attribute keep of memwrite: signal is true;
	Attribute keep of memtoregMUX: signal is true;
	Attribute keep of MDROUT: signal is true;
	Attribute keep of AluTemp: signal is true;
	Attribute keep of aluop: signal is true;
	Attribute keep of BranchSig: signal is true;
	Attribute keep of pcWriteSignal: signal is true;
	
	
	Begin
		Memoryin <= ("00000"&RegBOut);
		BranchSig <= (ALUBranch and pcwritecon);
		pcWriteSignal <=(pcWrite or BranchSig);
	
		With iord select IorDMux <=
			Pcout when '0',
			ALUOUT(8 downto 0) when '1',
			NULL when others;
			
		with regdes select regdesMUX <=
			Irout(12 downto 9) when "00",
			Irout(8 downto 5) when "01",
		   "1111" when "10",
			NULL when others;
		
		with memtoreg select memtoregMUX <=
			MDROUT when "00",
			AluOUT when "01",
			("0000000"&Pcout) when "10",
			NULL when others;
			
		with BMux select BmuxOut <=
			memtoregMUX when "00",
			conf when "01",
			NULL when others;
		
			
		with alusrcb select alusrcbMUX <=
			RegBOut when '0',
			("0000000"&Irout(8 downto 0)) when '1',
			NULL when others;
			
		with pcsource select PcsourceMUX <=
			Irout(16 downto 8) when "00",
			PcadderOut when "01",
			Irout(8 downto 0) when "10",
			regAOut(8 downto 0) when "11";
			
			
		PC1: pc port Map(PcsourceMUX,Pcout,clkt,pcWriteSignal);
		Ram1: instrucMem port Map(clkt,to_integer(unsigned(IorDMux)),Memoryin,memwrite,memread,memoryout);
		Ir1: instregister port Map(memoryout,Irout,clkt,irwrite);
		MDR1: mdr port Map(Memoryout(15 downto 0),MDROUT,clkt,mdrsig);
		RegF1: registerFile port Map(clkt,Irout(16 downto 13),Irout(12 downto 9),regdesMUX,regwrite,BMuxOut,RegA,RegB,Inmin1,Inmin2,conf);
		Deco1: Decode port Map(Inmin1,min1);
		Deco2: Decode port Map(Inmin2,min2);
		ReA: reg port Map(RegA,RegAOut,clkt);
		ReB: reg port Map(RegB,RegBOut,clkt);
		ALu1: alu port Map(aluop,RegAOut,alusrcbMUX,Alutemp,ALUBranch);
		RegAlu: reg port Map (Alutemp,AluOUT,clkt);
		MaqEstad: State port Map(clkt,Irout(20 downto 17), reset1, pcwritecon , pcwrite, iord , memread , memwrite ,irwrite , regdes ,memtoreg, regwrite , aluop, alusrcb, pcsource,trashState,mdrsig,BMux);
		Pcadder: adder port Map(Pcout,PcadderOut);
		Divider1: Divider port Map(Clk,clkt);
		Inputs1: Inputs port Map(Button1,Button2,Button3,Button4,Conf,clkt);
End Behaviour;