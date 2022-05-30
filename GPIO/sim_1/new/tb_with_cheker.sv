`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 18:56:46
// Design Name: 
// Module Name: tb_with_cheker
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


module tb_with_cheker#(parameter   // parameters
  GPIO_PINS  = 32, // Must be a multiple of 8
  PADDR_SIZE = 4,
  STAGES     = 2)(   // Steges to add more stability to inputs)(
    input  clk_in1,  
    input  reset,
    output   logic [7:0]   gpio_of,gpio_oef
    //,
    
//    output                          pclk,
//    output  logic [GPIO_PINS-1:0]   gpio_i,
//    output  logic                   prstn,
//    output  logic                   psel,
//    output  logic                   penable,
//    output  logic [PADDR_SIZE-1:0]  paddr,
//    output  logic                   pwrite,
//    output  logic [GPIO_PINS-1:0]   pwrdata,
//    output  logic [GPIO_PINS/8-1:0] pstrb,
//    input logic                   pready,
//    input logic [GPIO_PINS-1:0]   prddata,
//    input logic                   pslverr,
//    input logic                   irq_o,
//    input logic [GPIO_PINS-1:0]   gpio_o=0,
//                                   gpio_oe=0

    );
    
    

     logic                   pclk;
     logic [GPIO_PINS-1:0]   gpio_i=0;
     logic                   prstn;
     logic                   psel;
     logic                   penable;
     logic [PADDR_SIZE-1:0]  paddr=0;
     logic                   pwrite=0;
     logic [GPIO_PINS-1:0]   pwrdata=0;
     logic [GPIO_PINS/8-1:0] pstrb=4'b1111;
     logic                   pready;
     logic [GPIO_PINS-1:0]   prddata;
     logic                   pslverr;
     logic                   irq_o;
     logic [GPIO_PINS-1:0]   gpio_o,gpio_oe; 

    assign prstn = ~reset;
    assign gpio_of =  gpio_o[7:0];
    assign gpio_oef = gpio_oe[7:0];
    
//     logic clk_i; //use for FPGA

//   clk_wiz_0  clk_gen  // Use for FPGA
//     (
//      // Clock out ports
//      .clk_out1(clk_i),
//     // Clock in ports
//      .clk_in1(clk_in1)
//     );
     


//    assign pclk = clk_i; //use for FPGA
    assign pclk = clk_in1; // Use for Simulation
 
   
     rev_gpio #(
        .GPIO_PINS(GPIO_PINS), // Must be a multiple of 8
        .PADDR_SIZE(PADDR_SIZE),
        .STAGES(STAGES)) gpio_peripheral   
        ( 
        .pclk    (pclk   ),
        .gpio_i  (gpio_i ), 
        .prstn   (prstn  ),  
        .psel    (psel   ), 
        .penable (penable), 
        .paddr   (paddr  ), 
        .pwrite  (pwrite ),  
        .pwrdata (pwrdata),   
        .pstrb   (pstrb  ),  
        .pready  (pready ),   
        .prddata (prddata),   
        .pslverr (pslverr),   
        .irq_o   (irq_o  ),       
        .gpio_o (gpio_o ), 
        .gpio_oe(gpio_oe)
    );
    
    
    logic [7:0] clk_cnt=0;
//   enum {  IDLE , SET_MODE , SET_DIR , SET_OUTPUT, SET_TRIG_TYPE, SET_TRIG_LVL_LOW, SET_TRIG_LVL_HIGH, SET_IRQ } currState, nextState;

//    always @(posedge pclk or negedge prstn) begin    
//        if (!prstn) begin
//            currState <= IDLE;
//            clk_cnt <=0;
//        end
//        else begin
//        case (currState)

//            IDLE:           begin 
 initial begin
                                paddr    <= 'd0;
                                pwrdata   <= 'd0; 
                                pwrite   <= 'd0; 
//                            end                                    

//            SET_MODE:   begin // Setting Mode register
                                paddr    <= 'd0;  // Mode register address
                                pwrdata   <= 'd0; // All pins set to Push Pull
                                pwrite   <= 'd1; 
//                            end                                    

//            SET_DIR:        begin // Setting Direction Either input or Output  0 = input 1 =  Output 
                                paddr    <= 12'h1;
                                pwrdata   <= 32'b1111_1111_1111_1111_1111_1111_1111_1111; 
                                pwrite   <= 'd1; 
//                            end                                    


//            SET_OUTPUT:  begin // Setting Output state of each GPIO
                                paddr    <= 12'h2;
                                pwrdata   <= 32'b0000_0000_0000_0000_0000_0000_1000_1000; 
                                pwrite   <= 'd1; 
//                            end                                    


//            SET_TRIG_TYPE:  begin // Setting input Trigger type either logic level or edge trigger
                                paddr    <= 'h4;
                                pwrdata   <= 32'b1111_1111_1111_1111_1111_1111_1111_1111;
                                pwrite   <= 'd1; 
//                            end                                    


//            SET_TRIG_LVL_LOW:begin  //Setting trigger level low interrupts
                                paddr    <= 'h5;
                                pwrdata   <=  32'd0;
                                pwrite   <= 'd1; 
//                            end                                    


//            SET_TRIG_LVL_HIGH: begin // Setting trigger level high interrupts
                                paddr    <= 'h6;
                                pwrdata   <= 'd0; 
                                pwrite   <= 'd1; 
//                            end
//            SET_IRQ: begin 
                                paddr    <= 'h8;
                                pwrdata   <= 'd0; 
                                pwrite   <= 'd1; 
//                            end                                    

 
endmodule
