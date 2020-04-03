// report 51214 "HR Create Leave Year n"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//     }

//     requestpage
//     {
//         Caption = 'HR Create Leave Year';
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(PeriodCode; PeriodCode)
//                     {
//                         Caption = 'Period Code';
//                     }
//                     field(PeriodDescription; PeriodDescription)
//                     {
//                         Caption = 'Period Description';
//                     }
//                     field(LeaveYearStartDate; LeaveYearStartDate)
//                     {
//                         Caption = 'Period Starting Date';
//                     }
//                     field(NoOfPeriods; NoOfPeriods)
//                     {
//                         Caption = 'No. of Periods';
//                     }
//                     field(PeriodLength; PeriodLength)
//                     {
//                         Caption = 'Period Length';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         HRLeavePeriod."Starting Date" := LeaveYearStartDate;  //010114
//         HRLeavePeriod.TESTFIELD("Starting Date");

//         IF HRLeavePeriod.FIND('-') THEN BEGIN
//             FirstPeriodStartDate := HRLeavePeriod."Starting Date";
//             FirstPeriodLocked := HRLeavePeriod."Date Locked";
//             IF (LeaveYearStartDate < FirstPeriodStartDate) AND FirstPeriodLocked THEN
//                 IF NOT
//                    CONFIRM(
//                      Text000 +
//                      Text001)
//                 THEN
//                     EXIT;
//             IF HRLeavePeriod.FIND('+') THEN
//                 LastPeriodStartDate := HRLeavePeriod."Starting Date";
//         END ELSE
//             IF NOT
//                CONFIRM(
//                  Text002 +
//                  Text003)
//             THEN
//                 EXIT;

//         LeaveYearStartDate2 := LeaveYearStartDate;


//         FOR i := 1 TO NoOfPeriods + 1 DO BEGIN
//             //Exit if the fiscal year to be created is a date BELOW the current Leave year
//             IF (LeaveYearStartDate <= FirstPeriodStartDate) AND (i = NoOfPeriods + 1) THEN
//                 EXIT;

//             IF (FirstPeriodStartDate <> 0D) THEN
//                 IF (LeaveYearStartDate >= FirstPeriodStartDate) AND (LeaveYearStartDate < LastPeriodStartDate) THEN
//                     ERROR(Text004);

//             HRLeavePeriod.INIT;
//             HRLeavePeriod."Period Code" := PeriodCode;
//             HRLeavePeriod."Period Description" := PeriodDescription;
//             HRLeavePeriod."Starting Date" := LeaveYearStartDate;
//             HRLeavePeriod.VALIDATE("Starting Date");
//             HRLeavePeriod.VALIDATE("Period Description");

//             IF (i = 1) OR (i = NoOfPeriods + 1) THEN BEGIN
//                 HRLeavePeriod."New Fiscal Year" := TRUE;
//             END;

//             IF (FirstPeriodStartDate = 0D) AND (i = 1) THEN
//                 HRLeavePeriod."Date Locked" := TRUE;

//             IF (HRLeavePeriod."Starting Date" < FirstPeriodStartDate) AND FirstPeriodLocked THEN BEGIN
//                 HRLeavePeriod.Closed := TRUE;
//                 HRLeavePeriod."Date Locked" := TRUE;
//             END;

//             IF NOT HRLeavePeriod.FIND('=') THEN
//                 HRLeavePeriod.INSERT;
//             LeaveYearStartDate := CALCDATE(PeriodLength, LeaveYearStartDate);
//         END;

//         //HRLeavePeriod.GET(LeaveYearStartDate2);
//         //HRLeavePeriod.UpdateAvgItems(0);
//     end;

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
//         PeriodCode: Code[10];
//         PeriodDescription: Text;
//         Text000: Label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';
//         Text001: Label 'Do you want to create and close the fiscal year?';
//         Text002: Label 'Once you create the new fiscal year you cannot change its starting date.\\';
//         Text003: Label 'Do you want to create the fiscal year?';
//         Text004: Label 'It is only possible to create new fiscal years before or after the existing ones.';
// }

