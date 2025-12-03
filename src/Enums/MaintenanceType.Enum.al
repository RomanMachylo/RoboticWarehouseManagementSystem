enum 50004 "RWMS Maintenance Type"
{
    Extensible = true;

    value(0; Preventive)
    {
        Caption = 'Preventive';
    }
    value(1; Corrective)
    {
        Caption = 'Corrective';
    }
    value(2; Calibration)
    {
        Caption = 'Calibration';
    }
    value(3; Inspection)
    {
        Caption = 'Inspection';
    }
    value(4; Emergency)
    {
        Caption = 'Emergency';
    }
    value(5; Upgrade)
    {
        Caption = 'Upgrade';
    }
}
