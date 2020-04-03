tableextension 51110 "SourceCodeExt" extends "Source Code"
{
    fields
    {
        field(50100; "Navigator Supported"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50101; "Budget Controls"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50102; "Transaction-Level Approvals"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Transaction-Level Approvals") AND NOT (ApprovalProcessingLine.READPERMISSION) THEN
                    ERROR(SNText004);

                TestField("Navigator Supported", true);
                CheckExistingLineStatus(Code, "Transaction-Level Approvals");
            end;
        }
        field(50103; "Document-Level Approvals"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    var

        ApprovalProcessingLine: Record "Approval Processing Line";

        SNText004: TextConst ENU = 'with Approvals has not been licensed.';

    procedure CheckExistingLineStatus(SourceCode: Code[10]; FlagOn: Boolean)
    var

        GenJnlLine: Record "Gen. Journal Line";
        PurchaseLine: Record "Purchase Line";
        // RequisitionLine:	Record	"Purchase Requisition Line"	
        // PayrollJnlLine	:Record	Payroll Journal Line	
        ItemJnlLine: Record "Item Journal Line";
    // "JobJnlLine:Record	"Job Journal Line";
    begin

    end;

}