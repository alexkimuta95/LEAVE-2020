table 51200 "Leave Category Entitlement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Leave Types";

        }
        field(2; "Payroll Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Posting Group".Code;

            trigger OnValidate()
            begin
                if (("Payroll Posting Group" <> '') and ("Leave Code" <> '')) then begin
                    AutoFillLeaveCategory("Leave Code");
                end;
            end;


        }
        field(3; Days; decimal)
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
        field(5; "Unlimited Days"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(6; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Both,Male,Female;
        }
        field(7; Balance; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField(CarryForward, true);
            end;

        }
        field(13; CarryForward; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(14; InActive; boolean)
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(PK; "Leave Code", "Payroll Posting Group")
        {
            Clustered = true;
        }
    }

    var
        LeaveManager: Codeunit "Leave Manager";

        DelError: TextConst ENU = 'Changes Not Allowed, Allocations or Applications already Exists!';
        AllocateTxt: TextConst ENU = 'Allocate the Default Leave Days for All Active Employees for this Leave Type %1';

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

    end;

    procedure AssignDefaultDays()
    begin

    end;

    procedure AutoFillLeaveCategory(LeaveCode: code[20])
    var
        LeaveType: Record "Leave Types";
    begin
        if LeaveType.Get(LeaveCode) then begin
            Days := LeaveType.Days;
            "Accrue Days" := LeaveType."Accrue Days";
            "Unlimited Days" := LeaveType."Unlimited Days";
            Gender := LeaveType.Gender;
            Balance := LeaveType.Balance;
            "Inclusive of Holidays" := LeaveType."Inclusive of Holidays";
            "Inclusive of Saturday" := LeaveType."Inclusive of Saturday";
            "Inclusive of Sunday" := LeaveType."Inclusive of Sunday";
            "Off/Holidays Days Leave" := LeaveType."Off/Holidays Days Leave";
            CarryForward := LeaveType.CarryForward;
            Insert(true);
        end;
    end;

}