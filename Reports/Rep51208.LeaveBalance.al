report 51208 "Leave Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Leave Balance.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No.", Status, "Global Dimension 1 Code";
            column(No_Employee; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Unit; Employee.Unit)
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
            column(BranchName_Employee; Emp."Last Name")
            {
            }
            column(DepartmentName_Employee; Emp."Middle Name")
            {
            }
            column(JobTitle_Employee; Emp."Job Title")
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
            column(earneddays; earneddays)
            {
            }
            column(addedback; addedback)
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
                addedback := 0;
                /*
                //TotalRecalls:=0;
                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE("Employee No",Employee."No.");
                IF EmployeeLeaves.FINDSET THEN BEGIN
                  REPEAT
                    EmployeeLeaves.CALCFIELDS("Recalled Days");
                    TotalRecalls+=EmployeeLeaves."Recalled Days"; //MESSAGE('%1',TotalRecalls);
                  UNTIL EmployeeLeaves.NEXT=0;
                END;
                */
                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("employee No.", Employee."No.");
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
                LeaveLedgerEntry.SETRANGE(Recall, TRUE);
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        TotalRecalls += LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                LeaveLedgerEntry.RESET;
                LeaveLedgerEntry.SETRANGE("employee No.", Employee."No.");
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
                //LeaveLedgerEntry.SETRANGE("Leave Code",'NORMAL');
                LeaveLedgerEntry.SETRANGE(Closed, FALSE);
                LeaveLedgerEntry.SETRANGE("Added Back Days", TRUE);
                LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', DateFilter);
                IF LeaveLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        addedback += LeaveLedgerEntry.Days;
                    UNTIL LeaveLedgerEntry.NEXT = 0;
                END;

                Balance := BalanceBF + earneddays + TotalRecalls + addedback - TotalTaken;

                /*
                IF Leavefilter='ANNUAL' THEN BEGIN
                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE("Employee No","No.");
                EmployeeLeaves.SETFILTER("Maturity Date",'>%',DateFilter);
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Leave Code",Leavefilter);
                IF EmployeeLeaves.FIND('+') THEN BEGIN
                   //BalanceBF:=EmployeeLeaves."Balance Brought Forward";
                  // Entitlement:=EmployeeLeaves.Entitlement;
                   EndDate:=EmployeeLeaves."Maturity Date";
                   StartDate:=CALCDATE('-1Y',EmployeeLeaves."Maturity Date")+1;
                 //  MESSAGE('Entitlement=%1',Entitlement);
                END ELSE
                BEGIN
                AcctPeriod.RESET;
                AcctPeriod.SETRANGE(AcctPeriod."Starting Date",0D,TODAY);
                AcctPeriod.SETRANGE(AcctPeriod."New Fiscal Year",TRUE);
                IF AcctPeriod.FIND('-') THEN BEGIN
                  StartingDate:=AcctPeriod."Starting Date";
                 // Employee.TESTFIELD("Date Of Join2");
                  //MESSAGE('MATURITY=%1\Dateof Join=%2',MaturityDateFilter,Employee."Date Of Join");
                  IF Employee."Date Of Join" > AcctPeriod."Starting Date" THEN
                   Entitlement:=ROUND(((MaturityDateFilter - Employee."Date Of Join")/30)*2.5,0.1);
                   EmployeeLeaves.INIT;
                   EmployeeLeaves."Leave Code":=Leavefilter;
                   EmployeeLeaves."Employee No":="No.";
                   EmployeeLeaves.Entitlement:=Entitlement;
                   EmployeeLeaves."Maturity Date":=MaturityDateFilter;
                   IF NOT EmployeeLeaves.GET(EmployeeLeaves."Employee No",EmployeeLeaves."Leave Code",EmployeeLeaves."Maturity Date") THEN
                   EmployeeLeaves.INSERT;
                END;
                END;
                END;
                
                IF Leavefilter<>'ANNUAL' THEN BEGIN
                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE("Employee No","No.");
                EmployeeLeaves.SETFILTER("Maturity Date",'>%',DateFilter);
                //EmployeeLeaves.SETRANGE(EmployeeLeaves."Leave Code",Leavefilter);
                IF EmployeeLeaves.FIND('+') THEN BEGIN
                   EndDate:=EmployeeLeaves."Maturity Date";
                   StartDate:=CALCDATE('-1Y',EmployeeLeaves."Maturity Date")+1;
                END;
                END;
                
                
                //message('%1, %2',Leavefilter,DateFilter);
                 TotalTaken:=0;
                EmpLeaveApps.RESET;
                EmpLeaveApps.SETRANGE("Employee No","No.");
                EmpLeaveApps.SETRANGE("Maturity Date",EndDate);
                EmpLeaveApps.SETRANGE(Status,EmpLeaveApps.Status::"Pending Approval");
                EmpLeaveApps.SETRANGE("Leave Code",Leavefilter);
                EmpLeaveApps.SETFILTER(EmpLeaveApps."Start Date",'<=%1',DateFilter);
                IF EmpLeaveApps.FIND('-') THEN BEGIN REPEAT
                 TotalTaken:=TotalTaken+EmpLeaveApps."Days Applied";
                UNTIL EmpLeaveApps.NEXT=0;
                END;
                TotalRecalls:=0;
                IF Leavefilter='ANNUAL' THEN BEGIN
                Recalls.RESET;
                Recalls.SETRANGE("Employee No","No.");
                Recalls.SETRANGE("Maturity Date",EndDate);
                Recalls.SETFILTER(Recalls."Recalled To",'<=%1',DateFilter);
                Recalls.CALCSUMS(Recalls."No. of Off Days");
                TotalRecalls:=Recalls."No. of Off Days";
                
                Absences.RESET;
                Absences.SETRANGE("Employee No","No.");
                Absences.SETRANGE("Maturity Date",EndDate);
                Absences.SETFILTER(Absences."Absent To",'<=%1',DateFilter);
                Absences.CALCSUMS(Absences."No. of  Days Absent");
                TotalAbsence:=Absences."No. of  Days Absent";
                Balance:=BalanceBF+Entitlement-TotalTaken+TotalRecalls-TotalAbsence;
                
                END;
                */

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
                    TableRelation = "Leave Types".Code;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LeaveTypes1.RESET;
                        IF PAGE.RUNMODAL(50005, LeaveTypes1) = ACTION::LookupOK THEN
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
        // Label = LeaveBalance;
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
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        earneddays: Decimal;
        addedback: Decimal;
}

