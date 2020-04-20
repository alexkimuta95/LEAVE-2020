page 50016 "Posted Payment Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payment Header";
    SourceTableView = sorting("No.") where(Posted = filter(true));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Bank Code"; "Bank Code") { ApplicationArea = all; }
                field("Bank Name"; "Bank Name") { ApplicationArea = all; }
                field("Account Type"; "Account Type") { ApplicationArea = all; }
                field("Account No"; "Account No") { ApplicationArea = all; }
                field(Payee; Payee) { ApplicationArea = all; }
                field("Cheque No."; "Cheque No.") { ApplicationArea = all; }
                field(Amount; Amount) { ApplicationArea = all; }
                field(Remarks; Remarks) { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field(Posted; Posted) { ApplicationArea = all; }
                field("Payment Method"; "Payment Method") { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field("Total to Pay"; "Total to Pay") { ApplicationArea = all; }

                part(Lines; "Posted Payment Line Subform")
                {
                    SubPageLink = "Document No" = field("No.");
                    Editable = false;
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