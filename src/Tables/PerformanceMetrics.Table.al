table 50008 "RWMS Performance Metrics"
{
    Caption = 'Performance Metrics';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Performance Metrics List";
    DrillDownPageId = "RWMS Performance Metrics List";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Zone Configuration";
        }
        field(4; "Metric Date"; Date)
        {
            Caption = 'Metric Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Metric Hour"; Integer)
        {
            Caption = 'Metric Hour';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 23;
        }
        field(6; "Metric Type"; Option)
        {
            Caption = 'Metric Type';
            DataClassification = ToBeClassified;
            OptionMembers = Hourly,Daily,Weekly,Monthly;
            OptionCaption = 'Hourly,Daily,Weekly,Monthly';
        }
        field(10; "Avg Temperature"; Decimal)
        {
            Caption = 'Avg Temperature';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(11; "Min Temperature"; Decimal)
        {
            Caption = 'Min Temperature';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(12; "Max Temperature"; Decimal)
        {
            Caption = 'Max Temperature';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(13; "Avg Humidity"; Decimal)
        {
            Caption = 'Avg Humidity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(14; "Min Humidity"; Decimal)
        {
            Caption = 'Min Humidity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(15; "Max Humidity"; Decimal)
        {
            Caption = 'Max Humidity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(16; "Avg CO2 Level"; Decimal)
        {
            Caption = 'Avg CO2 Level';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(20; "Total Alert Count"; Integer)
        {
            Caption = 'Total Alert Count';
            DataClassification = ToBeClassified;
        }
        field(21; "Critical Alert Count"; Integer)
        {
            Caption = 'Critical Alert Count';
            DataClassification = ToBeClassified;
        }
        field(22; "Warning Alert Count"; Integer)
        {
            Caption = 'Warning Alert Count';
            DataClassification = ToBeClassified;
        }
        field(23; "Anomaly Count"; Integer)
        {
            Caption = 'Anomaly Count';
            DataClassification = ToBeClassified;
        }
        field(30; "Sensor Uptime Percentage"; Decimal)
        {
            Caption = 'Sensor Uptime Percentage';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(31; "Active Sensors"; Integer)
        {
            Caption = 'Active Sensors';
            DataClassification = ToBeClassified;
        }
        field(32; "Total Sensors"; Integer)
        {
            Caption = 'Total Sensors';
            DataClassification = ToBeClassified;
        }
        field(40; "Energy Consumption (kWh)"; Decimal)
        {
            Caption = 'Energy Consumption (kWh)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(41; "Energy Cost"; Decimal)
        {
            Caption = 'Energy Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(50; "Data Quality Score"; Decimal)
        {
            Caption = 'Data Quality Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(51; "Compliance Score"; Decimal)
        {
            Caption = 'Compliance Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(52; "Overall Performance Score"; Decimal)
        {
            Caption = 'Overall Performance Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(60; "Total Data Points"; Integer)
        {
            Caption = 'Total Data Points';
            DataClassification = ToBeClassified;
        }
        field(61; "Missing Data Points"; Integer)
        {
            Caption = 'Missing Data Points';
            DataClassification = ToBeClassified;
        }
        field(70; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
        }
        field(71; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Warehouse; "Warehouse Code", "Metric Date", "Metric Hour")
        {
        }
        key(Zone; "Zone Code", "Metric Date")
        {
        }
        key(Date; "Metric Date", "Metric Type")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime();
        CalculateOverallScore();
    end;

    trigger OnModify()
    begin
        CalculateOverallScore();
    end;

    local procedure CalculateOverallScore()
    var
        Score: Decimal;
        Weights: Decimal;
    begin
        Score := 0;
        Weights := 0;

        // Sensor uptime (30%)
        if "Sensor Uptime Percentage" > 0 then begin
            Score += "Sensor Uptime Percentage" * 0.3;
            Weights += 0.3;
        end;

        // Data quality (25%)
        if "Data Quality Score" > 0 then begin
            Score += "Data Quality Score" * 0.25;
            Weights += 0.25;
        end;

        // Compliance (25%)
        if "Compliance Score" > 0 then begin
            Score += "Compliance Score" * 0.25;
            Weights += 0.25;
        end;

        // Alert frequency (20% - inverted, fewer alerts = better)
        if "Total Sensors" > 0 then begin
            Score += (100 - MinValue(100, ("Total Alert Count" / "Total Sensors") * 10)) * 0.2;
            Weights += 0.2;
        end;

        if Weights > 0 then
            "Overall Performance Score" := Round(Score / Weights, 0.01);
    end;

    local procedure MinValue(Value1: Decimal; Value2: Decimal): Decimal
    begin
        if Value1 < Value2 then
            exit(Value1);
        exit(Value2);
    end;
}
