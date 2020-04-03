pageextension 51106 "EmployeeCardExt" extends "Employee Card"
{
    layout
    {
        addlast(General)
        {

            // field("HOD Name"; "HOD Name") { ApplicationArea = all; }
            field("Department Code"; "Department Code") { ApplicationArea = all; }
            field("Department Name"; "Department Name") { ApplicationArea = all; }
            field("Annual Leave Balance"; "Annual Leave Balance") { ApplicationArea = all; }
            field("HR Leave Calender"; "HR Leave Calender") { ApplicationArea = all; }
            field("Payroll Posting Group"; "Payroll Posting Group") { ApplicationArea = all; }
            // field("User ID"; "User ID") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}