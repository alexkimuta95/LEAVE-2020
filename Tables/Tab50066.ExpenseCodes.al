table 50066 "Expense Codes"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Income/Balance" = filter("Income Statement"), "Direct Posting" = const(true));
        }
        field(3; Description; Text[250])
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
        myInt: Integer;

    trigger OnInsert()
    begin

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

}