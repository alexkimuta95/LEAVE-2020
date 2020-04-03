codeunit 51201 "Workflow Event Handling Ext"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of

            RunWorkflowOnCancelLeaveForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelLeaveForApprovalCode, RunWorkflowOnSendLeaveForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveForApprovalCode);

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveForApprovalCode, 51000,
        LeaveSendforApprovalEventDescTxt, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveForApprovalCode, 51000,
      LeaveCancelforApprovalEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgt. Ext", 'OnCancelLeaveForApproval', '', true, true)]
    procedure RunWorkflowOnCancelLeaveForApproval(var LeaveApp: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveForApprovalCode, LeaveApp);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgt. Ext", 'OnSendLeaveForApproval', '', true, true)]
    procedure RunWorkflowOnSendLeaveForApproval(var LeaveApp: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveForApprovalCode, LeaveApp);
    end;


    procedure RunWorkflowOnSendLeaveForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveForApproval'));
    end;

    //cancel
    procedure RunWorkflowOnCancelLeaveForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveForApproval'));
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        LeaveSendforApprovalEventDescTxt: TextConst ENU = 'Approval of the leave document is requested';
        LeaveCancelforApprovalEventDescTxt: TextConst ENU = 'Approval of the leave document is cancel';
}