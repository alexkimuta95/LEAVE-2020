page 51126 "Leave Ledger Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "leave ledger entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; "Line No.") { ApplicationArea = All; }
                field("Document No."; "Document No.") { ApplicationArea = All; }
                field("Posting Date"; "Posting Date") { ApplicationArea = All; }
                field("Entry Type"; "Entry Type") { ApplicationArea = All; }
                field("Employee No."; "Employee No.") { ApplicationArea = All; }
                field("Leave Type"; "Leave Type") { ApplicationArea = All; }
                field("Leave Period"; "Leave Period") { ApplicationArea = All; }
                field(Days; Days) { ApplicationArea = All; }
                field("Leave Start Date"; "Leave Start Date") { ApplicationArea = All; }
                field("Leave End Date"; "Leave End Date") { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field("Leave Allocation"; "Leave Allocation") { ApplicationArea = All; }
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