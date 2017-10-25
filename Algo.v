module final_algo(dividend,divisor,rem,quo); //Initializing the module, Three Inputs 

	input [5:0] dividend;  //6-Bit Register 
	input [2:0] divisor;// 3-Bit Register
	output [5:0] rem;// 6-Bit Register, Remainder
	output [5:0] quo;// 6-Bit Register, Quotient
	
	integer i; // Decalring Interger for Loop 
	reg [5:0] Q; // Intermediate Regiters for Value Holding (Dividend)
	reg [5:0] M; // Intermediate Regiters for Value Holding (Divisor)
	reg [5:0] A; // Intermediate Regiters for Value Holding 
	
	always@(dividend or divisor)
	// Always Checks For Non-Negativity Condition
	begin                               
		M = 0; M = M + divisor; // As Divisor is 3 Bit and M is 6 Bit
		Q = dividend;
		A = 0;// Initializing with Zero, As Per Algorithm
		for(i=0; i<6; i=i+1)//Looping No. of Bits(6) in Dividend Times
		begin              
			if(A[5]==0)  //Checking The Sign of the Dividend(Positive Condition)
			begin
				A = A << 1;   //Left Shift The Bits of A Register
				A[0] = Q[5];  //As Verilog Shifts Circularly, Manual Shifting
				Q = Q << 1;   // Left Shift The Bits of Q Register
				Q = Q & 6'b111110; //As Verilog Shifts Circularly, Maunally Inserting Zero At End
				A = A - M;// Subtracting A from M
			end
			else //The Loop When A is Negative
			begin
				A = A << 1;//Left Shift The Bits of A Register
				A[0] = Q[5];//As Verilog Shifts Circularly, Manual Shifting
				Q = Q << 1;// Left Shift The Bits of Q Register
				Q = Q & 6'b111110;//As Verilog Shifts Circularly, Maunally Inserting Zero At End
				A = A + M;// Adding A and M
			end
			if(A[5]==1)// Checking MSB
			begin
				Q = Q & 6'b111110; //Setting LSB of Q = 0
			end
			else
			begin
				Q = Q | 6'b000001; //Setting LSB of Q = 1
			end
		end
		if(A[5]==1) // Checking MSB
		begin
			A = A + M; // Adjusting The Remainder
		end
	end
	assign quo = Q; // Assigning Values to Quotient
	assign rem = A; // Assigning Values to Remainder
endmodule