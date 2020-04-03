report 50000 "Employee Summary"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'summary.rdl';


    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", SystemId, Status;
            column(SystemId; SystemId)
            {

            }
            column(First_Name; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name") { }
            column(Unit; Unit) { }
            column(Job_Title; "Job Title") { }
            column(Extension; Extension) { }
            column(Company_E_Mail; "Company E-Mail") { }
            column(Address; Address) { }
            column(Mobile_Phone_No_; "Mobile Phone No.") { }
            column(Gender; Gender) { }
            column(Employment_Date; format("Employment Date")) { }
            column(Emplymt__Contract_Code; "Emplymt. Contract Code") { }
            column(Status; Status) { }
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address_2; CompanyInfo.Address)
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Picture; companyinfo.Picture) { }

            column(serialno; serialno)
            {
            }
            trigger OnAfterGetRecord()
            begin

                serialno += 1;
            end;

        }
    }



    var
        CompanyInfo: Record "Company Information";
        serialno: Integer;
}