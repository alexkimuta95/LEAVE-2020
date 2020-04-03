page 51103 "Employee Leaves Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leaves";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Leave Period"; "Leave Period")
                {
                    ApplicationArea = All;

                }
                field("Leave Code"; "Leave Code") { ApplicationArea = all; }
                field("Maturity Date"; "Maturity Date") { ApplicationArea = all; }
                field("Balance B/F"; "Balance B/F") { ApplicationArea = all; }
                field("Recalled Days"; "Recalled Days") { ApplicationArea = all; }
                field("Allocated Days"; "Allocated Days") { ApplicationArea = all; }
                field("Accrued Days"; "Accrued Days") { ApplicationArea = all; }
                field("Days Taken"; "Days Taken") { ApplicationArea = all; }

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