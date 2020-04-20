page 51119 "Employee Leave List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 5200;
    Editable = false;
    CardPageId = 51106;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field("First Name"; "First Name") { ApplicationArea = All; }
                field("Last Name"; "Last Name") { ApplicationArea = All; }
                field("Job Title"; "Job Title") { ApplicationArea = All; }
                field(Unit; Unit) { ApplicationArea = All; }

            }
        }
        area(Factboxes)
        {
            systempart(Link; Links)
            {
                Visible = true;
            }
            systempart(Note; Notes)
            {
                Visible = true;
            }
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