page 50017 "RWMS Work Order List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Work Order";
    CardPageId = "RWMS Work Order Card";
    Caption = 'Work Orders';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the work order number.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority.';
                    Style = Attention;
                    StyleExpr = IsHighPriority;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
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
                field("Work Type"; Rec."Work Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the work type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the work order is assigned to.';
                }
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
                field("Completed DateTime"; Rec."Completed DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the work order was completed.';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual hours worked.';
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost.';
                }
                field("Related Alert ID"; Rec."Related Alert ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related alert ID.';
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
            action(Start)
            {
                ApplicationArea = All;
                Caption = 'Start Work';
                ToolTip = 'Start working on this work order.';
                Image = Start;
                Enabled = CanStart;

                trigger OnAction()
                begin
                    Rec."Started DateTime" := CurrentDateTime();
                    Rec.Status := Rec.Status::"In Progress";
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(Complete)
            {
                ApplicationArea = All;
                Caption = 'Complete';
                ToolTip = 'Mark work order as completed.';
                Image = Completed;
                Enabled = CanComplete;

                trigger OnAction()
                begin
                    Rec."Completed DateTime" := CurrentDateTime();
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(ViewAlert)
            {
                ApplicationArea = All;
                Caption = 'View Related Alert';
                ToolTip = 'View the related alert.';
                Image = Alert;
                Enabled = HasAlert;
                RunObject = page "RWMS Alert History Card";
                RunPageLink = "Alert ID" = field("Related Alert ID");
            }
            action(ViewSensor)
            {
                ApplicationArea = All;
                Caption = 'View Related Sensor';
                ToolTip = 'View the related sensor.';
                Image = Setup;
                Enabled = HasSensor;
                RunObject = page "RWMS Sensor Config Card";
                RunPageLink = "Sensor ID" = field("Related Sensor ID");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Start_Promoted; Start)
                {
                }
                actionref(Complete_Promoted; Complete)
                {
                }
                actionref(ViewAlert_Promoted; ViewAlert)
                {
                }
                actionref(ViewSensor_Promoted; ViewSensor)
                {
                }
            }
        }
    }

    var
        IsHighPriority: Boolean;
        CanStart: Boolean;
        CanComplete: Boolean;
        HasAlert: Boolean;
        HasSensor: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsHighPriority := Rec.Priority in [Rec.Priority::Critical, Rec.Priority::Emergency];
        CanStart := Rec.Status in [Rec.Status::Open, Rec.Status::Assigned];
        CanComplete := Rec.Status = Rec.Status::"In Progress";
        HasAlert := Rec."Related Alert ID" <> '';
        HasSensor := Rec."Related Sensor ID" <> '';
    end;
}
