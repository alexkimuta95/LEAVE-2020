page 50009 "Petty Cash Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cash Management Line";
    SourceTableView = sorting("External Doc. No.") order(ascending) where(Posted = const(false));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = All;

                }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Account Name"; "Account Name") { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("External Doc. No."; "External Doc. No.") { ApplicationArea = all; }
                field("Employee No"; "Employee No") { ApplicationArea = all; }
                field("Employee Name"; "Employee Name") { ApplicationArea = all; }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group") { ApplicationArea = all; }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group") { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field("Currency Factor"; "Currency Factor") { ApplicationArea = all; }
                field("Actual Amount Spent"; "Actual Amount Spent") { ApplicationArea = all; }
                field("Amount in LCY"; "Amount in LCY") { ApplicationArea = all; }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code") { ApplicationArea = all; }
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}