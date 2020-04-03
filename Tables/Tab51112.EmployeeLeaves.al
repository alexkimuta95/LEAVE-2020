table 51112 "Employee Leaves"
{
    DataClassification = ToBeClassified;
    LookupPageId = 51121;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee;

        }
        field(2; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Leave Types".Code;


        }
        field(3; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(4; "Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; "Accrued Days"; Decimal)
        {
            // FieldClass = FlowField;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Days Taken"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Leave Application"."Days Applied" where("Employee No." = field("Employee No"), "Leave Code" = field("Leave Code"), Taken = const(true), Status = const(Approved), "Leave Period" = field("Leave Period")));
            Editable = false;
        }
        field(7; "Days Applied"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Application"."Days Applied" WHERE("Employee No." = FIELD("Employee No"), "Leave Code" = FIELD("Leave Code"), Status = CONST(Approved)));

        }

        field(8; "Balance B/F"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                CalculateAccruedDays(Rec);
            end;
        }
        field(9; "Recalled Days"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Leave Ledger Entry".Days where("Employee No." = field("Employee No"), "Leave Type" = field("Leave Code"), "Leave Period Closed" = filter(false), "Document Type" = filter(Recall)));

        }

        field(10; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Leave Periods"."Period Code";


        }
        field(11; "Days Approved Taken"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Application"."Approved Days" WHERE("Employee No." = FIELD("Employee No"), "Leave Code" = FIELD("Leave Code"), Taken = CONST(true), Status = CONST(Approved)));
        }
        field(12; "Days Approved"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Application"."Approved Days" WHERE("Employee No." = FIELD("Employee No"), "Leave Code" = FIELD("Leave Code"), Status = CONST(Approved)));

        }
        field(13; "Allocated Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            trigger OnValidate()
            begin
                CalculateAccruedDays(Rec);
            end;
        }
        field(14; Taken; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Employee No", "Leave Code", "Leave Period")
        {
            Clustered = true;
        }
    }

    var

        LeaveTypes: Record "Leave Types";
        EmployeeRec: Record Employee;

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

    procedure UpdateBalances()
    begin
        CALCFIELDS("Days Taken");
        Balance := "Accrued Days" - "Days Taken";
        // MODIFY;
    end;

    procedure CalculateAccruedDays(LeaveRec: Record "Employee Leaves"): Decimal
    begin
        "Accrued Days" := "Allocated Days" + "Balance B/F";
        UpdateBalances();
    end;


}