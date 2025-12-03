page 50019 "RWMS Zone Config List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Zone Configuration";
    CardPageId = "RWMS Zone Config Card";
    Caption = 'Zone Configurations';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                    Style = Attention;
                    StyleExpr = IsHighOccupancy;
                }
                field("Access Level"; Rec."Access Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the access level.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the zone is active.';
                }
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
            }
        }
    }

    var
        IsHighOccupancy: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsHighOccupancy := Rec."Occupancy Percentage" > 85;
    end;
}
