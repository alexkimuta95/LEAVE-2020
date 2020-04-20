page 50014 "Payments List Cash Office"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Header";
    Editable = false;
    CardPageId = "Payment Header Card";
    SourceTableView = sorting("No.") order(descending) where(Posted = const(false));

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
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field(Payee; Payee) { ApplicationArea = all; }
                field("Total to Pay"; "Total to Pay") { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field("Vendor Account Name"; "Vendor Account Name") { ApplicationArea = all; }
                field("Vendor Bank name"; "Vendor Bank name") { ApplicationArea = all; }
                field("Vendor Bank Code"; "Vendor Bank Code") { ApplicationArea = all; }
                field("Vendor Branch Code"; "Vendor Branch Code") { ApplicationArea = all; }
                field("Vendor Account Number"; "Vendor Account Number") { ApplicationArea = all; }
                field("Swift Code"; "Swift Code") { ApplicationArea = all; }
                field(Posted; Posted) { ApplicationArea = all; }
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