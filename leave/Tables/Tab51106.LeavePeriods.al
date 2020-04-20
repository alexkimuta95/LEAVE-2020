table 51106 "Leave Periods"
{
    DataClassification = ToBeClassified;

    fields
    {
        // field(1; "Starting Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     NotBlank = true;
        //     trigger OnValidate()
        //     begin
        //         "Period Description" := FORMAT("Starting Date", 0, Text000);

        //     end;

        // }
        field(2; "Period Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(3; "New Fiscal Year"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD("Date Locked", FALSE);

            end;

        }
        field(4; "Closed"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Date Locked"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Reimburment Closing Date"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Period Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Period Accrued"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; Current; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        // field(11; Code; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        field(12; Name; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Close Date"; date)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Closed By"; code[30])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Period Code")
        {
            Clustered = true;
        }
    }

    var
        LeavePeriods: Record "Leave Periods";
        InvtSetup: Record "Inventory Setup";
        Text000: TextConst ENU = '<Month text>';

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

    procedure UpdateAvgItems()
    var
        myInt: Integer;
    begin

    end;

}