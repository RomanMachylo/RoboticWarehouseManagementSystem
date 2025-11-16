page 50012 "RWMS Sensor Config API"
{
    PageType = API;
    APIPublisher = 'romanmachylo';
    APIGroup = 'warehouse';
    APIVersion = 'v1.0';
    EntityName = 'sensorConfiguration';
    EntitySetName = 'sensorConfigurations';
    SourceTable = "RWMS Sensor Configuration";
    DelayedInsert = true;
    ODataKeyFields = "Sensor ID";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(location; Rec.Location)
                {
                    Caption = 'Location';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(minValue; Rec."Min Value")
                {
                    Caption = 'Min Value';
                }
                field(maxValue; Rec."Max Value")
                {
                    Caption = 'Max Value';
                }
                field(warningThresholdMin; Rec."Warning Threshold Min")
                {
                    Caption = 'Warning Threshold Min';
                }
                field(warningThresholdMax; Rec."Warning Threshold Max")
                {
                    Caption = 'Warning Threshold Max';
                }
                field(criticalThresholdMin; Rec."Critical Threshold Min")
                {
                    Caption = 'Critical Threshold Min';
                }
                field(criticalThresholdMax; Rec."Critical Threshold Max")
                {
                    Caption = 'Critical Threshold Max';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(pollingInterval; Rec."Polling Interval (Sec)")
                {
                    Caption = 'Polling Interval (Sec)';
                }
                field(lastReadingDateTime; Rec."Last Reading DateTime")
                {
                    Caption = 'Last Reading DateTime';
                }
                field(lastReadingValue; Rec."Last Reading Value")
                {
                    Caption = 'Last Reading Value';
                }
                field(installationDate; Rec."Installation Date")
                {
                    Caption = 'Installation Date';
                }
                field(maintenanceDueDate; Rec."Maintenance Due Date")
                {
                    Caption = 'Maintenance Due Date';
                }
                field(manufacturer; Rec.Manufacturer)
                {
                    Caption = 'Manufacturer';
                }
                field(model; Rec.Model)
                {
                    Caption = 'Model';
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(apiEndpoint; Rec."API Endpoint")
                {
                    Caption = 'API Endpoint';
                }
                field(alertEnabled; Rec."Alert Enabled")
                {
                    Caption = 'Alert Enabled';
                }
                field(alertEmail; Rec."Alert Email")
                {
                    Caption = 'Alert Email';
                }
            }
        }
    }
}
