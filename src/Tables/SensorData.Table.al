table 50002 "RWMS Sensor Data"
{
    Caption = 'Sensor Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Sensor ID"; Code[30])
        {
            Caption = 'Sensor ID';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Sensor Configuration";
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
        field(5; "Reading DateTime"; DateTime)
        {
            Caption = 'Reading DateTime';
            DataClassification = ToBeClassified;
        }
        field(6; Value; Decimal)
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
        }
        field(7; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(8; "Alert Level"; Enum "RWMS Alert Level")
        {
            Caption = 'Alert Level';
            DataClassification = ToBeClassified;
        }
        field(9; "Alert Message"; Text[250])
        {
            Caption = 'Alert Message';
            DataClassification = ToBeClassified;
        }
        field(10; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Battery Level"; Decimal)
        {
            Caption = 'Battery Level';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(12; "Signal Strength"; Decimal)
        {
            Caption = 'Signal Strength';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(13; "Data Quality Score"; Decimal)
        {
            Caption = 'Data Quality Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(14; "Is Anomaly"; Boolean)
        {
            Caption = 'Is Anomaly';
            DataClassification = ToBeClassified;
        }
        field(15; "AI Analysis Result"; Text[250])
        {
            Caption = 'AI Analysis Result';
            DataClassification = ToBeClassified;
        }
        field(16; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "External System ID"; Text[100])
        {
            Caption = 'External System ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Sensor ID", "Reading DateTime")
        {
        }
        key(Key3; "Warehouse Code", "Sensor Type", "Reading DateTime")
        {
        }
        key(Key4; "Reading DateTime")
        {
        }
        key(Key5; "Alert Level")
        {
        }
    }

    trigger OnInsert()
    var
        SensorConfig: Record "RWMS Sensor Configuration";
    begin
        if "Created By" = '' then
            "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));

        // Update last reading in sensor configuration
        if SensorConfig.Get("Sensor ID") then begin
            SensorConfig."Last Reading DateTime" := "Reading DateTime";
            SensorConfig."Last Reading Value" := Value;
            SensorConfig.Modify();
        end;
    end;
}
