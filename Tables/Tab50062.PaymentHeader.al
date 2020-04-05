table 50062 "Payment Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

        }
        field(3; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Vendor;
        }
        field(5; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const(Vendor)) Vendor;

        }
        field(6; Payee; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(11; Posted; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Total to Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Payment Method"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(18; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Total on Document"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50000; "Total VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(50001; " Total Withholding Tax Amount"; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Total Payment Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(50004; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(50005; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50006; "Total WTax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50007; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",GLJournal,"Item Journal","Phys. Inventory Journal",FAJournal,"Petty Cash",Advance,IOU,"User (Store) Requisition","Store Manifest","Non-Conforming Products","Cooler Allocation","FA Reclass. Journal","Purchase Requisition",TransferOrder,QAQC,Jobs,Payment;

        }
        field(50008; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,"Pending Approval","Pending Action",Approved,Rejected,Cancelled;
        }
        field(50009; "Purchaser Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50010; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50011; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50012; "Vendor Account Name"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(50013; "Vendor Bank name"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(50014; "Vendor Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50015; "Vendor Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50016; "Vendor Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50017; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }




    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}