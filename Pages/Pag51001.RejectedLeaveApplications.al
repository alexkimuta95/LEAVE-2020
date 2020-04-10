page 51001 "Rejected Leave Applications"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Application";
    CardPageId = "Leave Application Review";
    SourceTableView = sorting("Application No", "Employee No.") where(Status = const(Rejected));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Leave Period"; "Leave Period") { ApplicationArea = all; }
                field("Employee No."; "Employee No.") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Application No"; "Application No") { ApplicationArea = all; }
                field("Leave Code"; "Leave Code") { ApplicationArea = all; }
                field("Days Applied"; "Days Applied") { ApplicationArea = all; }
                field("Start Date"; "Start Date") { ApplicationArea = all; }
                field("End Date"; "End Date") { ApplicationArea = all; }
                field("Application Date"; "Application Date") { ApplicationArea = all; }
                field("Approved Days"; "Approved Days") { ApplicationArea = all; }
                field("Approved Start Date"; "Approved Start Date") { ApplicationArea = all; }
                field("Approved End Date"; "Approved End Date") { ApplicationArea = all; }
                field("Approval Date"; "Approval Date") { ApplicationArea = all; }
                field(Comments; Comments) { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {
            systempart(Links; Links) { ApplicationArea = all; }
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