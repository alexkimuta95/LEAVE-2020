page 50002 "Petty Cash Account List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Account";
    SourceTableView = sorting("No.") order(descending) where("Petty Cash" = const(true));
    CardPageId = "Petty Cash Account Card";
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name) { ApplicationArea = all; }
                field("Post Code"; "Post Code") { ApplicationArea = all; }
                field("Country/Region Code"; "Country/Region Code") { ApplicationArea = all; }
                field("Phone No."; "Phone No.") { ApplicationArea = all; }
                field("Fax No."; "Fax No.") { ApplicationArea = all; }
                field(Contact; Contact) { ApplicationArea = all; }
                field("Bank Account No."; "Bank Account No.") { ApplicationArea = all; }
                field("SWIFT Code"; "SWIFT Code") { ApplicationArea = all; }
                field(IBAN; IBAN) { ApplicationArea = all; }
                field("Our Contact Code"; "Our Contact Code") { ApplicationArea = all; }
                field("Bank Acc. Posting Group"; "Bank Acc. Posting Group") { ApplicationArea = all; }
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field("Language Code"; "Language Code") { ApplicationArea = all; }
                field("Search Name"; "Search Name") { ApplicationArea = all; }

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