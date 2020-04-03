codeunit 51113 "Leave Manager"
{
    trigger OnRun()
    begin

    end;

    local procedure ValidateApplication(LeaveApp: record "Leave Application")
    var
        LPeriod: Record "Leave Periods";
    begin
        LoadGlobals;
        LPeriod.GET(LeaveApp."Leave Period");
        LPeriod.TESTFIELD(LPeriod.Closed, FALSE);
    end;

    procedure CalculateLeaveDates(LeaveAppCode: Code[30]; LeaveEmployee: Code[30]; BaseCalendarCode: Code[30]; SDate: Date; LDays: Decimal; VAR EDate: Date; VAR RDate: Date)
    var

        CurrDate: Date;
        DayApp: Decimal;
        IsValidReturnDate: Boolean;

        CalendarError: Label 'Base Calendar must be specified';
    begin
        IF BaseCalendarCode = '' THEN ERROR(CalendarError);

        IF NOT IsValidWorkDate(BaseCalendarCode, SDate) THEN ERROR(InvalidSDate);

        Employees.GET(LeaveEmployee);

        LeaveCodes.GET(LeaveAppCode);
        LeaveCodes.TESTFIELD(LeaveCodes.InActive, FALSE);

        IF (SDate = 0D) OR (LDays = 0) THEN EXIT;

        BEGIN
            CurrDate := SDate;
            DayApp := LDays;
            REPEAT
                IF NOT LeaveCodes."Inclusive of Holidays" THEN BEGIN
                    IF NOT IsValidWorkDate(BaseCalendarCode, CurrDate) THEN BEGIN
                        CurrDate := CALCDATE('1D', CurrDate);
                        DayApp += 1;
                    END;
                END;

                CurrDate := CALCDATE('1D', CurrDate);
                DayApp := DayApp - 1;
            UNTIL DayApp = 0;
        END;

        EDate := CALCDATE('-1D', CurrDate);
        RDate := EDate;

        IsValidReturnDate := FALSE;

        //ERROR('Halt');
        WHILE NOT IsValidReturnDate DO BEGIN
            RDate := CALCDATE('1D', RDate);
            IsValidReturnDate := IsValidWorkDate(BaseCalendarCode, RDate);
            IF IsValidReturnDate THEN EXIT;
        END;
    end;





    procedure CalculateLeaveDays(LeaveAppCode: Code[30]; LeaveEmployee: Code[30]; BaseCalendarCode: Code[30]; SDate: Date; RDate: Date; VAR EDate: Date; VAR LDays: Decimal);
    var

        DayApp: Decimal;
        HolsBtwn: Decimal;
        SatsBtwn: Decimal;
        SunsBtwn: Decimal;
        CalendarError: label 'Base Calendar must be specified';
    begin
        IF BaseCalendarCode = '' THEN ERROR(CalendarError);

        IF NOT IsValidWorkDate(BaseCalendarCode, SDate) THEN ERROR(InvalidSDate);

        IF NOT IsValidWorkDate(BaseCalendarCode, RDate) THEN ERROR(InvalidRDate);

        Employees.GET(LeaveEmployee);

        LeaveCodes.GET(LeaveAppCode);
        LeaveCodes.TESTFIELD(LeaveCodes.InActive, FALSE);

        IF (SDate = 0D) OR (RDate = 0D) THEN EXIT;

        BEGIN
            //Get days between the dates
            DayApp := SDate - RDate;

            //If NOT inclusive of holidays
            IF NOT LeaveCodes."Inclusive of Holidays" THEN BEGIN
                //get holidays between dates
                HolsBtwn := 0;
                //if holiday is on saturday, subtract one
                //if holiday is on a sunday, subtract one
            END;

            //if not inclusive of saturdays
            IF NOT LeaveCodes."Inclusive of Saturday" THEN BEGIN
                //get saturdays between dates
                SatsBtwn := 0;
            END;

            //if not inclusive of sundays
            IF NOT LeaveCodes."Inclusive of Sunday" THEN BEGIN
                //get sundays between dates
                SunsBtwn := 0;
            END;

            //Actual days
            DayApp := DayApp - (HolsBtwn + SatsBtwn + SunsBtwn);
        END;

        //Leave days
        LDays := DayApp;
    end;

    procedure CheckIfDaysAvailable(Employee: Code[30]; LeavePeriod: Code[30]; LeaveType: Code[30]; ReqDays: Decimal; ReqStartDate: Date; VAR BalDaysVar: Decimal): Boolean
    var

        EmpLeaves: Record "Employee Leaves";
        Types: Record "Leave Types";
        CurrMonthInt: Integer;
        BalDays: Decimal;
    begin
        IF NOT EmpLeaves.GET(Employee, LeaveType, LeavePeriod) THEN MESSAGE(NoLeaveAlloc, Employee, LeavePeriod, LeaveType);
        Types.GET(LeaveType);
        BEGIN
            //Calculate Accrued Days to Leave Start Date
            CurrMonthInt := DATE2DMY(ReqStartDate, 2);
            BalDays := EmpLeaves.Balance;
            // MESSAGE (FORMAT(CurrMonthInt) + '-' + FORMAT(EmpLeaves."Balance B/F"));
            IF Types."Accrue Days" THEN BalDays += (CurrMonthInt * Types.Days) / 12;//PRORATE MONTHLY IF APPLICABLE
        END;
        BalDaysVar := BalDays;
        IF BalDays >= ReqDays THEN EXIT(TRUE) ELSE EXIT(FALSE);
    end;

    procedure IsValidWorkDate(CalendarCode: Code[30]; WrkDate: Date): Boolean
    var

        CalMan: Codeunit "Calendar Management Custom";
        NonWorkDayTxt: Text;
        WrkDay: Boolean;
    begin
        NonWorkDayTxt := '';
        WrkDay := TRUE;
        IF CalMan.CheckDateStatus(CalendarCode, WrkDate, NonWorkDayTxt) THEN WrkDay := FALSE ELSE WrkDay := TRUE;
        EXIT(WrkDay);
    end;

    procedure GetLeaveMaturityDate(CurrLPeriod: Date): Date
    var
        Maturity: Date;
        IsValidReturn: Boolean;
        HRSetup: Record "Human Resources Setup";
    begin
        HRSetup.GET;

        HRSetup.TESTFIELD(HRSetup."Current Period End Date");

        EXIT(HRSetup."Current Period End Date");
    end;

    procedure GetAccruedDays(LeaveAllocation: Record "Employee Leaves"): Decimal
    begin

    end;

    procedure GetDaysBF(LeaveAllocation: Record "Employee Leaves"): Decimal
    begin

    end;

    procedure UpdateTakenDays(LeaveAllocation: Record "Employee Leaves"): Decimal
    begin
    end;

    procedure UpdateLeaveBalance(LeaveAllocation: Record "Employee Leaves"): Decimal
    begin
    end;

    procedure MarkLeaveAsTaken()
    begin
    end;


    procedure ProceedToClosePeriod(Period: Date)
    begin
    end;

    procedure CheckIfPreviousPeriodClosed(CurrPeriod: Date; VAR PrevPeriod: Date): Boolean
    begin
    end;

    procedure AllocatePeriodDays(PeriodCurr: Code[30]; LeaveType: Code[30])
    var
        Applications: Record "Leave Application";
        Allocations: Record "Employee Leaves";
        LeaveTypes: Record "Leave Types";
        AllocationsTemp: Record "Employee Leaves";
        PeriodNext: Date;
        RecExist: Boolean;
        LeaveCategoryEntitlement: Record "Leave Category Entitlement";
        Employee: Record Employee;
    begin
        LoadGlobals;
        Window.OPEN('Creating leave allocations ###################1');
        LeaveTypes.RESET;
        IF LeaveType <> '' THEN
            LeaveTypes.SETFILTER(LeaveTypes.Code, '%1', LeaveType);
        LeaveTypes.SETFILTER(LeaveTypes.InActive, '%1', FALSE);
        IF LeaveTypes.FINDSET THEN BEGIN
            REPEAT
                LeaveCategoryEntitlement.RESET;
                LeaveCategoryEntitlement.SETFILTER(LeaveCategoryEntitlement."Leave Code", '%1', LeaveTypes.Code);
                LeaveCategoryEntitlement.SETFILTER(LeaveCategoryEntitlement.InActive, '%1', FALSE);
                IF LeaveCategoryEntitlement.FINDSET THEN BEGIN
                    REPEAT
                        Employees.RESET;
                        Employees.SETFILTER(Employees."Payroll Posting Group", '%1', LeaveCategoryEntitlement."Payroll Posting Group");
                        Employees.SETFILTER(Employees.Status, '%1', Employees.Status::Active);
                        IF LeaveCategoryEntitlement.Gender = LeaveCategoryEntitlement.Gender::Male THEN
                            Employees.SETRANGE(Employees.Gender, Employees.Gender::Male);
                        IF LeaveCategoryEntitlement.Gender = LeaveCategoryEntitlement.Gender::Female THEN
                            Employees.SETRANGE(Employees.Gender, Employees.Gender::Female);
                        IF Employees.FINDSET THEN BEGIN
                            REPEAT
                                RecExist := FALSE;
                                SLEEP(5);
                                IF AllocationsTemp.GET(Employees."No.", LeaveType, PeriodCurr) THEN BEGIN
                                    RecExist := TRUE;
                                    AllocationsTemp.INIT;
                                END;
                                Window.UPDATE(1, Employees."No." + '-' + Employees."First Name" + ' ' + Employees."Last Name");
                                AllocationsTemp.Validate(AllocationsTemp."Leave Period", PeriodCurr);
                                AllocationsTemp.Validate(AllocationsTemp."Employee No", Employees."No.");
                                AllocationsTemp.Validate(AllocationsTemp."Leave Code", LeaveTypes.Code);
                                AllocationsTemp.Validate(AllocationsTemp."Maturity Date", GetLeaveMaturityDate(PeriodNext));
                                AllocationsTemp.Validate(AllocationsTemp."Allocated Days", LeaveCategoryEntitlement.Days);
                                AllocationsTemp.Validate(AllocationsTemp."Accrued Days", (LeaveCategoryEntitlement.Days + AllocationsTemp."Balance B/F"));
                                AllocationsTemp.Validate(AllocationsTemp.Balance, AllocationsTemp."Accrued Days");
                                AllocationsTemp.Validate("Balance B/F", GetLeaveBal(PeriodCurr, LeaveTypes.Code, Employees."No."));

                                IF NOT RecExist THEN AllocationsTemp.INSERT(TRUE) ELSE AllocationsTemp.MODIFY(TRUE);

                                Window.UPDATE(1, EmployeeDetails);
                            UNTIL Employees.NEXT = 0;
                        END;
                    UNTIL LeaveCategoryEntitlement.NEXT = 0;
                END;
            UNTIL LeaveTypes.NEXT = 0;
        END;
        Window.CLOSE;
        MESSAGE(AllocationMsg);
    end;

    local procedure GetLeaveBal(Period: Code[30]; LeaveCode: Code[20]; Emp: Code[20]): Decimal
    var
        EmpLev: Record "Employee Leaves";
        LeaveTypes2: Record "Leave Types";
    begin
        LeaveTypes2.GET(LeaveCode);
        IF LeaveTypes2.CarryForward THEN BEGIN
            EmpLev.RESET;
            EmpLev.SETCURRENTKEY("Leave Period");
            EmpLev.SETASCENDING("Leave Period", TRUE);
            EmpLev.SETFILTER("Leave Period", '<>%1', Period);
            EmpLev.SETFILTER("Employee No", '%1', Emp);
            IF EmpLev.FINDFIRST THEN
                IF EmpLev.Balance > LeaveTypes2."Max Carry Forward Days" THEN
                    EXIT(LeaveTypes2."Max Carry Forward Days")
                ELSE
                    EXIT(EmpLev.Balance);
        end;
    end;

    procedure GetCurrentPeriod(): Code[30]
    var
        LPeriods: Record "Leave Periods";
    begin
        LPeriods.RESET;
        LPeriods.SETRANGE(LPeriods.Current, TRUE);
        LPeriods.FINDFIRST;
        EXIT(LPeriods."Period Code");
    end;


    local procedure LoadGlobals()

    begin
        HRSetup.Get();
        HRSetup.TestField(HRSetup."Current Period Start Date");
        HRSetup.TestField("Current Period End Date");
        HRSetup.TestField("Leave Application Nos.");
        // HRSetup.TestField(HRSetup."HR Employee ID");
        HRSetup.TestField("Department Dimension");


    end;

    procedure ClosePeriod()
    begin
        LoadGlobals;
        Periods.Closed := TRUE;
        Periods."Close Date" := WORKDATE;
        Periods."Closed By" := USERID;
        Periods.MODIFY;
    end;

    procedure GetNextPeriod(Period: Date): Date
    begin
    end;

    var

        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Periods: Record "Leave Periods";
        PreviousPeriod: Date;
        Allocations: Record "Employee Leaves";
        Applications: Record "Leave Application";
        Window: Dialog;
        EmployeeDetails: Text;
        NextPeriod: Date;
        Employees: Record Employee;
        LeaveCodes: Record "Leave Types";
        HRSetup: Record "Human Resources Setup";
        Calendars: Record "Base Calendar Change";
        BaseCalender: Record "Base Calendar Change";
        // ApprovalManager: Codeunit "Approval Management Custom";
        // Notifier: Codeunit "Approval Manager Notifier";
        NoOfLInks: Integer;
        LeaveCodeRules: Record "Leave Types";

        //text constants

        Text001: textconst ENU = 'The period %1 has been closed already';
        Text002: textconst ENU = 'The previous period %1 must be closed before the current period can be closed';
        Text003: textconst ENU = 'The period %1 has been successfully closed';
        Text004: textconst ENU = 'The selected %1 period is not the current period!';
        InvalidSDate: textconst ENU = '  Inavlid Start Date';
        InvalidRDate: textconst ENU = '  Inavlid Return Date';
        NoLeaveAlloc: textconst ENU = '  No Leave Allocation exists for %1, %2, %3';
        Err0001: textconst ENU = 'Approver Not Found';
        NoLeaveBalErr: textconst ENU = '   Current Balance for %1 is %2, Application Not Allowed';
        Text040: textconst ENU = 'You must import an Approval Template in Approval Setup.';
        BodyTxt: textconst ENU = ' Microsoft Dynamics NAV Document Approval System';
        NoApproversError: textconst ENU = '  No Approvers have been setup for %1';
        CancelMsg: textconst ENU = ' Document Workflow canceled';
        ApprovalReqMsg: textconst ENU = 'Approval Request Sent';
        AllocationMsg: textconst ENU = ' Allocation for %1 Completed';
        ApprovalRequestTxt: textconst ENU = ' Send Document %1 %2 for Approval?';
        CancelDocTxt: textconst ENU = '  Cancel Approval Workflow for Document %1 %2 ?';
}