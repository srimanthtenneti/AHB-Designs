/*
   Design : Universal AHB Lite Interface
   Protocol : AHB-Lite -> AMBA3
   Engineer : Srimanth Tenneti
   Date : 4th october 2020
   File : Top Level 
   Version : 1
*/

/*
Description : 
-------------
 1)  Peripheral Interface unit
 
 Interface Input:
 ----------------
 1. HSELX : Posedge Trigger
 2. HWRITE : 1 -> Write 0 -> Read
 3. HTRANS : Non - Seq (Default)
 4. HSIZE : 2bit
 5. HADDR : 32 bit
 6. HRESETIN : Negedge Trigger
 
 Pipeline : 1 stage
*/

module AHB_Interface(
  input HCLK,
  input HRESETIN,
  input HSELX,
  input HWRITE,
  input [1:0]HTRANS,
  input [1:0]HSIZE,
  input [31:0]HADDR,
  input [31:0]HWDATA,
  input[31:0]HRDATA,
  input HREADYOUT,
  output reg HSELX_OUT,
  output reg HWRITE_OUT,
  output reg [1:0]HTRANS_OUT,
  output reg [1:0]HSIZE_OUT,
  output reg [31:0]HADDR_OUT,
  output reg [31:0]HWDATA_OUT
);
  
  reg HSELX_TEMP;
  reg HWRITE_TEMP;
  reg [1:0]HTRANS_TEMP;
  reg [1:0]HSIZE_TEMP;
  reg [31:0]HADDR_TEMP;
  reg [31:0]HWDATA_TEMP;
  
  always @ (posedge HCLK)
    begin
      if(!HRESETIN)
        begin
           HWDATA_OUT <= 0;
        end
      else
        begin
           HWDATA_OUT <= HWDATA; 
        end
    end
  
  always @ (posedge HCLK)
    begin
      if(!HRESETIN)
        begin
           HSELX_OUT <= 0;
           HWRITE_OUT <= 0;
           HTRANS_OUT <= 0;
           HSIZE_OUT <= 0;
           HADDR_OUT <= 0;
        end
      
      else
        begin
           
           HSELX_TEMP <= HSELX;
           HSELX_OUT  <= HSELX_TEMP;
          
           HWRITE_TEMP <= HWRITE;
           HWRITE_OUT <= HWRITE_TEMP;

           HTRANS_TEMP <= HTRANS;
           HTRANS_OUT <= HTRANS_TEMP;

           HSIZE_TEMP <= HSIZE; 
           HSIZE_OUT <= HSIZE_TEMP;

           HADDR_TEMP <= HADDR;
           HADDR_OUT <= HADDR_TEMP;
        end  
    end
endmodule
