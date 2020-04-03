page 51107 "Leave Recalls List"
{
    PageType = List;
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
                field("Employee No"; "Employee No") { ApplicationArea = All; }
                field("Employee Name"; "Employee Name") { ApplicationArea = All; }
                field("Leave Start Date"; "Leave Start Date") { ApplicationArea = All; }
                field("Days Applied"; "Days Applied") { ApplicationArea = All; }
                field("Leave Ending Date"; "Leave Ending Date") { ApplicationArea = All; }
                field("Recall Date"; "Recall Date") { ApplicationArea = All; }
                field("Recalled By"; "Recalled By") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Recalled Department"; "Recalled Department") { ApplicationArea = All; }
                field("Reason for Recall"; "Reason for Recall") { ApplicationArea = All; }
                field("Recalled From"; "Recalled From") { ApplicationArea = All; }
                field("Recalled To"; "Recalled To") { ApplicationArea = All; }
                field("Leave Application"; "Leave Application") { ApplicationArea = All; }


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