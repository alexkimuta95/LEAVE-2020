page 50001 "Petty Cash List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cash Management Header";
    SourceTableView = sorting(No) order(descending) where("Document Type" = filter("Petty Cash"), Posted = const(false), Replenishment = const(false));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field(No; No) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Account Name"; "Account Name") { ApplicationArea = all; }
                field(Amount; Amount) { ApplicationArea = all; }
                field("Paying Bank Account"; "Paying Bank Account") { ApplicationArea = all; }
                field(Name; Name) { ApplicationArea = all; }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("User Remarks"; "User Remarks") { ApplicationArea = all; }
                field("Finance Remarks"; "Finance Remarks") { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
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