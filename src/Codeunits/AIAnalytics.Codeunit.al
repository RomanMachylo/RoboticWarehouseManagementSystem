codeunit 50001 "RWMS AI Analytics"
{
    /// <summary>
    /// Handles AI-powered analytics integration with OpenAI
    /// This codeunit provides framework for AI analytics - actual OpenAI API integration would require additional setup
    /// </summary>

    procedure RunPredictiveAnalysis(WarehouseCode: Code[20]): Boolean
    var
        SensorData: Record "RWMS Sensor Data";
        AnalyticsLog: Record "RWMS Analytics Log";
        StartTime: DateTime;
        EndTime: DateTime;
        ProcessingTime: Integer;
        DataPointsCount: Integer;
    begin
        StartTime := CurrentDateTime();

        // Get recent sensor data for analysis
        SensorData.SetRange("Warehouse Code", WarehouseCode);
        SensorData.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today() - 7, 0T));
        DataPointsCount := SensorData.Count();

        if DataPointsCount = 0 then
            exit(false);

        // Perform analysis (placeholder for actual AI integration)
        AnalyticsLog.Init();
        AnalyticsLog."Warehouse Code" := WarehouseCode;
        AnalyticsLog."Analysis DateTime" := CurrentDateTime();
        AnalyticsLog."Analysis Type" := 'Predictive Analysis';
        AnalyticsLog."AI Model Used" := 'OpenAI GPT-4';
        AnalyticsLog."Data Points Analyzed" := DataPointsCount;

        // Simulate analysis result
        AnalyticsLog."Analysis Result" := StrSubstNo('Analyzed %1 data points. No critical issues detected.', DataPointsCount);
        AnalyticsLog."Confidence Score" := 85.5;
        AnalyticsLog."Alert Level" := AnalyticsLog."Alert Level"::Normal;

        // Calculate processing time
        EndTime := CurrentDateTime();
        ProcessingTime := EndTime - StartTime;
        AnalyticsLog."Processing Time (ms)" := ProcessingTime;

        AnalyticsLog.Insert(true);

        // Set recommendations
        SetDefaultRecommendations(AnalyticsLog);

        exit(true);
    end;

    procedure AnalyzeSensorTrends(SensorID: Code[30]): Text
    var
        SensorData: Record "RWMS Sensor Data";
        DataPoints: Integer;
        AvgValue: Decimal;
        MinValue: Decimal;
        MaxValue: Decimal;
        TrendDirection: Text;
        FirstValue: Decimal;
        LastValue: Decimal;
    begin
        SensorData.SetRange("Sensor ID", SensorID);
        SensorData.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today() - 7, 0T));
        SensorData.SetCurrentKey("Reading DateTime");

        DataPoints := SensorData.Count();
        if DataPoints = 0 then
            exit('Insufficient data for analysis');

        if SensorData.FindSet() then begin
            FirstValue := SensorData.Value;
            MinValue := SensorData.Value;
            MaxValue := SensorData.Value;
            AvgValue := SensorData.Value;

            repeat
                if SensorData.Value < MinValue then
                    MinValue := SensorData.Value;
                if SensorData.Value > MaxValue then
                    MaxValue := SensorData.Value;
                AvgValue += SensorData.Value;
                LastValue := SensorData.Value;
            until SensorData.Next() = 0;

            AvgValue := AvgValue / DataPoints;

            if LastValue > FirstValue then
                TrendDirection := 'Increasing'
            else
                if LastValue < FirstValue then
                    TrendDirection := 'Decreasing'
                else
                    TrendDirection := 'Stable';

            exit(StrSubstNo('Trend: %1, Avg: %2, Min: %3, Max: %4, Data Points: %5',
                TrendDirection, AvgValue, MinValue, MaxValue, DataPoints));
        end;

        exit('Unable to analyze trends');
    end;

    procedure DetectAnomaliesAcrossWarehouse(WarehouseCode: Code[20]): Integer
    var
        SensorData: Record "RWMS Sensor Data";
        AnalyticsLog: Record "RWMS Analytics Log";
        AnomalyCount: Integer;
    begin
        // Count anomalies in last 24 hours
        SensorData.SetRange("Warehouse Code", WarehouseCode);
        SensorData.SetRange("Is Anomaly", true);
        SensorData.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today(), 0T));
        AnomalyCount := SensorData.Count();

        if AnomalyCount > 0 then begin
            AnalyticsLog.Init();
            AnalyticsLog."Warehouse Code" := WarehouseCode;
            AnalyticsLog."Analysis DateTime" := CurrentDateTime();
            AnalyticsLog."Analysis Type" := 'Anomaly Detection';
            AnalyticsLog."AI Model Used" := 'Statistical Analysis';
            AnalyticsLog."Data Points Analyzed" := AnomalyCount;
            AnalyticsLog."Analysis Result" := StrSubstNo('Detected %1 anomalies in the last 24 hours', AnomalyCount);

            if AnomalyCount > 10 then begin
                AnalyticsLog."Alert Level" := AnalyticsLog."Alert Level"::Warning;
                AnalyticsLog."Confidence Score" := 75.0;
            end else begin
                AnalyticsLog."Alert Level" := AnalyticsLog."Alert Level"::Normal;
                AnalyticsLog."Confidence Score" := 90.0;
            end;

            AnalyticsLog.Insert(true);
            AnalyticsLog.SetRecommendations(GetAnomalyRecommendations(AnomalyCount));
        end;

        exit(AnomalyCount);
    end;

    procedure GenerateOptimizationRecommendations(WarehouseCode: Code[20]): Text
    var
        SensorData: Record "RWMS Sensor Data";
        SensorConfig: Record "RWMS Sensor Configuration";
        Recommendations: Text;
    begin
        Recommendations := 'Optimization Recommendations:\n';

        // Check for inactive sensors
        SensorConfig.SetRange("Warehouse Code", WarehouseCode);
        SensorConfig.SetRange(Status, SensorConfig.Status::Inactive);
        if not SensorConfig.IsEmpty() then
            Recommendations += StrSubstNo('- %1 inactive sensors detected. Consider reactivating or removing.\n', SensorConfig.Count());

        // Check for sensors needing maintenance
        SensorConfig.Reset();
        SensorConfig.SetRange("Warehouse Code", WarehouseCode);
        SensorConfig.SetFilter("Maintenance Due Date", '<%1', Today() + 30);
        if not SensorConfig.IsEmpty() then
            Recommendations += StrSubstNo('- %1 sensors require maintenance within 30 days.\n', SensorConfig.Count());

        // Check for high alert frequency
        SensorData.SetRange("Warehouse Code", WarehouseCode);
        SensorData.SetFilter("Alert Level", '<>%1', SensorData."Alert Level"::Normal);
        SensorData.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today() - 7, 0T));
        if SensorData.Count() > 50 then
            Recommendations += '- High alert frequency detected. Review sensor thresholds.\n';

        if Recommendations = 'Optimization Recommendations:\n' then
            Recommendations += '- No optimization recommendations at this time. System is operating efficiently.\n';

        exit(Recommendations);
    end;

    local procedure SetDefaultRecommendations(var AnalyticsLog: Record "RWMS Analytics Log")
    var
        Recommendations: Text;
    begin
        Recommendations := 'AI Analysis Recommendations:\n';
        Recommendations += '- Continue monitoring sensor data for trends\n';
        Recommendations += '- Review alerts from the past 7 days\n';
        Recommendations += '- Ensure all sensors are calibrated\n';
        Recommendations += '- Schedule preventive maintenance for sensors nearing due date\n';

        AnalyticsLog.SetRecommendations(Recommendations);
    end;

    local procedure GetAnomalyRecommendations(AnomalyCount: Integer): Text
    var
        Recommendations: Text;
    begin
        Recommendations := 'Anomaly Detection Recommendations:\n';

        if AnomalyCount > 10 then begin
            Recommendations += '- High number of anomalies detected. Immediate investigation recommended.\n';
            Recommendations += '- Check sensor calibration and environmental conditions.\n';
            Recommendations += '- Review warehouse operations for unusual activities.\n';
        end else begin
            Recommendations += '- Minor anomalies detected. Continue monitoring.\n';
            Recommendations += '- Review anomalous readings for patterns.\n';
        end;

        exit(Recommendations);
    end;

    procedure GenerateWarehouseSummary(WarehouseCode: Code[20]): Text
    var
        Warehouse: Record "RWMS Warehouse";
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        Summary: Text;
    begin
        if not Warehouse.Get(WarehouseCode) then
            exit('Warehouse not found');

        Summary := StrSubstNo('Warehouse Summary for %1:\n', Warehouse.Name);

        SensorConfig.SetRange("Warehouse Code", WarehouseCode);
        Summary += StrSubstNo('Total Sensors: %1\n', SensorConfig.Count());

        SensorConfig.SetRange(Status, SensorConfig.Status::Active);
        Summary += StrSubstNo('Active Sensors: %1\n', SensorConfig.Count());

        SensorData.SetRange("Warehouse Code", WarehouseCode);
        SensorData.SetFilter("Reading DateTime", '>%1', CreateDateTime(Today(), 0T));
        Summary += StrSubstNo('Readings Today: %1\n', SensorData.Count());

        SensorData.SetFilter("Alert Level", '<>%1', SensorData."Alert Level"::Normal);
        Summary += StrSubstNo('Alerts Today: %1\n', SensorData.Count());

        exit(Summary);
    end;
}
