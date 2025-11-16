table 50000 "RWMS Warehouse"
{
    Caption = 'Warehouse';
    DataClassification = CustomerContent;
    LookupPageId = "RWMS Warehouse List";
    DrillDownPageId = "RWMS Warehouse List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(5; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(9; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(11; "Square Meters"; Decimal)
        {
            Caption = 'Square Meters';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(12; "Max Capacity"; Decimal)
        {
            Caption = 'Max Capacity';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(13; "Active Robots"; Integer)
        {
            Caption = 'Active Robots';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Total Sensors"; Integer)
        {
            Caption = 'Total Sensors';
            FieldClass = FlowField;
            CalcFormula = count("RWMS Sensor Configuration" where("Warehouse Code" = field(Code)));
            Editable = false;
        }
        field(15; "Last Data Update"; DateTime)
        {
            Caption = 'Last Data Update';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Active,Inactive,Maintenance;
            OptionCaption = 'Active,Inactive,Maintenance';
        }
        field(17; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            DataClassification = CustomerContent;
        }
        field(18; "Operating Hours"; Text[50])
        {
            Caption = 'Operating Hours';
            DataClassification = CustomerContent;
        }
        field(19; "AI Analytics Enabled"; Boolean)
        {
            Caption = 'AI Analytics Enabled';
            DataClassification = CustomerContent;
        }
        field(20; Notes; Blob)
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, City, Status)
        {
        }
        fieldgroup(Brick; Code, Name, City)
        {
        }
    }

    trigger OnDelete()
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
    begin
        SensorConfig.SetRange("Warehouse Code", Code);
        SensorConfig.DeleteAll(true);

        SensorData.SetRange("Warehouse Code", Code);
        SensorData.DeleteAll(true);
    end;
}
