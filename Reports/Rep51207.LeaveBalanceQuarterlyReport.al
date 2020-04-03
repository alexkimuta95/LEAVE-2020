report 51207 "Leave Balance Quarterly Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Leave Balance Quarterly Report.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No.", Status;
            column(No_Employee; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Balance_B_FCaptionLbl; Balance_B_FCaptionLbl)
            {
            }
            column(BalanceCaptionLbl; BalanceCaptionLbl)
            {
            }
            column(NameCaptionLbl; NameCaptionLbl)
            {
            }
            column(EntitlmentCaptionLbl; EntitlmentCaptionLbl)
            {
            }
            column(Days_TakenCaptionLbl; Days_TakenCaptionLbl)
            {
            }
            column(Days_RecalledCaptionLbl; Days_RecalledCaptionLbl)
            {
            }
            column(Days_AbsentCaptionLbl; Days_AbsentCaptionLbl)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(Entitlement; Entitlement)
            {
            }
            column(TotalRecalls; TotalRecalls)
            {
            }
            column(TotalAbsence; TotalAbsence)
            {
            }
            column(TotalTaken; TotalTaken)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(DateFilter; STRSUBSTNO('AS AT %1', DateFilter))
            {
            }
            column(Name_Employee; Emp."First Name")
            {
            }
            column(BranchName_Employee; Emp."Middle Name")
            {
            }
            column(DepartmentName_Employee; Emp."Last Name")
            {
            }
            column(JobTitle_Employee; Employee."Job Title")
            {
            }
            column(serialno; serialno)
            {
            }
            column(DateOfJoin2_Employee; Emp."Employment Date")
            {
            }
            column(AnnualLeaveBalance_Employee; Employee."Annual Leave Balance")
            {
            }
            column(AnnualLeaveEarned_Employee; Employee."Annual Leave Earned")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(AnnualLeaveTaken_Employee; Employee."Annual Leave Taken")
            {
            }
            column(LostDays_Employee; Employee."Lost Days")
            {
            }
            // column(FixedPay_Employee; Emp.Salary)
            // {
            // }
            column(earneddays; earneddays)
            {
            }
            column(addeddays; addeddays)
            {
            }

            trigger OnAfterGetRecord()
            begin
                serialno += 1;
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //Balance Brought Forward;
                BalanceBF := 0;
                Entitlement := 0;
                earneddays := 0;
                TotalRecalls := 0;
                TotalTaken := 0;
                addeddays := 0;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Balance Brought Forward", TRUE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FIND('-') THEN BEGIN
                    BalanceBF := LeaveLedgerEntry.Days;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::"Positive Adjustment");
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        earneddays += LeaveLedgerEntry."Earned Leave Days";
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                LeaveTypes.RESET;
                LeaveTypes.SETRANGE(Code, 'ANNUAL');
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveTypes.FIND('-') THEN BEGIN
                    Entitlement := LeaveTypes.Days;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::"Positive Adjustment");
                LeaveLedgerEntry.SETRANGE("Recall", TRUE);
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        TotalRecalls += LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::"Negative Adjustment");
                LeaveLedgerEntry.SETRANGE("Leave Type", 'ANNUAL');
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        TotalTaken += -LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::"Negative Adjustment");
                LeaveLedgerEntry.SETRANGE("Leave Type", 'NORMAL');
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        TotalTaken += -LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("Employee No.", Employee."No.");
                LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::"Positive Adjustment");
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETRANGE("Added Back Days", TRUE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        addeddays += LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                Balance := BalanceBF + earneddays + TotalRecalls - TotalTaken;
            end;

            trigger OnPreDataItem()
            begin
                //
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date Filter"; DateFilter)
                {
                }
                field(LeaveFilter; Leavefilter)
                {
                    // TableRelation = Table84002;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*LeaveTypes.RESET;
                        IF PAGE.RUNMODAL(51511390,LeaveTypes) = ACTION::LookupOK THEN
                        Leavefilter:=LeaveTypes.Code;
                        */
                        LeaveTypes1.RESET;
                        IF PAGE.RUNMODAL(84055, LeaveTypes1) = ACTION::LookupOK THEN
                            Leavefilter := LeaveTypes1.Code;

                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        //  Label = 'LEAVE BALANCE QUARTERLY REPORT';
    }

    trigger OnInitReport()
    begin
        serialno := 0;
        CompanyInfo.GET;
        Leavefilter := 'ANNUAL';
    end;

    trigger OnPreReport()
    begin
        AcctPeriod.RESET;
        AcctPeriod.SETRANGE(AcctPeriod."Starting Date", 0D, TODAY);
        AcctPeriod.SETRANGE(AcctPeriod."New Fiscal Year", TRUE);
        IF AcctPeriod.FIND('+') THEN
            MaturityDateFilter := CALCDATE('1Y', AcctPeriod."Starting Date") - 1;
        CompanyInfo.CALCFIELDS(Picture);

        IF DateFilter = 0D THEN BEGIN
            ERROR('Please specify a date filter!');
        END;
    end;

    var
        Emp: Record Employee;
        Name: Text;
        AcctPeriod: Record "Accounting Period";
        MaturityDateFilter: Date;
        CompanyInfo: Record "Company Information";
        EmpLeaveApps: Record "Leave Application";
        TotalTaken: Decimal;
        Recalls: Record "Employee Off/Holidays";
        TotalRecalls: Decimal;
        TotalAbsence: Decimal;
        ANNUAL_LEAVE_BALANCE_CaptionLbl: Label 'ANNUAL LEAVE BALANCE ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_No_CaptionLbl: Label 'Staff No.';
        NameCaptionLbl: Label 'Name';
        Balance_B_FCaptionLbl: Label 'Balance B/F';
        BalanceCaptionLbl: Label 'Balance';
        EntitlmentCaptionLbl: Label 'Entitlment';
        Days_TakenCaptionLbl: Label 'Days Taken';
        Days_RecalledCaptionLbl: Label 'Days Recalled';
        Days_AbsentCaptionLbl: Label 'Days Absent';
        BalanceBF: Decimal;
        Entitlement: Decimal;
        EmployeeLeaves: Record "Employee Leaves";
        Balance: Decimal;
        DateFilter: Date;
        StartDate: Date;
        EndDate: Date;
        Leavefilter: Code[30];
        LeaveTypes: Record "Leave Types";
        StartingDate: Date;
        LeaveTypes1: Record "Leave Types";
        serialno: Integer;
        earneddays: Decimal;
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        addeddays: Decimal;
}

