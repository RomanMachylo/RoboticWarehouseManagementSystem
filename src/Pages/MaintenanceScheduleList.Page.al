page 50015 "RWMS Maintenance Schedule List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Maintenance Schedule";
    CardPageId = "RWMS Maintenance Schedule Card";
    Caption = 'Maintenance Schedule';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Schedule ID"; Rec."Schedule ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the schedule ID.';
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
                field("Maintenance Type"; Rec."Maintenance Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maintenance type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the scheduled date.';
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the scheduled time.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Technician Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the technician name.';
                }
                field("Duration (Hours)"; Rec."Duration (Hours)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the duration in hours.';
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost.';
                }
                field("Next Maintenance Date"; Rec."Next Maintenance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next maintenance date.';
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
            action(Complete)
            {
                ApplicationArea = All;
                Caption = 'Complete Maintenance';
                ToolTip = 'Mark maintenance as completed.';
                Image = Completed;
                Enabled = CanComplete;

                trigger OnAction()
                begin
                    Rec."Completed Date" := Today();
                    Rec."Completed Time" := Time();
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(ViewSensor)
            {
                ApplicationArea = All;
                Caption = 'View Sensor';
                ToolTip = 'View sensor configuration.';
                Image = Setup;
                RunObject = page "RWMS Sensor Config Card";
                RunPageLink = "Sensor ID" = field("Sensor ID");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Complete_Promoted; Complete)
                {
                }
                actionref(ViewSensor_Promoted; ViewSensor)
                {
                }
            }
        }
    }

    var
        CanComplete: Boolean;

    trigger OnAfterGetRecord()
    begin
        CanComplete := Rec.Status in [Rec.Status::Assigned, Rec.Status::"In Progress"];
    end;
}
