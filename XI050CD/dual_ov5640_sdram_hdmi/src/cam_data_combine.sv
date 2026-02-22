module cam_data_combine(
    input                                   i_cam_pclk,
    input                                   i_cam_vsync,
    input                                   i_cam_href,
    input               [ 7:0]              i_cam_data_8,

    output  logic                           o_cam_data_rst,
    output  logic                           o_cam_data_valid,
    output  logic       [31:0]              o_cam_data_32
);
/********************************************************************************/
/**************************   Test Code        **********************************/
/********************************************************************************/ 
// logic [18:0] write_cnt;
// always@(posedge i_cam_pclk)begin
//     if (o_cam_data_rst) begin
//         write_cnt <= 'd0;
//     end else if (o_cam_data_valid) begin
//         write_cnt <= write_cnt + 1;
//     end
// end

// ila_cam ila_cam_m0(
//     .clk        (i_cam_pclk         ),
//     .probe0     (i_cam_vsync        ),
//     .probe1     (i_cam_href         ),
//     .probe2     (o_cam_data_valid   ),
//     .probe3     (o_cam_data_rst     ),
//     .probe4     (write_cnt          )
// );

/********************************************************************************/
/**************************      Done         **********************************/
/********************************************************************************/ 
logic         cam_vsync_d0, cam_vsync_d1;

always@(posedge i_cam_pclk) begin
    cam_vsync_d0 <= i_cam_vsync;
    cam_vsync_d1 <= cam_vsync_d0;

    if(cam_vsync_d0 & cam_vsync_d1) //vsync信号连续两个周期为高，说明是新的一帧开始，复位数据处理模块
        o_cam_data_rst <= 1'b1;
    else
        o_cam_data_rst <= 1'b0;
end

/********************************************************************************/
/**************************      Data         **********************************/
/********************************************************************************/ 
logic [1:0]   byte_cnt;
logic [23:0]  cam_data_32_r;

always@(posedge i_cam_pclk) begin
    if(i_cam_href) begin
        byte_cnt <= byte_cnt + 2'b01;
    end else begin
        byte_cnt <= 2'b00;
    end
end

always@(posedge i_cam_pclk) begin
    case(byte_cnt)
        2'b00: cam_data_32_r[23:16] <= i_cam_data_8;
        2'b01: cam_data_32_r[15: 8] <= i_cam_data_8;
        2'b10: cam_data_32_r[ 7: 0] <= i_cam_data_8;
        // 2'b11: 输出在上一个always块中处理
    endcase
end

logic cam_data_valid_d0;
always@(posedge i_cam_pclk) begin
    o_cam_data_valid <= cam_data_valid_d0; //数据有效信号延迟一个周期，保证数据稳定

    if(byte_cnt == 2'b11) begin
        cam_data_valid_d0 <= 1'b1;
        // o_cam_data_32 <= {cam_data_32_r[23:0], i_cam_data_8};
        o_cam_data_32 <= {cam_data_32_r[12:8],cam_data_32_r[18:13],cam_data_32_r[23:19], //Pixel 1
                          i_cam_data_8[4:0], {cam_data_32_r[2:0],i_cam_data_8[7:5]},cam_data_32_r[7:3]}; //Pixel 2
    end else begin
        cam_data_valid_d0 <= 1'b0;
    end
end

endmodule