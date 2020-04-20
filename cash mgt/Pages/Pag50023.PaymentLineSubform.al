page 50023 "Payment Line Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Line";
    SourceTableView = sorting("Document No", "Line No") where(Posted = filter(false));
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("Account Type"; "Account Type") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Applies-to Doc. No."; "Applies-to Doc. No.") { ApplicationArea = all; }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type") { ApplicationArea = all; }
                field("Invoice Reference No."; "Invoice Reference No.") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field("Amount To Pay"; "Amount To Pay") { ApplicationArea = all; }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code") { ApplicationArea = all; }
                field("WithHold VAT"; "WithHold VAT") { ApplicationArea = all; }
                field("WithHold VAT Amount"; "WithHold VAT Amount") { ApplicationArea = all; }
                field("WTAX Bus. Posting Group"; "WTAX Bus. Posting Group") { ApplicationArea = all; }
                field("WTAX Prod. Posting Group"; "WTAX Prod. Posting Group") { ApplicationArea = all; }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group") { ApplicationArea = all; }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group") { ApplicationArea = all; }
                field("VAT Amount"; "VAT Amount") { ApplicationArea = all; }
                field("WTax Amount"; "WTax Amount") { ApplicationArea = all; }
                field("Line Amount"; "Line Amount") { ApplicationArea = all; }
                field("Actual To Pay"; "Actual To Pay") { ApplicationArea = all; }
                field(" Cheque No."; " Cheque No.") { ApplicationArea = all; }
                field("Invoice To Pay"; "Invoice To Pay") { ApplicationArea = all; }
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