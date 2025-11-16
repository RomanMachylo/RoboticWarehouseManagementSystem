page 50010 "RWMS Sensor Data API"
{
    PageType = API;
    APIPublisher = 'romanmachylo';
    APIGroup = 'warehouse';
    APIVersion = 'v1.0';
    EntityName = 'sensorData';
    EntitySetName = 'sensorData';
    SourceTable = "RWMS Sensor Data";
    DelayedInsert = true;
    ODataKeyFields = "Entry No.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(sensorId; Rec."Sensor ID")
                {
                    Caption = 'Sensor ID';
                }
                field(warehouseCode; Rec."Warehouse Code")
                {
                    Caption = 'Warehouse Code';
                }
                field(sensorType; Rec."Sensor Type")
                {
                    Caption = 'Sensor Type';
                }
                field(readingDateTime; Rec."Reading DateTime")
                {
                    Caption = 'Reading DateTime';
                }
                field(value; Rec.Value)
                {
                    Caption = 'Value';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(alertLevel; Rec."Alert Level")
                {
                    Caption = 'Alert Level';
                }
                field(alertMessage; Rec."Alert Message")
                {
                    Caption = 'Alert Message';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(batteryLevel; Rec."Battery Level")
                {
                    Caption = 'Battery Level';
                }
                field(signalStrength; Rec."Signal Strength")
                {
                    Caption = 'Signal Strength';
                }
                field(dataQualityScore; Rec."Data Quality Score")
                {
                    Caption = 'Data Quality Score';
                }
                field(isAnomaly; Rec."Is Anomaly")
                {
                    Caption = 'Is Anomaly';
                }
                field(aiAnalysisResult; Rec."AI Analysis Result")
                {
                    Caption = 'AI Analysis Result';
                }
                field(externalSystemId; Rec."External System ID")
                {
                    Caption = 'External System ID';
                }
            }
        }
    }
}
