page 50003 "RWMS Sensor Config Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Sensor Configuration";
    Caption = 'Sensor Configuration Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor status.';
                }
            }
            group(LocationInfo)
            {
                Caption = 'Location';

                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor location within the warehouse.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone code.';
                }
            }
            group(Thresholds)
            {
                Caption = 'Thresholds & Values';

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure.';
                }
                field("Min Value"; Rec."Min Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum operational value.';
                }
                field("Max Value"; Rec."Max Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum operational value.';
                }
                field("Warning Threshold Min"; Rec."Warning Threshold Min")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warning threshold minimum.';
                }
                field("Warning Threshold Max"; Rec."Warning Threshold Max")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warning threshold maximum.';
                }
                field("Critical Threshold Min"; Rec."Critical Threshold Min")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the critical threshold minimum.';
                }
                field("Critical Threshold Max"; Rec."Critical Threshold Max")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the critical threshold maximum.';
                }
            }
            group(Configuration)
            {
                Caption = 'Configuration';

                field("Polling Interval (Sec)"; Rec."Polling Interval (Sec)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the polling interval in seconds.';
                }
                field("API Endpoint"; Rec."API Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the API endpoint for data collection.';
                }
            }
            group(Hardware)
            {
                Caption = 'Hardware Information';

                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor manufacturer.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor model.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number.';
                }
                field("Installation Date"; Rec."Installation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the installation date.';
                }
                field("Maintenance Due Date"; Rec."Maintenance Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when maintenance is due.';
                }
            }
            group(Alerts)
            {
                Caption = 'Alerts';

                field("Alert Enabled"; Rec."Alert Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if alerts are enabled for this sensor.';
                }
                field("Alert Email"; Rec."Alert Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address for alerts.';
                }
            }
            group(LastReading)
            {
                Caption = 'Last Reading';

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
