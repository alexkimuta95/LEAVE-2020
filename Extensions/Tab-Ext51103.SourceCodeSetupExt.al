tableextension 51103 "SourceCodeSetupExt" extends "Source Code Setup"
{
    fields
    {
        field(50100; Recruitment; Code[20])
        {
            Caption = 'Recruitment';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50101; Imprest; Code[20])
        {
            Caption = 'Imprest';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50102; Booking; Code[20])
        {
            Caption = 'Booking';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50103; "Leave Application"; Code[20])
        {
            Caption = 'Leave Application';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50104; Travel; Code[20])
        {
            Caption = 'Travel';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50105; Training; Code[20])
        {
            Caption = 'Training';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(50106; Stationary; Code[20])
        {
            Caption = 'Stationary';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }


    }

    var
        myInt: Integer;
}