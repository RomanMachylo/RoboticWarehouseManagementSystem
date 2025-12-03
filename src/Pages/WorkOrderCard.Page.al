page 50018 "RWMS Work Order Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Work Order";
    Caption = 'Work Order Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the work order number.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Work Type"; Rec."Work Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the work type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                    MultiLine = true;
                }
            }
            group(Location)
            {
                Caption = 'Location';

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
                field("Related Sensor ID"; Rec."Related Sensor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related sensor ID.';
                }
                field("Related Alert ID"; Rec."Related Alert ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related alert ID.';
                }
            }
            group(Assignment)
            {
                Caption = 'Assignment';

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the work order is assigned to.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the work order.';
                }
            }
            group(Schedule)
            {
                Caption = 'Schedule';

                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the work order was created.';
                }
                field("Due DateTime"; Rec."Due DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date and time.';
                }
                field("Started DateTime"; Rec."Started DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when work started.';
                }
                field("Completed DateTime"; Rec."Completed DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the work order was completed.';
                }
            }
            group(Effort)
            {
                Caption = 'Effort & Cost';

                field("Estimated Hours"; Rec."Estimated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated hours.';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual hours worked.';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated cost.';
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost.';
                }
                field("Labor Cost"; Rec."Labor Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the labor cost.';
                }
                field("Parts Cost"; Rec."Parts Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the parts cost.';
                }
            }
            group(Resolution)
            {
                Caption = 'Resolution';

                field("Parts Used"; Rec."Parts Used")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the parts used.';
                    MultiLine = true;
                }
                field("Resolution Description"; Rec."Resolution Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resolution description.';
                    MultiLine = true;
                }
                field("Root Cause"; Rec."Root Cause")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the root cause.';
                    MultiLine = true;
                }
                field("Corrective Actions"; Rec."Corrective Actions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the corrective actions.';
                    MultiLine = true;
                }
            }
            group(FollowUp)
            {
                Caption = 'Follow-up';

                field("Follow-up Required"; Rec."Follow-up Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if follow-up is required.';
                }
                field("Follow-up Date"; Rec."Follow-up Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the follow-up date.';
                }
                field("Customer Satisfaction"; Rec."Customer Satisfaction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer satisfaction rating (1-5).';
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
            action(ViewAlert)
            {
                ApplicationArea = All;
                Caption = 'View Related Alert';
                ToolTip = 'View the related alert.';
                Image = Alert;
                RunObject = page "RWMS Alert History Card";
                RunPageLink = "Alert ID" = field("Related Alert ID");
            }
            action(ViewSensor)
            {
                ApplicationArea = All;
                Caption = 'View Related Sensor';
                ToolTip = 'View the related sensor.';
                Image = Setup;
                RunObject = page "RWMS Sensor Config Card";
                RunPageLink = "Sensor ID" = field("Related Sensor ID");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewAlert_Promoted; ViewAlert)
                {
                }
                actionref(ViewSensor_Promoted; ViewSensor)
                {
                }
            }
        }
    }
}
