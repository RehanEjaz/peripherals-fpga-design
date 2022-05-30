`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2022 19:07:39
// Design Name: 
// Module Name: GPIO_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GPIO_TB #(parameter   // parameters
  GPIO_PINS  = 32, // Must be a multiple of 8
  PADDR_SIZE = 4,
  STAGES     = 2)(
    output logic  clk_in1=0,  
    output logic reset=1,
    input   logic [7:0]   gpio_of,gpio_oef

    );
    localparam MODE      = 0,
               DIRECTION = 1,
               OUTPUT    = 2,
               INPUT     = 3,
               TR_TYPE   = 4,
               TR_LVL0   = 5,
               TR_LVL1   = 6,
               TR_STAT   = 7,
               IRQ_EN    = 8;
    
    gpio_controller  #(
           .GPIO_PINS(GPIO_PINS), // Must be a multiple of 8
           .PADDR_SIZE(PADDR_SIZE),
           .STAGES(STAGES) ) gpio_dut(.*);

    logic Data=32'dx;


task check ( input [32-1:0] actual,
                            expected
             );
             
               if (actual == expected)
               $display("Test Passed");
               else
               $display("Test Failed");
             endtask : check
           
    always
    #5 clk_in1 = ~clk_in1;
    
    initial begin
    #60 reset =0;
     
    end
    
endmodule
