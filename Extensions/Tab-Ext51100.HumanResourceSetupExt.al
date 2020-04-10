tableextension 51100 "HumanResourceSetupExt" extends "Human Resources Setup"
{
    fields
    {

        field(50103; "Leave Application Nos."; Code[10])
        {
            Caption = 'Leave Application Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;


        }
        field(50104; "Leave Recall Nos"; Code[20])
        {
            Caption = 'Leave Recall Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }

        field(50106; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));


        }
        field(50107; "Base Calendar Code"; Code[20])
        {
            Caption = 'Base Calendar Code';
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".code;

        }
        field(50108; "HR E-Mail"; Code[60])
        {
            Caption = 'HR Email';
            DataClassification = ToBeClassified;


        }
        field(50109; "Unit Dimension Code"; Code[10])
        {
            Caption = 'Unit Dimension Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(50122; "Current Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50123; "Current Period End Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50125; "Department Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;

        }

    }

    var
        myInt: Integer;
}