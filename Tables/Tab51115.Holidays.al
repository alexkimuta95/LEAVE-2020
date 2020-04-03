table 51115 "Holidays"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

        }
        field(2; "Day"; Text[50])
        {
            Caption = 'Day';
            DataClassification = ToBeClassified;

        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Date")
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