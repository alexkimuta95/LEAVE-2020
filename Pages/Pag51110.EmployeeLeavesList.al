page 51110 "Employee Leaves List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 51000;
    CardPageId = 51109;
    SourceTableView = sorting("Application No") order(descending) where(Status = filter(<> Approved | Canceled | Review));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Leave Period"; "Leave Period") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Application No"; "Application No") { ApplicationArea = all; }
                field("Employee No"; "Employee No.") { ApplicationArea = all; }
                field("Leave Code"; "Leave Code") { ApplicationArea = all; }
                field("Application Date"; "Application Date") { ApplicationArea = all; }
                field("Start Date"; "Start Date") { ApplicationArea = all; }
                field("End Date"; "End Date") { ApplicationArea = all; }
                field("Days Applied"; "Days Applied") { ApplicationArea = all; }
                field("Approved Days"; "Approved Days") { ApplicationArea = all; }
                field("Approved Start Date"; "Approved Start Date") { ApplicationArea = all; }
                field("Approved End Date"; "Approved End Date") { ApplicationArea = all; }
                field("Approved Resumption Date"; "Approved Resumption Date") { ApplicationArea = all; }
                field("Approval Date"; "Approval Date") { ApplicationArea = all; }
                field(Comments; Comments) { ApplicationArea = all; }
                field(Taken; Taken) { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {

            systempart(Links; Links)
            {
                ApplicationArea = all;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
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
    var
        UserSetup: Record "User Setup";

    trigger OnOpenPage()
    begin
        // UserSetup.GET(USERID);
        //SetRange("Employee No.", UserSetup."Employee No");
    end;

}