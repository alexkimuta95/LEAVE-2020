table 51110 "Leave Workflow Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UnitCode.Reset();
                UnitCode.SetRange(UnitCode.Code, "Department Code");
                if UnitCode.Find('-') then begin
                    "Department Name" := UnitCode.Name;
                end;
            end;
        }
        field(2; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "First Approver"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Second Approver"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Third Approver"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }

    }

    var
        UserSetup: Record "User Setup";
        UnitCode: Record "Dimension Value";

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