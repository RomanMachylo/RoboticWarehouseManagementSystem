# Quick Start Guide - Robotic Warehouse Management System

## What This Extension Does

This Business Central extension provides a complete solution for managing robotic warehouses with real-time sensor monitoring and AI-powered analytics.

## Key Capabilities

### 1. Warehouse Management
- Create and manage multiple warehouse locations
- Track capacity, robots, and sensors
- Integration with BC Location module
- Status tracking (Active, Inactive, Maintenance)

### 2. Sensor Monitoring
**Supported Sensor Types:**
- Temperature
- Humidity
- Smoke
- Motion
- Light Level
- CO2 Level
- Pressure
- Door Status
- Inventory Level

**Features:**
- Real-time data collection
- Configurable warning and critical thresholds
- Automatic alert generation
- Anomaly detection
- Battery and signal monitoring

### 3. AI Analytics
- Predictive analysis framework
- Trend detection
- Anomaly detection across all warehouses
- Optimization recommendations
- Ready for OpenAI integration

### 4. Dashboard & Visualization
- Real-time KPIs (warehouses, sensors, alerts)
- Alert monitoring with severity levels
- Recent alerts widget
- Statistics cuegroups

### 5. REST API
- OData v4 endpoints for external integration
- Endpoints for warehouses, sensors, and sensor data
- Supports POST for data ingestion from IoT devices

## Quick Setup

### Step 1: Deploy Extension
1. Open in VS Code with AL Language extension
2. Download symbols: `Ctrl+Shift+P` → "AL: Download Symbols"
3. Compile: `Ctrl+Shift+B` or `Ctrl+Shift+P` → "AL: Package"
4. Publish to your BC environment

### Step 2: Assign Permissions
- Give users "RWMS Full Access" permission set for complete access
- Or "RWMS Read Only" for monitoring only

### Step 3: Create Your First Warehouse
1. Open "Warehouses" from search
2. Click "New"
3. Fill in:
   - Code (e.g., "WH001")
   - Name (e.g., "Main Distribution Center")
   - Address and contact details
   - Status: Active
   - Enable "AI Analytics Enabled"

### Step 4: Configure Sensors
1. Open "Sensor Configurations" from search
2. Click "New" for each sensor
3. Fill in:
   - Sensor ID (e.g., "TEMP-001")
   - Warehouse Code (select from list)
   - Sensor Type (e.g., Temperature)
   - Description and Location
   - Status: Active
4. Set Thresholds:
   - Warning Threshold Min/Max
   - Critical Threshold Min/Max
   - Unit of Measure (e.g., "°C", "%", "ppm")
5. Configure Alerts:
   - Enable Alert Enabled
   - Set Alert Email

### Step 5: Start Collecting Data
Use the API to send sensor data:

**Endpoint:** `POST https://[your-bc-url]/api/warehouse/v1.0/sensorData`

**Example JSON:**
```json
{
  "sensorId": "TEMP-001",
  "warehouseCode": "WH001",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T14:30:00Z",
  "value": 22.5,
  "unitOfMeasure": "°C",
  "batteryLevel": 85.0,
  "signalStrength": 95.0,
  "dataQualityScore": 98.0
}
```

### Step 6: Access Dashboard
1. Search for "Robotic Warehouse Management Dashboard"
2. View real-time statistics:
   - Total/Active Warehouses
   - Total/Active Sensors
   - Critical and Warning Alerts
   - AI Analytics runs today
   - Anomalies detected

## Using the System

### Monitoring Sensor Data
1. Navigate to "Sensor Data" from dashboard
2. Filter by:
   - Warehouse Code
   - Sensor Type
   - Alert Level
   - Date Range
3. Review anomalies (marked with flag)
4. Check AI Analysis Results column

### Running Analytics
The system automatically:
- Detects anomalies (3σ from mean)
- Flags critical thresholds
- Generates alerts

Manual analysis (via code):
```al
// In codeunit or page
RWMSAIAnalytics: Codeunit "RWMS AI Analytics";

// Run predictive analysis
RWMSAIAnalytics.RunPredictiveAnalysis('WH001');

// Get sensor trends
TrendInfo := RWMSAIAnalytics.AnalyzeSensorTrends('TEMP-001');

// Detect anomalies
AnomalyCount := RWMSAIAnalytics.DetectAnomaliesAcrossWarehouse('WH001');
```

### Viewing Analytics Logs
1. Navigate to "Analytics" from warehouse card or dashboard
2. Review:
   - Analysis Type
   - AI Model Used
   - Confidence Score
   - Analysis Result
3. Click "View Recommendations" for detailed suggestions

### Managing Alerts
1. Critical/Warning alerts show in dashboard
2. Alert emails sent automatically (if configured)
3. Review "Recent Sensor Alerts" widget on dashboard
4. Filter Sensor Data by Alert Level

## API Integration Examples

### Authentication
Use OAuth 2.0 with Business Central credentials.

### Get All Warehouses
```
GET /api/warehouse/v1.0/warehouses
```

### Get Specific Warehouse
```
GET /api/warehouse/v1.0/warehouses('WH001')
```

### Get Sensor Configurations for Warehouse
```
GET /api/warehouse/v1.0/sensorConfigurations?$filter=warehouseCode eq 'WH001'
```

### Get Recent Sensor Data
```
GET /api/warehouse/v1.0/sensorData?$filter=warehouseCode eq 'WH001' and readingDateTime gt 2025-11-16T00:00:00Z
```

### Post Sensor Reading
```
POST /api/warehouse/v1.0/sensorData
Content-Type: application/json

{
  "sensorId": "TEMP-001",
  "warehouseCode": "WH001",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T14:30:00Z",
  "value": 22.5,
  "unitOfMeasure": "°C"
}
```

## Data Management

### Cleanup Old Data
To prevent database growth, periodically cleanup old sensor data:

```al
RWMSSensorDataMgmt: Codeunit "RWMS Sensor Data Management";

// Keep only last 90 days
RWMSSensorDataMgmt.CleanupOldData(90);
```

Consider scheduling this as a job queue entry.

## Extensibility

All enums are extensible, allowing you to add:
- New sensor types
- Custom alert levels
- Additional sensor statuses

Example:
```al
enumextension 50100 "My Sensor Types" extends "RWMS Sensor Type"
{
    value(50100; "Custom Sensor")
    {
        Caption = 'Custom Sensor';
    }
}
```

## Troubleshooting

### Sensor Not Receiving Data
1. Check sensor status is "Active"
2. Verify API endpoint configuration
3. Check authentication credentials
4. Review sensor logs in "Sensor Data"

### No Alerts Generated
1. Verify "Alert Enabled" is checked
2. Check threshold values are properly set
3. Ensure alert email is configured
4. Review sensor data values vs thresholds

### Dashboard Not Showing Data
1. Refresh the page
2. Check data exists in Sensor Data
3. Verify date filters
4. Ensure sensors are linked to warehouses

## Next Steps

1. **Integrate IoT Devices**: Connect your physical sensors via the API
2. **Configure OpenAI**: Implement actual OpenAI API calls for advanced analytics
3. **Create Reports**: Build custom reports using AL Report objects
4. **Add Power BI**: Integrate Power BI for advanced visualizations
5. **Mobile Access**: Configure for mobile devices
6. **Automated Jobs**: Set up job queues for analytics and cleanup

## Support

For questions or issues:
- Review the main README.md for detailed documentation
- Check the source code comments for implementation details
- Contact repository owner: Roman Machylo

## Version
1.0.0.0 - Initial Release
