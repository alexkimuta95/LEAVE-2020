page 50022 "Payment Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payment Header";
    SourceTableView = where(Posted = filter(false));

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
                field("Payment Method"; "Payment Method") { ApplicationArea = all; }
                field("Total to Pay"; "Total to Pay") { ApplicationArea = all; }
                field("Cheque No."; "Cheque No.") { ApplicationArea = all; }
                field("Cheque Date"; "Cheque Date") { ApplicationArea = all; }
                field(Remarks; Remarks) { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field("Total on Document"; "Total on Document") { ApplicationArea = all; }
                field(Posted; Posted) { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                part("Payment Line"; "Payment line subform")
                {
                    SubPageLink = "Document No" = field("No.");
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