table 50007 "RWMS Zone Configuration"
{
    Caption = 'Zone Configuration';
    DataClassification = ToBeClassified;
    LookupPageId = "RWMS Zone Config List";
    DrillDownPageId = "RWMS Zone Config List";

    fields
    {
        field(1; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Zone Name"; Text[100])
        {
            Caption = 'Zone Name';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Zone Type"; Enum "RWMS Zone Type")
        {
            Caption = 'Zone Type';
            DataClassification = ToBeClassified;
        }
        field(6; "Temperature Min"; Decimal)
        {
            Caption = 'Temperature Min';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(7; "Temperature Max"; Decimal)
        {
            Caption = 'Temperature Max';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(8; "Humidity Min"; Decimal)
        {
            Caption = 'Humidity Min';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(9; "Humidity Max"; Decimal)
        {
            Caption = 'Humidity Max';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(10; "Square Meters"; Decimal)
        {
            Caption = 'Square Meters';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(11; "Max Capacity"; Decimal)
        {
            Caption = 'Max Capacity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(12; "Current Occupancy"; Decimal)
        {
            Caption = 'Current Occupancy';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(13; "Occupancy Percentage"; Decimal)
        {
            Caption = 'Occupancy Percentage';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(14; "Access Level"; Option)
        {
            Caption = 'Access Level';
            DataClassification = ToBeClassified;
            OptionMembers = Public,Restricted,"High Security",Quarantine;
            OptionCaption = 'Public,Restricted,High Security,Quarantine';
        }
        field(15; "Special Requirements"; Text[250])
        {
            Caption = 'Special Requirements';
            DataClassification = ToBeClassified;
        }
        field(16; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(17; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            DataClassification = ToBeClassified;
        }
        field(18; "Total Sensors"; Integer)
        {
            Caption = 'Total Sensors';
            FieldClass = FlowField;
            CalcFormula = count("RWMS Sensor Configuration" where("Zone Code" = field("Zone Code")));
            Editable = false;
        }
        field(19; "Active Sensors"; Integer)
        {
            Caption = 'Active Sensors';
            FieldClass = FlowField;
            CalcFormula = count("RWMS Sensor Configuration" where("Zone Code" = field("Zone Code"), Status = const(Active)));
            Editable = false;
        }
        field(20; "Last Inspection Date"; Date)
        {
            Caption = 'Last Inspection Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Next Inspection Date"; Date)
        {
            Caption = 'Next Inspection Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Fire Safety Compliant"; Boolean)
        {
            Caption = 'Fire Safety Compliant';
            DataClassification = ToBeClassified;
        }
        field(23; "Environmental Compliant"; Boolean)
        {
            Caption = 'Environmental Compliant';
            DataClassification = ToBeClassified;
        }
        field(24; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Zone Code")
        {
            Clustered = true;
        }
        key(Warehouse; "Warehouse Code", "Zone Type")
        {
        }
        key(ZoneType; "Zone Type", Active)
        {
        }
    }

    trigger OnInsert()
    begin
        if not Active then
            Active := true;
    end;

    trigger OnModify()
    begin
        CalculateOccupancyPercentage();
    end;

    local procedure CalculateOccupancyPercentage()
    begin
        if "Max Capacity" <> 0 then
            "Occupancy Percentage" := Round(("Current Occupancy" / "Max Capacity") * 100, 0.01);
    end;
}
