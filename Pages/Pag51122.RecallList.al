page 51122 "Recall List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 51103;
    CardPageId = 51108;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field(Date; Date) { ApplicationArea = All; }

                field("Recall Date"; "Recall Date") { ApplicationArea = All; }
                field("Recalled By"; "Recalled By") { ApplicationArea = All; }
                field("Reason for Recall"; "Reason for Recall") { ApplicationArea = All; }
                field("Recalled From"; "Recalled From") { ApplicationArea = All; }
                field("Recalled To"; "Recalled To") { ApplicationArea = All; }


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