# Robotic Warehouse Management System

A comprehensive Business Central extension for managing robotic warehouses with real-time sensor monitoring, AI-powered analytics, and OpenAI integration.

## Overview

This extension provides a complete solution for managing multiple robotic warehouses with:
- **Multi-warehouse management** with detailed configuration
- **Real-time sensor monitoring** (temperature, humidity, smoke, motion, etc.)
- **AI-powered analytics** with OpenAI integration framework
- **Automated alerts** and threshold management
- **Comprehensive dashboard** with key metrics and insights
- **REST API** for external sensor data integration
- **Historical data analysis** and trend detection

## Features

### Core Functionality

#### 1. Warehouse Management
- Manage multiple warehouse locations
- Track warehouse capacity, square meters, and active robots
- Integration with Business Central Location functionality
- Warehouse status monitoring (Active, Inactive, Maintenance)

#### 2. Sensor Configuration
- Support for 9+ sensor types:
  - Temperature
  - Humidity
  - Smoke
  - Motion
  - Light Level
  - CO2 Level
  - Pressure
  - Door Status
  - Inventory Level
- Configurable thresholds (Warning and Critical)
- Sensor status tracking (Active, Inactive, Maintenance, Error, Calibrating)
- Maintenance scheduling and tracking

#### 3. Sensor Data Collection
- Real-time sensor data ingestion
- Automatic threshold validation
- Alert generation based on thresholds
- Anomaly detection using statistical analysis
- Data quality scoring
- Battery and signal strength monitoring

#### 4. AI Analytics
- Predictive analysis framework
- Trend detection and analysis
- Anomaly detection across warehouses
- Optimization recommendations
- OpenAI integration ready

#### 5. Dashboard & Reporting
- Role Center with comprehensive analytics
- Real-time KPIs (warehouses, sensors, alerts, anomalies)
- Alert management with severity levels
- Historical data visualization ready

#### 6. REST API
- API endpoints for external system integration:
  - `/api/warehouse/v1.0/warehouses` - Warehouse data
  - `/api/warehouse/v1.0/sensorConfigurations` - Sensor configurations
  - `/api/warehouse/v1.0/sensorData` - Sensor readings
- OData support for queries and filtering

## Installation

### Prerequisites
- Microsoft Dynamics 365 Business Central (Platform version 23.0 or higher)
- System Application dependency (23.0.0.0)
- Base Application dependency (23.0.0.0)

### Deployment
1. Clone this repository
2. Open in AL development environment (VS Code with AL Language extension)
3. Update `app.json` with your publisher information and unique GUID
4. Compile the extension
5. Deploy to your Business Central environment

```bash
# Download symbols
al: Download Symbols

# Compile
al: Package

# Deploy
al: Publish
```

## Configuration

### Initial Setup

1. **Create Warehouses**
   - Navigate to "Warehouses" from the dashboard
   - Create warehouse records with location details
   - Link to Business Central locations if needed
   - Configure AI analytics settings

2. **Configure Sensors**
   - Navigate to "Sensor Configurations"
   - Create sensor records for each physical sensor
   - Set thresholds (warning and critical levels)
   - Configure polling intervals
   - Enable alerts and set notification emails

3. **Assign Permissions**
   - Assign "RWMS Full Access" for administrators
   - Assign "RWMS Read Only" for monitoring users

### API Integration

To integrate external sensor systems:

1. Use the REST API endpoints (OData v4)
2. Authenticate using Business Central OAuth 2.0
3. POST sensor data to `/api/warehouse/v1.0/sensorData`

Example API call:
```json
POST /api/warehouse/v1.0/sensorData
{
  "sensorId": "TEMP-001",
  "warehouseCode": "WH001",
  "sensorType": "Temperature",
  "readingDateTime": "2025-11-16T14:00:00Z",
  "value": 22.5,
  "unitOfMeasure": "°C",
  "batteryLevel": 85.0,
  "signalStrength": 95.0
}
```

## Usage

### Dashboard Access
Open the "Robotic Warehouse Management Dashboard" from your Role Center to access:
- Key performance indicators
- Recent alerts
- Warehouse statistics
- Quick navigation to all features

### Monitoring Sensors
1. Navigate to "Sensor Data" to view real-time readings
2. Filter by warehouse, sensor type, or alert level
3. Review anomalies flagged by the AI system
4. Export data for external analysis

### Running AI Analytics
The system automatically:
- Detects anomalies in sensor data
- Generates trend analysis
- Creates optimization recommendations
- Logs all analysis results

Manual analysis can be triggered through codeunits:
- `RWMS AI Analytics.RunPredictiveAnalysis(WarehouseCode)`
- `RWMS AI Analytics.DetectAnomaliesAcrossWarehouse(WarehouseCode)`

## Architecture

### Object Ranges
- Tables: 50000-50099
- Pages: 50000-50099
- Codeunits: 50000-50099
- Enums: 50000-50099

### Key Components

#### Tables
- **RWMS Warehouse** (50000) - Warehouse master data
- **RWMS Sensor Configuration** (50001) - Sensor setup and configuration
- **RWMS Sensor Data** (50002) - Sensor readings and measurements
- **RWMS Analytics Log** (50003) - AI analysis results and recommendations

#### Pages
- **RWMS Dashboard** (50006) - Main Role Center
- **RWMS Warehouse List/Card** (50000-50001)
- **RWMS Sensor Config List/Card** (50002-50003)
- **RWMS Sensor Data List** (50004)
- **RWMS Analytics Log List** (50005)
- **RWMS Activities** (50007) - KPI cuegroup
- **RWMS Sensor Alerts Part** (50008) - Alert widget

#### Codeunits
- **RWMS Sensor Data Management** (50000) - Data processing and validation
- **RWMS AI Analytics** (50001) - AI-powered analytics and predictions

#### API Pages
- **RWMS Sensor Data API** (50010)
- **RWMS Warehouse API** (50011)
- **RWMS Sensor Config API** (50012)

## OpenAI Integration

The extension includes a framework for OpenAI integration. To enable:

1. Obtain OpenAI API credentials
2. Implement HTTP client calls in `RWMS AI Analytics` codeunit
3. Configure API endpoints and authentication
4. Enable AI Analytics on warehouse records

The framework supports:
- Natural language queries about warehouse conditions
- Predictive maintenance recommendations
- Automated report generation
- Trend analysis and forecasting

## Data Management

### Data Retention
Use the cleanup function to manage historical data:
```al
RWMS Sensor Data Management.CleanupOldData(90); // Keep last 90 days
```

### Performance Optimization
- Sensor data table uses BigInteger for entry numbers
- Indexed on common query patterns
- API pages use delayed insert for bulk operations

## Security

### Permission Sets
- **RWMS Full Access** (50000) - Complete access to all objects
- **RWMS Read Only** (50001) - View-only access

### Data Classification
All sensitive data is classified as `ToBeClassified` for GDPR compliance.

## Support & Development

### Master's Project
This extension was developed as a master's project for robotic warehouse management, demonstrating:
- Business Central extension development
- Integration with warehouse management
- IoT sensor data collection
- AI/ML analytics integration
- REST API development

### Extensibility
All enums are marked as `Extensible = true` for easy customization:
- Add new sensor types
- Define custom alert levels
- Extend analytics capabilities

## Future Enhancements

Planned features:
- [ ] Real-time OpenAI API integration
- [ ] Power BI embedded reports
- [ ] Mobile app integration
- [ ] Predictive maintenance scheduling
- [ ] Robot fleet management
- [ ] Automated inventory optimization
- [ ] Advanced machine learning models
- [ ] Integration with IoT platforms (Azure IoT, AWS IoT)

## License

This project is part of a master's thesis. Please contact the repository owner for licensing information.

## Author

Roman Machylo - Master's Project

## Acknowledgments

Built on Microsoft Dynamics 365 Business Central platform, integrating with standard warehouse management functionality.
