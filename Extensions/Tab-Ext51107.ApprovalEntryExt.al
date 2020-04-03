tableextension 51107 "ApprovalEntryExt" extends "Approval Entry"
{
    fields
    {
        field(50100; "Document Type 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Leave,Recruitment;
        }
    }

    var
        myInt: Integer;
}