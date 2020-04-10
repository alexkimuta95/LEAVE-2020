codeunit 50000 "Budget Manager"
{
    trigger OnRun()
    begin

    end;

    procedure GetInventoryBudgetAcc(ItemCode: Code[20]; BudgetLocation: Code[30]): Code[20]
    var
        GLAccounts: Record "G/L Account";
        Items: Record Item;
        InventPG: Record "Inventory Posting Setup";
    begin
        IF Items.GET(Items."Inventory Posting Group") THEN BEGIN
            InventPG.RESET;
            IF BudgetLocation <> '' THEN InventPG.SETRANGE(InventPG."Location Code", BudgetLocation);
            InventPG.SETRANGE(InventPG."Invt. Posting Group Code", Items."Inventory Posting Group");
            IF InventPG.FIND('-') THEN InventPG.TESTFIELD("Inventory Account");
            EXIT(InventPG."Inventory Account");
        END;
    end;

    procedure GetFABudgetAcc(AssetCode: Code[20]): Code[20]
    var
        GLAccounts: Record "G/L Account";
        Assets: Record "Fixed Asset";
        FAPostingGrps: Record "FA Posting Group";
    begin
        IF Assets.GET(AssetCode) THEN BEGIN
            FAPostingGrps.RESET;
            FAPostingGrps.SETRANGE(FAPostingGrps.Code, Assets."FA Posting Group");
            IF FAPostingGrps.FIND('-') THEN FAPostingGrps.TESTFIELD(FAPostingGrps."Acquisition Cost Account");
            EXIT(FAPostingGrps."Acquisition Cost Account");
        END;
    end;

    procedure PurchaseRequisitionValidation(DocumentNo: Code[30]): Boolean
    var
    begin

    end;

    procedure IfEntryExistsDelete(DocNo: Code[20]; DocLineNo: Integer; DocType: Option GLJournal,Requisition,Quote,Order,Imprest; SrcTableType: Integer; RecSignage: Option Positive,Negative)
    var
        Entries: Record "Expense Codes";
        EntriesTemp: Record "Expense Codes";
        xLineNo: Integer;
    begin

    end;

    var
        myInt: Integer;
}