codeunit 50007 "RWMS Analytics Tests"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        Warehouse: Record "RWMS Warehouse";
        AnalyticsLog: Record "RWMS Analytics Log";
        PerfMetrics: Record "RWMS Performance Metrics";

    [Test]
    procedure TestCreateAnalyticsLog()
    begin
        // [GIVEN] A warehouse
        CreateTestWarehouse('WH-ANA1');

        // [WHEN] Creating analytics log entry
        AnalyticsLog.Init();
        AnalyticsLog."Warehouse Code" := 'WH-ANA1';
        AnalyticsLog."Analysis DateTime" := CurrentDateTime;
        AnalyticsLog."Analysis Type" := 'Predictive Analysis';
        AnalyticsLog."Analysis Result" := 'Temperature increase predicted';
        AnalyticsLog."AI Model Used" := 'Azure ML';
        AnalyticsLog."Confidence Score" := 85.5;
        AnalyticsLog."Data Points Analyzed" := 500;
        AnalyticsLog."Alert Level" := AnalyticsLog."Alert Level"::Warning;
        AnalyticsLog.Insert(false);

        // [THEN] Analytics log should exist
        Assert.IsTrue(AnalyticsLog.FindLast(), 'Analytics log should be created');
        Assert.AreEqual(85.5, AnalyticsLog."Confidence Score", 'Confidence score should match');

        // Cleanup
        AnalyticsLog.DeleteAll();
        Warehouse.Get('WH-ANA1');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestCreatePerformanceMetrics()
    begin
        // [GIVEN] A warehouse
        CreateTestWarehouse('WH-PER1');

        // [WHEN] Creating performance metrics
        PerfMetrics.Init();
        PerfMetrics."Warehouse Code" := 'WH-PER1';
        PerfMetrics."Metric Date" := Today;
        PerfMetrics."Metric Type" := PerfMetrics."Metric Type"::Daily;
        PerfMetrics."Avg Temperature" := 20.5;
        PerfMetrics."Min Temperature" := 18.0;
        PerfMetrics."Max Temperature" := 23.0;
        PerfMetrics."Total Alert Count" := 10;
        PerfMetrics."Critical Alert Count" := 2;
        PerfMetrics."Warning Alert Count" := 8;
        PerfMetrics.Insert(false);

        // [THEN] Performance metrics should exist
        Assert.IsTrue(PerfMetrics.FindLast(), 'Performance metrics should be created');
        Assert.AreEqual(10, PerfMetrics."Total Alert Count", 'Total alerts should match');

        // Cleanup
        PerfMetrics.DeleteAll();
        Warehouse.Get('WH-PER1');
        Warehouse.Delete(true);
    end;

    [Test]
    procedure TestAnalyticsConfidenceScore()
    var
        HighConfidence: Decimal;
        LowConfidence: Decimal;
    begin
        // [GIVEN] Different confidence scores
        HighConfidence := 95.0;
        LowConfidence := 60.0;

        // [THEN] Confidence scores should be within valid range
        Assert.IsTrue((HighConfidence >= 0) and (HighConfidence <= 100), 'High confidence should be 0-100');
        Assert.IsTrue((LowConfidence >= 0) and (LowConfidence <= 100), 'Low confidence should be 0-100');
        Assert.IsTrue(HighConfidence > LowConfidence, 'High confidence should exceed low confidence');
    end;

    [Test]
    procedure TestPerformanceMetricsAggregation()
    begin
        // [GIVEN] A warehouse with metrics
        CreateTestWarehouse('WH-PER2');
        CreateTestMetrics('WH-PER2', 15, 3, 12);

        // [WHEN] Retrieving metrics
        PerfMetrics.FindLast();

        // [THEN] Alert counts should be consistent
        Assert.AreEqual(
            PerfMetrics."Total Alert Count",
            PerfMetrics."Critical Alert Count" + PerfMetrics."Warning Alert Count",
            'Total alerts should equal sum of critical and warning alerts'
        );

        // Cleanup
        PerfMetrics.DeleteAll();
        Warehouse.Get('WH-PER2');
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

    local procedure CreateTestMetrics(WarehouseCode: Code[20]; TotalAlerts: Integer; CriticalAlerts: Integer; WarningAlerts: Integer)
    begin
        PerfMetrics.Init();
        PerfMetrics."Warehouse Code" := WarehouseCode;
        PerfMetrics."Metric Date" := Today;
        PerfMetrics."Metric Type" := PerfMetrics."Metric Type"::Daily;
        PerfMetrics."Total Alert Count" := TotalAlerts;
        PerfMetrics."Critical Alert Count" := CriticalAlerts;
        PerfMetrics."Warning Alert Count" := WarningAlerts;
        PerfMetrics.Insert(false);
    end;
}
