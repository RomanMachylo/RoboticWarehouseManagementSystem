page 50006 "RWMS Dashboard"
{
    PageType = RoleCenter;
    Caption = 'Robotic Warehouse Management Dashboard';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Order Processor")
            {
                ApplicationArea = All;
            }
            part(WarehouseActivities; "RWMS Activities")
            {
                ApplicationArea = All;
            }
            part(SensorAlerts; "RWMS Sensor Alerts Part")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Warehouses)
            {
                Caption = 'Warehouses';
                Image = Warehouse;

                action(WarehouseList)
                {
                    ApplicationArea = All;
                    Caption = 'Warehouses';
                    ToolTip = 'View and manage warehouses.';
                    RunObject = page "RWMS Warehouse List";
                }
                action(Zones)
                {
                    ApplicationArea = All;
                    Caption = 'Zone Configurations';
                    ToolTip = 'Configure warehouse zones.';
                    RunObject = page "RWMS Zone Config List";
                }
                action(SensorConfigurations)
                {
                    ApplicationArea = All;
                    Caption = 'Sensor Configurations';
                    ToolTip = 'Configure sensors for warehouses.';
                    RunObject = page "RWMS Sensor Config List";
                }
            }
            group(Monitoring)
            {
                Caption = 'Monitoring';
                Image = Statistics;

                action(SensorData)
                {
                    ApplicationArea = All;
                    Caption = 'Sensor Data';
                    ToolTip = 'View real-time sensor data.';
                    RunObject = page "RWMS Sensor Data List";
                }
                action(Alerts)
                {
                    ApplicationArea = All;
                    Caption = 'Alert History';
                    ToolTip = 'View alert history and manage alerts.';
                    RunObject = page "RWMS Alert History List";
                }
                action(Analytics)
                {
                    ApplicationArea = All;
                    Caption = 'Analytics';
                    ToolTip = 'View analytics and AI insights.';
                    RunObject = page "RWMS Analytics Log List";
                }
                action(PerformanceMetrics)
                {
                    ApplicationArea = All;
                    Caption = 'Performance Metrics';
                    ToolTip = 'View performance metrics.';
                    RunObject = page "RWMS Performance Metrics List";
                }
            }
            group(Maintenance)
            {
                Caption = 'Maintenance';
                Image = ServiceTasks;

                action(WorkOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Work Orders';
                    ToolTip = 'View and manage work orders.';
                    RunObject = page "RWMS Work Order List";
                }
                action(MaintenanceSchedule)
                {
                    ApplicationArea = All;
                    Caption = 'Maintenance Schedule';
                    ToolTip = 'View and manage maintenance schedules.';
                    RunObject = page "RWMS Maintenance Schedule List";
                }
            }
        }
        area(Embedding)
        {
            action(Warehouses_Embed)
            {
                ApplicationArea = All;
                Caption = 'Warehouses';
                ToolTip = 'View and manage warehouses.';
                RunObject = page "RWMS Warehouse List";
            }
            action(WorkOrders_Embed)
            {
                ApplicationArea = All;
                Caption = 'Work Orders';
                ToolTip = 'View and manage work orders.';
                RunObject = page "RWMS Work Order List";
            }
            action(Alerts_Embed)
            {
                ApplicationArea = All;
                Caption = 'Alerts';
                ToolTip = 'View alert history.';
                RunObject = page "RWMS Alert History List";
            }
            action(SensorData_Embed)
            {
                ApplicationArea = All;
                Caption = 'Sensor Data';
                ToolTip = 'View real-time sensor data.';
                RunObject = page "RWMS Sensor Data List";
            }
            action(Analytics_Embed)
            {
                ApplicationArea = All;
                Caption = 'Analytics';
                ToolTip = 'View analytics and AI insights.';
                RunObject = page "RWMS Analytics Log List";
            }
        }
        area(Creation)
        {
            action(NewWarehouse)
            {
                ApplicationArea = All;
                Caption = 'New Warehouse';
                ToolTip = 'Create a new warehouse.';
                Image = NewWarehouse;
                RunObject = page "RWMS Warehouse Card";
                RunPageMode = Create;
            }
            action(NewZone)
            {
                ApplicationArea = All;
                Caption = 'New Zone';
                ToolTip = 'Create a new zone configuration.';
                Image = NewItem;
                RunObject = page "RWMS Zone Config Card";
                RunPageMode = Create;
            }
            action(NewSensor)
            {
                ApplicationArea = All;
                Caption = 'New Sensor Configuration';
                ToolTip = 'Create a new sensor configuration.';
                Image = NewItem;
                RunObject = page "RWMS Sensor Config Card";
                RunPageMode = Create;
            }
            action(NewWorkOrder)
            {
                ApplicationArea = All;
                Caption = 'New Work Order';
                ToolTip = 'Create a new work order.';
                Image = NewDocument;
                RunObject = page "RWMS Work Order Card";
                RunPageMode = Create;
            }
            action(NewMaintenance)
            {
                ApplicationArea = All;
                Caption = 'New Maintenance Schedule';
                ToolTip = 'Create a new maintenance schedule.';
                Image = NewTimeSheet;
                RunObject = page "RWMS Maintenance Schedule Card";
                RunPageMode = Create;
            }
        }
    }
}
