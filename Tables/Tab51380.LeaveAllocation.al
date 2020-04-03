table 51380 "Leave Allocation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";


        }
        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;


        }
        field(4; "Time Posted"; time)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;


        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Posted;
            Editable = false;

        }
        field(8; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Types";

        }
        field(9; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods";

        }
        field(10; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(13; Posted; boolean)
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        // if "No." <> xRec."No." then begin
        HumanResSetup.Get();
        HumanResSetup.TestField("Leave Allocation Nos.");
        NoSeriesMgt.InitSeries(HumanResSetup."Leave Allocation Nos.", xRec."No. series", 0D, "No.", "No. series");
        "No. Series" := '';

        "User ID" := UserId;
    end;

    // end;

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