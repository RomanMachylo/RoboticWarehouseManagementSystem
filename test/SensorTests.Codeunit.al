codeunit 50006 "RWMS Sensor Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        Warehouse: Record "RWMS Warehouse";
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        ZoneConfig: Record "RWMS Zone Configuration";

    [Test]
    procedure TestCreateSensorConfiguration()
    var
        SensorID: Code[30];
    begin
        // [GIVEN] A warehouse and sensor ID
        CreateTestWarehouse('WH-TST1');
        SensorID := 'SENS-001';

        // [WHEN] Creating sensor configuration
        SensorConfig.Init();
        SensorConfig."Sensor ID" := SensorID;
        SensorConfig."Warehouse Code" := 'WH-TST1';
        SensorConfig."Sensor Type" := SensorConfig."Sensor Type"::Temperature;
        SensorConfig.Description := 'Test Temperature Sensor';
        SensorConfig."Min Value" := 0;
        SensorConfig."Max Value" := 30;
        SensorConfig.Status := SensorConfig.Status::Active;
        SensorConfig.Insert(true);

        // [THEN] Sensor should exist
        Assert.IsTrue(SensorConfig.Get(SensorID), 'Sensor should be created');
        Assert.AreEqual(SensorConfig."Sensor Type"::Temperature, SensorConfig."Sensor Type", 'Sensor type should be Temperature');

        // Cleanup
        SensorConfig.Delete(true);
        Warehouse.Get('WH-TST1');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestSensorDataInsertion()
    begin
        // [GIVEN] A sensor configuration
        CreateTestWarehouse('WH-TST2');
        CreateTestSensor('SENS-002', 'WH-TST2');

        // [WHEN] Inserting sensor data
        SensorData.Init();
        SensorData."Sensor ID" := 'SENS-002';
        SensorData."Warehouse Code" := 'WH-TST2';
        SensorData."Sensor Type" := SensorData."Sensor Type"::Temperature;
        SensorData."Reading DateTime" := CurrentDateTime;
        SensorData.Value := 22.5;
        SensorData."Unit of Measure" := '°C';
        SensorData."Alert Level" := SensorData."Alert Level"::Normal;
        SensorData.Insert(false);

        // [THEN] Sensor data should exist
        Assert.IsTrue(SensorData.FindLast(), 'Sensor data should be created');
        Assert.AreEqual(22.5, SensorData.Value, 'Sensor value should match');

        // Cleanup
        SensorData.DeleteAll();
        SensorConfig.Get('SENS-002');
        SensorConfig.Delete(true);
        Warehouse.Get('WH-TST2');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestSensorThresholdValidation()
    begin
        // [GIVEN] A sensor with thresholds
        CreateTestWarehouse('WH-TST3');
        CreateTestSensor('SENS-003', 'WH-TST3');

        // [WHEN] Setting thresholds
        SensorConfig.Get('SENS-003');
        SensorConfig."Min Value" := 10;
        SensorConfig."Max Value" := 30;
        SensorConfig."Critical Threshold Min" := 5;
        SensorConfig."Critical Threshold Max" := 35;
        SensorConfig.Modify(true);

        // [THEN] Critical thresholds should be wider than normal range
        Assert.IsTrue(SensorConfig."Critical Threshold Min" < SensorConfig."Min Value", 'Critical min should be lower');
        Assert.IsTrue(SensorConfig."Critical Threshold Max" > SensorConfig."Max Value", 'Critical max should be higher');

        // Cleanup
        SensorConfig.Delete(true);
        Warehouse.Get('WH-TST3');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestSensorStatusTransition()
    begin
        // [GIVEN] An active sensor
        CreateTestWarehouse('WH-TST4');
        CreateTestSensor('SENS-004', 'WH-TST4');

        // [WHEN] Changing status to Maintenance
        SensorConfig.Get('SENS-004');
        SensorConfig.Status := SensorConfig.Status::Maintenance;
        SensorConfig.Modify(true);

        // [THEN] Status should be updated
        SensorConfig.Get('SENS-004');
        Assert.AreEqual(SensorConfig.Status::Maintenance, SensorConfig.Status, 'Status should be Maintenance');

        // Cleanup
        SensorConfig.Delete(true);
        Warehouse.Get('WH-TST4');
        Warehouse.Delete(true);
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
        SensorConfig.Description := 'Test Sensor';
        SensorConfig."Min Value" := 0;
        SensorConfig."Max Value" := 30;
        SensorConfig.Status := SensorConfig.Status::Active;
        SensorConfig.Insert(true);
    end;
}
