# Sample Data Setup Guide

This guide provides examples for creating sample data to test the Robotic Warehouse Management System.

## Sample Warehouses

### Warehouse 1: Main Distribution Center
```
Code: WH001
Name: Main Distribution Center
Address: 123 Industrial Park Drive
City: Seattle
Post Code: 98101
Country/Region Code: US
Phone No.: +1-206-555-0100
E-Mail: wh001@company.com
Location Code: MAIN
Square Meters: 50000.00
Max Capacity: 100000.00
Active Robots: 25
Status: Active
Manager Name: John Smith
Operating Hours: 24/7
AI Analytics Enabled: Yes
```

### Warehouse 2: Regional Hub
```
Code: WH002
Name: Regional Distribution Hub
Address: 456 Commerce Boulevard
City: Portland
Post Code: 97201
Country/Region Code: US
Phone No.: +1-503-555-0200
E-Mail: wh002@company.com
Location Code: REGIONAL
Square Meters: 30000.00
Max Capacity: 60000.00
Active Robots: 15
Status: Active
Manager Name: Sarah Johnson
Operating Hours: Mon-Fri 6AM-10PM
AI Analytics Enabled: Yes
```

### Warehouse 3: Cold Storage
```
Code: WH003
Name: Cold Storage Facility
Address: 789 Refrigeration Way
City: Tacoma
Post Code: 98402
Country/Region Code: US
Phone No.: +1-253-555-0300
E-Mail: wh003@company.com
Location Code: COLD
Square Meters: 20000.00
Max Capacity: 40000.00
Active Robots: 10
Status: Active
Manager Name: Mike Chen
Operating Hours: 24/7
AI Analytics Enabled: Yes
```

## Sample Sensor Configurations

### Temperature Sensors

#### WH001 - Zone A Temperature
```
Sensor ID: TEMP-WH001-A
Warehouse Code: WH001
Sensor Type: Temperature
Description: Temperature sensor - Zone A entrance
Location: Zone A - Main Entrance
Zone Code: ZONE-A
Status: Active
Min Value: -10.00
Max Value: 40.00
Warning Threshold Min: 15.00
Warning Threshold Max: 30.00
Critical Threshold Min: 10.00
Critical Threshold Max: 35.00
Unit of Measure: °C
Polling Interval (Sec): 60
Manufacturer: Honeywell
Model: THX-5000
Serial No.: HW-123456
Installation Date: 01/01/2025
Maintenance Due Date: 01/01/2026
Alert Enabled: Yes
Alert Email: alerts@company.com
```

#### WH001 - Zone B Temperature
```
Sensor ID: TEMP-WH001-B
Warehouse Code: WH001
Sensor Type: Temperature
Description: Temperature sensor - Zone B storage
Location: Zone B - Main Storage Area
Zone Code: ZONE-B
Status: Active
Min Value: -10.00
Max Value: 40.00
Warning Threshold Min: 16.00
Warning Threshold Max: 28.00
Critical Threshold Min: 12.00
Critical Threshold Max: 32.00
Unit of Measure: °C
Polling Interval (Sec): 60
Manufacturer: Honeywell
Model: THX-5000
Serial No.: HW-123457
Installation Date: 01/01/2025
Maintenance Due Date: 01/01/2026
Alert Enabled: Yes
Alert Email: alerts@company.com
```

#### WH003 - Cold Zone Temperature
```
Sensor ID: TEMP-WH003-COLD
Warehouse Code: WH003
Sensor Type: Temperature
Description: Cold storage temperature monitor
Location: Cold Storage - Main Chamber
Zone Code: COLD-1
Status: Active
Min Value: -30.00
Max Value: 5.00
Warning Threshold Min: -18.00
Warning Threshold Max: 0.00
Critical Threshold Min: -25.00
Critical Threshold Max: 2.00
Unit of Measure: °C
Polling Interval (Sec): 30
Manufacturer: Arctic Tech
Model: CT-2000
Serial No.: AT-789012
Installation Date: 01/01/2025
Maintenance Due Date: 06/01/2025
Alert Enabled: Yes
Alert Email: coldchain@company.com
```

### Humidity Sensors

#### WH001 - Zone A Humidity
```
Sensor ID: HUM-WH001-A
Warehouse Code: WH001
Sensor Type: Humidity
Description: Humidity sensor - Zone A
Location: Zone A - Main Entrance
Zone Code: ZONE-A
Status: Active
Min Value: 0.00
Max Value: 100.00
Warning Threshold Min: 30.00
Warning Threshold Max: 70.00
Critical Threshold Min: 20.00
Critical Threshold Max: 80.00
Unit of Measure: %
Polling Interval (Sec): 120
Manufacturer: Honeywell
Model: HUM-3000
Serial No.: HW-223456
Installation Date: 01/01/2025
Maintenance Due Date: 01/01/2026
Alert Enabled: Yes
Alert Email: alerts@company.com
```

### Smoke Detectors

#### WH001 - Smoke Detector 1
```
Sensor ID: SMOKE-WH001-1
Warehouse Code: WH001
Sensor Type: Smoke
Description: Smoke detector - Main area
Location: Zone A - Ceiling mount 1
Zone Code: ZONE-A
Status: Active
Min Value: 0.00
Max Value: 100.00
Warning Threshold Max: 20.00
Critical Threshold Max: 40.00
Unit of Measure: ppm
Polling Interval (Sec): 10
Manufacturer: FireSafe
Model: FS-500
Serial No.: FS-334455
Installation Date: 01/01/2025
Maintenance Due Date: 07/01/2025
Alert Enabled: Yes
Alert Email: fire.alerts@company.com
```

### Motion Sensors

#### WH002 - Motion Detector
```
Sensor ID: MOTION-WH002-1
Warehouse Code: WH002
Sensor Type: Motion
Description: Motion detector - Security zone
Location: Zone C - Restricted Area
Zone Code: ZONE-C
Status: Active
Min Value: 0.00
Max Value: 1.00
Unit of Measure: bool
Polling Interval (Sec): 5
Manufacturer: SecureTech
Model: MS-100
Serial No.: ST-445566
Installation Date: 01/01/2025
Maintenance Due Date: 01/01/2026
Alert Enabled: Yes
Alert Email: security@company.com
```

### CO2 Sensors

#### WH001 - CO2 Monitor
```
Sensor ID: CO2-WH001-1
Warehouse Code: WH001
Sensor Type: CO2 Level
Description: Carbon dioxide monitor
Location: Zone B - Central monitoring
Zone Code: ZONE-B
Status: Active
Min Value: 0.00
Max Value: 5000.00
Warning Threshold Max: 1000.00
Critical Threshold Max: 2000.00
Unit of Measure: ppm
Polling Interval (Sec): 300
Manufacturer: AirQuality Inc
Model: AQ-CO2-Pro
Serial No.: AQ-556677
Installation Date: 01/01/2025
Maintenance Due Date: 01/01/2026
Alert Enabled: Yes
Alert Email: safety@company.com
```

## Sample Sensor Data

You can insert sample sensor data via the API. Here are some examples:

### Normal Temperature Reading
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "TEMP-WH001-A",
  "warehouseCode": "WH001",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T10:00:00Z",
  "value": 22.5,
  "unitOfMeasure": "°C",
  "zoneCode": "ZONE-A",
  "batteryLevel": 95.0,
  "signalStrength": 98.0,
  "dataQualityScore": 100.0
}
```

### Warning Level Temperature
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "TEMP-WH001-A",
  "warehouseCode": "WH001",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T11:00:00Z",
  "value": 29.5,
  "unitOfMeasure": "°C",
  "zoneCode": "ZONE-A",
  "batteryLevel": 94.0,
  "signalStrength": 97.0,
  "dataQualityScore": 99.0
}
```

### Critical Temperature Alert
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "TEMP-WH003-COLD",
  "warehouseCode": "WH003",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T12:00:00Z",
  "value": 3.5,
  "unitOfMeasure": "°C",
  "zoneCode": "COLD-1",
  "batteryLevel": 85.0,
  "signalStrength": 92.0,
  "dataQualityScore": 98.0
}
```

### Humidity Reading
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "HUM-WH001-A",
  "warehouseCode": "WH001",
  "sensorType": "Humidity",
  "readingDateTime": "2025-11-16T10:00:00Z",
  "value": 45.2,
  "unitOfMeasure": "%",
  "zoneCode": "ZONE-A",
  "batteryLevel": 96.0,
  "signalStrength": 99.0,
  "dataQualityScore": 100.0
}
```

### Smoke Detector (Normal)
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "SMOKE-WH001-1",
  "warehouseCode": "WH001",
  "sensorType": "Smoke",
  "readingDateTime": "2025-11-16T10:00:00Z",
  "value": 2.5,
  "unitOfMeasure": "ppm",
  "zoneCode": "ZONE-A",
  "batteryLevel": 88.0,
  "signalStrength": 95.0,
  "dataQualityScore": 100.0
}
```

### Motion Detected
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "MOTION-WH002-1",
  "warehouseCode": "WH002",
  "sensorType": "Motion",
  "readingDateTime": "2025-11-16T10:05:00Z",
  "value": 1.0,
  "unitOfMeasure": "bool",
  "zoneCode": "ZONE-C",
  "batteryLevel": 92.0,
  "signalStrength": 96.0,
  "dataQualityScore": 100.0
}
```

## Testing Scenarios

### Scenario 1: Normal Operations
1. Create 3 warehouses (WH001, WH002, WH003)
2. Add 2-3 sensors per warehouse
3. Send normal readings every minute for 1 hour
4. Verify dashboard shows correct statistics
5. Check that no alerts are generated

### Scenario 2: Temperature Warning
1. Send temperature reading above warning threshold
2. Verify alert is generated in Sensor Data
3. Check alert appears in dashboard "Recent Alerts"
4. Verify alert email would be sent (if configured)

### Scenario 3: Critical Alert
1. Send reading above critical threshold
2. Verify critical alert level is set
3. Check dashboard shows increased critical alert count
4. Verify anomaly detection doesn't flag this (it's expected due to threshold)

### Scenario 4: Anomaly Detection
1. Send 100 normal readings (e.g., 22-24°C)
2. Send one reading far outside normal range (e.g., 45°C)
3. Verify "Is Anomaly" flag is set
4. Run AI analytics to detect anomalies

### Scenario 5: Sensor Maintenance
1. Create sensor with maintenance due date in past
2. Check dashboard statistics
3. Update sensor status to "Maintenance"
4. Verify sensor data collection stops

### Scenario 6: Multi-Warehouse Analytics
1. Create multiple warehouses with sensors
2. Generate data across all warehouses
3. Run predictive analysis for each warehouse
4. Compare analytics results

## Bulk Data Import

For testing with larger datasets, consider using PowerShell or Python scripts to automate API calls:

```powershell
# PowerShell example
$baseUrl = "https://your-bc-url/api/warehouse/v1.0"
$token = "your-oauth-token"

# Generate 1000 temperature readings
for ($i = 0; $i -lt 1000; $i++) {
    $reading = @{
        sensorId = "TEMP-WH001-A"
        warehouseCode = "WH001"
        sensorType = "Temperature"
        readingDateTime = (Get-Date).AddMinutes(-$i).ToString("yyyy-MM-ddTHH:mm:ssZ")
        value = 22.0 + (Get-Random -Minimum -2.0 -Maximum 2.0)
        unitOfMeasure = "°C"
        batteryLevel = 95.0 - ($i * 0.01)
        signalStrength = 98.0
    }
    
    Invoke-RestMethod -Uri "$baseUrl/sensorData" -Method Post -Body ($reading | ConvertTo-Json) -Headers @{Authorization="Bearer $token"; "Content-Type"="application/json"}
    Start-Sleep -Milliseconds 100
}
```

## Clean Up Test Data

After testing, you can clean up using:
1. Delete sensor data: Delete all from "Sensor Data" list
2. Delete sensor configurations: Delete all from "Sensor Configuration" list
3. Delete warehouses: Delete all from "Warehouses" list
4. Or use the cleanup function for old data:
   - `RWMS Sensor Data Management.CleanupOldData(0)` to delete all

## Notes

- All timestamps should be in UTC format (ISO 8601)
- Battery levels are percentages (0-100)
- Signal strength is percentage (0-100)
- Data quality score is percentage (0-100)
- Boolean sensors use 0.0 or 1.0 as values
