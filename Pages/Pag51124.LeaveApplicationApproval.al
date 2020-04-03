// page 51124 "Leave Application Approval"
// {
//     PageType = Card;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = 51000;
//     Editable = true;


//     layout
//     {
//         area(Content)
//         {
//             group(Application)
//             {
//                 field("Application No"; "Application No") { ApplicationArea = all; Editable = false; }
//                 field("Employee No."; "Employee No.") { ApplicationArea = all; Editable = true; }
//                 field("Approval Date"; "Approval Date") { ApplicationArea = all; Editable = false; }
//                 field("Employee Name"; "Employee Name") { ApplicationArea = all; Editable = false; }
//                 field("Mobile No"; "Mobile No") { ApplicationArea = all; Editable = false; }
//                 field("Department Code"; "Department Code") { ApplicationArea = all; Visible = true; }
//                 field("Job Title"; "Job Title") { ApplicationArea = all; Editable = false; }
//                 field("Employment Date"; "Employment Date") { ApplicationArea = all; Editable = false; }
//                 field("Leave Code"; "Leave Code")
//                 {
//                     ApplicationArea = all;
//                     NotBlank = true;
//                     trigger OnValidate()
//                     begin
//                         if "Leave Code" <> '' then
//                             seeentitlement := true;

//                     end;
//                 }


//             }
//             group(Balances)
//             {
//                 // field("Leave Earned to Date"; "Leave Earned to Date") { ApplicationArea = all; Editable = false; }
//                 // field("Added Back Days"; "Added Back Days") { ApplicationArea = all; Editable = false; }
//                 // field("Total Leave Days Taken"; "Total Leave Days Taken") { ApplicationArea = all; Visible = false; Editable = false; }
//                 // field("Total Leave Days Taken Normal"; "Total Leave Days Taken Normal") { ApplicationArea = all; Editable = false; }
//                 field("Total Days"; "Total Days") { ApplicationArea = all; Visible = false; }
//                 field("Recalled Days"; "Recalled Days") { ApplicationArea = all; Editable = false; }
//                 // field("Days Absent"; "Days Absent") { ApplicationArea = all; Visible = false; }
//                 // field("Lost Days"; "Lost Days") { ApplicationArea = all; Editable = false; }
//                 field("Leave Balance "; "Leave Balance") { ApplicationArea = all; Editable = false; }
//                 field("Leave Entitlement"; "Leave Entitlement") { ApplicationArea = all; Editable = false; }
//                 field("Total Leave Days Taken"; "Total Leave Days Taken") { ApplicationArea = all; Editable = false; }

//                 field("Balance Brought Forward"; "Balance Brought Forward") { ApplicationArea = all; }
//                 // field(Supervisor; Supervisor) { ApplicationArea = all; }
//                 // field("Supervisor Name"; "Supervisor Name") { ApplicationArea = all; Editable = false; }

//             }
//             group("Current Application Details")
//             {
//                 field("Start Date"; "Start Date") { ApplicationArea = all; Editable = false; }
//                 field("Days Applied"; "Days Applied")
//                 {
//                     ApplicationArea = all;
//                     NotBlank = true;
//                     trigger OnValidate()
//                     begin
//                         IF "Days Applied" > "Leave Balance" then
//                             ERROR('The days applied for are more than your leave balance');
//                     end;
//                 }

//                 field("End Date"; "End Date") { ApplicationArea = all; Editable = false; }
//                 field("Resumption Date"; "Resumption Date") { ApplicationArea = all; Editable = false; NotBlank = true; }
//                 field("Annual Leave Entitlment Bal"; "Annual Leave Entitlment Bal") { ApplicationArea = all; Editable = false; }
//                 field("Reason for Leave"; "Reason for Leave") { ApplicationArea = all; Editable = false; }
//                 field("Duties Taken Over By"; "Duties Taken Over By") { ApplicationArea = all; Editable = false; }
//                 field(Name; Name) { ApplicationArea = all; }
//                 field(Status; Status) { ApplicationArea = all; Editable = false; }
//                 field(Comments; Comments) { ApplicationArea = all; }
//             }
//         }
//         area(FactBoxes)
//         {
//             systempart(links; Links) { Visible = true; }
//             systempart(note; Notes) { Visible = true; }
//         }
//     }

//     actions
//     {

//         area(Processing)
//         {
//             action("Print Leave Application Form")
//             {
//                 ApplicationArea = All;
//                 Image = Aging;
//                 Promoted = true;
//                 PromotedCategory = Report;

//                 trigger OnAction()
//                 begin
//                     leaveapp.RESET;
//                     leaveapp.SETFILTER("Application No", "Application No");
//                     if leaveapp.FINDSET then begin
//                         REPORT.RUN(51300, true, false, leaveapp);
//                     end;
//                 end;
//             }
//             action("Leave Approval")
//             {
//                 ApplicationArea = All;
//                 Image = PostOrder;
//                 Promoted = true;
//                 PromotedCategory = Process;


//                 trigger OnAction()
//                 begin
//                     if (Post = false) then begin

//                         Periods.SetRange(Periods."New Fiscal Year", true);
//                         Periods.SetRange(Periods."Date Locked", true);
//                         Periods.SetRange(Periods.Closed, false);
//                         IF Periods.FindFirst() then
//                             PeriodCode := Periods."Period Code";

//                         HRJournalLine.Init();
//                         HRJournalLine."Document No." := "Application No";
//                         HRJournalLine."Leave Period" := PeriodCode;
//                         HRJournalLine."Employee No." := "Employee No.";
//                         HRJournalLine.Validate(HRJournalLine."Employee No.");
//                         HRJournalLine."Posting Date" := TODAY;
//                         HRJournalLine."Entry Type" := HRJournalLine."Entry Type"::"Negative Adjustment";
//                         HRJournalLine.Description := Comments;
//                         HRJournalLine."Leave Type" := "Leave Code";
//                         HRJournalLine."Leave Period" := "Leave Period";
//                         Message(Format("Leave Period"));
//                         HRJournalLine.Days := -"Days Applied";
//                         HRJournalLine."User ID" := "User ID";
//                         HRJournalLine."Leave Start Date" := "Start Date";
//                         HRJournalLine."Leave End Date" := "End Date";
//                         HRJournalLine.LeaveAppNo := "Application No";
//                         HRJournalLine."Employee Name" := "Employee Name";
//                         HRJournalLine."Document Type" := HRJournalLine."Document Type"::Taken;
//                         HRJournalLine.Insert(true);

//                         EmpLeaves.SetRange(EmpLeaves."Employee No", "Employee No.");
//                         EmpLeaves.SetRange(EmpLeaves."Leave Code", "Leave Code");
//                         IF EmpLeaves.FindFirst() then begin
//                             EmpLeaves.Balance := EmpLeaves.Balance - "Days Applied";
//                             EmpLeaves.Modify();
//                         end;

//                         Message('Posted Succesfully');
//                         Status := Status::Approved;
//                         Post := true;
//                         Modify();
//                     end else
//                         Message('Leave was already posted');
//                 end;
//             }
//             action(Cancel)
//             {
//                 ApplicationArea = All;
//                 Image = Cancel;
//                 Promoted = true;
//                 Ellipsis = true;

//                 trigger OnAction()
//                 begin
//                     Status := Status::Canceled;
//                     Modify();
//                     Message('Leave Cancelled');
//                 end;
//             }
//         }
//     }

//     var
//         date: Date;
//         Mail: Codeunit Mail;
//         body: Text;
//         days: Decimal;
//         LeaveAllowancePaid: Boolean;
//         FiscalStart: Date;
//         FiscalEnd: Date;
//         HRSetup: Record "Human Resources Setup";
//         leaveapp: Record "Leave Application";
//         LeaveLedgerEntry: Record "Leave Ledger Entry";
//         SeeApprovals: Boolean;
//         DimensionValue: Record "Dimension Value";
//         UserSetup: Record "User Setup";
//         SeeSubmit: Boolean;
//         ChooseApprover: Boolean;
//         SeeBypass: Boolean;
//         CancelLeaveReq: Boolean;
//         User: Record "User Setup";
//         smtprec: Record "SMTP Mail Setup";
//         smtpcu: Codeunit "SMTP Mail";
//         bddialog: Dialog;
//         mailheader: Text;
//         mailbody: Text;
//         SMTPMailSetup: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit "SMTP Mail";
//         sendto: Text;
//         A: Text;
//         b: Text;
//         c: Text;
//         Employee: Record Employee;

//         No: Code[20];
//         E: Text;
//         F: Text;
//         HRJournalLine: Record "Leave Ledger Entry";
//         chooseapprover2: Boolean;
//         LeaveTypes: Record "Leave Types";
//         startdate2: Date;
//         noticeperiod: Text;
//         seebalances: Boolean;
//         daysused: Decimal;
//         seeentitlement: Boolean;
//         annualdays: Decimal;
//         bfdays: Decimal;
//         entitleddays: Decimal;
//         balancedays: Decimal;
//         earneddays: Decimal;
//         recalleddays: Decimal;
//         // recall	:Record	employee off	
//         // GLTranManagement:Codeunit GLTranManagement;
//         // NavigatorManagement	:Codeunit NavigatorManagement;	
//         Periods: Record "Leave Periods";
//         PeriodCode: Code[30];
//         EmpLeaves: Record "Employee Leaves";

//         Text19051012: TextConst ENU = 'No. Of days to Apply';
//         Tx0001: TextConst ENU = 'Notification sent';
//         ApprovedStartDate: Date;
//         ApprovedDays: Decimal;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         seebalances := FALSE;
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         if ("Leave Code" = 'ANNUAL') OR ("Leave Code" = 'NORMAL') then begin
//             seebalances := true;
//         end;
//     end;

//     procedure sendrequestapprovalemail(var User: Record "User Setup")
//     var

//         smtprec: Record "SMTP Mail Setup";
//         smtpcu: Codeunit "SMTP Mail";
//         bddialog: Dialog;
//         mailheader: Text;
//         mailbody: Text;
//     begin

//     end;

//     procedure sendapprovalemail(var User: Record "User Setup")
//     var

//         smtprec: Record "SMTP Mail Setup";
//         smtpcu: Codeunit "SMTP Mail";
//         bddialog: Dialog;
//         mailheader: Text;
//         mailbody: Text;
//     begin

//     end;
// }