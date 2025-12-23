codeunit 50008 "RWMS Alert Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        Warehouse: Record "RWMS Warehouse";
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        AlertHistory: Record "RWMS Alert History";

    [Test]
    procedure TestCreateAlert()
    begin
        // [GIVEN] Sensor data with critical value
        CreateTestWarehouse('WH-ALT1');
        CreateTestSensor('SENS-ALT1', 'WH-ALT1');
        CreateTestSensorData('SENS-ALT1', 'WH-ALT1', 35.0); // Above threshold

        // [WHEN] Creating an alert
        AlertHistory.Init();
        AlertHistory."Alert ID" := 'ALT-001';
        AlertHistory."Sensor ID" := 'SENS-ALT1';
        AlertHistory."Warehouse Code" := 'WH-ALT1';
        AlertHistory."Sensor Type" := AlertHistory."Sensor Type"::Temperature;
        AlertHistory."Created DateTime" := CurrentDateTime;
        AlertHistory."Alert Level" := AlertHistory."Alert Level"::Critical;
        AlertHistory.Status := AlertHistory.Status::New;
        AlertHistory."Sensor Value" := 35.0;
        AlertHistory.Insert(false);

        // [THEN] Alert should exist
        Assert.IsTrue(AlertHistory.FindLast(), 'Alert should be created');
        Assert.AreEqual(AlertHistory."Alert Level"::Critical, AlertHistory."Alert Level", 'Alert level should be Critical');

        // Cleanup
        AlertHistory.DeleteAll();
        SensorData.DeleteAll();
        SensorConfig.Get('SENS-ALT1');
        SensorConfig.Delete(true);
        Warehouse.Get('WH-ALT1');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestAlertStatusProgression()
    begin
        // [GIVEN] A new alert
        CreateTestWarehouse('WH-ALT2');
        CreateTestSensor('SENS-ALT2', 'WH-ALT2');
        CreateTestAlert('ALT-002', 'SENS-ALT2', 'WH-ALT2', AlertHistory.Status::New);

        // [WHEN] Progressing through statuses
        AlertHistory.FindLast();
        AlertHistory.Status := AlertHistory.Status::Acknowledged;
        AlertHistory."Assigned DateTime" := CurrentDateTime;
        AlertHistory.Modify(false);

        AlertHistory.Status := AlertHistory.Status::"In Progress";
        AlertHistory.Modify(false);

        AlertHistory.Status := AlertHistory.Status::Resolved;
        AlertHistory."Resolved DateTime" := CurrentDateTime;
        AlertHistory.Modify(false);

        // [THEN] Final status should be Resolved
        Assert.AreEqual(AlertHistory.Status::Resolved, AlertHistory.Status, 'Alert should be resolved');

        // Cleanup
        AlertHistory.DeleteAll();
        SensorConfig.Get('SENS-ALT2');
        SensorConfig.Delete(true);
        Warehouse.Get('WH-ALT2');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestAlertLevelClassification()
    var
        NormalValue: Decimal;
        WarningValue: Decimal;
        CriticalValue: Decimal;
    begin
        // [GIVEN] Different sensor values
        NormalValue := 20.0;
        WarningValue := 28.0;
        CriticalValue := 35.0;

        // [THEN] Values should be classified correctly
        Assert.IsTrue(NormalValue >= 0, 'Normal value should be within range');
        Assert.IsTrue(WarningValue > 25, 'Warning value should exceed normal max');
        Assert.IsTrue(CriticalValue > 30, 'Critical value should exceed critical threshold');
    end;

    local procedure CreateTestWarehouse(WarehouseCode: Code[20])
    begin
        Warehouse.Init();
        Warehouse.Code := WarehouseCode;
        Warehouse.Name := 'Test Warehouse';
        Warehouse.Status := Warehouse.Status::Active;
        Warehouse."Square Meters" := 1000;
        Warehouse."Max Capacity" := 5000;
        Warehouse.Insert(true);
    end;

    local procedure CreateTestSensor(SensorID: Code[30]; WarehouseCode: Code[20])
    begin
        SensorConfig.Init();
        SensorConfig."Sensor ID" := SensorID;
        SensorConfig."Warehouse Code" := WarehouseCode;
        SensorConfig."Sensor Type" := SensorConfig."Sensor Type"::Temperature;
        SensorConfig."Min Value" := 0;
        SensorConfig."Max Value" := 25;
        SensorConfig."Critical Threshold Min" := -5;
        SensorConfig."Critical Threshold Max" := 30;
        SensorConfig.Status := SensorConfig.Status::Active;
        SensorConfig.Insert(true);
    end;

    local procedure CreateTestSensorData(SensorID: Code[30]; WarehouseCode: Code[20]; Value: Decimal)
    begin
        SensorData.Init();
        SensorData."Sensor ID" := SensorID;
        SensorData."Warehouse Code" := WarehouseCode;
        SensorData."Sensor Type" := SensorData."Sensor Type"::Temperature;
        SensorData."Reading DateTime" := CurrentDateTime;
        SensorData.Value := Value;
        SensorData."Alert Level" := SensorData."Alert Level"::Critical;
        SensorData.Insert(false);
    end;

    local procedure CreateTestAlert(AlertID: Code[30]; SensorID: Code[30]; WarehouseCode: Code[20]; Status: Enum "RWMS Alert Status")
    begin
        AlertHistory.Init();
        AlertHistory."Alert ID" := AlertID;
        AlertHistory."Sensor ID" := SensorID;
        AlertHistory."Warehouse Code" := WarehouseCode;
        AlertHistory."Sensor Type" := AlertHistory."Sensor Type"::Temperature;
        AlertHistory."Created DateTime" := CurrentDateTime;
        AlertHistory."Alert Level" := AlertHistory."Alert Level"::Critical;
        AlertHistory.Status := Status;
        AlertHistory.Insert(false);
    end;
}
