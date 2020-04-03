// report 51209 "StaffOnLeave"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './StaffOnLeave.rdl';

//     dataset
//     {
//         dataitem("Employee Leave Application"; "Leave Application")
//         {
//             DataItemTableView = WHERE(Status = CONST(Approved));
//             RequestFilterFields = "Employee No.", "Leave Code", "Start Date", "End Date", "Directorate Code";
//             column(EmpNo; "Employee Leave Application"."Employee No.")
//             {
//             }
//             column(DaysApplied; "Employee Leave Application"."Days Applied")
//             {
//             }
//             column(StartDate; "Employee Leave Application"."Start Date")
//             {
//             }
//             column(EndDate; "Employee Leave Application"."End Date")
//             {
//             }
//             column(LeaveStatus; "Employee Leave Application"."Leave Status")
//             {
//             }
//             column(Taken; "Employee Leave Application".Taken)
//             {
//             }
//             column(Picture; CompanyInfo.Picture)
//             {
//             }
//             column(EmployeeName; "Employee Leave Application"."Employee Name")
//             {
//             }
//             column(ApprovedDays; "Employee Leave Application"."Approved Days")
//             {
//             }
//             column(ApprovedStartDate; "Employee Leave Application"."Approved Start Date")
//             {
//             }
//             column(ApprovedEndDate; "Employee Leave Application"."Approved End Date")
//             {
//             }
//             column(LeaveCode; "Employee Leave Application"."Leave Code")
//             {
//             }
//             column(DepartmentName; "Employee Leave Application"."Department Name")
//             {
//             }
//             column(JobTitle; "Employee Leave Application"."Job Title")
//             {
//             }
//             column(Name; CompanyInfo.Name)
//             {
//             }
//             column(Address; CompanyInfo.Address)
//             {
//             }
//             column(PostCode; CompanyInfo."Post Code")
//             {
//             }
//             column(City; CompanyInfo.City)
//             {
//             }
//             column(ApplicationDate_EmployeeLeaveApplicationn1; "Employee Leave Application"."Application Date")
//             {
//             }
//             column(serialno; serialno)
//             {
//             }
//             column(ResumptionDate_EmployeeLeaveApplicationn1; "Employee Leave Application"."Resumption Date")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 IF "Employee Leave Application"."Start Date" > TODAY THEN
//                     CurrReport.SKIP;
//                 serialno += 1;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 i := 0;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         CompanyInfo.GET;
//     end;

//     trigger OnPreReport()
//     begin
//         CompanyInfo.CALCFIELDS(Picture);
//         serialno := 0;
//     end;

//     var
//         CompanyInfo: Record "Company Information";
//         i: Integer;
//         serialno: Integer;
// }

