codeunit 50005 "RWMS Warehouse Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        Warehouse: Record "RWMS Warehouse";

    [Test]
    procedure TestCreateWarehouse()
    var
        WarehouseCode: Code[20];
    begin
        // [GIVEN] A new warehouse code
        WarehouseCode := 'TEST01';

        // [WHEN] Creating a new warehouse
        Warehouse.Init();
        Warehouse.Code := WarehouseCode;
        Warehouse.Name := 'Test Warehouse';
        Warehouse.City := 'Київ';
        Warehouse."Square Meters" := 1000;
        Warehouse."Max Capacity" := 5000;
        Warehouse.Status := Warehouse.Status::Active;
        Warehouse.Insert(true);

        // [THEN] Warehouse should exist
        Assert.IsTrue(Warehouse.Get(WarehouseCode), 'Warehouse should be created');
        Assert.AreEqual('Test Warehouse', Warehouse.Name, 'Warehouse name should match');

        // Cleanup
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestWarehouseCodeMandatory()
    var
        EmptyWarehouse: Record "RWMS Warehouse";
    begin
        // [GIVEN] A warehouse without code
        EmptyWarehouse.Init();
        EmptyWarehouse.Name := 'No Code Warehouse';

        // [WHEN] [THEN] Inserting should fail
        asserterror EmptyWarehouse.Insert(true);
        Assert.ExpectedError('');
    end;

    [Test]
    procedure TestWarehouseStatusChange()
    begin
        // [GIVEN] An active warehouse
        CreateTestWarehouse('STAT01', 'Status Test', Warehouse.Status::Active);

        // [WHEN] Changing status to Maintenance
        Warehouse.Status := Warehouse.Status::Maintenance;
        Warehouse.Modify(true);

        // [THEN] Status should be updated
        Warehouse.Get('STAT01');
        Assert.AreEqual(Warehouse.Status::Maintenance, Warehouse.Status, 'Status should be Maintenance');

        // Cleanup
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestWarehouseCapacityValidation()
    begin
        // [GIVEN] A warehouse with capacity
        CreateTestWarehouse('CAP01', 'Capacity Test', Warehouse.Status::Active);
        Warehouse."Max Capacity" := 10000;
        Warehouse."Square Meters" := 2000;
        Warehouse.Modify(true);

        // [THEN] Values should be positive
        Assert.IsTrue(Warehouse."Max Capacity" > 0, 'Max Capacity should be positive');
        Assert.IsTrue(Warehouse."Square Meters" > 0, 'Square Meters should be positive');

        // Cleanup
        Warehouse.Delete(true);
    end;

    local procedure CreateTestWarehouse(WarehouseCode: Code[20]; WarehouseName: Text[100]; WarehouseStatus: Option)
    begin
        Warehouse.Init();
        Warehouse.Code := WarehouseCode;
        Warehouse.Name := WarehouseName;
        Warehouse.Status := WarehouseStatus;
        Warehouse."Square Meters" := 1000;
        Warehouse."Max Capacity" := 5000;
        Warehouse.Insert(true);
    end;
}
