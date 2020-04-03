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



        field(50110; "Annual Leave Earned"; Decimal)
        {
            Caption = 'Annual Leave Earned';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days where("Employee No." = field("No."), "Leave Type" = filter('ANNUAL'), Days = FILTER(> 0), Closed = CONST(false), "Lost Days" = CONST(false)));

        }
        field(50111; "Annual Leave Taken"; Decimal)
        {
            Caption = 'Annual Leave Taken';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = - Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('ANNUAL'), Days = FILTER(< 0), Closed = CONST(false)));

        }
        field(50112; "Annual Leave Balance"; Decimal)
        {
            Caption = 'Annual Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('ANNUAL'), "Leave Period Closed" = CONST(false)));

        }
        field(50113; "Lost Days"; Decimal)
        {
            Caption = 'Lost Days';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('ANNUAL'), Days = FILTER(> 0), Closed = CONST(false), "Lost Days" = CONST(true)));
            Editable = false;
        }
        //    <-- -->
        field(50139; "Compassion Leave Balance"; Decimal)
        {
            Caption = 'Compassion Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('COMPASSION'), "Leave Period Closed" = CONST(false)));

        }
        field(50140; "Offday Leave Balance"; Decimal)
        {
            Caption = 'Offday Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('OFFDAY'), "Leave Period Closed" = CONST(false)));

        }
        field(50141; "Paternity Leave Balance"; Decimal)
        {
            Caption = 'Paternity Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('PATERNITY'), "Leave Period Closed" = CONST(false)));

        }
        field(50142; "Maternity Leave Balance"; Decimal)
        {
            Caption = 'Maternity Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('MATERNITY'), "Leave Period Closed" = CONST(false)));

        }
        field(50143; "sick Leave Balance"; Decimal)
        {
            Caption = 'sick Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('SICK'), "Leave Period Closed" = CONST(false)));

        }
        field(50144; "Study Leave Balance"; Decimal)
        {
            Caption = 'Study Leave Balance';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum ("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("No."), "Leave Type" = FILTER('STUDY'), "Leave Period Closed" = CONST(false)));

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