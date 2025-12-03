enum 50006 "RWMS Work Order Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Assigned)
    {
        Caption = 'Assigned';
    }
    value(2; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(3; "On Hold")
    {
        Caption = 'On Hold';
    }
    value(4; Completed)
    {
        Caption = 'Completed';
    }
    value(5; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(6; "Waiting for Parts")
    {
        Caption = 'Waiting for Parts';
    }
}
