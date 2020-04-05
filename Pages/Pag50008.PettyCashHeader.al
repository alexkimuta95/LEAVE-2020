page 50008 "Petty Cash Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cash Management Header";
    SourceTableView = sorting("Document Type", No) where("Document Type" = filter("Petty Cash"), Posted = const(false), Replenishment = const(false));

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
                field("Document Date"; "Document Date") { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                // field(BankAccName; BankAccName) { ApplicationArea = all; }
                field("Amount to Pay"; "Amount to Pay") { ApplicationArea = all; }
                field("Amount LCY"; "Amount LCY") { ApplicationArea = all; }
                field("User Remarks"; "User Remarks") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
            }
            group(Dimenions)
            {
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code") { ApplicationArea = all; }
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