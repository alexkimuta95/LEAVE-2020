codeunit 50001 "Inventory & Cash Management"
{
    trigger OnRun()
    begin

    end;

    procedure ReopenAdvancePettyCashIOU(VAR AdvancePettyCashIOUHeader: Record "Cash Management Header")
    begin
        WITH AdvancePettyCashIOUHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            Status := Status::Open;

            MODIFY(TRUE);
        END;
    end;

    procedure PerformManualReleaseAdvancePettyCashIOU(VAR AdvancePettyCashIOUHeader: Record "Cash Management Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovedOnly: Boolean;
    begin
        WITH AdvancePettyCashIOUHeader DO BEGIN

            //IF ApprovalManagement.CheckApprAdvancePettyCashIOUDocument(AdvancePettyCashIOUHeader) THEN BEGIN
            CASE Status OF
                Status::"Pending Approval":
                    ERROR(Text002);
                Status::Released:
                    EXIT;
                Status::Open:
                    BEGIN
                        ApprovedOnly := TRUE;
                        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
                        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Cash Management Header");
                        //Filter for the different Document Types
                        IF AdvancePettyCashIOUHeader."Document Type" = AdvancePettyCashIOUHeader."Document Type"::"Petty Cash" THEN BEGIN
                            // ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"10");
                        END ELSE
                            IF AdvancePettyCashIOUHeader."Document Type" = AdvancePettyCashIOUHeader."Document Type"::Advance THEN BEGIN
                                // ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"11");
                            END ELSE
                                IF AdvancePettyCashIOUHeader."Document Type" = AdvancePettyCashIOUHeader."Document Type"::Training THEN BEGIN
                                    // ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"21");

                                END ELSE
                                    IF AdvancePettyCashIOUHeader."Document Type" = AdvancePettyCashIOUHeader."Document Type"::IOU THEN BEGIN
                                        // ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"12");
                                    END;
                        //End Filter different Document types
                        ApprovalEntry.SETRANGE("Document No.", No);
                        ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
                        IF ApprovalEntry.FINDSET THEN BEGIN
                            REPEAT
                                IF ApprovalEntry.Status <> ApprovalEntry.Status::Approved THEN
                                    ApprovedOnly := FALSE;
                            UNTIL NOT ApprovedOnly OR (ApprovalEntry.NEXT = 0);

                            IF ApprovedOnly THEN BEGIN
                                TESTFIELD("Account No.");
                                TESTFIELD("On Behalf Of");
                                TESTFIELD(Description);
                                TESTFIELD(Date);
                                Status := Status::Released;
                                MODIFY(TRUE);
                            END ELSE
                                ERROR(Text002);
                        END ELSE
                            ERROR(Text002);
                    END;
            END;
            //END ELSE BEGIN
            Status := Status::Released;
            MODIFY(TRUE);
            //END;
        END;
    end;

    procedure PerformManualReopenAdvancePettyCashIOU(VAR AdvancePettyCashIOUHeader: Record "Cash Management Header")
    begin
        WITH AdvancePettyCashIOUHeader DO BEGIN
            //IF ApprovalManagement.CheckApprAdvancePettyCashIOUDocument(AdvancePettyCashIOUHeader) THEN BEGIN
            CASE Status OF
                Status::"Pending Approval":
                    ERROR(Text003);
                Status::Open, Status::Released:
                    ReopenAdvancePettyCashIOU(AdvancePettyCashIOUHeader);
            END;
            //END ELSE
            ReopenAdvancePettyCashIOU(AdvancePettyCashIOUHeader);
        END;
    end;

    procedure TestApprovalLimit(AdvancePettyCashIOUHeader: Record "Cash Management Header"): Boolean
    var
        UserSetup: Record "User Setup";
        AppAmount: Decimal;
        AppAmountLCY: Decimal;
    begin
        AppAmount := AdvancePettyCashIOUHeader.Amount;
        AppAmountLCY := AdvancePettyCashIOUHeader.Amount;

        UserSetup.GET(USERID);
        IF UserSetup."Unlimited Request Approval" THEN
            EXIT(TRUE);

        IF AppAmountLCY > UserSetup."Request Amount Approval Limit" THEN
            ERROR(Text002);

        EXIT(TRUE);
    end;

    procedure GetGLBankAccountNo(BankCode: Code[20]): Code[20]
    var
        BankAccount: Record "Bank Account";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
    begin
        IF BankAccount.GET(BankCode) THEN BEGIN
            IF BankAccountPostingGroup.GET(BankAccount."Bank Acc. Posting Group") THEN
                EXIT(BankAccountPostingGroup."G/L Account No.");
        END;
    end;

    var
        GlobalQuantityRequested: Decimal;
        ItemJnlApprovalSource: Integer;
        BudgetManager: Codeunit "Budget Manager";
        Text001: Label 'is nothing to release for the document of type %1 with the number %2.';
        Text002: Label 'document can only be released when the approval process is complete.';
        Text003: Label 'The approval process must be cancelled or completed to reopen this document.';
        Text004: Label 'Posting of reversals not allowed for the current user, please liaise with the finance manager.';
        Text005: Label 'Store Manifest Lines Copied.';
        Text006: Label 'Approval of received items not allowed for the current user, please liaise with the QA.';
        Text007: label 'Approval of Item Category %1  not allowed for the current user, please liaise with the QA.';
        Text008: Label 'Requisition document %1 has been successfully released.';
        Text009: Label 'This document has already been released. Did you mean to reopen?';
}