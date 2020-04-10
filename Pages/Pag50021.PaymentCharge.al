page 50021 "Payment Charge"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Charge";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field("Charge Type"; "Charge Type") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field("Charge %"; "Charge %") { ApplicationArea = all; }
                field("Charge Posting Account"; "Charge Posting Account") { ApplicationArea = all; }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group") { ApplicationArea = all; }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group") { ApplicationArea = all; }
                field(InActive; InActive) { ApplicationArea = all; }

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