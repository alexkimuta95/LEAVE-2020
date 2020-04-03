report 51211 "Leave Recall List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Leave Recall List.rdl';

    dataset
    {
        dataitem("<Leave Recall>"; "Employee Off/Holidays")
        {
            DataItemTableView = WHERE("Employee No" = FILTER(<> ''),
                                      "Reason for Recall" = FILTER(<> ''));
            RequestFilterFields = "Employee No", "Recall Date", "No. of Off Days", "Branch Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PAGENO)
            // {
            // }
            column(USERID; USERID)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Leave_Recall___Employee_No_; "Employee No")
            {
            }
            column(Leave_Recall___Employee_Name_; "Employee Name")
            {
            }
            column(Leave_Recall___Recall_Date_; "Recall Date")
            {
            }
            column(Leave_Recall___Recalled_By_; "Recalled By")
            {
            }
            column(Leave_Recall___Reason_for_Recall_; "Reason for Recall")
            {
            }
            column(Leave_Recall___Recalled_From_; "Recalled From")
            {
            }
            column(Leave_Recall___Recalled_To_; "Recalled To")
            {
            }
            column(Leave_Recall___Department_Name_; "Department Name")
            {
            }
            column(Leave_Recall___Head_Of_Department_; "Head Of Department")
            {
            }
            column(Employee_Off_HolidaysCaption; Employee_Off_HolidaysCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Leave_Recall___Employee_No_Caption; FIELDCAPTION("Employee No"))
            {
            }
            column(Leave_Recall___Employee_Name_Caption; FIELDCAPTION("Employee Name"))
            {
            }
            column(Leave_Recall___Recall_Date_Caption; FIELDCAPTION("Recall Date"))
            {
            }
            column(Leave_Recall___Recalled_By_Caption; FIELDCAPTION("Recalled By"))
            {
            }
            column(Leave_Recall___Reason_for_Recall_Caption; FIELDCAPTION("Reason for Recall"))
            {
            }
            column(Leave_Recall___Recalled_From_Caption; FIELDCAPTION("Recalled From"))
            {
            }
            column(Leave_Recall___Recalled_To_Caption; FIELDCAPTION("Recalled To"))
            {
            }
            column(Leave_Recall___Department_Name_Caption; FIELDCAPTION("Department Name"))
            {
            }
            column(Leave_Recall___Head_Of_Department_Caption; FIELDCAPTION("Head Of Department"))
            {
            }
            column(Leave_Recall__No_; "No.")
            {
            }
            column(EmployeeDepartment_LeaveRecall; "<Leave Recall>"."Employee Department")
            {
            }
            column(EmployeeBranch_LeaveRecall; "<Leave Recall>"."Employee Branch")
            {
            }
            column(LeaveStartDate_LeaveRecall; "<Leave Recall>"."Leave Start Date")
            {
            }
            column(DaysApplied_LeaveRecall; "<Leave Recall>"."Days Applied")
            {
            }
            column(RecallDepartment_LeaveRecall; "<Leave Recall>"."Recalled Department")
            {
            }
            column(RecallBranch_LeaveRecall; "<Leave Recall>"."Recalled Branch")
            {
            }
            column(EmployeeJobTitle_LeaveRecall; "<Leave Recall>"."Employee Job Title")
            {
            }
            column(JobTitle_LeaveRecall; "<Leave Recall>"."Job Title")
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(Address_CompanyInformation; CompanyInformation.Address)
            {
            }
            column(PostCode_CompanyInformation; CompanyInformation."Post Code")
            {
            }
            column(City_CompanyInformation; CompanyInformation.City)
            {
            }
            column(Pic_CompanyInformation; CompanyInformation.Picture)
            {
            }
            column(Name_LeaveRecall; "<Leave Recall>".Name)
            {
            }
            column(NoofOffDays_LeaveRecall; "<Leave Recall>"."No. of Off Days")
            {
            }
            column(serialno; serialno)
            {
            }

            trigger OnAfterGetRecord()
            begin
                serialno += 1;
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.RESET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
    end;

    trigger OnPreReport()
    begin
        serialno := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        Employee_Off_HolidaysCaptionLbl: Label 'Employee Off/Holidays';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CompanyInformation: Record "Company Information";
        serialno: Integer;
}

