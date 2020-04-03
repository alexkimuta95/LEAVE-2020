table 51104 "Leave Journal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;

        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods"."Period Code" where("New Fiscal Year" = filter(true), Closed = filter(false), "Date Locked" = filter(true));

        }
        field(4; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if ("Staff No." <> xRec."Staff No.") then begin
                    Employee.GET("Staff No.");
                    EmployeeName := Employee.FullName;
                end;
            end;

        }
        field(5; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Types".Code;

        }
        field(7; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Positive,Negative;
        }
        field(8; "Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Days Brought Forward",Recall,Accrued,"Negative Adjustment";
        }
        field(11; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Employee Name"; Text[40])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        EmployeeName: Text;

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Leave Journal Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Journal Nos.", xRec."No. series", 0D, "Document No", "No. series");
        end;
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