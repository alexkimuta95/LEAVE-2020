table 51130 "Approval Processing Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Open/History"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,History;
            Editable = false;
        }

        field(3; Decision; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Disapproved,Acknowledged;

        }
        field(4; Response; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Internal Control No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(6; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(7; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(8; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(9; "Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(10; " External Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(11; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(12; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(13; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(14; "Source Code"; code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(15; "Business Rule Code"; code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(16; "Business Rule Eff. Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(17; "Business Rule Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Budget,"Transaction Approval","Document Approval";
        }
        field(18; "Workflow Routing Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(19; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved;
            Editable = true;
        }
        field(21; Priority; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(22; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(23; "Message Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(24; "Message Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(25; "Decision Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(26; "Decision Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(27; "Decision By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(28; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Transfer Budget",Approval,"Acknowledge Only";
            Editable = false;
        }
        field(29; "Action ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";

        }
        field(30; "Owner ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";

        }
        field(31; "One Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(32; "Combine Lines for Processing"; Boolean)
        {
            DataClassification = ToBeClassified;


        }
        field(33; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(34; "Allocation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }

        field(35; "Ctl. Fund No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }


        field(36; "  Fund Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(37; "  Fund Class Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(38; "  Fund No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(39; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(40; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(41; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(42; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(43; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(44; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(45; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(46; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(47; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";


        }
        field(48; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(49; "Approval Key"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50; "Source Code Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50100; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50101; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50102; "Supervisor No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50103; "Supervisor Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }











    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var

        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        // LDB	:Record	"Line Distribution Buffer"	


        SNText001: TextConst ENU = 'If you have not transferred the necessary amount, this transaction will continue to trigger the budget rule.\ \Have you transferred the necessary budget amount?';
        SNText002: TextConst ENU = 'You cannot mark %3 %2 line as %1.';
        SNText003: TextConst ENU = 'a';
        SNText004: TextConst ENU = 'an';

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

    procedure CalcAvailableBalance(): Decimal
    var
        myInt: Integer;
    begin

    end;

    procedure DrilldownAvailableBalance()
    var
        ChartOfAccounts: Page "Chart of Accounts";
    begin

    end;

}