page 50021 "RWMS Performance Metrics List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Performance Metrics";
    Caption = 'Performance Metrics';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone code.';
                }
                field("Metric Date"; Rec."Metric Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the metric date.';
                }
                field("Metric Type"; Rec."Metric Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the metric type.';
                }
                field("Overall Performance Score"; Rec."Overall Performance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the overall performance score.';
                    Style = Favorable;
                    StyleExpr = IsGoodScore;
                }
                field("Avg Temperature"; Rec."Avg Temperature")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the average temperature.';
                }
                field("Avg Humidity"; Rec."Avg Humidity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the average humidity.';
                }
                field("Total Alert Count"; Rec."Total Alert Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total alert count.';
                }
                field("Critical Alert Count"; Rec."Critical Alert Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the critical alert count.';
                    Style = Unfavorable;
                    StyleExpr = HasCriticalAlerts;
                }
                field("Anomaly Count"; Rec."Anomaly Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the anomaly count.';
                }
                field("Sensor Uptime Percentage"; Rec."Sensor Uptime Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor uptime percentage.';
                }
                field("Active Sensors"; Rec."Active Sensors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the active sensors.';
                }
                field("Total Sensors"; Rec."Total Sensors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total sensors.';
                }
                field("Energy Consumption (kWh)"; Rec."Energy Consumption (kWh)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the energy consumption in kWh.';
                }
                field("Energy Cost"; Rec."Energy Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the energy cost.';
                }
                field("Data Quality Score"; Rec."Data Quality Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the data quality score.';
                }
                field("Compliance Score"; Rec."Compliance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance score.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewWarehouse)
            {
                ApplicationArea = All;
                Caption = 'View Warehouse';
                ToolTip = 'View the warehouse for this metric.';
                Image = Warehouse;
                RunObject = page "RWMS Warehouse Card";
                RunPageLink = Code = field("Warehouse Code");
            }
            action(ViewZone)
            {
                ApplicationArea = All;
                Caption = 'View Zone';
                ToolTip = 'View the zone for this metric.';
                Image = FixedAssets;
                Enabled = HasZone;
                RunObject = page "RWMS Zone Config Card";
                RunPageLink = "Zone Code" = field("Zone Code");
            }
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                ToolTip = 'Export performance metrics to Excel.';
                Image = ExportToExcel;

                trigger OnAction()
                var
                    PerformanceMetrics: Record "RWMS Performance Metrics";
                begin
                    PerformanceMetrics.Copy(Rec);
                    CurrPage.SetSelectionFilter(PerformanceMetrics);
                    Message('Export functionality will be available in the full implementation.');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewWarehouse_Promoted; ViewWarehouse)
                {
                }
                actionref(ViewZone_Promoted; ViewZone)
                {
                }
                actionref(ExportToExcel_Promoted; ExportToExcel)
                {
                }
            }
        }
    }

    var
        IsGoodScore: Boolean;
        HasCriticalAlerts: Boolean;
        HasZone: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsGoodScore := Rec."Overall Performance Score" >= 80;
        HasCriticalAlerts := Rec."Critical Alert Count" > 0;
        HasZone := Rec."Zone Code" <> '';
    end;
}
