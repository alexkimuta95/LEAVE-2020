page 51131 "Holidays"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Holidays;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;

                }
                field(Day; Day) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
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