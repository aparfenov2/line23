module task_cross_domain (
    input rst,
    
    input clkA,
    input TaskStart_clkA,
    output TaskBusy_clkA, TaskDone_clkA,

    input clkB,
    output TaskStart_clkB, TaskBusy_clkB,
    input TaskDone_clkB
);

reg FlagToggle_clkA, FlagToggle_clkB, Busyhold_clkB;
reg [2:0] SyncA_clkB, SyncB_clkA;

always @(posedge clkA or posedge rst) begin
    if (rst) begin
        FlagToggle_clkA <= 0;
    end else begin
        FlagToggle_clkA <= FlagToggle_clkA ^ (TaskStart_clkA & ~TaskBusy_clkA);
    end
end

always @(posedge clkB or posedge rst) begin 
    if (rst) begin
        SyncA_clkB <= 0;
    end else begin
        SyncA_clkB <= {SyncA_clkB[1:0], FlagToggle_clkA};
    end
end

assign TaskStart_clkB = (SyncA_clkB[2] ^ SyncA_clkB[1]);
assign TaskBusy_clkB = TaskStart_clkB | Busyhold_clkB;

always @(posedge clkB or posedge rst) begin
    if (rst) begin
        Busyhold_clkB <= 0;
    end else begin
        Busyhold_clkB <= ~TaskDone_clkB & TaskBusy_clkB;
    end
end
    
always @(posedge clkB or posedge rst) begin
    if (rst) begin
        FlagToggle_clkB <= 0;
    end else begin
        if(TaskBusy_clkB & TaskDone_clkB) FlagToggle_clkB <= FlagToggle_clkA;
    end
end

always @(posedge clkA or posedge rst) begin
    if (rst) begin
        SyncB_clkA <= 0;
    end else begin
        SyncB_clkA <= {SyncB_clkA[1:0], FlagToggle_clkB};
    end
end
    
assign TaskBusy_clkA = FlagToggle_clkA ^ SyncB_clkA[2];
assign TaskDone_clkA = SyncB_clkA[2] ^ SyncB_clkA[1];
endmodule
