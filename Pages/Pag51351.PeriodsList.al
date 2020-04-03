page 51351 "Periods List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Periods";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; "Period Code")
                {
                    ApplicationArea = All;

                }
                field(Name; "Period Description") { ApplicationArea = all; }
                field(closed; closed) { ApplicationArea = all; }
                field("Date Locked"; "Date Locked") { ApplicationArea = all; }
                field("Close Date"; "Close Date") { ApplicationArea = all; }
                field("Closed By"; "Closed By") { ApplicationArea = all; }
                field(Current; Current) { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {
            systempart(Notes; Notes) { ApplicationArea = all; }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Close Period")
            {
                ApplicationArea = All;
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    IF NOT CONFIRM('Are you sure you want to close the current Leave period?' + //
                    'This will rollover balances to the new Period.' + //
                    'Print current leave balances before closing the period', FALSE) THEN
                        Message('close successfu');

                end;
            }
        }
    }
}