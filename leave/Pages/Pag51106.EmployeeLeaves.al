page 51106 "Employee Leaves"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 5200;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.") { ApplicationArea = All; Editable = false; }
                field("First Name"; "First Name") { ApplicationArea = All; Editable = false; }
                field("Middle Name"; "Middle Name") { ApplicationArea = All; }
                field("Last Name"; "Last Name") { ApplicationArea = All; Editable = false; }
                field("Job Title"; "Job Title") { ApplicationArea = All; Editable = false; }
                field("Mobile Phone No."; "Mobile Phone No.") { ApplicationArea = all; }
                field("E-Mail"; "E-Mail") { ApplicationArea = all; }
                field(Gender; Gender) { ApplicationArea = all; }
                field("Employment Date"; "Employment Date") { ApplicationArea = all; }
            }
            part("Employee Leaves Subform"; 51103)
            {
                SubPageLink = "Employee No" = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}