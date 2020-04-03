pageextension 50010 "GLSetupPageExt" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(General)
        {
            field("Base Calendar"; "Base Calendar") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}