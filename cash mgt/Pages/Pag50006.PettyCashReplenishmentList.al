page 50006 "Petty Cash Replenishment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cash Management Header";
    CardPageId = "Petty Cash Replenishment";
    SourceTableView = sorting(No) order(descending) where(Replenishment = const(true), Posted = const(false));
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }
                field(Date; Date) { ApplicationArea = all; }
                field("Document Type"; "Document Type") { ApplicationArea = all; }
                field("Account No."; "Account No.") { ApplicationArea = all; }
                field("Account Name"; "Account Name") { ApplicationArea = all; }
                field(Name; Name) { ApplicationArea = all; }
                field(Amount; Amount) { ApplicationArea = all; }
                field("Pay Mode"; "Pay Mode") { ApplicationArea = all; }
                field("Cheque Date"; "Cheque Date") { ApplicationArea = all; }
                field("Cheque No"; "Cheque No") { ApplicationArea = all; }
                field("Paying Bank Account"; "Paying Bank Account") { ApplicationArea = all; }
                field("User Remarks"; "User Remarks") { ApplicationArea = all; }
                field("Finance Remarks"; "Finance Remarks") { ApplicationArea = all; }
                field("Entered By"; "Entered By") { ApplicationArea = all; }
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