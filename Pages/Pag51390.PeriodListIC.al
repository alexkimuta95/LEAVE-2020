page 51390 "Period List IC"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "leave periods";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; "Period Code")
                {
                    ApplicationArea = All;

                }
                field(Name; Name) { ApplicationArea = all; }
                field(Closed; Closed) { ApplicationArea = all; }
                field("Date Locked"; "Date Locked") { ApplicationArea = all; }
                field("Close Date"; "Close Date") { ApplicationArea = all; }
                field("Closed By"; "Closed By") { ApplicationArea = all; }
                field(Current; Current) { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {
            systempart(Notes; Notes) { ApplicationArea = all; }
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