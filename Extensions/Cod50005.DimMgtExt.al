codeunit 50005 "Dim Mgt Ext"
{
    trigger OnRun()
    begin

    end;

    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]; VAR GlobalDimVal3: Code[20]; VAR GlobalDimVal4: Code[20]; VAR GlobalDimVal5: Code[20]; VAR GlobalDimVal6: Code[20]; VAR GlobalDimVal7: Code[20]; var GlobalDimVal8: Code[20]): Integer
    var
        EditDimSetEntries: Page "Edit Dimension Set Entries";
        NewDimSetID: Integer;
        DimSetEntry: Record "Dimension Set Entry";
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2,

        // Navigator
        GlobalDimVal3, GlobalDimVal4, GlobalDimVal5, GlobalDimVal6, GlobalDimVal7, GlobalDimVal8);

        DimSetEntry.RESET;
        EXIT(NewDimSetID);
    end;

    procedure UpdateGlobalDimFromDimSetID(DimSetID: Integer; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]; VAR GlobalDimVal3: Code[20]; VAR GlobalDimVal4: Code[20]; VAR GlobalDimVal5: Code[20]; VAR GlobalDimVal6: Code[20]; VAR GlobalDimVal7: Code[20]; var GlobalDimVal8: Code[20])
    var
        GLSetupShortcutDimCode: Code[20];
        DimSetEntry: Record "Dimension Set Entry";
    begin
        GetGLSetup;
        GlobalDimVal1 := '';
        GlobalDimVal2 := '';

        // Navigator
        GlobalDimVal3 := '';
        GlobalDimVal4 := '';
        GlobalDimVal5 := '';
        GlobalDimVal6 := '';
        GlobalDimVal7 := '';
        GlobalDimVal8 := '';

        IF GLSetupShortcutDimCode[1] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[1]) THEN
                GlobalDimVal1 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[2] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[2]) THEN
                GlobalDimVal2 := DimSetEntry."Dimension Value Code";

        // Navigator
        IF GLSetupShortcutDimCode[3] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[3]) THEN
                GlobalDimVal3 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[4] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[4]) THEN
                GlobalDimVal4 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[5] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[5]) THEN
                GlobalDimVal5 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[6] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[6]) THEN
                GlobalDimVal6 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[7] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[7]) THEN
                GlobalDimVal7 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[8] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[8]) THEN
                GlobalDimVal8 := DimSetEntry."Dimension Value Code";
    end;

    LOCAL procedure GetGLSetup()
    var
        HasGotGLSetup: Boolean;
        GLSetup: Record "General Ledger Setup";
        GLSetupShortcutDimCode: Code[20];
    begin
        IF NOT HasGotGLSetup THEN BEGIN
            GLSetup.GET;
            // GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            // GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            // GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            // GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            // GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            // GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            // GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            // GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := TRUE;
        END;
    end;

    var
        myInt: Integer;
}