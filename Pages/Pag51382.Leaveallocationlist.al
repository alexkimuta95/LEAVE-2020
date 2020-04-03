page 51382 "Leave allocation list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Allocation";
    CardPageId= "Leave Allocation Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.") { ApplicationArea = all; }
                field("Document Date"; "Document Date") { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("Time Posted"; "Time Posted") { ApplicationArea = all; }
                field("Date Posted"; "Date Posted") { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Leave Type"; "Leave Type") { ApplicationArea = all; }
                field("Leave Period"; "Leave Period") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }

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