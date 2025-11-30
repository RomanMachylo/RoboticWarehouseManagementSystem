page 50004 "RWMS Sensor Data List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Sensor Data";
    Caption = 'Sensor Data';
    Editable = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

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
                    ToolTip = 'Specifies the type of sensor.';
                }
                field("Reading DateTime"; Rec."Reading DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reading date and time.';
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor reading value.';
                    Style = Unfavorable;
                    StyleExpr = IsAbnormal;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure.';
                }
                field("Alert Level"; Rec."Alert Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert level.';
                    Style = Attention;
                    StyleExpr = IsAlert;
                }
                field("Alert Message"; Rec."Alert Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert message.';
                }
                field("Is Anomaly"; Rec."Is Anomaly")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this reading is an anomaly.';
                }
                field("AI Analysis Result"; Rec."AI Analysis Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AI analysis result.';
                }
                field("Battery Level"; Rec."Battery Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensor battery level.';
                }
                field("Signal Strength"; Rec."Signal Strength")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the signal strength.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                ToolTip = 'Export sensor data to Excel.';
                Image = ExportToExcel;

                trigger OnAction()
                var
                    SensorData: Record "RWMS Sensor Data";
                begin
                    SensorData.Copy(Rec);
                    CurrPage.SetSelectionFilter(SensorData);
                    // Export functionality would be implemented here
                    Message('Export functionality will be available in the full implementation.');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ExportToExcel_Promoted; ExportToExcel)
                {
                }
            }
        }
    }

    var
        IsAbnormal: Boolean;
        IsAlert: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsAbnormal := Rec."Is Anomaly";
        IsAlert := Rec."Alert Level" in [Rec."Alert Level"::Warning, Rec."Alert Level"::Critical, Rec."Alert Level"::Emergency];
    end;
}
