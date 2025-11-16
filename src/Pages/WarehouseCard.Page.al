page 50001 "RWMS Warehouse Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Warehouse";
    Caption = 'Warehouse Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Manager Name"; Rec."Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager name.';
                }
                field("Operating Hours"; Rec."Operating Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the operating hours.';
                }
            }
            group(Address)
            {
                Caption = 'Address';

                field(AddressField; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                    ToolTip = 'Specifies the warehouse address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the post code.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code.';
                }
            }
            group(Contact)
            {
                Caption = 'Contact';

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address.';
                }
            }
            group(Capacity)
            {
                Caption = 'Capacity & Operations';

                field("Square Meters"; Rec."Square Meters")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse area in square meters.';
                }
                field("Max Capacity"; Rec."Max Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum capacity.';
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
            }
            group(AISettings)
            {
                Caption = 'AI & Analytics';

                field("AI Analytics Enabled"; Rec."AI Analytics Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if AI analytics is enabled for this warehouse.';
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
