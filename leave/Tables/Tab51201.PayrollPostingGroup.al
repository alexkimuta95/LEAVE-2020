table 51201 "Payroll Posting Group"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Emplyee No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(4; Active; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "NSSF By Company"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "NHIF By Company"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Base Calendar"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".Code;

        }
        field(8; "Period Filter"; date)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period"."Starting Date";

        }
        field(9; "Total Employees"; integer)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Global Dimension 1 Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(11; "Global Dimension 2 Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }
        field(12; "Posting Group Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Posting Group".Code;

        }
        field(13; "Default Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;


        }
        field(14; "G/L Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";


        }
        field(15; "Casual Employees"; Boolean)
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