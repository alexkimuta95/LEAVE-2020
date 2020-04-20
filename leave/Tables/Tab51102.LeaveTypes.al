table 51102 "Leave Types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckIfEntrysExist();
            end;

        }
        field(4; "Accrue Days"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Both,Male,Female;
        }
        field(6; "Balance"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(7; "Inclusive of Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Inclusive of Saturday"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Inclusive of Sunday"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Off/Holidays Days Leave"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Max Carry Forward Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(CarryForward, true);
            end;

        }
        field(22; "Unlimited Days"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(23; InActive; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(24; Allocations; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Employee Leaves" where("Leave Code" = field(Code)));

        }
        field(25; Applications; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Leave Application" where("Leave Code" = field(Code)));


        }
        field(26; CarryForward; Boolean)
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(PK; "Code")
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
        CheckIfEntrysExist();
    end;

    trigger OnRename()
    begin

    end;

    procedure CheckIfEntrysExist()
    begin
        if (Allocations + Applications) <> 0 then Error(DelError);
    end;

    procedure AssignDefaultDays()
    begin
        IF CONFIRM(AllocateTxt, FALSE, Code) THEN BEGIN
            Code := '';
            LeaveManager.AllocatePeriodDays(LeaveManager.GetCurrentPeriod(), Code);
        END;
    end;

    procedure PopulateDefaultLeaveCategories()
    var

        LeaveTypes: Record "Leave Types";
        PayrollPostingGroup: Record "Payroll Posting Group";
        LeaveCategoryEntitlement: Record "Leave Category Entitlement";
    begin
        IF CONFIRM(Text01, FALSE) THEN BEGIN
            LeaveTypes.RESET;
            LeaveTypes.SETFILTER(InActive, '%1', FALSE);
            IF LeaveTypes.FINDSET THEN BEGIN
                REPEAT
                    PayrollPostingGroup.RESET;
                    IF PayrollPostingGroup.FINDSET THEN BEGIN
                        REPEAT
                            IF NOT LeaveCategoryEntitlement.GET(LeaveTypes.Code, PayrollPostingGroup.Code) THEN BEGIN
                                LeaveCategoryEntitlement."Leave Code" := LeaveTypes.Code;
                                LeaveCategoryEntitlement."Payroll Posting Group" := PayrollPostingGroup.Code;
                                LeaveCategoryEntitlement.Days := LeaveTypes.Days;
                                LeaveCategoryEntitlement."Accrue Days" := LeaveTypes."Accrue Days";
                                LeaveCategoryEntitlement."Unlimited Days" := LeaveTypes."Unlimited Days";
                                LeaveCategoryEntitlement.Gender := LeaveTypes.Gender;
                                LeaveCategoryEntitlement.Balance := LeaveTypes.Balance;
                                LeaveCategoryEntitlement."Inclusive of Holidays" := LeaveTypes."Inclusive of Holidays";
                                LeaveCategoryEntitlement."Inclusive of Saturday" := LeaveTypes."Inclusive of Saturday";
                                LeaveCategoryEntitlement."Inclusive of Sunday" := LeaveTypes."Inclusive of Sunday";
                                LeaveCategoryEntitlement."Off/Holidays Days Leave" := LeaveTypes."Off/Holidays Days Leave";
                                LeaveCategoryEntitlement."Max Carry Forward Days" := LeaveTypes."Max Carry Forward Days";
                                LeaveCategoryEntitlement.CarryForward := LeaveTypes.CarryForward;
                                LeaveCategoryEntitlement.INSERT(TRUE);
                            END;
                        UNTIL PayrollPostingGroup.NEXT = 0;
                    END;
                UNTIL LeaveTypes.NEXT = 0;
                MESSAGE('Populating of leave category entitlements with default leave days completed');
            END;
        END;

    end;


    var
        LeaveManager: Codeunit "Leave Manager";

        DelError: TextConst ENU = 'Changes Not Allowed, Allocations or Applications already Exists!';
        AllocateTxt: TextConst ENU = 'Allocate the Default Leave Days for All Active Employees for this Leave Type %1';
        Text01: TextConst ENU = 'Do you want want to populate leave category entitlements with default leave days?';

}