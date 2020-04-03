page 51121 "Employee Leave Look Up"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leaves";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee No"; "Employee No") { ApplicationArea = all; }
                field("Leave Code"; "Leave Code") { ApplicationArea = All; }
                field("Maturity Date"; "Maturity Date") { ApplicationArea = All; }
                field(Balance; Balance) { ApplicationArea = All; }
                field("Accrued Days"; "Accrued Days") { ApplicationArea = All; }

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