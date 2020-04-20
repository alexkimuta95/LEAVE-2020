page 51396 "Payroll Posting Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payroll Posting Group";

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
                field(Description; Description) { ApplicationArea = all; }
                field("Emplyee No. Series"; "Emplyee No. Series") { ApplicationArea = all; }
                field(Active; Active) { ApplicationArea = all; }
                field("NSSF By Company"; "NSSF By Company") { ApplicationArea = all; }
                field("NHIF By Company"; "NHIF By Company") { ApplicationArea = all; }
                field("Base Calendar"; "Base Calendar") { ApplicationArea = all; }

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