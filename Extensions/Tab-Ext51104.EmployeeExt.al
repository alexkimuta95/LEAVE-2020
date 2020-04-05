tableextension 51104 "EmployeeExt" extends Employee
{
    fields
    {
        field(50100; Unit; Code[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1)); //NOT BEST PRACTISE

        }



        field(50105; "NHIF No"; Code[20])
        {
            Caption = 'NHIF No';
            DataClassification = ToBeClassified;

        }
        field(50106; "NSSF No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(50118; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange("Global Dimension No.", 1);
                DimVal.SetRange(Code, "Department Code");
                if DimVal.FindSet() then begin
                    "Department Name" := DimVal.Name;
                end;
            end;

        }
        field(50119; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;

        }

        field(50122; "HR Leave Calender"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";

        }
        field(50123; "Payroll Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Posting Group".Code;

        }
        field(50124; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }


    }

    var
        DimVal: Record "Dimension Value";
        Employee: Record Employee;
}