table 51202 "Payroll Period"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Starting Date"; date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Name := FORMAT("Starting Date", 0, Text000);
            end;


        }
        field(3; "New Fiscal Year"; boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Date Locked", FALSE);
            end;

        }
        field(4; Closed; boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; "Date Locked"; boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

        }
    }

    keys
    {
        key(PK; "Starting Date")
        {
            Clustered = true;
        }
    }

    var
        AccountingPeriod2: Record "Payroll Period";
        Text000: TextConst ENU = 'Month Text';

    trigger OnInsert()
    begin
        AccountingPeriod2 := Rec;
        IF AccountingPeriod2.Find('>') THEN
            AccountingPeriod2.TestField("Date Locked", false);
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TestField("Date Locked", FALSE);

    end;

    trigger OnRename()
    begin
        TestField("Date Locked", false);
        AccountingPeriod2 := Rec;
        IF AccountingPeriod2.Find('>') THEN
            AccountingPeriod2.TestField("Date Locked", FALSE);
    end;

}