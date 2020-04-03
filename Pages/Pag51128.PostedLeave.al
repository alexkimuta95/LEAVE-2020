page 51128 "Posted Leave"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Ledger entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Line No.") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Document Type"; "Document Type") { ApplicationArea = All; }
                field("Leave Code"; "Leave Type") { ApplicationArea = All; }
                field(Days; Days) { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field("Start Date"; "Leave Start Date") { ApplicationArea = All; }
                field("End Date"; "Leave End Date") { ApplicationArea = All; }
                field(LeaveAppNo; LeaveAppNo) { ApplicationArea = All; }
                field("Employee Name"; "Employee Name") { ApplicationArea = All; }
                field("Employee Resumption Date"; "Leave Resumption Date") { ApplicationArea = All; }

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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}