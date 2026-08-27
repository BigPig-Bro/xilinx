// FT232H 高速USB测速顶层
//260826    v1.0.0   初始版本

module ft232h (
    input               i_rst_n,        //复位，低有效
    input               i_ft_clk,       //FT232H时钟
    input               i_ft_rxf_n,     //FT232H数据有效，低有效
    input               i_ft_txe_n,     //FT232H可写，低有效
    output logic        o_ft_oe_n,      //FT232H输出使能，低有效
    output logic        o_ft_rd_n,      //FT232H读，低有效
    output logic        o_ft_wr_n,      //FT232H写，低有效
    output logic        o_ft_siwu_n,    //FT232H唤醒，低有效
    inout  [7:0]        io_ft_data      //FT232H数据总线
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
typedef enum logic [1:0] {
    IDLE,
    READ,
    WRITE
} state_ft_t;
state_ft_t state;

logic [7:0] buf_data;    //FIFO写数据
logic       buf_wr;      //FIFO写请求
logic       buf_rd;      //FIFO读请求
logic       buf_empty;   //FIFO空
logic [7:0] ft_data_out; //FIFO读数据
logic       rst_n_sys;   //boot_rst上电复位输出

assign io_ft_data = (o_ft_oe_n == 1'b0) ? 8'hzz : ft_data_out;
assign o_ft_siwu_n = 1'b1; //FT232H唤醒信号，低有效，暂时不使用
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              boot_rst上电复位           /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
boot_rst boot_rst_m0(
    .i_clk   (i_ft_clk  ),
    .i_rst_n (i_rst_n   ),
    .o_rst_n (rst_n_sys )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              ft_buf FIFO例化            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
ft_buf ft_buf_m0(
    .wrclk   (i_ft_clk    ),
    .data    (buf_data    ),
    .wrreq   (buf_wr      ),
    .wrusedw (            ),
    .rdclk   (i_ft_clk    ),
    .rdreq   (buf_rd      ),
    .q       (ft_data_out ),
    .rdusedw (            ),
    .wrfull  (            ),
    .rdempty (buf_empty   )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              USB收发时序状态机           /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_ft_clk)begin
    if(!rst_n_sys)begin
        state <= IDLE;
    end else begin
        case(state)
            IDLE:begin
                if(!i_ft_rxf_n)begin //接收到数据时，rxf_n为低电平
                    o_ft_oe_n <= 1'b0; //接收数据时，oe_n为低允许接收
                    state     <= READ;
                end else if(!i_ft_txe_n && !buf_empty)begin //发送FIFO不空且可发送
                    buf_rd <= 1'b1; //读FIFO
                    state  <= WRITE;
                end else begin
                    buf_rd    <= 1'b0;
                    buf_wr    <= 1'b0;
                    o_ft_oe_n <= 1'b1;
                    o_ft_rd_n <= 1'b1;
                    o_ft_wr_n <= 1'b1;
                    state     <= IDLE;
                end
            end

            READ:begin
                if(!i_ft_rxf_n && !o_ft_rd_n)begin
                    buf_wr   <= 1'b1;
                    buf_data <= io_ft_data;
                end else if(o_ft_rd_n)begin
                    o_ft_rd_n <= 1'b0; //rd_n比oe_n慢一拍拉低
                    buf_data  <= io_ft_data;
                end else begin
                    buf_wr    <= 1'b0;
                    o_ft_oe_n <= 1'b1;
                    o_ft_rd_n <= 1'b1;
                    state     <= IDLE;
                end
            end

            WRITE:begin
                if(!i_ft_txe_n && !buf_empty)begin
                    o_ft_wr_n <= 1'b0; //写数据时，wr_n为低有效
                    state     <= WRITE;
                end else begin
                    o_ft_wr_n <= 1'b1;
                    buf_rd    <= 1'b0;
                    state     <= IDLE;
                end
            end

            default:begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
