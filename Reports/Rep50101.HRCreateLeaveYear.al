// report 50101 "HR Create Leave Year"
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     // dataset
//     // {
//     //     dataitem()
//     //     {

//     //     }
//     // }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field("Period Code"; PeriodCode) { ApplicationArea = All; }
//                     field("Period Description"; PeriodDescription) { ApplicationArea = All; }
//                     field("Leave YearStart Date"; LeaveYearStartDate) { ApplicationArea = All; }
//                     field("No Of Periods"; NoOfPeriods) { ApplicationArea = All; }
//                     field("Period Length"; PeriodLength) { ApplicationArea = All; }

//                 }
//             }
//         }


//     }

//     var

//         HRLeavePeriod: Record "Leave Periods";
//         InvtSetup: Record "Human Resources Setup";
//         NoOfPeriods: Integer;
//         PeriodLength: DateFormula;
//         LeaveYearStartDate: Date;
//         LeaveYearStartDate2: Date;
//         FirstPeriodStartDate: Date;
//         LastPeriodStartDate: Date;
//         FirstPeriodLocked: Boolean;
//         i: Integer;
//         PeriodCode: Code[20];
//         PeriodDescription: Text;

//         Text000: TextConst ENU = 'new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.';
//         Text001: TextConst ENU = 'Do you want to create and close the fiscal year?';
//         Text002: TextConst ENU = 'Once you create the new fiscal year you cannot change its starting date.';
//         Text003: TextConst ENU = 'you want to create the fiscal year?';
//         Text004: TextConst ENU = 'is only possible to create new fiscal years before or after the existing ones.';


//     trigger OnPreReport()
//     begin
//         HRLeavePeriod."Starting Date" := LeaveYearStartDate;
//         HRLeavePeriod.TestField("Starting Date");

//         if HRLeavePeriod.FIND('-') then begin
//             FirstPeriodStartDate := HRLeavePeriod."Starting Date";
//             FirstPeriodLocked := HRLeavePeriod."Date Locked";
//             if (LeaveYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
//                 if not
//                    Confirm(
//                      Text000 +
//                      Text001)
//                 then
//                     exit;
//             if HRLeavePeriod.Find('+') then
//                 LastPeriodStartDate := HRLeavePeriod."Starting Date";
//         end else
//             if not
//                Confirm(
//                  Text002 +
//                  Text003)
//             then
//                 exit;

//         LeaveYearStartDate2 := LeaveYearStartDate;


//         for i := 1 to NoOfPeriods + 1 do begin

//             if (LeaveYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
//                 exit;

//             if (FirstPeriodStartDate <> 0D) then
//                 if (LeaveYearStartDate >= FirstPeriodStartDate) and (LeaveYearStartDate < LastPeriodStartDate) then
//                     Error(Text004);

//             HRLeavePeriod.Init();
//             HRLeavePeriod."Period Code" := PeriodCode;
//             HRLeavePeriod."Period Description" := PeriodDescription;
//             HRLeavePeriod."Starting Date" := LeaveYearStartDate;
//             HRLeavePeriod.Validate("Starting Date");
//             HRLeavePeriod.Validate("Period Description");

//             if (i = 1) or (i = NoOfPeriods + 1) then begin
//                 HRLeavePeriod."New Fiscal Year" := true;
//             end;

//             if (FirstPeriodStartDate = 0D) and (i = 1) then
//                 HRLeavePeriod."Date Locked" := true;

//             if (HRLeavePeriod."Starting Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
//                 HRLeavePeriod.Closed := true;
//                 HRLeavePeriod."Date Locked" := true;
//             end;

//             if not HRLeavePeriod.Find('-') then
//                 HRLeavePeriod.Insert();
//             LeaveYearStartDate := CalcDate(PeriodLength, LeaveYearStartDate);
//         end;
//     end;
// }