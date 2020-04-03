codeunit 51215 "Workflow Response Handling Ext"
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; Handled: Boolean)
    var
        LeaveApplication: Record "Leave Application";
    begin
        case RecRef.Number of
            DATABASE::"Leave Application":
                begin
                    Handled := false;
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::New;
                    LeaveApplication.Modify(true);
                    Handled := true;

                end;
        end;
    end;



    //onrelseas

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; Handled: Boolean)
    var
        LeaveApp: Record "Leave Application";
    begin
        case RecRef.Number of
            DATABASE::"Leave Application":
                begin
                    RecRef.SetTable(LeaveApp);
                    LeaveApp.Status := LeaveApp.Status::Approved;
                    LeaveApp.Modify();
                    Handled := true;

                end;
        end;
    end;

    //on aoproval pending
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; variant: Variant; var IsHandled: Boolean)

    var
        LeaveApp: Record "Leave Application";

    begin

        case RecRef.Number of
            DATABASE::"Leave Application":
                begin
                    // isHandled := true;
                    RecRef.SetTable(LeaveApp);
                    // LeaveApp.Validate(Status, LeaveApp.Status::"Approval Pending");
                    LeaveApp.Modify(true);
                    isHandled := true;

                end;


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        workflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandlingCust: Codeunit "Workflow event Handling Ext";
    begin
        case ResponseFunctionName of
            workflowResponseHandling.SetStatusToPendingApprovalCode:
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandlingCust.RunWorkflowOnSendLeaveForApprovalCode);
            workflowResponseHandling.SendApprovalRequestForApprovalCode:
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandlingCust.RunWorkflowOnSendLeaveForApprovalCode);
            workflowResponseHandling.CancelAllApprovalRequestsCode:
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandlingCust.RunWorkflowOnCancelLeaveForApprovalCode);

            workflowResponseHandling.OpenDocumentCode:
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.OpenDocumentCode,
                WorkflowEventHandlingCust.RunWorkflowOnCancelLeaveForApprovalCode);
        end;
    end;



    var
        myInt: Integer;
}