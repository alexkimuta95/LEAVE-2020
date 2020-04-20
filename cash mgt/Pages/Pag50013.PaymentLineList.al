page 50013 "Payment Line List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Line";
    SourceTableView = sorting("Document No", "Line No") where(Posted = filter(false), "Invoice To Pay" = filter(true));
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No"; "Document No") { ApplicationArea = all; }
                field("Line No"; "Line No") { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("Account Type"; "Account Type") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Applies-to Doc. No."; "Applies-to Doc. No.") { ApplicationArea = all; }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type") { ApplicationArea = all; }
                field("Invoice Reference No."; "Invoice Reference No.") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("Actual To Pay"; "Actual To Pay") { ApplicationArea = all; }
                field("VAT Amount"; "VAT Amount") { ApplicationArea = all; }
                field("WTax Amount"; "WTax Amount") { ApplicationArea = all; }
                field("Credit Card Amount"; "Credit Card Amount") { ApplicationArea = all; }
                field("Service Charge Amount"; "Service Charge Amount") { ApplicationArea = all; }
                field("Line Amount"; "Line Amount") { ApplicationArea = all; }
                field("Charge VAT Amount"; "Charge VAT Amount") { ApplicationArea = all; }
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}