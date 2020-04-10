codeunit 51200 "Approvals Mgt. Ext"
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveForApproval(var LeaveApp: Record "Leave Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveForApproval(var LeaveApp: Record "Leave Application")
    begin
    end;

    procedure CheckLeaveApprovalsWorkflowEnabled(var LeaveApp: Record "Leave Application"): Boolean
    begin
        if not IsLeaveDocApprovalWorkflowEnable(LeaveApp) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveDocApprovalWorkflowEnable(var Leave: Record "Leave Application"): Boolean
    begin
        if Leave.Status <> Leave.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Leave, WorkflowEventHandling.RunWorkflowOnSendLeaveForApprovalCode))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        LeaveApp: Record "Leave Application";
    begin
        case RecRef.Number of
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveApp);
                    ApprovalEntryArgument."Document No." := LeaveApp."Application No";
                    // ApprovalEntryArgument.Amount := LeaveApp.Days;

                end;
        end;
    end;

    //set status to aproval pending
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(var Variant: Variant)
    var
        LeaveApp: Record "Leave Application";
        RecRef: RecordRef;
        IsHandled: Boolean;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Leave Application":
                begin
                    RecRef.SetTable(LeaveApp);
                    LeaveApp.Validate(Status, LeaveApp.Status::"Approval Pending");
                    LeaveApp.Modify(true);
                    Variant := LeaveApp;
                end;
        end;
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record is enabled';
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext";

}