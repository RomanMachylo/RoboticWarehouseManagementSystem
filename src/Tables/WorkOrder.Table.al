table 50006 "RWMS Work Order"
{
    Caption = 'Work Order';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Work Order List";
    DrillDownPageId = "RWMS Work Order List";

    fields
    {
        field(1; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Related Alert ID"; Code[30])
        {
            Caption = 'Related Alert ID';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Alert History";
        }
        field(3; "Related Sensor ID"; Code[30])
        {
            Caption = 'Related Sensor ID';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Sensor Configuration";

            trigger OnValidate()
            var
                SensorConfig: Record "RWMS Sensor Configuration";
            begin
                if SensorConfig.Get("Related Sensor ID") then begin
                    "Warehouse Code" := SensorConfig."Warehouse Code";
                    "Zone Code" := SensorConfig."Zone Code";
                end;
            end;
        }
        field(4; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(5; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Zone Configuration";
        }
        field(6; Priority; Enum "RWMS Work Order Priority")
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
        }
        field(7; "Work Type"; Enum "RWMS Maintenance Type")
        {
            Caption = 'Work Type';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(11; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
        }
        field(12; "Due DateTime"; DateTime)
        {
            Caption = 'Due DateTime';
            DataClassification = ToBeClassified;
        }
        field(13; "Started DateTime"; DateTime)
        {
            Caption = 'Started DateTime';
            DataClassification = ToBeClassified;
        }
        field(14; "Completed DateTime"; DateTime)
        {
            Caption = 'Completed DateTime';
            DataClassification = ToBeClassified;
        }
        field(15; Status; Enum "RWMS Work Order Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(16; "Estimated Hours"; Decimal)
        {
            Caption = 'Estimated Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(17; "Actual Hours"; Decimal)
        {
            Caption = 'Actual Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(18; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(19; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(20; "Parts Cost"; Decimal)
        {
            Caption = 'Parts Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(21; "Labor Cost"; Decimal)
        {
            Caption = 'Labor Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(22; "Parts Used"; Text[250])
        {
            Caption = 'Parts Used';
            DataClassification = ToBeClassified;
        }
        field(23; "Resolution Description"; Text[250])
        {
            Caption = 'Resolution Description';
            DataClassification = ToBeClassified;
        }
        field(24; "Root Cause"; Text[250])
        {
            Caption = 'Root Cause';
            DataClassification = ToBeClassified;
        }
        field(25; "Corrective Actions"; Text[250])
        {
            Caption = 'Corrective Actions';
            DataClassification = ToBeClassified;
        }
        field(26; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
            DataClassification = ToBeClassified;
        }
        field(27; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Customer Satisfaction"; Integer)
        {
            Caption = 'Customer Satisfaction';
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 5;
        }
    }

    keys
    {
        key(PK; "Work Order No.")
        {
            Clustered = true;
        }
        key(Alert; "Related Alert ID")
        {
        }
        key(Warehouse; "Warehouse Code", Status, Priority)
        {
        }
        key(AssignedTo; "Assigned To", Status)
        {
        }
        key(Priority; Priority, Status, "Created DateTime")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Work Order No." = '' then
            "Work Order No." := GetNextWorkOrderNo();

        "Created DateTime" := CurrentDateTime();
        "Created By" := UserId();
    end;

    local procedure GetNextWorkOrderNo(): Code[20]
    var
        WorkOrder: Record "RWMS Work Order";
        NextNo: Integer;
    begin
        if WorkOrder.FindLast() then begin
            if Evaluate(NextNo, CopyStr(WorkOrder."Work Order No.", 3)) then
                exit('WO' + Format(NextNo + 1, 0, '<Integer,6><Filler Character,0>'));
        end;
        exit('WO000001');
    end;
}
