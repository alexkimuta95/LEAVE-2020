codeunit 51300 "HR Leave management"
{
    trigger OnRun()
    begin

    end;

    procedure PostLeaveAllocation(LeaveAllocation: Code[30]) LeaveAllocationPosted: Boolean
    var
        HRLeaveAllocationHeader: Record "Leave Allocation";
        HRLeaveAllocationLine: Record "Leave Allocation Line";
        leaveLedgerEntry: Record "Leave Ledger Entry";
        Employee: Record Employee;

    begin
        LeaveAllocationPosted := false;
        HRLeaveAllocationHeader.Get(LeaveAllocation);
        HRLeaveAllocationLine.Reset();
        HRLeaveAllocationLine.SetRange(HRLeaveAllocationLine."No.", HRLeaveAllocationHeader."No.");
        HRLeaveAllocationLine.SetFilter("Allocate the Days", '>%1', 0);
        IF HRLeaveAllocationLine.FINDSET THEN BEGIN
            REPEAT
                Employee.Get(HRLeaveAllocationLine."Employee No.");
                LeaveLedgerEntry.Init();
                LeaveLedgerEntry."Line No." := 0;
                LeaveLedgerEntry."Document No." := HRLeaveAllocationLine."No.";
                LeaveLedgerEntry."Posting Date" := HRLeaveAllocationHeader."Posting Date";

                LeaveLedgerEntry."Entry Type" := HRLeaveAllocationLine."Entry Type";
                LeaveLedgerEntry."Employee No." := HRLeaveAllocationLine."Employee No.";
                LeaveLedgerEntry."Leave Type" := HRLeaveAllocationHeader."Leave Type";
                LeaveLedgerEntry."Leave Period" := HRLeaveAllocationHeader."Leave Period";
                IF HRLeaveAllocationLine."Entry Type" = HRLeaveAllocationLine."Entry Type"::"Positive Adjustment" then
                    leaveLedgerEntry.Days := HRLeaveAllocationLine."Allocate the Days"
                ELSE
                    LeaveLedgerEntry.Days := -(HRLeaveAllocationLine."Allocate the Days");

                LeaveLedgerEntry."Leave Allocation" := TRUE;
                LeaveLedgerEntry.INSERT;
            UNTIL HRLeaveAllocationLine.NEXT = 0;
        END;
        COMMIT;
        HRLeaveAllocationHeader.Get(LeaveAllocation);
        LeaveLedgerEntry.Reset();
        LeaveLedgerEntry.SETRANGE(LeaveLedgerEntry."Document No.", HRLeaveAllocationHeader."No.");
        IF LeaveLedgerEntry.FINDFIRST then begin
            HRLeaveAllocationHeader.Status := HRLeaveAllocationHeader.Status::Posted;
            HRLeaveAllocationHeader.Posted := TRUE;
            HRLeaveAllocationHeader."Posted By" := USERID;
            HRLeaveAllocationHeader."Date Posted" := TODAY;
            HRLeaveAllocationHeader."Time Posted" := TIME;
            HRLeaveAllocationHeader.Validate(HRLeaveAllocationHeader.Status);
            IF HRLeaveAllocationHeader.Modify() then begin
                LeaveAllocationPosted := true;
            end;
        end;
    end;

    var
        myInt: Integer;
}