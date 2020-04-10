table 50064 "Payment Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Payment Header"."No.";

        }
        field(2; "Line No"; Code[20])
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(5; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else
            if ("Account Type" = const(Vendor)) Vendor;

        }
        field(6; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; " Cheque No."; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Amount To Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Actual To Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Payment Method"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
        field(12; "Invoice To Pay"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Applies-to Doc. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            Editable = false;
        }
        field(14; "Applies-to Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Applies-to Doc. Type" = const("Credit Memo")) "Purch. Cr. Memo Hdr."."No.";
        }
        field(15; Posted; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "VAT Business Posting Group";

        }
        field(18; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(19; "Vendor Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Invoice Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50000; "WTAX Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";

        }
        field(50001; "WTAX Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(50002; "WTax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50004; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50005; "Credit Card Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Charge" where("Charge Type" = filter("Credit Card"));
        }
        field(50006; "Service Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Charge" where("Charge Type" = filter("Service Charge"));


        }
        field(50007; "Credit Card Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50008; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved,Committed,,,,,Fulfilled,Canceled;
        }
        field(50009; "Purchaser Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50010; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50011; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50012; "Amount To Pay (Excl. VAT)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50013; "Amount Paid (Excl. VAT)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Service Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50015; "Charge VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50016; "Payment Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Charge";
        }
        field(50017; "WithHold VAT"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50018; "WithHold VAT Amount"; decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50019; "Line Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50020; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50021; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50022; "Dimension Set ID"; integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Set Entry";

        }
        field(50023; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Document date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }



    }

    keys
    {
        key(PK; "Document No", "Line No")
        {
            Clustered = true;
        }
        key(key1; "Invoice To Pay")
        {
            SumIndexFields = "Line Amount";
        }
    }



    var
        PaymentHeader: Record "Payment Header";
        GLSetupRead: Boolean;
        CurrencyCode: Code[20];
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentLine: Record "Payment Line";
        HeaderAmount: Decimal;
        PaySetup: Record "Purchases & Payables Setup";
        DimMgt: Codeunit DimensionManagement;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Err10000: Label 'VAT can only be specified for GL Expense entires only';
        Text002: Label 'be specified without %1';
        Text50000: Label 'You cannot delete posted entries.';
        errmissingServiceAccount: Label 'Missing service account, please set the below under payment charges page to continue.';
        errmissingVATSalesAccount: Label 'Missing VAT Sales account, please set the below under VAT Posting Setup page to continue.';

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