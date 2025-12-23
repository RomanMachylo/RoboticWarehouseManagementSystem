page 50000 "RWMS Warehouse List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Warehouse";
    CardPageId = "RWMS Warehouse Card";
    Caption = 'Warehouses';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse name.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse status.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related location code.';
                }
                field("Active Robots"; Rec."Active Robots")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of active robots.';
                }
                field("Total Sensors"; Rec."Total Sensors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of sensors.';
                }
                field("AI Analytics Enabled"; Rec."AI Analytics Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if AI analytics is enabled.';
                }
                field("Last Data Update"; Rec."Last Data Update")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last data update timestamp.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control2; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SensorData)
            {
                ApplicationArea = All;
                Caption = 'Sensor Data';
                ToolTip = 'View sensor data for this warehouse.';
                Image = DataEntry;
                RunObject = page "RWMS Sensor Data List";
                RunPageLink = "Warehouse Code" = field(Code);
            }
            action(SensorConfig)
            {
                ApplicationArea = All;
                Caption = 'Sensor Configuration';
                ToolTip = 'View and configure sensors for this warehouse.';
                Image = Setup;
                RunObject = page "RWMS Sensor Config List";
                RunPageLink = "Warehouse Code" = field(Code);
            }
            action(Analytics)
            {
                ApplicationArea = All;
                Caption = 'Analytics';
                ToolTip = 'View analytics for this warehouse.';
                Image = Analytics;
                RunObject = page "RWMS Analytics Log List";
                RunPageLink = "Warehouse Code" = field(Code);
            }

            action(GenerateSampleData)
            {
                ApplicationArea = All;
                Caption = 'Generate Sample Data';
                ToolTip = 'Generate realistic sample data for demonstration purposes.';
                Image = CreateDocument;

                trigger OnAction()
                var
                    SampleDataGenerator: Codeunit "RWMS Sample Data Generator";
                begin
                    SampleDataGenerator.GenerateAllSampleData();
                end;
            }
        }
        area(Navigation)
        {
            action(Dashboard)
            {
                ApplicationArea = All;
                Caption = 'Open Dashboard';
                ToolTip = 'Open the warehouse management dashboard.';
                Image = Dashboard;
                RunObject = page "RWMS Dashboard";
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(SensorData_Promoted; SensorData)
                {
                }
                actionref(SensorConfig_Promoted; SensorConfig)
                {
                }
                actionref(Analytics_Promoted; Analytics)
                {
                }
            }
        }
    }
}
