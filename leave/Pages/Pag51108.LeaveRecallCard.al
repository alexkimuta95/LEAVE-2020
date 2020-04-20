page 51108 "Leave Recall Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 51103;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field("Recall Date"; "Recall Date") { ApplicationArea = All; }
                field("Employee No"; "Employee No") { ApplicationArea = All; }
                field("Employee Name"; "Employee Name") { ApplicationArea = All; }
                field("Leave Application"; "Leave Application") { ApplicationArea = All; }
                field("Leave Start Date"; "Leave Start Date") { ApplicationArea = All; }
                field("Days Applied"; "Days Applied") { ApplicationArea = All; }
                field("Leave ending Date"; "Leave ending Date") { ApplicationArea = All; }
                // field("Employee Department"; "Employee Department") { ApplicationArea = All; }
                // field("Employee Job Title"; "Employee Job Title") { ApplicationArea = All; }
                // field("No. of Off Days"; "No. of Off Days") { ApplicationArea = All; }
                field("Recalled From"; "Recalled From") { ApplicationArea = All; }
                field("Recalled To"; "Recalled To") { ApplicationArea = All; }
                field(recalldays; recalldays)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        recalldays := "Leave Ending Date" - "Leave Start Date";
                    end;
                }
                field("Recalled By"; "Recalled By") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                // field("Recalled Department"; "Recalled Department") { ApplicationArea = All; }
                field("Job Title"; "Job Title") { ApplicationArea = All; }
                // field("Head of Department"; "Head of Department") { ApplicationArea = All; }
                field("Reason for Recall"; "Reason for Recall") { ApplicationArea = All; }
            }
        }
        area(Factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = all;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Recall)
            {
                ApplicationArea = All;
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to recall this employee from leave?') then begin
                        TestField("Leave Application");
                        TestField("Employee No");
                        TestField(Name);
                        TestField("Leave ending Date");
                        TestField("Recalled From");
                        TestField("Recalled To");
                        TestField("Recalled By");
                        TestField("Reason for Recall");
                        TestField("Recall Date");

                        Periods.SetRange(Periods."New Fiscal Year", true);
                        Periods.SetRange(Periods."Date Locked", true);
                        Periods.SetRange(Periods.Closed, false);
                        if Periods.FindFirst() then
                            PeriodCode := Periods."Period Code";

                        //Posting
                        HRJournalLine.Init();
                        HRJournalLine."Document No." := "No.";
                        HRJournalLine."Leave Period" := Format(DATE2DMY(Today, 3));
                        ;
                        HRJournalLine."Employee No." := "Employee No";
                        HRJournalLine.Validate(HRJournalLine."Employee No.");
                        HRJournalLine."Posting Date" := Today;
                        HRJournalLine."Entry Type" := HRJournalLine."Entry Type"::"Positive Adjustment";
                        HRJournalLine.Description := "Reason for Recall";
                        HRJournalLine."Leave Type" := "Leave Code";
                        HRJournalLine.Days := "No. of Off Days";
                        HRJournalLine."User ID" := USERID;
                        HRJournalLine."Recall" := true;
                        HRJournalLine.LeaveAppNo := "Leave Application";
                        HRJournalLine."Leave Period" := PeriodCode;
                        HRJournalLine.Insert(true);

                        EmpLeaves.SetRange(EmpLeaves."Employee No", "Employee No");
                        EmpLeaves.SetRange(EmpLeaves."Leave Code", "Leave Code");
                        if EmpLeaves.FindFirst() then begin
                            EmpLeaves.Balance := EmpLeaves.Balance + "No. of Off Days";
                            EmpLeaves.Modify();
                        end;
                    end;

                    UserSetup.SetRange("HR Administrator", true);
                    if UserSetup.FindFirst() then
                        OfficeEmail := UserSetup."E-Mail";
                    SMTPSetup.Get();

                    // SMTP.AppendBody('Dear Sir / Madam,');
                    // SMTP.AppendBody('<br><br>');
                    // SMTP.AppendBody(('The Employee.') + "Employee Name" + 'Has been recalled from Leave');
                    // SMTP.AppendBody('<br><Br>');
                    // SMTP.AppendBody('Regards,');
                    // SMTP.AppendBody('<br><br>');
                    // SMTP.AppendBody('<HR>');
                    // SMTP.AppendBody('This is a system generated mail. Please do not reply to this email ID.');
                    // SMTP.Send;


                    Message(TX0001, "Employee Name");
                    Delete();

                end;

            }
        }
    }

    var

        d: Date;
        Mail: Codeunit Mail;
        EmployeeRec: Record Employee;
        email: Text;
        UserSetup: Record "User Setup";
        OfficeEmail: Text;
        Requester: Text;
        hod: Text;
        CompInfo: Record "Company Information";
        SMTP: Codeunit "SMTP Mail";
        SenderAddress: Text;
        Users: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        link: Text;
        HRSetup: Record "Human Resources Setup";
        maiheader: Text;
        mailbody: Text;
        HRJournalLine: Record "Leave Ledger Entry";
        Periods: Record "Leave Periods";
        PeriodCode: Code[20];
        recalldays: Decimal;
        EmpLeaves: Record "Employee Leaves";
        SMTPSetup: Record "SMTP Mail Setup";
        TX0001: TextConst ENU = 'Employee %1 successfully recalled';
}