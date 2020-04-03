table 51105 "HR Leave Reasons"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Reason for Leave"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "No", "Reason for Leave")
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