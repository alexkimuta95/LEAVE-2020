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
        CashMgtSetup: Record "Cash Management Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        Vendor: Record Vendor;
        UsetSetup: Record "User Setup";
        PaymentLine: Record "Payment Line";
        test: Code[20];
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Lines: Record "Payment Line";
        DimMgt: Codeunit DimensionManagement;
        Options: Record "Purchases & Payables Setup";
        PVHeader: Record "Payment Header";
        Text022: Label 'Do you want to update the exchange rate?';
        DeleteError: Label 'Pay Voucher %1 has been submitted for approval thus cannot be deleted.  Cancel approval request and then retry pay voucher deletion';

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

    procedure AssistEdit(OldPayHeader: Record "Payment Header"): Boolean
    begin
    end;

    procedure PaymentLinesExist(Payheader: Record "Payment Header"): Boolean
    var
        Payheader2: Record "Payment Header";
    begin
        WITH Payheader2 DO BEGIN
            SETRANGE("No.", Payheader."No.");



            IF FINDFIRST THEN BEGIN
                PaymentLine.RESET;
                PaymentLine.SETRANGE("Document No", "No.");
                PaymentLine.SETRANGE(PaymentLine."Invoice To Pay", TRUE);
                IF FINDFIRST THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE); //This line has a bug for some reason!
            END;
        END;
    end;

    local procedure UpdateCurrency()
    begin
        IF "Currency Code" <> '' THEN BEGIN
            IF "Posting Date" <> 0D THEN
                CurrencyDate := "Posting Date"
            ELSE
                CurrencyDate := WORKDATE;

            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        END ELSE
            "Currency Factor" := 0;
    end;

    LOCAL procedure ConfirmUpdateCurrencyFactor()
    begin
        IF HideValidationDialog THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(Text022, FALSE);
        IF Confirmed THEN
            VALIDATE("Currency Factor")
        ELSE
            "Currency Factor" := xRec."Currency Factor";
    end;

    procedure SelectAll(VAR Header: Record "Payment Header")
    begin
        WITH Lines DO BEGIN
            RESET;
            SETFILTER("Document No", '%1', Header."No.");
            IF Lines.FINDSET THEN Lines.MODIFYALL("Invoice To Pay", TRUE);
        END;
    end;

    procedure UnSelectAll(VAR Header: Record "Payment Header")
    begin
        WITH Lines DO BEGIN
            RESET;
            SETFILTER("Document No", '%1', Header."No.");
            IF Lines.FINDSET THEN Lines.MODIFYALL("Invoice To Pay", FALSE);
        END;
    end;

}