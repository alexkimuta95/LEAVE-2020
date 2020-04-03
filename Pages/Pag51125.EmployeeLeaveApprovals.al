// page 51125 "Employee Leave Approvals"
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = 51000;
//     Editable = false;
//     CardPageId = 51124;
//     SourceTableView = sorting("Application No") order(descending) where(Status = filter("Approval Pending"));

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field(Status; Status) { ApplicationArea = all; }
//                 field("Application No"; "Application No") { ApplicationArea = all; }
//                 field("Employee No"; "Employee No.") { ApplicationArea = all; }
//                 field("Employee Name"; "Employee Name") { ApplicationArea = all; }
//                 field("Department Code"; "Department Code") { ApplicationArea = all; }
//                 field("Department Name"; "Department Name") { ApplicationArea = all; }
//                 field("Job Title"; "Job Title") { ApplicationArea = all; }
//                 field("Leave Code"; "Leave Code") { ApplicationArea = all; }
//                 field("Application Date"; "Application Date") { ApplicationArea = all; }
//                 field("Start Date"; "Start Date") { ApplicationArea = all; }
//                 field("End Date"; "End Date") { ApplicationArea = all; }
//                 field("Days Applied"; "Days Applied") { ApplicationArea = all; }
//                 // field(Supervisor; Supervisor) { ApplicationArea = all; }


//             }
//         }
//         area(Factboxes)
//         {
//             systempart(Links; Links)
//             {
//                 ApplicationArea = all;
//             }
//             systempart(Notes; Notes)
//             {
//                 ApplicationArea = all;
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
// }