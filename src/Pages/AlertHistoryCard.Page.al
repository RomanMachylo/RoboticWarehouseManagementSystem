page 50014 "RWMS Alert History Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Alert History";
    Caption = 'Alert History Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Alert ID"; Rec."Alert ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert ID.';
                }
                field("Sensor ID"; Rec."Sensor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor ID.';
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone code.';
                }
                field("Sensor Type"; Rec."Sensor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor type.';
                }
            }
            group(AlertDetails)
            {
                Caption = 'Alert Details';

                field("Alert Level"; Rec."Alert Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert level.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert status.';
                }
                field("Alert Message"; Rec."Alert Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert message.';
                    MultiLine = true;
                }
                field("Sensor Value"; Rec."Sensor Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor value that triggered the alert.';
                }
                field(Escalated; Rec.Escalated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the alert was escalated.';
                }
                field("Escalation Reason"; Rec."Escalation Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the escalation reason.';
                }
            }
            group(Timestamps)
            {
                Caption = 'Timestamps';

                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert was created.';
                }
                field("Acknowledged DateTime"; Rec."Acknowledged DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert was acknowledged.';
                }
                field("Assigned DateTime"; Rec."Assigned DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert was assigned.';
                }
                field("Resolved DateTime"; Rec."Resolved DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert was resolved.';
                }
            }
            group(Assignment)
            {
                Caption = 'Assignment';

                field("Acknowledged By"; Rec."Acknowledged By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who acknowledged the alert.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the alert is assigned to.';
                }
            }
            group(Metrics)
            {
                Caption = 'Metrics';

                field("Response Time (Minutes)"; Rec."Response Time (Minutes)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the response time in minutes.';
                }
                field("Resolution Time (Minutes)"; Rec."Resolution Time (Minutes)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resolution time in minutes.';
                }
            }
            group(Resolution)
            {
                Caption = 'Resolution';

                field("Resolution Notes"; Rec."Resolution Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resolution notes.';
                    MultiLine = true;
                }
                field("Related Work Order No."; Rec."Related Work Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related work order number.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control2; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewSensorData)
            {
                ApplicationArea = All;
                Caption = 'View Sensor Data';
                ToolTip = 'View sensor data for this sensor.';
                Image = DataEntry;
                RunObject = page "RWMS Sensor Data List";
                RunPageLink = "Sensor ID" = field("Sensor ID");
            }
            action(ViewWorkOrder)
            {
                ApplicationArea = All;
                Caption = 'View Work Order';
                ToolTip = 'View the related work order.';
                Image = Document;
                Enabled = HasWorkOrder;
                RunObject = page "RWMS Work Order Card";
                RunPageLink = "Work Order No." = field("Related Work Order No.");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewSensorData_Promoted; ViewSensorData)
                {
                }
                actionref(ViewWorkOrder_Promoted; ViewWorkOrder)
                {
                }
            }
        }
    }

    var
        HasWorkOrder: Boolean;

    trigger OnAfterGetRecord()
    begin
        HasWorkOrder := Rec."Related Work Order No." <> '';
    end;
}
