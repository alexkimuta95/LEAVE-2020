tableextension 51101 "UserSetupEXt" extends "User Setup"
{
    fields
    {
        field(50100; "HR Administrator"; Boolean)
        {
            Caption = 'HR Administrator';
            DataClassification = ToBeClassified;


        }
        field(50101; "Full Name"; Text[50])
        {
            Caption = 'Full Name';
            DataClassification = ToBeClassified;

        }
        field(50102; "Payroll Admin Category"; Option)
        {
            Caption = 'Payroll Admin Category';
            DataClassification = ToBeClassified;
            OptionMembers = ,USD,KES;
        }
        field(50103; Supervisor; Boolean)
        {
            Caption = 'Supervisor';
            DataClassification = ToBeClassified;

        }
        field(50104; HOD; Code[10])
        {
            Caption = 'HOD';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(50105; "Selection Panel"; Boolean)
        {
            Caption = 'Selection Panel';
            DataClassification = ToBeClassified;

        }
        field(50106; "Recruitment Advert"; Code[40])
        {
            Caption = 'Recruitment Advert';
            DataClassification = ToBeClassified;
            // TableRelation = advert

        }
        field(50107; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

        }
    }

    var
        myInt: Integer;
}