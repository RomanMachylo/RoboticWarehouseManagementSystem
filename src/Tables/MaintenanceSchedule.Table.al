table 50005 "RWMS Maintenance Schedule"
{
    Caption = 'Maintenance Schedule';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Maintenance Schedule List";
    DrillDownPageId = "RWMS Maintenance Schedule List";

    fields
    {
        field(1; "Schedule ID"; Code[20])
        {
            Caption = 'Schedule ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Sensor ID"; Code[30])
        {
            Caption = 'Sensor ID';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Sensor Configuration";

            trigger OnValidate()
            var
                SensorConfig: Record "RWMS Sensor Configuration";
            begin
                if SensorConfig.Get("Sensor ID") then begin
                    "Warehouse Code" := SensorConfig."Warehouse Code";
                    "Sensor Type" := SensorConfig."Sensor Type";
                    Description := 'Maintenance for ' + SensorConfig.Description;
                end;
            end;
        }
        field(3; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(4; "Sensor Type"; Enum "RWMS Sensor Type")
        {
            Caption = 'Sensor Type';
            DataClassification = ToBeClassified;
        }
        field(5; "Maintenance Type"; Enum "RWMS Maintenance Type")
        {
            Caption = 'Maintenance Type';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Scheduled Time"; Time)
        {
            Caption = 'Scheduled Time';
            DataClassification = ToBeClassified;
        }
        field(9; "Completed Date"; Date)
        {
            Caption = 'Completed Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Completed Time"; Time)
        {
            Caption = 'Completed Time';
            DataClassification = ToBeClassified;
        }
        field(11; "Technician Name"; Text[100])
        {
            Caption = 'Technician Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Technician Contact"; Text[50])
        {
            Caption = 'Technician Contact';
            DataClassification = ToBeClassified;
        }
        field(13; Status; Enum "RWMS Work Order Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(14; "Duration (Hours)"; Decimal)
        {
            Caption = 'Duration (Hours)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(15; "Estimated Duration (Hours)"; Decimal)
        {
            Caption = 'Estimated Duration (Hours)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(16; Cost; Decimal)
        {
            Caption = 'Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(17; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(18; "Next Maintenance Date"; Date)
        {
            Caption = 'Next Maintenance Date';
            DataClassification = ToBeClassified;
        }
        field(19; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
        field(20; "Completion Notes"; Text[250])
        {
            Caption = 'Completion Notes';
            DataClassification = ToBeClassified;
        }
        field(21; "Parts Used"; Text[100])
        {
            Caption = 'Parts Used';
            DataClassification = ToBeClassified;
        }
        field(22; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(23; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
        }
        field(24; Recurring; Boolean)
        {
            Caption = 'Recurring';
            DataClassification = ToBeClassified;
        }
        field(25; "Recurrence Interval (Days)"; Integer)
        {
            Caption = 'Recurrence Interval (Days)';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Schedule ID")
        {
            Clustered = true;
        }
        key(Sensor; "Sensor ID", "Scheduled Date")
        {
        }
        key(Warehouse; "Warehouse Code", Status, "Scheduled Date")
        {
        }
        key(Status; Status, "Scheduled Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Schedule ID" = '' then
            "Schedule ID" := GetNextScheduleID();

        "Created DateTime" := CurrentDateTime();
        "Created By" := UserId();
    end;

    local procedure GetNextScheduleID(): Code[20]
    var
        MaintenanceSchedule: Record "RWMS Maintenance Schedule";
        NextNo: Integer;
    begin
        if MaintenanceSchedule.FindLast() then begin
            if Evaluate(NextNo, CopyStr(MaintenanceSchedule."Schedule ID", 4)) then
                exit('MNT' + Format(NextNo + 1, 0, '<Integer,5><Filler Character,0>'));
        end;
        exit('MNT00001');
    end;
}
