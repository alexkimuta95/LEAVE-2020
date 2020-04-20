table 50061 "Cash Management Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Cash Management Header".No;

        }
        field(2; "Account No."; Code[20])
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
                CopyHeaderDimensions;
                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            IF GLAcc.GET("Account No.") THEN
                                "Account Name" := GLAcc.Name;
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            IF Cust.GET("Account No.") THEN
                                "Account Name" := Cust.Name;
                            "Customer Posting Group" := Cust."Customer Posting Group";
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            Vend.GET("Account No.");
                            "Account Name" := Vend.Name;
                            "Customer Posting Group" := Vend."Vendor Posting Group";
                        END;
                    "Account Type"::"Bank Account":
                        BEGIN
                            IF BankAcc.GET("Account No.") THEN
                                "Account Name" := BankAcc.Name;
                        END;
                END;
            end;
        }
        field(3; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Amount in LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
                UpdateUnitCost;
                UpdateAmounts;
            end;

        }
        field(5; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Advance Holder"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

        }
        field(7; "Actual Amount Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF AdvancePettyCashIOU.GET(No) THEN BEGIN
                    IF AdvancePettyCashIOU.Amount <> 0 THEN BEGIN
                        IF AdvancePettyCashIOU.Amount > "Actual Amount Spent" THEN BEGIN
                            "Surrender Amount" := AdvancePettyCashIOU.Amount - "Actual Amount Spent";
                            "Reimbursement Amount" := 0;
                        END ELSE
                            IF AdvancePettyCashIOU.Amount < "Actual Amount Spent" THEN BEGIN
                                "Reimbursement Amount" := "Actual Amount Spent" - AdvancePettyCashIOU.Amount;
                                "Surrender Amount" := 0;
                            END;
                    END;
                END;
                UpdateCurrencyFactor;
                UpdateUnitCost;
                UpdateAmounts;
            end;

        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(9; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(10; Allocated; boolean)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup ("Cash Management Header".Allocated where(No = field(No)));

        }
        field(11; "Reimbursement Amount"; decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateSurrenderAmounts;
            end;

        }
        field(12; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";

        }
        field(13; "Customer Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group" else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group" else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group";

        }
        field(14; "Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Source Code";

        }
        field(15; "Document Type"; Option)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup ("Cash Management Header"."Document Type" where(No = field(No)));
            OptionMembers = "Petty Cash",Advance,IOU;
        }
        field(16; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Applies-to ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Accounted for Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Accounted for"; boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Cash Management Header"."Accounted for" where(No = field(No)));
        }
        field(20; "Account for Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Type of Surrender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Cash,Receipt;
        }
        field(23; "Dept. Vch. No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Surrender Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF Settled THEN ERROR(Text0002);
                VALIDATE("Reimbursement Amount", 0);

                IF "Surrender Amount" > 0 THEN IF "Accounted for Date" = 0D THEN "Accounted for Date" := WORKDATE;

                IF "Surrender Amount" > "Open Amount" THEN BEGIN
                    "Reimbursement Amount" := "Surrender Amount" - "Open Amount";
                    MESSAGE(Text0001);
                END;
                IF "Surrender Amount" < "Open Amount" THEN BEGIN
                    IF CONFIRM(Text0003, FALSE) THEN BEGIN
                        "Reimbursement Amount" := "Surrender Amount" - "Open Amount";
                    END;
                END;

                UpdateSurrenderAmounts;
                MODIFY;
            end;

        }
        field(25; "Bank/Petty Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

        }
        field(26; "Vote Book"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(27; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(28; Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;

        }
        field(30; "Surrender Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

            end;

        }
        field(32; "Reimbursement Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(33; Posted; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Journal Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";

        }
        field(35; "Journal Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));

        }
        field(36; "Gen. Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] THEN
                    TESTFIELD("Gen. Posting Type", "Gen. Posting Type"::" ");
                IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
                    ERROR('Error %1', "Gen. Posting Type"); //this is a hack, confirm what the actual erro message should be
                                                            //CheckVATInAlloc;
                IF "Gen. Posting Type" > 0 THEN
                    VALIDATE("VAT Prod. Posting Group");

            end;
        }
        field(37; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
            trigger OnValidate()
            begin
                IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] THEN
                    TESTFIELD("Gen. Bus. Posting Group", '');
                IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                    IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") THEN
                        VALIDATE("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;

        }
        field(38; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
            trigger OnValidate()
            begin
                IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] THEN
                    TESTFIELD("Gen. Prod. Posting Group", '');
                IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
                    IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") THEN
                        VALIDATE("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");

            end;

        }
        field(39; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
            trigger OnValidate()
            begin
                IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] THEN
                    TESTFIELD("VAT Bus. Posting Group", '');

                VALIDATE("VAT Prod. Posting Group");
            end;

        }
        field(40; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
            Editable = true;
            trigger OnValidate()
            begin
                IF CurrFieldNo <> FIELDNO("Currency Code") THEN
                    UpdateCurrencyFactor
                ELSE BEGIN
                    IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                        CheckOKtoModify(FIELDNAME("Currency Code"));
                        UpdateCurrencyFactor;
                        UpdateUnitCost;
                        UpdateAmounts;
                    END ELSE
                        IF "Currency Code" <> '' THEN BEGIN
                            UpdateCurrencyFactor;
                            IF "Currency Factor" <> xRec."Currency Factor" THEN
                                ConfirmUpdateCurrencyFactor;
                        END;
                END;
            end;

        }
        field(41; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;

        }
        field(42; "Dimension Set ID"; integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

        }
        field(43; "External Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(44; "Amount Conv"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF AdvancePettyCashIOU.GET(No) THEN BEGIN
                    IF AdvancePettyCashIOU.Amount <> 0 THEN BEGIN
                        IF AdvancePettyCashIOU.Amount > "Actual Amount Spent" THEN BEGIN
                            "Surrender Amount" := AdvancePettyCashIOU.Amount - "Actual Amount Spent";
                            "Reimbursement Amount" := 0;
                        END ELSE
                            IF AdvancePettyCashIOU.Amount < "Actual Amount Spent" THEN BEGIN
                                "Reimbursement Amount" := "Actual Amount Spent" - AdvancePettyCashIOU.Amount;
                                "Surrender Amount" := 0;
                            END;
                    END;
                END;
            end;

        }
        field(45; Settled; boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(46; "Open Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Total Surrendered Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Settled THEN ERROR(Text0002);
                IF "Surrender Amount" > 0 THEN IF "Accounted for Date" = 0D THEN "Accounted for Date" := WORKDATE;

                IF "Surrender Amount" > "Open Amount" THEN BEGIN
                    "Reimbursement Amount" := "Surrender Amount" - "Open Amount";
                    MESSAGE(Text0001);
                END;

                UpdateSurrenderAmounts;
                MODIFY;
            end;

        }
        field(48; "Total Reimbursement Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(49; "Total Surrendered Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50; "Total Reimbursement Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF Settled THEN ERROR(Text0002);
                IF "Surrender Amount" > 0 THEN IF "Accounted for Date" = 0D THEN "Accounted for Date" := WORKDATE;

                IF "Surrender Amount" > "Open Amount" THEN BEGIN
                    "Reimbursement Amount" := "Surrender Amount" - "Open Amount";
                    MESSAGE(Text0001);
                END;

                UpdateSurrenderAmounts;
                MODIFY;
            end;

        }
        field(50004; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;

        }
        field(50005; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;

        }
        field(50006; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;

        }
        field(50007; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;

        }
        field(50008; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;

        }
        field(50009; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
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
        field(50012; "Same Budget"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50013; "Posted Doc.  No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50014; Description; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50015; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            begin
                EmployeeRec.RESET;
                EmployeeRec.SETRANGE(EmployeeRec."No.", "Employee No");
                IF EmployeeRec.FIND('-') THEN BEGIN
                    "Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                    "Shortcut Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                    MODIFY;
                END;
            end;

        }
        field(50016; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(PK; No, "Line No.", Description)
        {
            Clustered = true;
            SumIndexFields = "Amount in LCY";
        }
        key(key1; "External Doc. No.")
        {

        }

    }

    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        GLAccount: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        MonthBudget: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        LastDay: Date;
        CurrMonth: Code[20];
        CurrYR: Code[10];
        BudgetDate: Date;
        CommittedAmount: Decimal;
        ProjectCode: Code[20];
        BudgetEntries: Record "G/L Budget Entry";
        BudgetBal: Decimal;
        Totalcommitmententries: Decimal;
        Glentry: Record "G/L Entry";
        Glentrytotal: Decimal;
        ActualBalance: Decimal;
        AvailableBalance: Decimal;
        Glbudgetentry: Record "G/L Budget Entry";
        Budgetedammt: Decimal;
        AdvancePettyCashIOU: Record "Cash Management Header";
        DimMgt: Codeunit DimensionManagement;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        Lines: Record "Cash Management Line";
        EmployeeRec: Record Employee;

        Text0001: label 'Additional amounts above imprest allocation for this line, have been assigned to reimbursements';
        Text0002: Label 'Additional Surrenders can not be performed as Imprest Line is fully settled';
        Text0003: Label 'The Surrender Amount is less that the expected amount, do you want to record a cash return';

    trigger OnInsert()
    begin
        CopyHeaderDimensions();
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

    procedure SetAdvancePettyCashIOULinesExists(HeaderNo: Code[20])
    var
        AdvancePettyCashIOUHeader: Record "Cash Management Header";
    begin
        IF AdvancePettyCashIOUHeader.GET(HeaderNo) THEN BEGIN
            AdvancePettyCashIOUHeader."Exists Lines" := TRUE;
            AdvancePettyCashIOUHeader.MODIFY;
        END;
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20])
    var
        TableID: Integer;
        No: Code[20];
    begin
        // TableID[1] := Type1;
        // No[1] := No1;
        // TableID[2] := Type2;
        // No[2] := No2;
        // TableID[3] := Type3;
        // No[3] := No3;
        // TableID[4] := Type4;
        // No[4] := No4;
        // TableID[5] := Type5;
        // No[5] := No5;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        // "Dimension Set ID" :=
        //   DimMgt.GetDefaultDimID(
        // TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
        // DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    begin

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(VAR ShortcutDimCode: ARRAY[8] OF Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);

    end;

    procedure ShowDimensions()
    begin
        // "Dimension Set ID" :=;
        //   DimMgtExt.EditDimensionSet2(
        //     "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."),
        //     "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        // DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    LOCAL procedure UpdateCurrencyFactor()
    begin
        IF "Currency Code" <> '' THEN BEGIN
            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, "Currency Code");
        END ELSE
            "Currency Factor" := 1;
    end;

    procedure CheckOKtoModify(ChangedFieldName: Text[30])
    begin
        IF GUIALLOWED THEN;

    end;

    procedure UpdateDirectUnitCost()
    begin
    end;

    procedure UpdateAmounts()
    begin
        IF "Currency Factor" = 0 THEN "Currency Factor" := 1;
        "Amount in LCY" := ROUND(("Actual Amount Spent" * (1 / "Currency Factor")), Currency."Amount Rounding Precision");
        "Open Amount" := "Actual Amount Spent";
    end;

    LOCAL procedure UpdateUnitCost()
    begin
    end;

    LOCAL procedure ConfirmUpdateCurrencyFactor()
    begin
    end;

    procedure CopyHeaderDimensions()
    var
        Header: Record "Cash Management Header";
    begin

        Header.RESET;
        Header.SETRANGE(Header.No, Rec.No);
        IF Header.FINDFIRST THEN BEGIN
            Rec.VALIDATE("Shortcut Dimension 1 Code", Header."Shortcut Dimension 1 Code");
            Rec.VALIDATE("Shortcut Dimension 2 Code", Header."Shortcut Dimension 2 Code");
            Rec.VALIDATE("Shortcut Dimension 3 Code", Header."Shortcut Dimension 3 Code");
            Rec.VALIDATE("Shortcut Dimension 4 Code", Header."Shortcut Dimension 4 Code");
            Rec."Dimension Set ID" := Header."Dimension Set ID";
            //COPY CURRENCY
            "Currency Code" := Header."Currency Code";
            //MODIFY;
        END;
    end;

    procedure UpdateSurrenderAmounts()
    begin
        IF "Currency Factor" = 0 THEN "Currency Factor" := 1;
        "Surrender Amount LCY" := ROUND(("Surrender Amount" * (1 / "Currency Factor")), Currency."Amount Rounding Precision");
        "Reimbursement Amount LCY" := ROUND(("Reimbursement Amount" * (1 / "Currency Factor")), Currency."Amount Rounding Precision");

    end;
}