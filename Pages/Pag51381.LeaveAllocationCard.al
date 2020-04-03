page 51381 "Leave Allocation Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Allocation";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; "Document Date") { ApplicationArea = all; }
                field("Posting Date"; "Posting Date") { ApplicationArea = all; }
                field("Time Posted"; "Time Posted") { ApplicationArea = all; }
                field("Date Posted"; "Date Posted") { ApplicationArea = all; }
                field("User ID"; "User ID") { ApplicationArea = all; }
                field(Status; Status) { ApplicationArea = all; }
                field("Leave Type"; "Leave Type") { ApplicationArea = all; }
                field("Leave Period"; "Leave Period") { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
            }
            part("Leave Allocation Subform"; "Leave Allocation Subform")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Leave Allocation")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF HRLeavemanagement.PostLeaveAllocation("No.") then
                        Message('leave allocation posted');
                end;
            }
            action("Send for Approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin

                end;
            }

        }
    }

    var
        HRLeavemanagement: Codeunit "HR Leave management";
}