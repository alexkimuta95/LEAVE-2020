page 50015 "Posted Payment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Header";
    CardPageId = "Posted Payment Header Card";
    SourceTableView = sorting("No.") order(descending) where(Posted = filter(true));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Bank Code"; "Bank Code") { ApplicationArea = all; }
                field("Account No"; "Account No") { ApplicationArea = all; }
                field(Payee; Payee) { ApplicationArea = all; }
                field("Total to Pay"; "Total to Pay") { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field("Cheque No."; "Cheque No.") { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
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