table 50001 "RWMS Sensor Configuration"
{
    Caption = 'Sensor Configuration';
    DataClassification = CustomerContent;
    LookupPageId = "RWMS Sensor Config List";
    DrillDownPageId = "RWMS Sensor Config List";

    fields
    {
        field(1; "Sensor ID"; Code[30])
        {
            Caption = 'Sensor ID';
            DataClassification = CustomerContent;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = CustomerContent;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Sensor Type"; Enum "RWMS Sensor Type")
        {
            Caption = 'Sensor Type';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Location; Text[100])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
        }
        field(6; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = CustomerContent;
        }
        field(7; Status; Enum "RWMS Sensor Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; "Min Value"; Decimal)
        {
            Caption = 'Min Value';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(9; "Max Value"; Decimal)
        {
            Caption = 'Max Value';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(10; "Warning Threshold Min"; Decimal)
        {
            Caption = 'Warning Threshold Min';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(11; "Warning Threshold Max"; Decimal)
        {
            Caption = 'Warning Threshold Max';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(12; "Critical Threshold Min"; Decimal)
        {
            Caption = 'Critical Threshold Min';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(13; "Critical Threshold Max"; Decimal)
        {
            Caption = 'Critical Threshold Max';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(14; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(15; "Polling Interval (Sec)"; Integer)
        {
            Caption = 'Polling Interval (Sec)';
            DataClassification = CustomerContent;
            MinValue = 1;
        }
        field(16; "Last Reading DateTime"; DateTime)
        {
            Caption = 'Last Reading DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Last Reading Value"; Decimal)
        {
            Caption = 'Last Reading Value';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
            Editable = false;
        }
        field(18; "Installation Date"; Date)
        {
            Caption = 'Installation Date';
            DataClassification = CustomerContent;
        }
        field(19; "Maintenance Due Date"; Date)
        {
            Caption = 'Maintenance Due Date';
            DataClassification = CustomerContent;
        }
        field(20; "Manufacturer"; Text[50])
        {
            Caption = 'Manufacturer';
            DataClassification = CustomerContent;
        }
        field(21; "Model"; Text[50])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(22; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(23; "API Endpoint"; Text[250])
        {
            Caption = 'API Endpoint';
            DataClassification = CustomerContent;
        }
        field(24; "Alert Enabled"; Boolean)
        {
            Caption = 'Alert Enabled';
            DataClassification = CustomerContent;
        }
        field(25; "Alert Email"; Text[80])
        {
            Caption = 'Alert Email';
            DataClassification = CustomerContent;
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
