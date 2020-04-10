table 50065 "Cash Management Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(3; "Payment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(4; "Receipt Template Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;

        }
        field(5; "Receipt Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Template Name"));

        }
        field(6; "Payment Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;

        }
        field(7; "Payment Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Template Name"));

        }
        field(8; "Default Collection Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

        }
        field(9; "Payment Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(10; "Payment Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";

        }
        field(11; "Receipt Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";

        }
        field(12; "Cash Receipt Report"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "AutoEmail Online Receipts"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Post Receipt If Bal. Is Zero"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Post Online Receipts From"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Cash Sale Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(17; "Enforce Document Review"; boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Email Attachment Location"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Distribution Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(20; "Distribution Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(21; "Distribution Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Distribution Template Name"));
        }
        field(22; "Alt. Petty Cash Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Imprest Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Shortcut Dimension 1 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "Shortcut Dimension 2 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50004; "Shortcut Dimension 3 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50005; "Shortcut Dimension 4 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50006; "Shortcut Dimension 5 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50007; "Shortcut Dimension 6 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50008; "Shortcut Dimension 7 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50009; "Shortcut Dimension 8 Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50010; "Leave Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50011; "Applicants Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50012; "Recruitment Needs Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50013; "Disciplinary Cases Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50014; "Base Calendar"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";
        }
        field(50015; "Appraisal Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50016; "Complaint Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50017; "Training Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50018; "Payment Transactions"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50019; "Petty Cash Journal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50020; "Petty Cash Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Journal Template"));
        }
        field(50021; "Petty Cash Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account Posting Group";
        }
        field(50022; "Petty Cash Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50023; "Petty Cash Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "Primary Key")
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

    end;

    trigger OnRename()
    begin

    end;

}