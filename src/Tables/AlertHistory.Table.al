table 50004 "RWMS Alert History"
{
    Caption = 'Alert History';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Alert History List";
    DrillDownPageId = "RWMS Alert History List";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Alert ID"; Code[30])
        {
            Caption = 'Alert ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Sensor ID"; Code[30])
        {
            Caption = 'Sensor ID';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Sensor Configuration";
        }
        field(4; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(5; "Sensor Type"; Enum "RWMS Sensor Type")
        {
            Caption = 'Sensor Type';
            DataClassification = ToBeClassified;
        }
        field(6; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
        }
        field(7; "Resolved DateTime"; DateTime)
        {
            Caption = 'Resolved DateTime';
            DataClassification = ToBeClassified;
        }
        field(8; "Alert Level"; Enum "RWMS Alert Level")
        {
            Caption = 'Alert Level';
            DataClassification = ToBeClassified;
        }
        field(9; Status; Enum "RWMS Alert Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(10; "Alert Message"; Text[250])
        {
            Caption = 'Alert Message';
            DataClassification = ToBeClassified;
        }
        field(11; "Sensor Value"; Decimal)
        {
            Caption = 'Sensor Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(12; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(13; "Assigned DateTime"; DateTime)
        {
            Caption = 'Assigned DateTime';
            DataClassification = ToBeClassified;
        }
        field(14; "Response Time (Minutes)"; Integer)
        {
            Caption = 'Response Time (Minutes)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Resolution Time (Minutes)"; Integer)
        {
            Caption = 'Resolution Time (Minutes)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Resolution Notes"; Text[250])
        {
            Caption = 'Resolution Notes';
            DataClassification = ToBeClassified;
        }
        field(17; Escalated; Boolean)
        {
            Caption = 'Escalated';
            DataClassification = ToBeClassified;
        }
        field(18; "Escalation Reason"; Text[100])
        {
            Caption = 'Escalation Reason';
            DataClassification = ToBeClassified;
        }
        field(19; "Related Work Order No."; Code[20])
        {
            Caption = 'Related Work Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Work Order";
        }
        field(20; "Acknowledged By"; Code[50])
        {
            Caption = 'Acknowledged By';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(21; "Acknowledged DateTime"; DateTime)
        {
            Caption = 'Acknowledged DateTime';
            DataClassification = ToBeClassified;
        }
        field(22; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Zone Configuration";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Alert; "Alert ID")
        {
        }
        key(Sensor; "Sensor ID", "Created DateTime")
        {
        }
        key(Warehouse; "Warehouse Code", Status, "Created DateTime")
        {
        }
        key(Status; Status, "Alert Level")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Alert ID" = '' then
            "Alert ID" := Format("Entry No.");
    end;

    trigger OnModify()
    begin
        CalculateResponseTime();
        CalculateResolutionTime();
    end;

    local procedure CalculateResponseTime()
    begin
        if ("Assigned DateTime" <> 0DT) and ("Created DateTime" <> 0DT) then
            "Response Time (Minutes)" := Round(("Assigned DateTime" - "Created DateTime") / 60000, 1);
    end;

    local procedure CalculateResolutionTime()
    begin
        if ("Resolved DateTime" <> 0DT) and ("Created DateTime" <> 0DT) then
            "Resolution Time (Minutes)" := Round(("Resolved DateTime" - "Created DateTime") / 60000, 1);
    end;
}
