codeunit 51111 "Calendar Management Custom"
{
    trigger OnRun()
    begin

    end;

    procedure CheckDateStatus(CalendarCode: Code[20]; TargetDate: Date; var Description: Text): Boolean
    begin
        BaseCalChange.Reset();
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FINDSET then
            repeat
                case BaseCalChange."Recurring System" of
                    BaseCalChange."Recurring System"::" ":
                        if TargetDate = BaseCalChange.Date then begin
                            Description := BaseCalChange.Description;
                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        if Date2DWY(TargetDate, 1) = BaseCalChange.Day then begin
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        if (Date2DMY(TargetDate, 2) = DATE2DMY(BaseCalChange.Date, 2)) and
                           (Date2DMY(TargetDate, 1) = DATE2DMY(BaseCalChange.Date, 1))
                        then begin
                            Description := BaseCalChange.Description;
                            exit(BaseCalChange.Nonworking);
                        end;
                end;
            UNTIL BaseCalChange.Next() = 0;
        Description := '';
    end;

    var
        BaseCalChange: Record "Base Calendar Change";
}