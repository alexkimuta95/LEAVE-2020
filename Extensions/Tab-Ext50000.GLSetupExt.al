tableextension 50000 "GLSetupExt" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Base Calendar"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";

        }

    }

    var
        myInt: Integer;
}