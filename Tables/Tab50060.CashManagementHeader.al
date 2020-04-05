table 50060 "Cash Management Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;

        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";

        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,"Pending Approval",Approved;
            Editable = false;
        }
        field(7; Select; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(8; Description; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Received From"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "On Behalf Of"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(11; "Entered By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(12; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Editable = false;
        }
        field(13; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else
            if ("Account Type" = const(Customer)) Customer else
            if ("Account Type" = const(Vendor)) Vendor else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset" else
            if ("Account Type" = const("IC Partner")) "IC Partner" else
            if ("Account Type" = filter("Bank Account"), "Document Type" = filter("Petty Cash")) "Bank Account"."No." where("Petty Cash" = filter(true));
            trigger OnValidate()
            begin
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAcc.Get("Account No.") then
                                "Account Name" := GLAcc.Name;
                            "Gen. Posting Type" := 0;
                        end;
                    "Account Type"::Customer:
                        begin
                            if Cust.Get("Account No.") then
                                "Account Name" := Cust.Name;
                            "Gen. Posting Type" := 0;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            if BankAcc.Get("Account No.") then
                                if "Document Type" = "Document Type"::"Petty Cash" then begin

                                    BankAcc.TestField(BankAcc."Petty Cash Replenishment");
                                    NoSeriesMgt.InitSeries(BankAcc."Petty Cash Replenishment", xRec."No. Series", 0D, No, "No. Series");
                                end;
                            "Account Name" := BankAcc.Name;
                            "Gen. Posting Type" := 0;

                        end;
                end;
            end;
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

        }
        field(15; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(16; Posted; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Date Posted"; date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(18; "Time Posted"; time)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(19; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";

        }
        field(20; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ConverttoWords.InitTextVariable();
                // ConverttoWords.FormatNoText(AmountinWords, Amount, '');
                "Amount in Words" := AmountinWords[1];
                "Original Amount" := Amount;
            end;

        }
        field(21; "User Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Transaction Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(23; "VAT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(25; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(26; "Withholding Tax Amount"; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(27; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Paying Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Paying Account Type" = const("G/L Account")) "G/L Account" else
            if ("Paying Account Type" = const(Customer)) Customer else
            if ("Paying Account Type" = const(Vendor)) Vendor else
            if ("Paying Account Type" = const("Bank Account")) "Bank Account" else
            if ("Paying Account Type" = const("Fixed Asset")) "Fixed Asset" else
            if ("Paying Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                CASE "Paying Account Type" OF
                    "Paying Account Type"::"G/L Account":
                        BEGIN
                            IF GLAcc.GET("Paying Bank Account") THEN
                                Name := GLAcc.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            IF Cust.GET("Paying Bank Account") THEN
                                Name := Cust.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                    "Account Type"::"Bank Account":
                        BEGIN
                            IF BankAcc.GET("Paying Bank Account") THEN
                                Name := BankAcc.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                END;

            end;

        }
        field(29; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                Employees.Get(Payee);
                Employees.TestField(Employees."NSSF No.");
                "Customer Code" := Employees."NSSF No.";
                Modify();
            end;

        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");

            end;

        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = filter(Standard));
            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");

            end;
        }
        field(32; "Original Amount"; decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Amount in Words"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Petty Cash Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Paying Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            if ("Paying Account Type" = CONST(Customer)) Customer ELSE
            if ("Paying Account Type" = CONST(Vendor)) Vendor ELSE
            if ("Paying Account Type" = CONST("Bank Account")) "Bank Account"."No." WHERE("Petty Cash" = CONST(true)) ELSE
            if ("Paying Account Type" = CONST("Fixed Asset")) "Fixed Asset" ELSE
            if ("Paying Account Type" = CONST("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                CASE "Paying Account Type" OF
                    "Paying Account Type"::"G/L Account":
                        BEGIN
                            IF GLAcc.GET("Petty Cash Account") THEN
                                Name := GLAcc.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            IF Cust.GET("Petty Cash Account") THEN
                                Name := Cust.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                    "Account Type"::"Bank Account":
                        BEGIN
                            IF BankAcc.GET("Petty Cash Account") THEN
                                Name := BankAcc.Name;
                            "Bal. Gen. Posting Type" := 0;
                        END;
                END;
            end;

        }
        field(35; "Paying Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(36; "G/L Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // CheckGLAcc("G/L Bank Account No.");

            end;

        }
        field(37; Grouping; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(38; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Petty Cash",Advance,IOU,Receipt,Leave,Training;
        }
        field(39; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Petty Cash","Business Advance","I Owe You";
        }
        field(40; "PV Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Petty Cash","Business Advance","I Owe You";
        }
        field(41; "Apply To"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Ledger Entry"."Vendor No." where("Vendor No." = field("Account No."));

        }
        field(42; "Apply To ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(43; "Accounted for Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(44; "Accounted For"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(45; "Account for Doc. No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(46; "Amount to Pay"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Cash Management Line"."Actual Amount Spent" where("Document Type" = field("Document Type"), No = field(No), Posted = const(false)));
            Editable = false;

        }
        field(47; "Amount to Pay Posted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Cash Management Line"."Actual Amount Spent" where("Document Type" = field("Document Type"), No = field(No), Posted = const(true)));
            Editable = false;

        }
        field(48; "Amount LCY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Cash Management Line"."Amount in LCY" where("Document Type" = field("Document Type"), No = field(No), Posted = const(false)));
            Editable = false;

        }
        field(49; "Amount Accounted For"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50; Balance; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(51; "Balance Less this Entry"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(52; "Applicant Designation"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(53; "Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(54; "Finance Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(55; Name; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(56; Allocated; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(57; "Date Allocated"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(58; "Time Allocated"; Time)
        {
            DataClassification = ToBeClassified;

        }
        field(59; "Allocated By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(60; "Date Accounted For"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(61; "Time Accounted For"; Time)
        {
            DataClassification = ToBeClassified;

        }
        field(62; "Accounted For By"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(63; "Exists Lines"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(64; "Gen. Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Purchase,Sale,Settlement;
        }
        field(66; "Replenish Petty Cash(Optional)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cash Management Header" where("Document Type" = filter("Petty Cash"), "Accounted For" = const(false), Posted = const(true), Allocated = const(false));

        }
        field(67; "Amount Accounted For LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(68; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Set Entry";

            trigger OnValidate()
            begin
                // ShowDocDim;

            end;

        }
        field(69; Replenishment; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(70; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer;

        }
        field(71; Disbursed; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50000; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "Imprest UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(50004; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");

            end;

        }
        field(50005; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

            end;

        }
        field(50006; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");

            end;

        }
        field(50007; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(6,"Shortcut Dimension 6 Code");

            end;

        }
        field(50008; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(7,"Shortcut Dimension 7 Code");

            end;

        }
        field(50009; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(8,"Shortcut Dimension 8 Code");

            end;

        }
        field(50010; "Budget MTD"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50011; "Budget YTD"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50012; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

        }
        field(50013; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50014; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50015; "No of days"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50016; "Finance Surrender"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50017; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50018; "Receipt Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Application,Membership,Exams,Events,Others;
        }


    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
        key(key1; "Document Type", No)
        {

        }
    }

    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        EntryNo: Integer;
        SingleMonth: Boolean;
        DateFrom: Date;
        DateTo: Date;
        Budget: Decimal;
        CurrMonth: Code[20];
        CurrYR: Code[20];
        BudgDate: Text;
        BudgetDate: Date;
        YrBudget: Decimal;
        BudgetDateTo: Date;
        BudgetAvailable: Decimal;
        GenLedSetup: Record "General Ledger Setup";
        TotalBudget: Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text;
        // DateFrom: Text;
        // DateTo: Text;
        LastDay: Date;
        Dimm: Record "Dimension Value";
        ConverttoWords: Report Check;
        AmountinWords: Text;
        DimMgt: Codeunit DimensionManagement;
        // CashSetup   Record Table51052
        Employees: Record Employee;
        LastGenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        // Options Record Table51052
        BaseCalendar: Record "Base Calendar Change";
        // GeneralOptions  Record Table51052
        Text064: label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text300: label 'Imprest document must be approved before disbursement can be done!';
        Text301: Label 'imprest %1 has already been disbursed to the payee';
        Text302: Label 'Surrenders have already been processed for the document %1';
        Text500: label 'The current user has no employee profile for Imprest Application';
        TEXT001: Label 'transaction has already been posted.';
        Text0005: Label 'Do you want to post the disbursement for the Imprest Application %1?';
        Text0006: label 'Do you want to post the Surrenders for the Imprest Application %1?';
        Text600: Label 'The Imprest Amount cannot be zero';
        errglsetupsnotfound: label 'Advance Gen Journal Template, or Gen Journal Batch Name not found under General Ledger Setup';
        msgimprestdisbursed: label 'Imprest disbursed successfully';
        msgimprestsurrendered: label 'Imprest Surrenders done successfully';

    trigger OnInsert()
    begin
        if ("Document Type" = "Document Type"::Advance) then begin
            Employees.Reset();
            if not Employees.FindFirst() then Error(Text500);
            Cust.Reset();
            if Cust.Find('-') then begin
                Cust.CalcFields(Balance);
                if Cust.Balance = 0 then begin

                end else
                    Error('You have an outstanding balance %1 clear first before requesting for another imprest', Cust.Balance);

            end;
            if No <> xRec.No then begin
                if GLSetup.Get() then begin

                end;
            end;
        end;
        if Replenishment then begin
            "Account Type" := "Account Type"::"Bank Account";
            "Paying Account Type" := "Paying Account Type"::"Bank Account";
        end;
        Payee := Employees."No.";
        "User Remarks" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
        Date := Today;
        "Document Date" := Today;
        "Entered By" := UserId;
        "On Behalf Of" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if Status <> Status::Open then Error('You cannot delete a document whose status is not %1', Format(Status::Open));

    end;

    trigger OnRename()
    begin

    end;

}