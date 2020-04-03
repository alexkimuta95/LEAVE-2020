table 51111 "Employee Leave Plan"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Approved Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Approved Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Verified by Manager"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Verification Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;
        }
        field(12; "Approved End Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Comments"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Taken"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Accrued Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Over used Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Leave Allowance Payable"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Post"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(20; "days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(21; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(23; "Resumption Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(25; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved,Committed,Fulfilled,Canceled;
        }
        field(26; "Leave Entitlement"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(27; "Total Leave Days Taken"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Duties Taken Over By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(29; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(30; "Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(31; "Balance Brought Forward"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(32; "Leave Earned to Date"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Date of Joining Company"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(35; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(36; "No. of Months Worked"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(37; "Annual Leave Entitlement Bal"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(38; "Recalled Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(39; "Off Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(40; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(41; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(42; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(43; "Directorate Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(44; "Total Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Employee No", "Line No", "Application No")
        {
            Clustered = true;
            SumIndexFields = days;
        }
        key(Info; "Employee No", Status, "Leave Code", "Maturity Date")
        {
            Enabled = true;
            SumIndexFields = "Days Applied", "Approved Days";
        }
        key(MoreInfo; "Employee No", "Application No", "Maturity Date")
        {
            Enabled = true;
        }
        key(MoreInfo2; "Department Code", "Application No", "Employee No", "Line No")
        {
            Enabled = true;
            SumIndexFields = "Days Applied";
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