table 51000 "Leave Application"
{
    DataClassification = ToBeClassified;
    LookupPageId = 51104;
    DrillDownPageId = 51104;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            trigger OnValidate()
            begin
                "Application Date" := Today;
            end;

        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            NotBlank = false;

        }

        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = ToBeClassified;
            TableRelation = "Employee Leaves"."Leave Code" where("Employee No" = field("Employee No."), "Leave Period" = field("Leave Period"));
            trigger OnValidate()
            begin
                GetApplicationNo();
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            Caption = 'Days Applied';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ValidateApplicationDates();
                ValidateAccruedDays();
            end;
        }

        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ValidateApplicationDates();
                ValidateAccruedDays();
                IF HasPendingOrActiveLeave = TRUE THEN ERROR('You have another active or pending leave!');
            end;

        }

        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                ValidateApplicationDates();
            end;
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(8; "Approved Days"; Decimal)
        {
            Caption = 'Approved Days';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ValidateApprovalDates();
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
            Caption = 'Approved Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ValidateApprovalDates();
            end;
        }
        field(10; "Verified by Manager"; boolean)
        {
            Caption = 'Verified by Manager';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Verification Date" := Today;
            end;

        }
        field(11; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
            DataClassification = ToBeClassified;

        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Review,Approved,Rejected,Canceled;

            trigger OnValidate()
            begin
                GeneralOptions.GET;
                GeneralOptions.TESTFIELD(GeneralOptions."Base Calendar");
                IF (Status = Status::Review) AND (xRec.Status <> Status::Review) THEN BEGIN
                    ;
                    "Approval Date" := TODAY;
                    EmpLeave.RESET;
                    EmpLeave.SETRANGE(EmpLeave."Employee No", "Employee No.");
                    EmpLeave.SETRANGE(EmpLeave."Leave Code", "Leave Code");
                    IF EmpLeave.FIND('-') THEN;

                    EmpLeave.Balance := EmpLeave.Balance - "Approved Days";
                    EmpLeave.MODIFY;
                END ELSE
                    IF (Status <> Status::Review) AND (xRec.Status = Status::Review) THEN BEGIN
                        "Approval Date" := TODAY;
                        EmpLeave.RESET;
                        EmpLeave.SETRANGE(EmpLeave."Employee No", "Employee No.");
                        EmpLeave.SETRANGE(EmpLeave."Leave Code", "Leave Code");
                        IF EmpLeave.FIND('-') THEN;
                        EmpLeave.Balance := EmpLeave.Balance + "Approved Days";
                        EmpLeave.MODIFY;
                    END
            end;
        }

        field(13; "Approved End Date"; DateTime)
        {
            Caption = 'Approved End Date';
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(14; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Approval Date" := Today;
            end;

        }
        field(15; Comments; Text[100])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;

        }
        field(16; Taken; Boolean)
        {
            Caption = 'Taken';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Approved);
                IF CONFIRM(Txt0001, FALSE) THEN BEGIN
                    MarkLeaveAsTaken(Rec);
                END;
            end;
        }
        field(17; "Accrued Days"; Decimal)
        {
            Caption = 'Accrued Days';
            DataClassification = ToBeClassified;

        }
        field(18; "No. Series"; code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;

        }

        field(19; "Resumption Date"; Date)
        {
            Caption = 'Resumption Date';
            DataClassification = ToBeClassified;

        }
        field(20; "Approved Resumption Date"; Date)
        {
            Caption = 'Approve Resumption Date';
            DataClassification = ToBeClassified;

        }
        field(21; "User ID"; Code[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;

        }
        field(22; "Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            TableRelation = "Leave Periods"."Period Code";

        }

    }

    keys
    {
        key(PK; "Application No", "Employee No.")
        {
            Clustered = true;
        }
    }

    var
        EmpLeave: Record "Employee Leaves";
        BaseCalender: Record "Base Calendar Change";
        GeneralOptions: Record "General Ledger Setup";
        CurDate: Date;
        LeaveTypes: Record "Leave Types";
        DayApp: Decimal;
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LeaveManager: Codeunit "Leave Manager";
        Periods: Record "Leave Periods";
        Employees: Record Employee;
        Err0001: Label 'No approver has been defined for this Employee profile, check the approvers setup';
        Err0002: Label 'Leave balance of %1 will not be sufficient for this application. Reduce the No. of requested days';
        Txt0001: label 'Do you want to mark this leave application as taken, this will update Employee Leave Balances';


    trigger OnInsert()
    begin
        "Application Date" := Today;
        "Leave Period" := LeaveManager.GetCurrentPeriod();
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
        TestField(Status, Status::New);
    end;

    trigger OnRename()
    begin
    end;

    procedure GetApplicationNo()
    var
        myInt: Integer;
    begin
        HRSetup.Get();
        HRSetup.TestField(HRSetup."Leave Application Nos.");

        if "Application No" = '' then begin
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. Series", 0D, "Application No", "No. Series");
        end;
    end;

    procedure GetCurrentLeavePeriod()
    begin

    end;

    procedure ValidateApplicationDates()
    begin
        IF "Days Applied" = 0 THEN EXIT;
        IF "Start Date" = 0D THEN EXIT;

        Employees.GET("Employee No.");
        Employees.TESTFIELD(Employees."HR Leave Calender");

        LeaveTypes.GET("Leave Code");
        LeaveTypes.TESTFIELD(LeaveTypes.InActive, FALSE);

        LeaveManager.CalculateLeaveDates("Leave Code", "Employee No.", Employees."HR Leave Calender", "Start Date", "Days Applied", "End Date", "Resumption Date");
    end;

    procedure ValidateApprovalDates()
    var

        EndDate: DateTime;
        AppReturn: Datetime;
    begin


    end;

    procedure SendDocApprovalRequest()
    begin
        // LeaveManager.SendApprovalRequest(Rec);
    end;

    procedure CancelDocApproval()
    begin
        // LeaveManager.SendCancelRequest (Rec);
    end;

    procedure UpdateDocApprovalStats(VAR CurrRec: Record "Leave Application")
    begin

    end;

    procedure MarkLeaveAsTaken(VAR CurrRec: Record "Leave Application")
    begin
        EmpLeave.GET(CurrRec."Employee No.", CurrRec."Leave Code", CurrRec."Leave Period");
        CurrRec.Taken := TRUE;
        CurrRec.MODIFY;
        EmpLeave.UpdateBalances;
    end;

    procedure ViewApprovals()
    begin
        // ApprovalManager.ViewDocApprovals(0, "Application Code");

    end;

    procedure ShowOrigDoc()
    begin
        //CurrRecPage.SETTABLEVIEW(Rec);
        //CurrRecPage.RUNMODAL;
    end;

    local procedure HasPendingOrActiveLeave(): Boolean
    var
        leaveApps: Record "Leave Application";
    begin
        leaveApps.RESET;
        leaveApps.SETFILTER("Employee No.", "Employee No.");
        leaveApps.SETFILTER("Start Date", '>= %1', Today);

        IF leaveApps.FINDSET THEN BEGIN
            REPEAT
                IF leaveApps.Status = leaveApps.Status::Review THEN
                    EXIT(TRUE)

                ELSE
                    IF leaveApps.Status = leaveApps.Status::Approved THEN
                        IF "Start Date" <= leaveApps."End Date" THEN
                            EXIT(TRUE);

            UNTIL leaveApps.NEXT = 0;
        END;
        EXIT(FALSE);
    end;

    procedure ValidateAccruedDays()
    var
        LeaveTypes2: Record "Leave Types";
        DefaultLDays: Decimal;
        LeaveAlloc: Record "Employee Leaves";
        LBal: Decimal;
        DaysTaken: Decimal;
        SDateMonth: Integer;
        CurrentYear: Integer;
        EndDatePMonth: Date;
        EndPMonth: Integer;
        EarnedDays: Decimal;
        AccError001: Label 'Leave days applied are not earned';
        AccError002: Label 'Leave days applied are not earned. Can Apply upto %1 days';
    begin
        LeaveTypes2.RESET;
        LeaveTypes2.SETFILTER("Accrue Days", '%1', TRUE);
        IF LeaveTypes2.FINDFIRST THEN BEGIN
            DefaultLDays := LeaveTypes2.Days;
            LeaveAlloc.RESET;
            LeaveAlloc.SETAUTOCALCFIELDS("Days Taken");
            LeaveAlloc.SETFILTER("Leave Period", '%1', Rec."Leave Period");
            LeaveAlloc.SETFILTER("Employee No", '%1', Rec."Employee No.");
            LeaveAlloc.SETFILTER("Leave Code", '%1', LeaveTypes2.Code);
            IF LeaveAlloc.FINDFIRST THEN BEGIN
                LBal := LeaveAlloc.Balance;
                DaysTaken := LeaveAlloc."Days Taken";
                IF (DaysTaken + Rec."Days Applied") > LeaveAlloc."Balance B/F" THEN BEGIN
                    //Check If Leave Days Earned
                    IF Rec."Start Date" <> 0D THEN BEGIN
                        SDateMonth := DATE2DMY((Rec."Start Date"), 2);
                        CurrentYear := DATE2DMY((Rec."Start Date"), 3);
                        EndDatePMonth := CALCDATE('<CM>', CALCDATE('<-CM-1D>', (Rec."Start Date")));
                        IF DATE2DMY(EndDatePMonth, 3) = CurrentYear THEN BEGIN
                            EndPMonth := DATE2DMY(EndDatePMonth, 2);
                            EarnedDays := (DefaultLDays / 12) * EndPMonth;
                            IF Rec."Days Applied" > ((EarnedDays + LeaveAlloc."Balance B/F") - DaysTaken) THEN ERROR(STRSUBSTNO(AccError002, ((EarnedDays + LeaveAlloc."Balance B/F") - DaysTaken)));
                        END ELSE
                            ERROR(AccError001);
                    END;
                END;
            END;
        END;
    end;

}