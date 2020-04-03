page 51120 "Leave Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 51102;
    Editable = false;
    // SourceTableView = where(Status = const(Active));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code) { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field(Days; Days) { ApplicationArea = All; }
                field("Unlimited Days"; "Unlimited Days") { ApplicationArea = All; }
                field(Gender; Gender) { ApplicationArea = All; }
                field(Balance; Balance) { ApplicationArea = All; }
                field("Max Carry Forward Days"; "Max Carry Forward Days") { ApplicationArea = All; }
                field("Inclusive of Holidays"; "Inclusive of Holidays") { ApplicationArea = All; }
                field("Inclusive of Saturday"; "Inclusive of Saturday") { ApplicationArea = All; }
                field("Inclusive of Sunday"; "Inclusive of Sunday") { ApplicationArea = All; }
                field("Off/Holidays Days Leave"; "Off/Holidays Days Leave") { ApplicationArea = All; }
                // field(Status; Status) { ApplicationArea = All; }

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