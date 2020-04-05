tableextension 50001 "Bank Acc Ext" extends "Bank Account"
{
    fields
    {
        field(50000; "Petty Cash Replenishment"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Fund Account"; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    var
        myInt: Integer;
}