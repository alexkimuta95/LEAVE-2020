pageextension 51107 "HumanResourceSetupPageExt" extends "Human Resources Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field("Leave No"; "Leave No") { ApplicationArea = all; }
            field("Leave Application Nos."; "Leave Application Nos.") { ApplicationArea = all; }
            field("Leave Recall Nos"; "Leave Recall Nos") { ApplicationArea = all; }
            field("Leave Plan Nos"; "Leave Plan Nos") { ApplicationArea = all; }
            field("Base Calendar Code"; "Base Calendar Code") { ApplicationArea = all; }
            field("Leave Journal Nos."; "Leave Journal Nos.") { ApplicationArea = all; }
            field("Leave Allocation Nos."; "Leave Allocation Nos.") { ApplicationArea = all; }
            field("Current Period Start Date"; "Current Period Start Date") { ApplicationArea = all; }
            field("Current Period End Date"; "Current Period End Date") { ApplicationArea = all; }
            field("Department Dimension"; "Department Dimension") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}