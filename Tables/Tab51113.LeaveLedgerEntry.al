table 51113 "Leave Ledger Entry"
{
    DataClassification = ToBeClassified;
    LookupPageId = 51126;
    DrillDownPageId = 51126;

    fields
    {
        // field(1; "Entry No."; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     AutoIncrement = true;

        // }
        // field(2; "Leave Period"; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(3; "Closed"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(4; "Staff No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(5; "Posting Date"; Date)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(6; "Document Type"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = "Days Brought Forward",Recall,Accrued,"Negative Adjustment",Taken;

        // }
        // field(7; "User ID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(8; "Leave Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(9; "Days"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(10; "Document No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(11; "Description"; Text[100])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(12; "Entry Type"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = Positive,Negative;
        // }
        // field(13; "Lost Days"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(14; "Earned Leave Days"; Decimal)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(15; "Balance Brought Forward"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(16; "Recalled Days"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(17; "Added Back Days"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(18; "Start Date"; Date)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(19; "End Date"; Date)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(20; "LeaveAppNo"; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(21; "Leave Period Closed"; Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(22; "Employee Resumption Date"; Date)
        // {
        //     DataClassification = ToBeClassified;

        // }
        // field(23; "Employee Name"; Text[50])
        // {
        //     DataClassification = ToBeClassified;

        // }
        field(1; "Line No."; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Days Brought Forward",Recall,Accrued,"Negative Adjustment",Taken;

        }
        field(3; "Posting Date"; date)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Positive Adjustment","Negative Adjustment",Reimbursement,"Carry Forward";
        }
        field(5; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

        }
        field(25; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Types";

        }

        field(7; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods";

        }
        field(8; Days; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Leave Start Date"; date)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Leave End Date"; date)
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Leave Resumption Date"; date)
        {
            DataClassification = ToBeClassified;

        }
        field(11; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Leave Allocation"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Balance Brought Forward"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Leave Period Closed"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Lost Days"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(16; Closed; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Added Back Days"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Earned Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(19; Recall; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(23; LeaveAppNo; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(24; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }

    }

    keys
    {
        key(PK; "Line No.", "Leave Type")
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