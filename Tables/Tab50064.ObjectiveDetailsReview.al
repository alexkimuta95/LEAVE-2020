table 50064 "Objective Details Review"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Objective Code"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No"; Code[20])
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; "Objective Details"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Success Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Target; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Resources Required"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(8; Achievement; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(9; Completed; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",No,Yes;
        }
        field(10; "Employee Rating"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Employee Comment"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Reviewer's Comment"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Reviewer's Rating"; Integer)
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(PK; "Objective Code")
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