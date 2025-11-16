enum 50001 "RWMS Sensor Status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; Inactive)
    {
        Caption = 'Inactive';
    }
    value(2; Maintenance)
    {
        Caption = 'Maintenance';
    }
    value(3; Error)
    {
        Caption = 'Error';
    }
    value(4; Calibrating)
    {
        Caption = 'Calibrating';
    }
}
