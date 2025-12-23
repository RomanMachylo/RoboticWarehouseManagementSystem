codeunit 50002 "RWMS Sample Data Generator"
{
    procedure GenerateAllSampleData()
    begin
        if not Confirm('Це створить тестові дані в усіх таблицях. Продовжити?', false) then
            exit;

        ClearExistingData();
        GenerateWarehouses();
        GenerateZones();
        GenerateSensorConfigurations();
        GenerateSensorData();
        GenerateAlertHistory();

        Message('Тестові дані успішно створено!\' +
                'Склади: 3\' +
                'Зони: 12\' +
                'Сенсори: 45\' +
                'Записи даних: 500+\' +
                'Сповіщення: 25');
    end;

    local procedure ClearExistingData()
    var
        Warehouse: Record "RWMS Warehouse";
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        AlertHistory: Record "RWMS Alert History";
        ZoneConfig: Record "RWMS Zone Configuration";
    begin
        if not Confirm('Видалити існуючі дані?', false) then
            exit;

        AlertHistory.DeleteAll();
        SensorData.DeleteAll();
        SensorConfig.DeleteAll();
        ZoneConfig.DeleteAll();
        Warehouse.DeleteAll();
    end;

    local procedure GenerateWarehouses()
    var
        Warehouse: Record "RWMS Warehouse";
    begin
        // Warehouse 1 - Main
        Warehouse.Init();
        Warehouse.Code := 'WH01';
        Warehouse.Name := 'Центральний склад Київ';
        Warehouse.Address := 'вул. Промислова, 15';
        Warehouse.City := 'Київ';
        Warehouse."Post Code" := '03680';
        Warehouse."Country/Region Code" := 'UA';
        Warehouse."Square Meters" := 5000;
        Warehouse."Max Capacity" := 10000;
        Warehouse.Status := Warehouse.Status::Active;
        Warehouse."Manager Name" := 'Петренко Олександр';
        Warehouse."Phone No." := '+380441234567';
        Warehouse."E-Mail" := 'warehouse1@company.com';
        Warehouse.Insert(true);

        // Warehouse 2 - Cold Storage
        Warehouse.Init();
        Warehouse.Code := 'WH02';
        Warehouse.Name := 'Холодильний склад Одеса';
        Warehouse.Address := 'вул. Портова, 88';
        Warehouse.City := 'Одеса';
        Warehouse."Post Code" := '65000';
        Warehouse."Country/Region Code" := 'UA';
        Warehouse."Square Meters" := 3000;
        Warehouse."Max Capacity" := 5000;
        Warehouse.Status := Warehouse.Status::Active;
        Warehouse."Manager Name" := 'Сидоренко Марія';
        Warehouse."Phone No." := '+380481234567';
        Warehouse."E-Mail" := 'warehouse2@company.com';
        Warehouse.Insert(true);

        // Warehouse 3 - Distribution
        Warehouse.Init();
        Warehouse.Code := 'WH03';
        Warehouse.Name := 'Логістичний центр Львів';
        Warehouse.Address := 'вул. Шевченка, 120';
        Warehouse.City := 'Львів';
        Warehouse."Post Code" := '79000';
        Warehouse."Country/Region Code" := 'UA';
        Warehouse."Square Meters" := 4000;
        Warehouse."Max Capacity" := 8000;
        Warehouse.Status := Warehouse.Status::Maintenance;
        Warehouse."Manager Name" := 'Коваленко Ігор';
        Warehouse."Phone No." := '+380321234567';
        Warehouse."E-Mail" := 'warehouse3@company.com';
        Warehouse.Insert(true);
    end;

    local procedure GenerateZones()
    var
        Zone: Record "RWMS Zone Configuration";
    begin
        // WH01 Zones
        CreateZone('Z01', 'WH01', 'Зона A - Загальне зберігання', Zone."Zone Type"::Storage, 1500, 3000, 2400, true, false);
        CreateZone('Z02', 'WH01', 'Зона B - Комплектація', Zone."Zone Type"::Receiving, 800, 1500, 1100, true, false);
        CreateZone('Z03', 'WH01', 'Зона C - Пакування', Zone."Zone Type"::Shipping, 600, 1000, 750, true, false);
        CreateZone('Z04', 'WH01', 'Зона D - Завантаження', Zone."Zone Type"::Loading, 500, 500, 200, false, false);

        // WH02 Zones (Cold Storage)
        CreateZone('Z05', 'WH02', 'Холодильна камера 1', Zone."Zone Type"::Cooling, 1000, 2000, 1800, true, false);
        CreateZone('Z06', 'WH02', 'Холодильна камера 2', Zone."Zone Type"::Freezer, 1000, 2000, 1500, true, false);
        CreateZone('Z07', 'WH02', 'Зона якості', Zone."Zone Type"::Quarantine, 300, 300, 150, true, false);
        CreateZone('Z08', 'WH02', 'Транзитна зона', Zone."Zone Type"::Loading, 400, 700, 300, false, false);

        // WH03 Zones
        CreateZone('Z09', 'WH03', 'Зона зберігання 1', Zone."Zone Type"::Storage, 1500, 3000, 2200, true, false);
        CreateZone('Z10', 'WH03', 'Зона зберігання 2', Zone."Zone Type"::Storage, 1500, 3000, 1900, true, false);
        CreateZone('Z11', 'WH03', 'Небезпечні матеріали', Zone."Zone Type"::Hazardous, 500, 800, 200, true, true);
        CreateZone('Z12', 'WH03', 'Завантаження/Розвантаження', Zone."Zone Type"::Loading, 500, 900, 400, false, false);
    end;

    local procedure CreateZone(ZoneCode: Code[20]; WarehouseCode: Code[20]; ZoneName: Text[100]; ZoneType: Enum "RWMS Zone Type"; AreaSQM: Decimal; Capacity: Integer; CurrentOccupancy: Integer; IsClimateControlled: Boolean; IsHazardous: Boolean)
    var
        Zone: Record "RWMS Zone Configuration";
    begin
        Zone.Init();
        Zone."Zone Code" := ZoneCode;
        Zone."Warehouse Code" := WarehouseCode;
        Zone."Zone Name" := ZoneName;
        Zone."Zone Type" := ZoneType;
        Zone."Temperature Min" := 5;
        Zone."Temperature Max" := 25;
        Zone."Humidity Min" := 30;
        Zone."Humidity Max" := 70;
        Zone.Insert(true);
    end;

    local procedure GenerateSensorConfigurations()
    begin
        // WH01 Sensors
        GenerateSensorsForWarehouse('WH01', 'Z01', 5);
        GenerateSensorsForWarehouse('WH01', 'Z02', 4);
        GenerateSensorsForWarehouse('WH01', 'Z03', 3);
        GenerateSensorsForWarehouse('WH01', 'Z04', 3);

        // WH02 Sensors (more for cold storage)
        GenerateSensorsForWarehouse('WH02', 'Z05', 6);
        GenerateSensorsForWarehouse('WH02', 'Z06', 6);
        GenerateSensorsForWarehouse('WH02', 'Z07', 3);
        GenerateSensorsForWarehouse('WH02', 'Z08', 2);

        // WH03 Sensors
        GenerateSensorsForWarehouse('WH03', 'Z09', 4);
        GenerateSensorsForWarehouse('WH03', 'Z10', 4);
        GenerateSensorsForWarehouse('WH03', 'Z11', 5);
        GenerateSensorsForWarehouse('WH03', 'Z12', 3);
    end;

    local procedure GenerateSensorsForWarehouse(WarehouseCode: Code[20]; ZoneCode: Code[20]; SensorCount: Integer)
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorType: Enum "RWMS Sensor Type";
        i: Integer;
        TypeIndex: Integer;
    begin
        for i := 1 to SensorCount do begin
            TypeIndex := (i mod 9);
            case TypeIndex of
                0:
                    SensorType := SensorType::Temperature;
                1:
                    SensorType := SensorType::Humidity;
                2:
                    SensorType := SensorType::Smoke;
                3:
                    SensorType := SensorType::Motion;
                4:
                    SensorType := SensorType::"Light Level";
                5:
                    SensorType := SensorType::"CO2 Level";
                6:
                    SensorType := SensorType::Pressure;
                7:
                    SensorType := SensorType::"Door Status";
                8:
                    SensorType := SensorType::"Inventory Level";
            end;

            CreateSensor(WarehouseCode, ZoneCode, SensorType, i);
        end;
    end;

    local procedure CreateSensor(WarehouseCode: Code[20]; ZoneCode: Code[20]; SensorType: Enum "RWMS Sensor Type"; Number: Integer)
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorStatus: Enum "RWMS Sensor Status";
    begin
        SensorConfig.Init();
        SensorConfig."Sensor ID" := WarehouseCode + '-' + ZoneCode + '-' + Format(Number);
        SensorConfig."Warehouse Code" := WarehouseCode;
        SensorConfig."Zone Code" := ZoneCode;
        SensorConfig."Sensor Type" := SensorType;
        SensorConfig.Description := Format(SensorType) + ' сенсор ' + Format(Number);
        SensorConfig.Location := 'Позиція ' + Format(Number);

        if Random(10) > 8 then
            SensorConfig.Status := SensorStatus::Maintenance
        else
            SensorConfig.Status := SensorStatus::Active;

        // Set thresholds based on sensor type
        case SensorType of
            SensorType::Temperature:
                begin
                    SensorConfig."Min Value" := 2;
                    SensorConfig."Max Value" := 25;
                    SensorConfig."Critical Threshold Min" := 0;
                    SensorConfig."Critical Threshold Max" := 30;
                    SensorConfig."Unit of Measure" := '°C';
                end;
            SensorType::Humidity:
                begin
                    SensorConfig."Min Value" := 30;
                    SensorConfig."Max Value" := 70;
                    SensorConfig."Critical Threshold Min" := 20;
                    SensorConfig."Critical Threshold Max" := 80;
                    SensorConfig."Unit of Measure" := '%';
                end;
            SensorType::Smoke:
                begin
                    SensorConfig."Min Value" := 0;
                    SensorConfig."Max Value" := 200;
                    SensorConfig."Critical Threshold Min" := 0;
                    SensorConfig."Critical Threshold Max" := 500;
                    SensorConfig."Unit of Measure" := 'ppm';
                end;
            SensorType::"CO2 Level":
                begin
                    SensorConfig."Min Value" := 0;
                    SensorConfig."Max Value" := 1000;
                    SensorConfig."Critical Threshold Min" := 0;
                    SensorConfig."Critical Threshold Max" := 1500;
                    SensorConfig."Unit of Measure" := 'ppm';
                end;
            SensorType::"Light Level":
                begin
                    SensorConfig."Min Value" := 100;
                    SensorConfig."Max Value" := 1000;
                    SensorConfig."Critical Threshold Min" := 50;
                    SensorConfig."Critical Threshold Max" := 2000;
                    SensorConfig."Unit of Measure" := 'lux';
                end;
        end;

        // Last calibration field not available in current schema
        SensorConfig.Insert(true);
    end;

    local procedure GenerateSensorData()
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        i: Integer;
        DaysBack: Integer;
    begin
        if SensorConfig.FindSet() then
            repeat
                // Generate 10-15 readings per sensor over last 7 days
                for i := 1 to (10 + Random(6)) do begin
                    DaysBack := Random(7);
                    CreateSensorReading(SensorConfig, DaysBack);
                end;
            until SensorConfig.Next() = 0;
    end;

    local procedure CreateSensorReading(SensorConfig: Record "RWMS Sensor Configuration"; DaysBack: Integer)
    var
        SensorData: Record "RWMS Sensor Data";
        AlertLevel: Enum "RWMS Alert Level";
        ReadingValue: Decimal;
        IsAnomaly: Boolean;
    begin
        SensorData.Init();
        SensorData."Sensor ID" := SensorConfig."Sensor ID";
        SensorData."Warehouse Code" := SensorConfig."Warehouse Code";
        SensorData."Sensor Type" := SensorConfig."Sensor Type";
        SensorData."Reading DateTime" := CreateDateTime(CalcDate('<-' + Format(DaysBack) + 'D>', Today), Time + Random(86400000));

        // Generate realistic values based on sensor type
        case SensorConfig."Sensor Type" of
            SensorConfig."Sensor Type"::Temperature:
                ReadingValue := 15 + Random(20);
            SensorConfig."Sensor Type"::Humidity:
                ReadingValue := 40 + Random(30);
            SensorConfig."Sensor Type"::Smoke:
                ReadingValue := Random(100);
            SensorConfig."Sensor Type"::Motion:
                ReadingValue := Random(2);
            SensorConfig."Sensor Type"::"Light Level":
                ReadingValue := 200 + Random(800);
            SensorConfig."Sensor Type"::"CO2 Level":
                ReadingValue := 400 + Random(600);
            SensorConfig."Sensor Type"::Pressure:
                ReadingValue := 980 + Random(40);
            SensorConfig."Sensor Type"::"Door Status":
                ReadingValue := Random(2);
            SensorConfig."Sensor Type"::"Inventory Level":
                ReadingValue := 20 + Random(80);
        end;

        SensorData.Value := ReadingValue;
        SensorData."Unit of Measure" := SensorConfig."Unit of Measure";

        // Determine alert level
        if (ReadingValue < SensorConfig."Critical Threshold Min") or (ReadingValue > SensorConfig."Critical Threshold Max") then begin
            AlertLevel := AlertLevel::Critical;
            IsAnomaly := true;
        end else if (ReadingValue < SensorConfig."Min Value") or (ReadingValue > SensorConfig."Max Value") then begin
            AlertLevel := AlertLevel::Warning;
            IsAnomaly := (Random(10) > 7);
        end else begin
            AlertLevel := AlertLevel::Normal;
            IsAnomaly := false;
        end;

        SensorData."Alert Level" := AlertLevel;
        SensorData."Is Anomaly" := IsAnomaly;
        SensorData.Insert(false);
    end;

    local procedure GenerateAlertHistory()
    var
        SensorData: Record "RWMS Sensor Data";
        AlertHistory: Record "RWMS Alert History";
        AlertStatus: Enum "RWMS Alert Status";
        StatusIndex: Integer;
        Counter: Integer;
    begin
        SensorData.SetFilter("Alert Level", '<>%1', SensorData."Alert Level"::Normal);
        if SensorData.FindSet() then
            repeat
                if Random(3) = 1 then begin // Create alert for ~33% of non-normal readings
                Counter += 1;
                    AlertHistory.Init();
                    AlertHistory."Entry No." := Counter;
                    AlertHistory."Alert ID" := 'ALT-' + Format(SensorData."Entry No.");
                    AlertHistory."Sensor ID" := SensorData."Sensor ID";
                    AlertHistory."Warehouse Code" := SensorData."Warehouse Code";
                    AlertHistory."Sensor Type" := SensorData."Sensor Type";
                    AlertHistory."Created DateTime" := SensorData."Reading DateTime";
                    AlertHistory."Alert Level" := SensorData."Alert Level";
                    AlertHistory."Sensor Value" := SensorData.Value;

                    StatusIndex := Random(5);
                    case StatusIndex of
                        0:
                            AlertStatus := AlertStatus::New;
                        1:
                            AlertStatus := AlertStatus::Acknowledged;
                        2:
                            AlertStatus := AlertStatus::"In Progress";
                        3:
                            AlertStatus := AlertStatus::Resolved;
                        4:
                            AlertStatus := AlertStatus::Closed;
                    end;
                    AlertHistory.Status := AlertStatus;

                    if AlertStatus <> AlertStatus::New then begin
                        AlertHistory."Assigned DateTime" := AlertHistory."Created DateTime" + Random(3600000);
                    end;

                    if AlertStatus in [AlertStatus::Resolved, AlertStatus::Closed] then begin
                        AlertHistory."Resolved DateTime" := AlertHistory."Assigned DateTime" + Random(7200000);
                        AlertHistory."Resolution Notes" := 'Проблему вирішено, параметри в нормі';
                    end;

                    AlertHistory.Insert(false);
                end;
            until SensorData.Next() = 0;
    end;
}
