// page 51123 "Posted Leave Applications"
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = 51000;
//     Editable = false;
//     // CardPageId = 51101;
//     SourceTableView = sorting("Application No") order(descending) where(Status = filter(Approved), Post = filter(true));
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field(Status; Status) { ApplicationArea = All; }
//                 field("Application No"; "Application No") { ApplicationArea = All; }
//                 field("Employee No."; "Employee No.") { ApplicationArea = All; }
//                 field("Employee Name"; "Employee Name") { ApplicationArea = All; }
//                 field("Department Name"; "Department Name") { ApplicationArea = All; }
//                 field("Job Title"; "Job Title") { ApplicationArea = All; }
//                 field("Leave Code"; "Leave Code") { ApplicationArea = All; }
//                 field("Approval Date"; "Approval Date") { ApplicationArea = All; }
//                 field("Start Date"; "Start Date") { ApplicationArea = All; }
//                 field("End Date"; "End Date") { ApplicationArea = All; }
//                 field("Days Applied"; "Days Applied") { ApplicationArea = All; }

//             }
//         }
//         area(Factboxes)
//         {
//             systempart(Link; Links)
//             {
//                 Visible = true;
//             }
//             systempart(Note; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
//     var

//         FirstApprover: Code[20];
//         FirstApproverDate: Date;
//         SecondApprover: Code[30];
//         SecondApproverDate: Date;
//         ApprovalEntries: Record "Approval Entry";
//         i: Integer;
//         ThirdApprover: Code[20];
//         ThirdApproverDate: Date;

//     trigger OnAfterGetCurrRecord()
//     begin
//         if Status = Status::"Approval Pending" then begin
//             ApprovalEntries.RESET;
//             ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", "Application No");
//             ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
//             if ApprovalEntries.FIND('-') then begin
//                 i := 0;
//                 repeat
//                     i := i + 1;
//                     if i = 1 then begin
//                         FirstApprover := ApprovalEntries."Approver ID";
//                         FirstApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
//                     end;

//                     if i = 2 then begin
//                         SecondApprover := ApprovalEntries."Approver ID";
//                         SecondApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
//                     end;

//                     if i = 3 then begin
//                         ThirdApprover := ApprovalEntries."Approver ID";
//                         ThirdApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
//                     end;

//                 until ApprovalEntries.NEXT = 0;
//             end;
//         end;
//     end;
// }