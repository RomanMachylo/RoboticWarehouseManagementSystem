page 50020 "RWMS Zone Config Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Zone Configuration";
    Caption = 'Zone Configuration Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone code.';
                }
                field("Zone Name"; Rec."Zone Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone name.';
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Zone Type"; Rec."Zone Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                    MultiLine = true;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the zone is active.';
                }
                field("Manager Name"; Rec."Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manager name.';
                }
            }
            group(Environmental)
            {
                Caption = 'Environmental Controls';

                field("Temperature Min"; Rec."Temperature Min")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum temperature.';
                }
                field("Temperature Max"; Rec."Temperature Max")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum temperature.';
                }
                field("Humidity Min"; Rec."Humidity Min")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum humidity.';
                }
                field("Humidity Max"; Rec."Humidity Max")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum humidity.';
                }
            }
            group(Capacity)
            {
                Caption = 'Capacity';

                field("Square Meters"; Rec."Square Meters")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the square meters.';
                }
                field("Max Capacity"; Rec."Max Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum capacity.';
                }
                field("Current Occupancy"; Rec."Current Occupancy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current occupancy.';
                }
                field("Occupancy Percentage"; Rec."Occupancy Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the occupancy percentage.';
                }
            }
            group(Security)
            {
                Caption = 'Security & Compliance';

                field("Access Level"; Rec."Access Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the access level.';
                }
                field("Special Requirements"; Rec."Special Requirements")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies special requirements.';
                    MultiLine = true;
                }
                field("Fire Safety Compliant"; Rec."Fire Safety Compliant")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if fire safety compliant.';
                }
                field("Environmental Compliant"; Rec."Environmental Compliant")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if environmental compliant.';
                }
            }
            group(Inspection)
            {
                Caption = 'Inspection';

                field("Last Inspection Date"; Rec."Last Inspection Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last inspection date.';
                }
                field("Next Inspection Date"; Rec."Next Inspection Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next inspection date.';
                }
            }
            group(Sensors)
            {
                Caption = 'Sensors';

                field("Total Sensors"; Rec."Total Sensors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of sensors.';
                }
                field("Active Sensors"; Rec."Active Sensors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of active sensors.';
                }
            }
            group(NotesGroup)
            {
                Caption = 'Notes';

                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies notes.';
                    MultiLine = true;
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
            action(ViewSensors)
            {
                ApplicationArea = All;
                Caption = 'View Sensors';
                ToolTip = 'View sensors in this zone.';
                Image = Setup;
                RunObject = page "RWMS Sensor Config List";
                RunPageLink = "Zone Code" = field("Zone Code");
            }
            action(ViewMetrics)
            {
                ApplicationArea = All;
                Caption = 'View Performance Metrics';
                ToolTip = 'View performance metrics for this zone.';
                Image = Analytics;
                RunObject = page "RWMS Performance Metrics List";
                RunPageLink = "Zone Code" = field("Zone Code");
            }
            action(ViewWarehouse)
            {
                ApplicationArea = All;
                Caption = 'View Warehouse';
                ToolTip = 'View the warehouse this zone belongs to.';
                Image = Warehouse;
                RunObject = page "RWMS Warehouse Card";
                RunPageLink = Code = field("Warehouse Code");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewSensors_Promoted; ViewSensors)
                {
                }
                actionref(ViewMetrics_Promoted; ViewMetrics)
                {
                }
                actionref(ViewWarehouse_Promoted; ViewWarehouse)
                {
                }
            }
        }
    }
}
