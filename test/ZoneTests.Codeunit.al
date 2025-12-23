codeunit 50004 "RWMS Zone Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        Warehouse: Record "RWMS Warehouse";
        ZoneConfig: Record "RWMS Zone Configuration";

    [Test]
    procedure TestCreateZone()
    begin
        // [GIVEN] A warehouse
        CreateTestWarehouse('WH-ZON1');

        // [WHEN] Creating a zone
        ZoneConfig.Init();
        ZoneConfig."Zone Code" := 'Z01';
        ZoneConfig."Warehouse Code" := 'WH-ZON1';
        ZoneConfig."Zone Name" := 'Test Zone A';
        ZoneConfig."Zone Type" := ZoneConfig."Zone Type"::Storage;
        ZoneConfig."Temperature Min" := 5;
        ZoneConfig."Temperature Max" := 25;
        ZoneConfig."Humidity Min" := 30;
        ZoneConfig."Humidity Max" := 70;
        ZoneConfig.Insert(true);

        // [THEN] Zone should exist
        Assert.IsTrue(ZoneConfig.Get('Z01', 'WH-ZON1'), 'Zone should be created');
        Assert.AreEqual('Test Zone A', ZoneConfig."Zone Name", 'Zone name should match');

        // Cleanup
        ZoneConfig.Delete(true);
        Warehouse.Get('WH-ZON1');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestZoneTypeAssignment()
    var
        StorageZone: Record "RWMS Zone Configuration";
        CoolingZone: Record "RWMS Zone Configuration";
    begin
        // [GIVEN] A warehouse with different zone types
        CreateTestWarehouse('WH-ZON2');

        // [WHEN] Creating storage zone
        CreateTestZone('Z-STOR', 'WH-ZON2', 'Storage Zone', StorageZone."Zone Type"::Storage);

        // [WHEN] Creating cooling zone
        CreateTestZone('Z-COOL', 'WH-ZON2', 'Cooling Zone', CoolingZone."Zone Type"::Cooling);

        // [THEN] Zone types should be different
        StorageZone.Get('Z-STOR', 'WH-ZON2');
        CoolingZone.Get('Z-COOL', 'WH-ZON2');
        Assert.AreNotEqual(StorageZone."Zone Type", CoolingZone."Zone Type", 'Zone types should differ');

        // Cleanup
        StorageZone.Delete(true);
        CoolingZone.Delete(true);
        Warehouse.Get('WH-ZON2');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestZoneTemperatureRange()
    begin
        // [GIVEN] A zone with temperature range
        CreateTestWarehouse('WH-ZON3');
        CreateTestZone('Z-TEMP', 'WH-ZON3', 'Temperature Zone', ZoneConfig."Zone Type"::Storage);

        // [WHEN] Setting temperature range
        ZoneConfig.Get('Z-TEMP', 'WH-ZON3');
        ZoneConfig."Temperature Min" := 10;
        ZoneConfig."Temperature Max" := 20;
        ZoneConfig.Modify(true);

        // [THEN] Max should be greater than Min
        Assert.IsTrue(ZoneConfig."Temperature Max" > ZoneConfig."Temperature Min", 'Max temp should exceed Min temp');

        // Cleanup
        ZoneConfig.Delete(true);
        Warehouse.Get('WH-ZON3');
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

    local procedure CreateTestZone(ZoneCode: Code[20]; WarehouseCode: Code[20]; ZoneName: Text[100]; ZoneType: Enum "RWMS Zone Type")
    begin
        ZoneConfig.Init();
        ZoneConfig."Zone Code" := ZoneCode;
        ZoneConfig."Warehouse Code" := WarehouseCode;
        ZoneConfig."Zone Name" := ZoneName;
        ZoneConfig."Zone Type" := ZoneType;
        ZoneConfig."Temperature Min" := 5;
        ZoneConfig."Temperature Max" := 25;
        ZoneConfig."Humidity Min" := 30;
        ZoneConfig."Humidity Max" := 70;
        ZoneConfig.Insert(true);
    end;
}
