page 50016 "RWMS Maintenance Schedule Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RWMS Maintenance Schedule";
    Caption = 'Maintenance Schedule Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
            }
            group(Schedule)
            {
                Caption = 'Schedule';

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
                field("Completed Date"; Rec."Completed Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completed date.';
                }
                field("Completed Time"; Rec."Completed Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completed time.';
                }
                field("Next Maintenance Date"; Rec."Next Maintenance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next maintenance date.';
                }
            }
            group(Technician)
            {
                Caption = 'Technician';

                field("Technician Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the technician name.';
                }
                field("Technician Contact"; Rec."Technician Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the technician contact.';
                }
            }
            group(Duration)
            {
                Caption = 'Duration & Cost';

                field("Estimated Duration (Hours)"; Rec."Estimated Duration (Hours)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated duration in hours.';
                }
                field("Duration (Hours)"; Rec."Duration (Hours)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual duration in hours.';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated cost.';
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost.';
                }
            }
            group(Details)
            {
                Caption = 'Details';

                field("Parts Used"; Rec."Parts Used")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the parts used.';
                    MultiLine = true;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies notes.';
                    MultiLine = true;
                }
                field("Completion Notes"; Rec."Completion Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies completion notes.';
                    MultiLine = true;
                }
            }
            group(Recurrence)
            {
                Caption = 'Recurrence';

                field(Recurring; Rec.Recurring)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a recurring maintenance.';
                }
                field("Recurrence Interval (Days)"; Rec."Recurrence Interval (Days)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recurrence interval in days.';
                }
            }
            group(Metadata)
            {
                Caption = 'Metadata';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created this schedule.';
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this schedule was created.';
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

                actionref(ViewSensor_Promoted; ViewSensor)
                {
                }
            }
        }
    }
}
