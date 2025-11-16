permissionset 50001 "RWMS Read Only"
{
    Assignable = true;
    Caption = 'Robotic Warehouse Management - Read Only';

    Permissions =
        tabledata "RWMS Warehouse" = R,
        tabledata "RWMS Sensor Configuration" = R,
        tabledata "RWMS Sensor Data" = R,
        tabledata "RWMS Analytics Log" = R,
        table "RWMS Warehouse" = X,
        table "RWMS Sensor Configuration" = X,
        table "RWMS Sensor Data" = X,
        table "RWMS Analytics Log" = X,
        page "RWMS Warehouse List" = X,
        page "RWMS Warehouse Card" = X,
        page "RWMS Sensor Config List" = X,
        page "RWMS Sensor Config Card" = X,
        page "RWMS Sensor Data List" = X,
        page "RWMS Analytics Log List" = X,
        page "RWMS Dashboard" = X,
        page "RWMS Activities" = X,
        page "RWMS Sensor Alerts Part" = X;
}
