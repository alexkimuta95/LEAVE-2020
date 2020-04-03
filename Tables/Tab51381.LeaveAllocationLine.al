table 51381 "Leave Allocation Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(2; "Line No"; integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Emp.Get("Employee No.");
                "Employee Name" := Emp.FullName();
            end;

        }
        field(4; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Positive Adjustment","Negative Adjustment",Reimbursement,"Carry Forward";
        }

        field(6; "Allocate the Days"; integer)
        {
            DataClassification = ToBeClassified;

        }
        field(7; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "No.", "Line No")
        {
            Clustered = true;
        }
    }

    var
        Emp: Record Employee;

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