page 51105 "Leave Types Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    SourceTable = "Leave Types";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Code) { ApplicationArea = All; }
                field(Description; Description) { ApplicationArea = All; }
                field(Days; Days) { ApplicationArea = All; }
                field(InActive; InActive) { ApplicationArea = all; }
                field("Accrue Days"; "Accrue Days") { ApplicationArea = all; }

                field("Unlimited Days"; "Unlimited Days") { ApplicationArea = All; Visible = false; }
                field(Gender; Gender) { ApplicationArea = All; }
                field(Balance; Balance) { ApplicationArea = All; }
                field(CarryForward; CarryForward) { ApplicationArea = all; }
                field("Max Carry Forward Days"; "Max Carry Forward Days") { ApplicationArea = All; }
                field("Inclusive of Holidays"; "Inclusive of Holidays") { ApplicationArea = All; }
                field("Inclusive of Saturday"; "Inclusive of Saturday") { ApplicationArea = All; }
                field("Inclusive of Sunday"; "Inclusive of Sunday") { ApplicationArea = All; }
                field("Off/Holidays Days Leave"; "Off/Holidays Days Leave") { ApplicationArea = All; Visible = false; }
            }
        }

    }

    actions
    {

        area(Processing)
        {
            action("Leave Category Entitlement")
            {
                Image = AbsenceCategory;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Leave Category Entitlement";
                RunPageLink = "Leave Code" = field(Code);
            }
            action(HRSetup)
            {
                ApplicationArea = All;
                Image = ServiceSetup;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Human Resources Setup";

                trigger OnAction();
                begin

                end;
            }
            action(AllocateDefault)
            {
                ApplicationArea = all;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Generate Entitlements';

                trigger OnAction();
                begin
                    AssignDefaultDays();
                end;
            }
            action("PopulateDefault")
            {
                ApplicationArea = All;
                Image = AutoReserve;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PopulateDefaultLeaveCategories();
                end;
            }
        }
    }
    var

        Text01: TextConst ENU = 'you want want to populate leave category entitlements with default leave days?';
}