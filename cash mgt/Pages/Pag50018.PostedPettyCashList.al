page 50018 "Posted Petty Cash List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cash Management Header";
    Editable = false;
    SourceTableView = sorting(No) order(descending) where("Document Type" = filter("Petty Cash"), Posted = const(true), Replenishment = const(false));
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; No)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("Account Name"; "Account Name") { ApplicationArea = all; }
                field("Amount to Pay Posted"; "Amount to Pay Posted") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                // field(BankAccName; BankAccName) { ApplicationArea = all; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code") { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field(Posted; Posted) { ApplicationArea = all; }
                field("Posted By"; "Posted By") { ApplicationArea = all; }
                field("Date Posted"; "Date Posted") { ApplicationArea = all; }
                field("Time Posted"; "Time Posted") { ApplicationArea = all; }

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