page 50020 "Posted PettyCash Replenishment"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cash Management Header";
    Editable = false;
    SourceTableView = sorting(No) order(descending) where(Replenishment = const(true), Posted = const(true));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("Document Type"; "Document Type") { ApplicationArea = all; }
                field("Account Type"; "Account Type") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Account Name"; "Account Name") { ApplicationArea = all; }
                field(Amount; Amount) { ApplicationArea = all; }
                field("Pay Mode"; "Pay Mode") { ApplicationArea = all; }
                field("Cheque No"; "Cheque No") { ApplicationArea = all; }
                field("Cheque Date"; "Cheque Date") { ApplicationArea = all; }
                field("Paying Account Type"; "Paying Account Type") { ApplicationArea = all; }
                field(Name; Name) { ApplicationArea = all; }
                field("User Remarks"; "User Remarks") { ApplicationArea = all; }
                field("Finance Remarks"; "Finance Remarks") { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
            }
            group(Dimensions)
            {
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
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