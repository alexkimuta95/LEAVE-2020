page 50011 "Posted Petty Cash Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cash Management Header";
    SourceTableView = sorting("Document Type", No) where("Document Type" = filter("Petty Cash"), Posted = const(true), Replenishment = const(false));
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; No)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("Amount to Pay Posted"; "Amount to Pay Posted") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                // field(BankAccName; BankAccName) { ApplicationArea = all; }
                field("User Remarks"; "User Remarks") { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
                field("On Behalf Of"; "On Behalf Of") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
            }
            group("Posting Details")
            {
                field(Posted; Posted) { ApplicationArea = all; }
                field("Posted By"; "Posted By") { ApplicationArea = all; }
                field("Date Posted"; "Date Posted") { ApplicationArea = all; }
                field("Time Posted"; "Time Posted") { ApplicationArea = all; }

            }
            group(Dimensions)
            {
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code") { ApplicationArea = all; }
                part(Lines; "Posted Petty Cash Lines")
                {
                    SubPageLink = No = field(No);
                }
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