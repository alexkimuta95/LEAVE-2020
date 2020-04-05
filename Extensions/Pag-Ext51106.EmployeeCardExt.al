pageextension 51106 "EmployeeCardExt" extends "Employee Card"
{
    layout
    {
        addlast(General)
        {


            field("Department Code"; "Department Code") { ApplicationArea = all; }
            field("Department Name"; "Department Name") { ApplicationArea = all; }
            field("NSSF No."; "NSSF No.") { ApplicationArea = all; }
            field("NHIF No"; "NHIF No") { ApplicationArea = all; }
            field("HR Leave Calender"; "HR Leave Calender") { ApplicationArea = all; }
            field("Payroll Posting Group"; "Payroll Posting Group") { ApplicationArea = all; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}