page 50013 "RWMS Alert History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Alert History";
    CardPageId = "RWMS Alert History Card";
    Caption = 'Alert History';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Sensor Type"; Rec."Sensor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor type.';
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alert was created.';
                }
                field("Alert Level"; Rec."Alert Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert level.';
                    Style = Attention;
                    StyleExpr = IsHighPriority;
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
                }
                field("Sensor Value"; Rec."Sensor Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor value that triggered the alert.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the alert is assigned to.';
                }
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
                field(Escalated; Rec.Escalated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the alert was escalated.';
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
            action(Acknowledge)
            {
                ApplicationArea = All;
                Caption = 'Acknowledge';
                ToolTip = 'Acknowledge this alert.';
                Image = Approve;
                Enabled = CanAcknowledge;

                trigger OnAction()
                begin
                    Rec."Acknowledged By" := UserId();
                    Rec."Acknowledged DateTime" := CurrentDateTime();
                    Rec.Status := Rec.Status::Acknowledged;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(Resolve)
            {
                ApplicationArea = All;
                Caption = 'Resolve';
                ToolTip = 'Mark this alert as resolved.';
                Image = Completed;
                Enabled = CanResolve;

                trigger OnAction()
                begin
                    Rec."Resolved DateTime" := CurrentDateTime();
                    Rec.Status := Rec.Status::Resolved;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(CreateWorkOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Work Order';
                ToolTip = 'Create a work order from this alert.';
                Image = NewDocument;

                trigger OnAction()
                var
                    WorkOrder: Record "RWMS Work Order";
                    WorkOrderCard: Page "RWMS Work Order Card";
                begin
                    WorkOrder.Init();
                    WorkOrder."Related Alert ID" := Rec."Alert ID";
                    WorkOrder."Related Sensor ID" := Rec."Sensor ID";
                    WorkOrder."Warehouse Code" := Rec."Warehouse Code";
                    WorkOrder."Zone Code" := Rec."Zone Code";
                    WorkOrder.Description := Rec."Alert Message";
                    WorkOrder.Priority := ConvertAlertLevelToPriority(Rec."Alert Level");
                    WorkOrder.Insert(true);

                    Rec."Related Work Order No." := WorkOrder."Work Order No.";
                    Rec.Modify(true);

                    WorkOrderCard.SetRecord(WorkOrder);
                    WorkOrderCard.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Acknowledge_Promoted; Acknowledge)
                {
                }
                actionref(Resolve_Promoted; Resolve)
                {
                }
                actionref(CreateWorkOrder_Promoted; CreateWorkOrder)
                {
                }
            }
        }
    }

    var
        IsHighPriority: Boolean;
        CanAcknowledge: Boolean;
        CanResolve: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsHighPriority := Rec."Alert Level" in [Rec."Alert Level"::Critical, Rec."Alert Level"::Emergency];
        CanAcknowledge := Rec.Status = Rec.Status::New;
        CanResolve := Rec.Status in [Rec.Status::Acknowledged, Rec.Status::"In Progress"];
    end;

    local procedure ConvertAlertLevelToPriority(AlertLevel: Enum "RWMS Alert Level"): Enum "RWMS Work Order Priority"
    var
        Priority: Enum "RWMS Work Order Priority";
    begin
        case AlertLevel of
            AlertLevel::Normal:
                exit(Priority::Low);
            AlertLevel::Warning:
                exit(Priority::Medium);
            AlertLevel::Critical:
                exit(Priority::High);
            AlertLevel::Emergency:
                exit(Priority::Emergency);
        end;
    end;
}
