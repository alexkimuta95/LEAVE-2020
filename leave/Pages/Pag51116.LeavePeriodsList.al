page 51116 "Leave Periods List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 51106;
    SourceTableView = sorting("Period Code");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Starting Date"; "Starting Date") { ApplicationArea = All; }
                field("Period Code"; "Period Code") { ApplicationArea = All; }
                field("Period Description"; "Period Description") { ApplicationArea = All; }
                field("New Fiscal Year"; "New Fiscal Year") { ApplicationArea = All; }
                field("Period Accrued"; "Period Accrued") { ApplicationArea = All; }
                field(Closed; Closed) { ApplicationArea = All; }
                field("Date Locked"; "Date Locked") { ApplicationArea = All; }


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
            action(" Create Leave Year")
            {
                ApplicationArea = All;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                // RunObject = report "HR Create Leave Year n";

                trigger OnAction();
                begin

                end;
            }
            action("HR Leave Year - Close")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = codeunit "HR Leave Year - Close";

                trigger OnAction()
                begin

                end;
            }
        }
    }
}