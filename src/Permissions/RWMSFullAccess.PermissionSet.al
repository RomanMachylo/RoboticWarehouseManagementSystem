permissionset 50000 "RWMS Full Access"
{
    Assignable = true;
    Caption = 'Robotic Warehouse Management - Full Access';

    Permissions =
        tabledata "RWMS Warehouse" = RIMD,
        tabledata "RWMS Sensor Configuration" = RIMD,
        tabledata "RWMS Sensor Data" = RIMD,
        tabledata "RWMS Analytics Log" = RIMD,
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
        page "RWMS Sensor Alerts Part" = X,
        page "RWMS Sensor Data API" = X,
        page "RWMS Warehouse API" = X,
        page "RWMS Sensor Config API" = X,
        codeunit "RWMS Sensor Data Management" = X,
        codeunit "RWMS AI Analytics" = X;
}
