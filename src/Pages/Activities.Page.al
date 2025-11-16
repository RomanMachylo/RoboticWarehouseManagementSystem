page 50007 "RWMS Activities"
{
    PageType = CardPart;
    SourceTable = "RWMS Warehouse";
    Caption = 'Warehouse Activities';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(Statistics)
            {
                Caption = 'Statistics';

                field(TotalWarehouses; TotalWarehouses)
                {
                    ApplicationArea = All;
                    Caption = 'Total Warehouses';
                    ToolTip = 'Shows the total number of warehouses.';
                    StyleExpr = 'Favorable';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"RWMS Warehouse List");
                    end;
                }
                field(ActiveWarehouses; ActiveWarehouses)
                {
                    ApplicationArea = All;
                    Caption = 'Active Warehouses';
                    ToolTip = 'Shows the number of active warehouses.';
                    StyleExpr = 'Favorable';

                    trigger OnDrillDown()
                    var
                        Warehouse: Record "RWMS Warehouse";
                    begin
                        Warehouse.SetRange(Status, Warehouse.Status::Active);
                        Page.Run(Page::"RWMS Warehouse List", Warehouse);
                    end;
                }
                field(TotalSensors; TotalSensors)
                {
                    ApplicationArea = All;
                    Caption = 'Total Sensors';
                    ToolTip = 'Shows the total number of configured sensors.';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"RWMS Sensor Config List");
                    end;
                }
                field(ActiveSensors; ActiveSensors)
                {
                    ApplicationArea = All;
                    Caption = 'Active Sensors';
                    ToolTip = 'Shows the number of active sensors.';
                    StyleExpr = 'Favorable';

                    trigger OnDrillDown()
                    var
                        SensorConfig: Record "RWMS Sensor Configuration";
                    begin
                        SensorConfig.SetRange(Status, SensorConfig.Status::Active);
                        Page.Run(Page::"RWMS Sensor Config List", SensorConfig);
                    end;
                }
            }
            cuegroup(Alerts)
            {
                Caption = 'Alerts';

                field(CriticalAlerts; CriticalAlerts)
                {
                    ApplicationArea = All;
                    Caption = 'Critical Alerts';
                    ToolTip = 'Shows the number of critical alerts.';
                    StyleExpr = 'Unfavorable';

                    trigger OnDrillDown()
                    var
                        SensorData: Record "RWMS Sensor Data";
                    begin
                        SensorData.SetRange("Alert Level", SensorData."Alert Level"::Critical);
                        Page.Run(Page::"RWMS Sensor Data List", SensorData);
                    end;
                }
                field(WarningAlerts; WarningAlerts)
                {
                    ApplicationArea = All;
                    Caption = 'Warning Alerts';
                    ToolTip = 'Shows the number of warning alerts.';
                    StyleExpr = 'Attention';

                    trigger OnDrillDown()
                    var
                        SensorData: Record "RWMS Sensor Data";
                    begin
                        SensorData.SetRange("Alert Level", SensorData."Alert Level"::Warning);
                        Page.Run(Page::"RWMS Sensor Data List", SensorData);
                    end;
                }
                field(SensorsInMaintenance; SensorsInMaintenance)
                {
                    ApplicationArea = All;
                    Caption = 'Sensors in Maintenance';
                    ToolTip = 'Shows the number of sensors in maintenance.';

                    trigger OnDrillDown()
                    var
                        SensorConfig: Record "RWMS Sensor Configuration";
                    begin
                        SensorConfig.SetRange(Status, SensorConfig.Status::Maintenance);
                        Page.Run(Page::"RWMS Sensor Config List", SensorConfig);
                    end;
                }
            }
            cuegroup(Analytics)
            {
                Caption = 'AI Analytics';

                field(AIAnalyticsRuns; AIAnalyticsRuns)
                {
                    ApplicationArea = All;
                    Caption = 'AI Analysis Today';
                    ToolTip = 'Shows the number of AI analysis runs today.';

                    trigger OnDrillDown()
                    var
                        AnalyticsLog: Record "RWMS Analytics Log";
                    begin
                        AnalyticsLog.SetRange("Analysis DateTime", CreateDateTime(Today(), 0T), CreateDateTime(Today(), 235959T));
                        Page.Run(Page::"RWMS Analytics Log List", AnalyticsLog);
                    end;
                }
                field(AnomaliesDetected; AnomaliesDetected)
                {
                    ApplicationArea = All;
                    Caption = 'Anomalies Today';
                    ToolTip = 'Shows the number of anomalies detected today.';
                    StyleExpr = 'Attention';

                    trigger OnDrillDown()
                    var
                        SensorData: Record "RWMS Sensor Data";
                    begin
                        SensorData.SetRange("Is Anomaly", true);
                        SensorData.SetRange("Reading DateTime", CreateDateTime(Today(), 0T), CreateDateTime(Today(), 235959T));
                        Page.Run(Page::"RWMS Sensor Data List", SensorData);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CalculateStatistics();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateStatistics();
    end;

    local procedure CalculateStatistics()
    var
        Warehouse: Record "RWMS Warehouse";
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        AnalyticsLog: Record "RWMS Analytics Log";
    begin
        TotalWarehouses := Warehouse.Count();
        Warehouse.SetRange(Status, Warehouse.Status::Active);
        ActiveWarehouses := Warehouse.Count();

        TotalSensors := SensorConfig.Count();
        SensorConfig.SetRange(Status, SensorConfig.Status::Active);
        ActiveSensors := SensorConfig.Count();

        SensorConfig.Reset();
        SensorConfig.SetRange(Status, SensorConfig.Status::Maintenance);
        SensorsInMaintenance := SensorConfig.Count();

        SensorData.SetRange("Alert Level", SensorData."Alert Level"::Critical);
        CriticalAlerts := SensorData.Count();

        SensorData.SetRange("Alert Level", SensorData."Alert Level"::Warning);
        WarningAlerts := SensorData.Count();

        AnalyticsLog.SetRange("Analysis DateTime", CreateDateTime(Today(), 0T), CreateDateTime(Today(), 235959T));
        AIAnalyticsRuns := AnalyticsLog.Count();

        SensorData.Reset();
        SensorData.SetRange("Is Anomaly", true);
        SensorData.SetRange("Reading DateTime", CreateDateTime(Today(), 0T), CreateDateTime(Today(), 235959T));
        AnomaliesDetected := SensorData.Count();
    end;

    var
        TotalWarehouses: Integer;
        ActiveWarehouses: Integer;
        TotalSensors: Integer;
        ActiveSensors: Integer;
        CriticalAlerts: Integer;
        WarningAlerts: Integer;
        SensorsInMaintenance: Integer;
        AIAnalyticsRuns: Integer;
        AnomaliesDetected: Integer;
}
