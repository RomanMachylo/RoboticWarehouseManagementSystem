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
            cuegroup(WorkManagement)
            {
                Caption = 'Work Management';

                field(OpenWorkOrders; OpenWorkOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Open Work Orders';
                    ToolTip = 'Shows the number of open work orders.';
                    StyleExpr = 'Attention';

                    trigger OnDrillDown()
                    var
                        WorkOrder: Record "RWMS Work Order";
                    begin
                        WorkOrder.SetFilter(Status, '%1|%2|%3', WorkOrder.Status::Open, WorkOrder.Status::Assigned, WorkOrder.Status::"In Progress");
                        Page.Run(Page::"RWMS Work Order List", WorkOrder);
                    end;
                }
                field(HighPriorityWorkOrders; HighPriorityWorkOrders)
                {
                    ApplicationArea = All;
                    Caption = 'High Priority Work Orders';
                    ToolTip = 'Shows the number of high priority work orders.';
                    StyleExpr = 'Unfavorable';

                    trigger OnDrillDown()
                    var
                        WorkOrder: Record "RWMS Work Order";
                    begin
                        WorkOrder.SetFilter(Priority, '%1|%2', WorkOrder.Priority::Critical, WorkOrder.Priority::Emergency);
                        WorkOrder.SetFilter(Status, '<>%1', WorkOrder.Status::Completed);
                        Page.Run(Page::"RWMS Work Order List", WorkOrder);
                    end;
                }
                field(ScheduledMaintenanceToday; ScheduledMaintenanceToday)
                {
                    ApplicationArea = All;
                    Caption = 'Maintenance Scheduled Today';
                    ToolTip = 'Shows maintenance scheduled for today.';

                    trigger OnDrillDown()
                    var
                        MaintenanceSchedule: Record "RWMS Maintenance Schedule";
                    begin
                        MaintenanceSchedule.SetRange("Scheduled Date", Today());
                        Page.Run(Page::"RWMS Maintenance Schedule List", MaintenanceSchedule);
                    end;
                }
                field(OverdueWorkOrders; OverdueWorkOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Overdue Work Orders';
                    ToolTip = 'Shows the number of overdue work orders.';
                    StyleExpr = 'Unfavorable';

                    trigger OnDrillDown()
                    var
                        WorkOrder: Record "RWMS Work Order";
                    begin
                        WorkOrder.SetFilter("Due DateTime", '<%1', CurrentDateTime());
                        WorkOrder.SetFilter(Status, '<>%1', WorkOrder.Status::Completed);
                        Page.Run(Page::"RWMS Work Order List", WorkOrder);
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
        WorkOrder: Record "RWMS Work Order";
        MaintenanceSchedule: Record "RWMS Maintenance Schedule";
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

        // Work Orders
        WorkOrder.SetFilter(Status, '%1|%2|%3', WorkOrder.Status::Open, WorkOrder.Status::Assigned, WorkOrder.Status::"In Progress");
        OpenWorkOrders := WorkOrder.Count();

        WorkOrder.Reset();
        WorkOrder.SetFilter(Priority, '%1|%2', WorkOrder.Priority::Critical, WorkOrder.Priority::Emergency);
        WorkOrder.SetFilter(Status, '<>%1', WorkOrder.Status::Completed);
        HighPriorityWorkOrders := WorkOrder.Count();

        WorkOrder.Reset();
        WorkOrder.SetFilter("Due DateTime", '<%1', CurrentDateTime());
        WorkOrder.SetFilter(Status, '<>%1', WorkOrder.Status::Completed);
        OverdueWorkOrders := WorkOrder.Count();

        // Maintenance
        MaintenanceSchedule.SetRange("Scheduled Date", Today());
        ScheduledMaintenanceToday := MaintenanceSchedule.Count();
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
        OpenWorkOrders: Integer;
        HighPriorityWorkOrders: Integer;
        OverdueWorkOrders: Integer;
        ScheduledMaintenanceToday: Integer;
}
