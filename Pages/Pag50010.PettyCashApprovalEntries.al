page 50010 "Petty Cash Approval Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Approval Entry";
    SourceTableView = sorting("Table ID", "Document Type", "Document No.", "Sequence No.") order(ascending) where("Table ID" = const(50060)); //Document Type const 10
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(IsOverdue; IsOverdue)
                {
                    ApplicationArea = All;

                }
                field("Table ID"; "Table ID") { ApplicationArea = all; }
                field("Limit Type"; "Limit Type") { ApplicationArea = all; }
                field("Approval Type"; "Approval Type") { ApplicationArea = all; }
                field("Document Type"; "Document Type") { ApplicationArea = all; }
                field("Document No."; "Document No.") { ApplicationArea = all; }
                field("Sequence No."; "Sequence No.") { ApplicationArea = all; }
                field("Approval Code"; "Approval Code") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Sender ID"; "Sender ID") { ApplicationArea = all; }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code") { ApplicationArea = all; }
                field("Approver ID"; "Approver ID") { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field("Amount (LCY)"; "Amount (LCY)") { ApplicationArea = all; }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)") { ApplicationArea = all; }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval") { ApplicationArea = all; }
                field("Last Date-Time Modified"; "Last Date-Time Modified") { ApplicationArea = all; }
                field(Comment; Comment) { ApplicationArea = all; }
                field("Due Date"; "Due Date") { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {
            systempart(Links; Links) { ApplicationArea = all; }
            systempart(Notes; Notes) { ApplicationArea = all; }
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