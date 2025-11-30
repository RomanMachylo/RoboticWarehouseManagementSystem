table 50001 "RWMS Sensor Configuration"
{
    Caption = 'Sensor Configuration';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Sensor Config List";
    DrillDownPageId = "RWMS Sensor Config List";

    fields
    {
        field(1; "Sensor ID"; Code[30])
        {
            Caption = 'Sensor ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Sensor Type"; Enum "RWMS Sensor Type")
        {
            Caption = 'Sensor Type';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; Location; Text[100])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(6; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
        }
        field(7; Status; Enum "RWMS Sensor Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(8; "Min Value"; Decimal)
        {
            Caption = 'Min Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(9; "Max Value"; Decimal)
        {
            Caption = 'Max Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(10; "Warning Threshold Min"; Decimal)
        {
            Caption = 'Warning Threshold Min';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(11; "Warning Threshold Max"; Decimal)
        {
            Caption = 'Warning Threshold Max';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(12; "Critical Threshold Min"; Decimal)
        {
            Caption = 'Critical Threshold Min';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(13; "Critical Threshold Max"; Decimal)
        {
            Caption = 'Critical Threshold Max';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(14; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(15; "Polling Interval (Sec)"; Integer)
        {
            Caption = 'Polling Interval (Sec)';
            DataClassification = ToBeClassified;
            MinValue = 1;
        }
        field(16; "Last Reading DateTime"; DateTime)
        {
            Caption = 'Last Reading DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Last Reading Value"; Decimal)
        {
            Caption = 'Last Reading Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
            Editable = false;
        }
        field(18; "Installation Date"; Date)
        {
            Caption = 'Installation Date';
            DataClassification = ToBeClassified;
        }
        field(19; "Maintenance Due Date"; Date)
        {
            Caption = 'Maintenance Due Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Manufacturer"; Text[50])
        {
            Caption = 'Manufacturer';
            DataClassification = ToBeClassified;
        }
        field(21; "Model"; Text[50])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;
        }
        field(22; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
        }
        field(23; "API Endpoint"; Text[250])
        {
            Caption = 'API Endpoint';
            DataClassification = ToBeClassified;
        }
        field(24; "Alert Enabled"; Boolean)
        {
            Caption = 'Alert Enabled';
            DataClassification = ToBeClassified;
        }
        field(25; "Alert Email"; Text[80])
        {
            Caption = 'Alert Email';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sensor ID")
        {
            Clustered = true;
        }
        key(Key2; "Warehouse Code", "Sensor Type")
        {
        }
        key(Key3; Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sensor ID", Description, "Sensor Type", Status)
        {
        }
    }
}
