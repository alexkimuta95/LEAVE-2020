table 50063 "Payment Charge"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Charge %"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Charge Posting Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckGLAcc("Charge Posting Account");

            end;

        }
        field(5; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Credit Card","Service Charge";
        }
        field(6; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(7; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(8; InActive; boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        Text000: Label '%1 must be entered on the tax jurisdiction line when %2 is %3.';
        Text001: Label '%1 = %2 has already been used for %3 = %4 in %5 for %6 = %7 and %8 = %9.';
        DuplicateEntryErr: Label 'Another entry with the same %1 in the same %2 has a different %3 assigned. Use the same %3 or remove it.';

    trigger OnInsert()
    begin
        if "Charge %" = 0 then;
        "Charge %" := GetVATPtc();
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    LOCAL procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        IF AccNo <> '' THEN BEGIN
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc;
        END;
    end;

    LOCAL procedure GetVATPtc(): Decimal
    begin
    end;

}