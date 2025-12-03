enum 50003 "RWMS Alert Status"
{
    Extensible = true;

    value(0; New)
    {
        Caption = 'New';
    }
    value(1; Acknowledged)
    {
        Caption = 'Acknowledged';
    }
    value(2; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(3; Resolved)
    {
        Caption = 'Resolved';
    }
    value(4; Closed)
    {
        Caption = 'Closed';
    }
    value(5; Escalated)
    {
        Caption = 'Escalated';
    }
}
