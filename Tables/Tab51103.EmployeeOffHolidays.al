table 51103 "Employee Off/Holidays"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Emp.Get("Employee No") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;

        }
        field(2; "Date"; Date)
        {
            DataClassification = ToBeClassified;


        }
        field(3; "Approved"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                LeaveTypes.Reset();
                LeaveTypes.SetRange(LeaveTypes."Off/Holidays Days Leave", true);
                if LeaveTypes.Find('-') then;
                EmpLeave.Reset();
                EmpLeave.SetRange(EmpLeave."Employee No", "Employee No");
                EmpLeave.SetRange(EmpLeave."Leave Code", LeaveTypes.Code);
                if EmpLeave.Find('-') then;
                if Approved = true then begin
                    EmpLeave.Balance := EmpLeave.Balance + 1;
                    EmpLeave.Modify();
                end
                else begin
                    EmpLeave.Balance := EmpLeave.Balance - 1;
                    EmpLeave.Modify();
                end;
            end;

        }
        field(4; "Leave Application"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Application"."Application No" where(Status = const(Approved), "Employee No." = field("Employee No"));

            trigger OnValidate()
            begin
                LeaveApplication.RESET;
                if LeaveApplication.GET("Leave Application") then begin
                    // "Leave Ending Date" := LeaveApplication."End Date";
                    "Employee No" := LeaveApplication."Employee No.";
                    // "Employee Name" := LeaveApplication."Employee Name";
                    // "Directorate Code" := LeaveApplication."Directorate Code";
                    // "Employee Department" := LeaveApplication."Department Name";
                    // "Leave Start Date" := LeaveApplication."Start Date";
                    "Days Applied" := FORMAT(LeaveApplication."Days Applied");
                    // "Employee Job Title" := LeaveApplication."Job Title";
                    "Leave Code" := LeaveApplication."Leave Code";
                end;
            end;
        }
        field(5; "Recall Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Leave Application");

            end;

        }
        field(6; "No. of Off Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                LeaveApplication.Reset();
                LeaveApplication.SetRange(LeaveApplication."Application No", "Leave Application");
                if LeaveApplication.Find('-') then
                    if LeaveApplication."Days Applied" < "No. of Off Days" then
                        Error('The days you are trying to recall for %1 are more than the leave days applied they for', "Employee Name");
            end;

        }
        field(7; "Leave Ending Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(13; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Recalled By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Emp.Get("Recalled By") then begin
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Job Title" := Emp."Job Title";

                    DimensionsValue.Reset();
                    DimensionsValue.SetRange(DimensionsValue."Dimension Code", 'DEPARTMENT');
                    DimensionsValue.SetRange(DimensionsValue.Code, Emp."Global Dimension 1 Code");
                    IF DimensionsValue.Find('-') then
                        "Head Of Department" := DimensionsValue.Name;

                end;
            end;

        }
        field(15; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(16; "Reason for Recall"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Head of Department"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Recalled From"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;

        }
        field(19; "Recalled To"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;

        }
        field(20; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Directorate Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(23; "Directorate Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Employee Department"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(25; "Employee Branch"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(26; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(27; "Days Applied"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Recalled Department"; Text[50])
        {
            DataClassification = ToBeClassified;
            // hjjhh
        }
        field(29; "Recalled Branch"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(30; "Employee Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(31; "Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(32; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Info; "Employee No", "Maturity Date")
        {
            Enabled = true;
            SumIndexFields = "No. of Off Days";

        }
        key(MoreInfo; "Employee No", "Contract No.")
        {
            Enabled = true;
            SumIndexFields = "No. of Off Days";
        }

    }

    var
        EmpLeave: Record "Employee Leaves";
        LeaveTypes: Record "Leave Types";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        FiscalStart: Date;
        MaturityDate: Date;
        Emp: Record Employee;
        LeaveApplication: Record "Leave Application";
        NextDate: Date;
        NoOfDaysOff: Decimal;
        CalendarMgmt: Codeunit "Calendar Management";
        GeneralOptions: Record "Company Information";
        Description: Text;
        BaseCalender: Record Date;
        NonWorkingDay: Boolean;
        NotworkingDaysRecall: Integer;

        BaseCalendarChange: Record "Base Calendar Change";
        d: Date;
        DimensionsValue: Record "Dimension Value";
        LeaveCode: Code[20];
        FullDays: Decimal;
        HalfDays: Decimal;
        days: Decimal;
        NoOfWorkingDays: Decimal;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get();
            HumanResSetup.TestField(HumanResSetup."Leave Recall Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Recall Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Date := Today;
        "Recall Date" := Today;
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
    end;

    trigger OnModify()
    begin
        Message('You are modifying leave recall data for %1 are you sure you want to do this', "Employee Name");

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange(AccPeriod."Starting Date", 0D, TODAY);
        AccPeriod.SetRange(AccPeriod."New Fiscal Year", TRUE);
        if AccPeriod.FIND('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;

    end;

}