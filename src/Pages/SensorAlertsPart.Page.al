page 50008 "RWMS Sensor Alerts Part"
{
    PageType = ListPart;
    SourceTable = "RWMS Sensor Data";
    Caption = 'Recent Sensor Alerts';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Reading DateTime"; Rec."Reading DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert occurred.';
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Sensor ID"; Rec."Sensor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor ID.';
                }
                field("Sensor Type"; Rec."Sensor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor type.';
                }
                field("Alert Level"; Rec."Alert Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert level.';
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Alert Message"; Rec."Alert Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert message.';
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor value.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Alert Level", '<>%1', Rec."Alert Level"::Normal);
        Rec.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today() - 7, 0T));
        Rec.SetCurrentKey("Reading DateTime");
        Rec.Ascending(false);
    end;
}
