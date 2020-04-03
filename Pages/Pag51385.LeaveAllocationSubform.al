page 51385 "Leave Allocation Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Allocation Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee No."; "Employee No.") { ApplicationArea = all; }
                field("Employee Name"; "Employee Name") { ApplicationArea = all; }
                field("Entry Type"; "Entry Type") { ApplicationArea = all; }
                field("Allocate the Days"; "Allocate the Days") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }

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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}