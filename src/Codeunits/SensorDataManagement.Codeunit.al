codeunit 50000 "RWMS Sensor Data Management"
{
    /// <summary>
    /// Manages sensor data collection, validation, and processing
    /// </summary>

    procedure InsertSensorReading(SensorID: Code[30]; ReadingDateTime: DateTime; Value: Decimal): Boolean
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        AlertLevel: Enum "RWMS Alert Level";
        AlertMessage: Text[250];
    begin
        if not SensorConfig.Get(SensorID) then
            Error('Sensor %1 not found.', SensorID);

        if SensorConfig.Status <> SensorConfig.Status::Active then
            Error('Sensor %1 is not active.', SensorID);

        // Determine alert level
        AlertLevel := DetermineAlertLevel(SensorConfig, Value, AlertMessage);

        // Create sensor data record
        SensorData.Init();
        SensorData."Sensor ID" := SensorID;
        SensorData."Warehouse Code" := SensorConfig."Warehouse Code";
        SensorData."Sensor Type" := SensorConfig."Sensor Type";
        SensorData."Reading DateTime" := ReadingDateTime;
        SensorData.Value := Value;
        SensorData."Unit of Measure" := SensorConfig."Unit of Measure";
        SensorData."Alert Level" := AlertLevel;
        SensorData."Alert Message" := AlertMessage;
        SensorData."Zone Code" := SensorConfig."Zone Code";
        SensorData.Insert(true);

        // Check for anomalies
        CheckForAnomalies(SensorData);

        // Send alert if needed
        if AlertLevel <> AlertLevel::Normal then
            SendAlert(SensorData);

        exit(true);
    end;

    local procedure DetermineAlertLevel(SensorConfig: Record "RWMS Sensor Configuration"; Value: Decimal; var AlertMessage: Text[250]): Enum "RWMS Alert Level"
    var
        AlertLevel: Enum "RWMS Alert Level";
    begin
        AlertLevel := AlertLevel::Normal;
        AlertMessage := '';

        // Check critical thresholds
        if (SensorConfig."Critical Threshold Min" <> 0) and (Value < SensorConfig."Critical Threshold Min") then begin
            AlertLevel := AlertLevel::Critical;
            AlertMessage := StrSubstNo('Critical: Value %1 below minimum threshold %2', Value, SensorConfig."Critical Threshold Min");
        end else
            if (SensorConfig."Critical Threshold Max" <> 0) and (Value > SensorConfig."Critical Threshold Max") then begin
                AlertLevel := AlertLevel::Critical;
                AlertMessage := StrSubstNo('Critical: Value %1 above maximum threshold %2', Value, SensorConfig."Critical Threshold Max");
            end else
                // Check warning thresholds
                if (SensorConfig."Warning Threshold Min" <> 0) and (Value < SensorConfig."Warning Threshold Min") then begin
                    AlertLevel := AlertLevel::Warning;
                    AlertMessage := StrSubstNo('Warning: Value %1 below minimum threshold %2', Value, SensorConfig."Warning Threshold Min");
                end else
                    if (SensorConfig."Warning Threshold Max" <> 0) and (Value > SensorConfig."Warning Threshold Max") then begin
                        AlertLevel := AlertLevel::Warning;
                        AlertMessage := StrSubstNo('Warning: Value %1 above maximum threshold %2', Value, SensorConfig."Warning Threshold Max");
                    end;

        exit(AlertLevel);
    end;

    local procedure CheckForAnomalies(var SensorData: Record "RWMS Sensor Data")
    var
        HistoricalData: Record "RWMS Sensor Data";
        Math: Codeunit Math;
        AvgValue: Decimal;
        StdDev: Decimal;
        Count: Integer;
        SumValue: Decimal;
        SumSquares: Decimal;
    begin
        // Get historical data for the same sensor (last 100 readings)
        HistoricalData.SetRange("Sensor ID", SensorData."Sensor ID");
        HistoricalData.SetFilter("Entry No.", '<%1', SensorData."Entry No.");
        HistoricalData.SetCurrentKey("Entry No.");
        HistoricalData.Ascending(false);

        if HistoricalData.FindSet() then begin
            Count := 0;
            repeat
                Count += 1;
                SumValue += HistoricalData.Value;
                SumSquares += Power(HistoricalData.Value, 2);
            until (HistoricalData.Next() = 0) or (Count >= 100);

            if Count > 10 then begin // Need enough data points
                AvgValue := SumValue / Count;
                StdDev := Math.Sqrt((SumSquares / Count) - Power(AvgValue, 2));

                // Mark as anomaly if value is more than 3 standard deviations from mean
                if Abs(SensorData.Value - AvgValue) > (3 * StdDev) then begin
                    SensorData."Is Anomaly" := true;
                    SensorData.Modify();
                end;
            end;
        end;
    end;

    local procedure SendAlert(SensorData: Record "RWMS Sensor Data")
    var
        SensorConfig: Record "RWMS Sensor Configuration";
    begin
        if SensorConfig.Get(SensorData."Sensor ID") then
            if SensorConfig."Alert Enabled" and (SensorConfig."Alert Email" <> '') then begin
                // Email alert functionality would be implemented here
                // For now, we'll just log it
                Message('Alert would be sent to %1: %2', SensorConfig."Alert Email", SensorData."Alert Message");
            end;
    end;

    procedure CalculateAverageValue(SensorID: Code[30]; StartDateTime: DateTime; EndDateTime: DateTime): Decimal
    var
        SensorData: Record "RWMS Sensor Data";
        TotalValue: Decimal;
        Count: Integer;
    begin
        SensorData.SetRange("Sensor ID", SensorID);
        SensorData.SetRange("Reading DateTime", StartDateTime, EndDateTime);
        if SensorData.FindSet() then begin
            repeat
                TotalValue += SensorData.Value;
                Count += 1;
            until SensorData.Next() = 0;

            if Count > 0 then
                exit(TotalValue / Count);
        end;

        exit(0);
    end;

    procedure GetSensorStatus(SensorID: Code[30]): Text[50]
    var
        SensorConfig: Record "RWMS Sensor Configuration";
        SensorData: Record "RWMS Sensor Data";
        LastReadingAge: Duration;
    begin
        if not SensorConfig.Get(SensorID) then
            exit('Unknown');

        if SensorConfig.Status <> SensorConfig.Status::Active then
            exit(Format(SensorConfig.Status));

        if SensorConfig."Last Reading DateTime" = 0DT then
            exit('No Data');

        LastReadingAge := CurrentDateTime() - SensorConfig."Last Reading DateTime";
        if LastReadingAge > (SensorConfig."Polling Interval (Sec)" * 2 * 1000) then
            exit('Offline');

        SensorData.SetRange("Sensor ID", SensorID);
        SensorData.SetCurrentKey("Reading DateTime");
        SensorData.Ascending(false);
        if SensorData.FindFirst() then
            if SensorData."Alert Level" <> SensorData."Alert Level"::Normal then
                exit('Alert')
            else
                exit('Normal');

        exit('Unknown');
    end;

    procedure CleanupOldData(DaysToKeep: Integer)
    var
        SensorData: Record "RWMS Sensor Data";
        CutoffDate: DateTime;
    begin
        CutoffDate := CreateDateTime(Today() - DaysToKeep, 0T);
        SensorData.SetFilter("Reading DateTime", '<%1', CutoffDate);
        if not SensorData.IsEmpty() then
            SensorData.DeleteAll(true);
    end;
}
