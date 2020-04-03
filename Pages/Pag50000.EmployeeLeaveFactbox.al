page 50000 "Employee Leave Factbox"
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Leaves";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Balance B/F"; "Balance B/F")
                {
                    ApplicationArea = All;

                }
                field("Accrued Days"; "Accrued Days") { ApplicationArea = all; }
                field("Allocated Days"; "Allocated Days") { ApplicationArea = all; }
                field("Recalled Days"; "Recalled Days") { ApplicationArea = all; }
                field(Taken; Taken) { ApplicationArea = all; }
                field(Balance; Balance) { ApplicationArea = all; }
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