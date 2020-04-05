pageextension 50009 "Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Petty Cash Replenishment"; "Petty Cash Replenishment") { ApplicationArea = all; }
            field("Petty Cash"; "Petty Cash") { ApplicationArea = all; }
            field("Fund Account"; "Fund Account") { ApplicationArea = all; }
            field("Bank Name"; "Bank Name") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}