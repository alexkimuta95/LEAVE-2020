page 51104 "Leave Application Review"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Application";

    layout
    {
        area(Content)
        {
            group("Employee Details")
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field(Names; Names) { ApplicationArea = all; }


                group("Approval Details")
                {
                    field("Approved Start Date"; "Approved Start Date") { ApplicationArea = all; }
                    field("Approved Days"; "Approved Days") { ApplicationArea = all; }
                    field("Approved End Date"; "Approved End Date") { ApplicationArea = all; }
                    field("Approved Resumption Date"; "Approved Resumption Date") { ApplicationArea = all; }

                }
                group("Appliation Details")
                {
                    field("Leave Period"; "Leave Period") { ApplicationArea = all; }
                    field("Leave Code"; "Leave Code") { ApplicationArea = all; }
                    field("Application No"; "Application No") { ApplicationArea = all; }
                    field("Days Applied"; "Days Applied") { ApplicationArea = all; }
                    field("Accrued Days"; "Accrued Days") { ApplicationArea = all; }
                    field("Start Date"; "Start Date") { ApplicationArea = all; }
                    field("End Date"; "End Date") { ApplicationArea = all; }
                    field("Resumption Date"; "Resumption Date") { ApplicationArea = all; }
                    field("Application Date"; "Application Date") { ApplicationArea = all; }
                    field(Comments; Comments) { ApplicationArea = all; }
                }
            }

        }
        area(FactBoxes)
        {
            part("Employee Leave Factbox"; "Employee Leave Factbox")
            {
                SubPageLink = "Employee No" = field("Employee No."), "Leave Code" = field("Leave Code");
                ApplicationArea = all;
            }
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        Employees: Record Employee;
        Names: Text;
        ISOWNER: Boolean;
        Err100: Label 'The current user has not been associated with an Employee profile, contact your system admin for assistance';
}