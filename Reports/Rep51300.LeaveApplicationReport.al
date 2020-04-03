// report 51300 "Leave Application Report"
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     DefaultLayout = Word;

//     WordLayout = 'LeaveApplication.docx';

//     dataset
//     {
//         dataitem("Leave Application"; "Leave Application")
//         {
//             column(Application_No; "Application No")
//             {

//             }
//             column(Employee_No_; "Employee No.") { }
//             column(Application_Date; "Application Date") { }
//             column(Employee_Name; "Employee Name") { }
//             column(Mobile_No; "Mobile No") { }
//             column(Employment_Date; "Employment Date") { }
//             column(Leave_Code; "Leave Code") { }

//             column(Leave_Entitlement; "Leave Entitlement") { }
//             column(Annual_Leave_Entitlment_Bal; "Annual Leave Entitlment Bal") { }
//             column(Start_Date; "Start Date") { }
//             column(Days_Applied; "Days Applied") { }
//             column(End_Date; "End Date") { }
//             column(Resumption_Date; "Resumption Date") { }
//             column(Status; Status) { }

//         }
//     }


//     // requestpage
//     // {
//     //     layout
//     //     {
//     //         area(Content)
//     //         {
//     //             group(GroupName)
//     //             {
//     //                 field()
//     //                 {
//     //                     ApplicationArea = All;

//     //                 }
//     //             }
//     //         }
//     //     }

//     //     actions
//     //     {
//     //         area(processing)
//     //         {
//     //             action(ActionName)
//     //             {
//     //                 ApplicationArea = All;

//     //             }
//     //         }
//     //     }
//     // }

//     var
//         myInt: Integer;
// }