page 50002 "RWMS Sensor Config List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Sensor Configuration";
    CardPageId = "RWMS Sensor Config Card";
    Caption = 'Sensor Configurations';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Sensor ID"; Rec."Sensor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor ID.';
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Sensor Type"; Rec."Sensor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of sensor.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor description.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor location.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor status.';
                }
                field("Last Reading DateTime"; Rec."Last Reading DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last reading date and time.';
                }
                field("Last Reading Value"; Rec."Last Reading Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last reading value.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure.';
                }
                field("Alert Enabled"; Rec."Alert Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if alerts are enabled.';
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
            action(ViewSensorData)
            {
                ApplicationArea = All;
                Caption = 'View Sensor Data';
                ToolTip = 'View historical data for this sensor.';
                Image = DataEntry;
                RunObject = page "RWMS Sensor Data List";
                RunPageLink = "Sensor ID" = field("Sensor ID");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewSensorData_Promoted; ViewSensorData)
                {
                }
            }
        }
    }
}
