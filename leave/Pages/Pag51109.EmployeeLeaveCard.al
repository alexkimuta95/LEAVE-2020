page 51109 "Employee Leave Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 51000;
    Editable = true;

    layout
    {
        area(Content)
        {
            group("Employee Details")
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        GetNames();
                    end;
                }
                field(Names; Names) { ApplicationArea = all; }
                field("Verified by Manager"; "Verified by Manager") { ApplicationArea = all; }
                field("Date of Verification"; "Verification Date") { ApplicationArea = all; Editable = false; }
                field(Status; Status) { ApplicationArea = all; Editable = false; }
                field(Taken; Taken) { ApplicationArea = all; }

            }
            group("Application Details")
            {
                field("Leave Period"; "Leave Period") { ApplicationArea = all; Editable = false; }
                field("Application No"; "Application No") { ApplicationArea = all; }

                field("Leave Code"; "Leave Code") { ApplicationArea = all; }
                field("Start Date"; "Start Date") { ApplicationArea = all; }

                field("Days Applied"; "Days Applied") { ApplicationArea = all; }

                field("End Date"; "End Date") { ApplicationArea = all; }
                field("Resumption Date"; "Resumption Date") { ApplicationArea = all; }
                field("Application Date"; "Approval Date") { ApplicationArea = all; }
                field(Comments; Comments) { ApplicationArea = all; }
                field("Accrued Days"; "Accrued Days") { ApplicationArea = all; }

            }
            group("Approval Details")
            {
                field("User ID"; "User ID") { ApplicationArea = all; }
                field("Approved Days"; "Approved Days")
                {
                    ApplicationArea = all;
                }
                field("Approved Start Date"; "Approved Start Date") { ApplicationArea = all; Editable = false; }
                field("Approved End Date"; "Approved End Date") { ApplicationArea = all; }
                field("Approved Resumption Date"; "Resumption Date") { ApplicationArea = all; Editable = false; NotBlank = true; }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(FactBoxes)
        {
            part("Employee Leave Factbox"; "Employee Leave Factbox")
            {
                SubPageLink = "Employee No" = field("Employee No."), "Leave Code" = field("Leave Code");
            }
            systempart(Links; Links) { ApplicationArea = all; }
            systempart(Notes; Notes) { ApplicationArea = all; }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print Leave Application Form")
            {
                ApplicationArea = All;
                Image = Aging;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    // leaveapp.Reset();
                    // leaveapp.SetFilter("Application No", "Application No");
                    // if leaveapp.FindSet() then begin
                    //     Report.Run(51300, true, false, leaveapp);
                end;

            }
            action("Send for Approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if ApprovalsMgtCustom.CheckLeaveApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgtCustom.OnSendLeaveForApproval(Rec);

                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = All;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin

                end;
            }
            Action(View)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovalEntrys: Record "Approval Entry";
                    DocType: Integer;
                    DocNo: Code[20];
                begin
                    ApprovalEntrys.RESET;
                    CASE DocType OF
                        0:
                            ApprovalEntrys.SETFILTER(ApprovalEntrys."Table ID", '%1', DATABASE::"Leave Application");
                    END;
                    ApprovalEntrys.SETFILTER(ApprovalEntrys."Document Type", '%1', DocType);
                    ApprovalEntrys.SETFILTER(ApprovalEntrys."Document No.", DocNo);
                    // IF ApprovalEntrys.FINDSET THEN
                    //     ApprovRecPage.SETTABLEVIEW(ApprovalEntrys);
                    // ApprovalEntrys.RESET;
                    // ApprovRecPage.RUNMODAL;
                end;
            }



        }

    }


    trigger OnOpenPage()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Employees.RESET;
        Employees.SETRANGE(Employees."User ID", USERID);
        IF Employees.FINDFIRST THEN BEGIN
            Rec.VALIDATE(Rec."Employee No.", Employees."No.");
            GetApplicationNo;
            GetNames;
        END ELSE
            ERROR(Err100);

    end;

    trigger OnAfterGetRecord()
    begin
        IF "User ID" = USERID THEN ISOWNER := TRUE;
        GetNames();
    end;

    local procedure GetNames()
    begin
        Employees.GET("Employee No.");
        Names := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
    end;

    procedure FilterToEmployee()
    begin
        SETFILTER("User ID", '%1', USERID);

    end;

    var

        Employees: Record Employee;
        Names: Text;
        LeaveManager: Codeunit "Leave Manager";
        ISOWNER: Boolean;
        Err100: label 'The current user has not been associated with an Employee profile, contact your system admin for assistance';
        ApprovalsMgtCustom: Codeunit "Approvals Mgt. Ext";


}