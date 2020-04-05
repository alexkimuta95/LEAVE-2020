page 50004 "Petty Cash Account Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Bank Account";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name) { ApplicationArea = all; }
                field(Address; Address) { ApplicationArea = all; }
                field("Address 2"; "Address 2") { ApplicationArea = all; }
                field("Post Code"; "Post Code") { ApplicationArea = all; }
                field(City; City) { ApplicationArea = all; }
                field("Country/Region Code"; "Country/Region Code") { ApplicationArea = all; }
                field("Phone No."; "Phone No.") { ApplicationArea = all; }
                field(Contact; Contact) { ApplicationArea = all; }
                field("Search Name"; "Search Name") { ApplicationArea = all; }
                field(Balance; Balance) { ApplicationArea = all; }
                field("Balance (LCY)"; "Balance (LCY)") { ApplicationArea = all; }
                field("Min. Balance"; "Min. Balance") { ApplicationArea = all; }
                field("Our Contact Code"; "Our Contact Code") { ApplicationArea = all; }
                field(Blocked; Blocked) { ApplicationArea = all; }
                field("Petty Cash"; "Petty Cash") { ApplicationArea = all; }
                field("Petty Cash Replenishment"; "Petty Cash Replenishment") { ApplicationArea = all; }
                field("Fund Account"; "Fund Account") { ApplicationArea = all; }
                field("Last Date Modified"; "Last Date Modified") { ApplicationArea = all; }
            }
            group(Communication)
            {
                field("Phone No. 2"; "Phone No.") { ApplicationArea = all; }
                field("Fax No."; "Fax No.") { ApplicationArea = all; }
                field("Home Page"; "Home Page") { ApplicationArea = all; }
                field("E-Mail"; "E-Mail") { ApplicationArea = all; }

            }
            group(Posting)
            {
                field("Currency Code"; "Currency Code") { ApplicationArea = all; }
                field("Last Check No."; "Last Check No.") { ApplicationArea = all; }
                field("Last Statement No."; "Last Statement No.") { ApplicationArea = all; }
                field("Balance Last Statement"; "Balance Last Statement") { ApplicationArea = all; }
                field("Bank Acc. Posting Group"; "Bank Acc. Posting Group") { ApplicationArea = all; }

            }
            group("Payment Match Tolerance")
            {
                field("Match Tolerance Type"; "Match Tolerance Type") { ApplicationArea = all; }
                field("Match Tolerance Value"; "Match Tolerance Value") { ApplicationArea = all; }
            }
            group(Transfer)
            {
                field("Bank Branch No."; "Bank Branch No.") { ApplicationArea = all; }
                field("Bank Account No."; "Bank Account No.") { ApplicationArea = all; }
                field("Transit No."; "Transit No.") { ApplicationArea = all; }
                field("SWIFT Code"; "SWIFT Code") { ApplicationArea = all; }
                field(IBAN; IBAN) { ApplicationArea = all; }
            }
        }
        area(FactBoxes)
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}