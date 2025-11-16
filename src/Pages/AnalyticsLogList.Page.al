page 50005 "RWMS Analytics Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RWMS Analytics Log";
    Caption = 'Analytics Log';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

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
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse code.';
                }
                field("Analysis DateTime"; Rec."Analysis DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the analysis was performed.';
                }
                field("Analysis Type"; Rec."Analysis Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of analysis.';
                }
                field("Analysis Result"; Rec."Analysis Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the analysis result.';
                }
                field("AI Model Used"; Rec."AI Model Used")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AI model used for analysis.';
                }
                field("Confidence Score"; Rec."Confidence Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the confidence score of the analysis.';
                }
                field("Alert Level"; Rec."Alert Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the alert level.';
                    Style = Attention;
                    StyleExpr = IsAlert;
                }
                field("Data Points Analyzed"; Rec."Data Points Analyzed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of data points analyzed.';
                }
                field("Processing Time (ms)"; Rec."Processing Time (ms)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the processing time in milliseconds.';
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any action taken based on the analysis.';
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
            action(ViewRecommendations)
            {
                ApplicationArea = All;
                Caption = 'View Recommendations';
                ToolTip = 'View detailed recommendations from the analysis.';
                Image = Info;

                trigger OnAction()
                var
                    Recommendations: Text;
                begin
                    Recommendations := Rec.GetRecommendations();
                    if Recommendations <> '' then
                        Message(Recommendations)
                    else
                        Message('No recommendations available for this analysis.');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ViewRecommendations_Promoted; ViewRecommendations)
                {
                }
            }
        }
    }

    var
        IsAlert: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsAlert := Rec."Alert Level" in [Rec."Alert Level"::Warning, Rec."Alert Level"::Critical, Rec."Alert Level"::Emergency];
    end;
}
