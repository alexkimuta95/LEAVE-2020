page 51117 "Leave Journal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Journal";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; "Entry No") { ApplicationArea = All; }
                field("Entry Type"; "Entry Type") { ApplicationArea = All; }
                field("Document Type"; "Document Type") { ApplicationArea = All; }
                field("Document No"; "Document No") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Leave Period"; "Leave Period") { ApplicationArea = All; }
                field("Staff No."; "Staff No.") { ApplicationArea = All; }
                field("Employee Name"; "Employee Name") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field("Leave Type"; "Leave Type") { ApplicationArea = All; }
                field(Days; Days) { ApplicationArea = All; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Leave Data")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    if HRJournalLine.FindLast() then begin
                        ;
                        LastNumber := HRJournalLine."line No." + 1;
                    end;

                    repeat
                        HRJournalLine.Init();
                        HRJournalLine."Line No." := LastNumber;
                        HRJournalLine."Document No." := "Document No";
                        HRJournalLine."Leave Period" := "Leave Period";
                        HRJournalLine."Employee No." := "Staff No.";
                        HRJournalLine.VALIDATE(HRJournalLine."Employee No.");
                        HRJournalLine."Posting Date" := TODAY;
                        HRJournalLine."Entry Type" := "Entry Type";
                        HRJournalLine."Posting Date" := TODAY;
                        HRJournalLine.Description := Description;
                        HRJournalLine."Leave Type" := "Leave Type";
                        if "Entry Type" = "Entry Type"::Negative then
                            HRJournalLine.Days := -Days
                        else
                            HRJournalLine.Days := Days;
                        HRJournalLine."Document No." := "Document No";
                        if ("Document Type" = "Document Type"::"Days Brought Forward") then
                            HRJournalLine."Balance Brought Forward" := TRUE;

                        HRJournalLine.INSERT(TRUE);
                        LastNumber := LastNumber + 1;
                    until NEXT = 0;
                    Message('Successfully Posted');
                    DeleteAll();
                    ;

                end;
            }
        }
    }
    var

        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LeaveLedger: Record "Leave Ledger Entry";
        LastNumber: Integer;
        HRJournalLine: Record "Leave Ledger Entry";
        LeaveJournal: Record "Leave Journal";
        EmployeeName: Text;
        Employee: Record Employee;
        SMTP: Codeunit "SMTP Mail";
        HRSetup: Record "Human Resources Setup";
        maiheader: Text;
        mailbody: Text;
        User: Record "User Setup";
        Selected: Integer;
}