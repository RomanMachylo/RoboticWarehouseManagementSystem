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
                action(Analytics)
                {
                    ApplicationArea = All;
                    Caption = 'Analytics';
                    ToolTip = 'View analytics and AI insights.';
                    RunObject = page "RWMS Analytics Log List";
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
            action(NewSensor)
            {
                ApplicationArea = All;
                Caption = 'New Sensor Configuration';
                ToolTip = 'Create a new sensor configuration.';
                Image = NewItem;
                RunObject = page "RWMS Sensor Config Card";
                RunPageMode = Create;
            }
        }
    }
}
