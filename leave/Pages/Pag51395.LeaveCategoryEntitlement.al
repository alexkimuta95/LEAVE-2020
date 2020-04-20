page 51395 "Leave Category Entitlement"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Category Entitlement";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = All;

                }
                field("Payroll Posting Group"; "Payroll Posting Group") { ApplicationArea = all; }
                field(Days; Days) { ApplicationArea = all; }
                field("Accrue Days"; "Accrue Days") { ApplicationArea = all; }
                field("Unlimited Days"; "Unlimited Days") { ApplicationArea = all; }
                field(Gender; Gender) { ApplicationArea = all; }
                field(Balance; Balance) { ApplicationArea = all; }
                field("Inclusive of Holidays"; "Inclusive of Holidays") { ApplicationArea = all; }
                field("Inclusive of Saturday"; "Inclusive of Saturday") { ApplicationArea = all; }
                field("Inclusive of Sunday"; "Inclusive of Sunday") { ApplicationArea = all; }
                field("Off/Holidays Days Leave"; "Off/Holidays Days Leave") { ApplicationArea = all; }
                field("Max Carry Forward Days"; "Max Carry Forward Days") { ApplicationArea = all; }
                field(CarryForward; CarryForward) { ApplicationArea = all; }
                field(InActive; InActive) { ApplicationArea = all; }

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