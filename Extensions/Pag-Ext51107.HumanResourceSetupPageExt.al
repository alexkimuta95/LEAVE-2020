pageextension 51107 "HumanResourceSetupPageExt" extends "Human Resources Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field("Leave Application Nos."; "Leave Application Nos.") { ApplicationArea = all; }
            field("Leave Recall Nos"; "Leave Recall Nos") { ApplicationArea = all; }
            field("Base Calendar Code"; "Base Calendar Code") { ApplicationArea = all; }
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