# Architecture Documentation

## System Architecture Overview

The Robotic Warehouse Management System (RWMS) is built as a Business Central extension that integrates with the core warehouse functionality while adding IoT sensor monitoring and AI analytics capabilities.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Role Center │  │  List Pages  │  │  Card Pages  │      │
│  │  (Dashboard) │  │              │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  API Pages   │  │  Fact Boxes  │  │  Cue Groups  │      │
│  │  (REST API)  │  │              │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    Business Logic Layer                      │
│  ┌────────────────────────────────────────────────────┐     │
│  │  Sensor Data Management Codeunit                   │     │
│  │  - Data validation                                 │     │
│  │  - Threshold checking                              │     │
│  │  - Alert generation                                │     │
│  │  - Anomaly detection                               │     │
│  └────────────────────────────────────────────────────┘     │
│  ┌────────────────────────────────────────────────────┐     │
│  │  AI Analytics Codeunit                             │     │
│  │  - Predictive analysis                             │     │
│  │  - Trend detection                                 │     │
│  │  - Optimization recommendations                    │     │
│  │  - OpenAI integration framework                    │     │
│  └────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Warehouse   │  │    Sensor    │  │  Sensor Data │      │
│  │    Table     │  │Configuration │  │    Table     │      │
│  │              │  │    Table     │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐                                           │
│  │  Analytics   │                                           │
│  │  Log Table   │                                           │
│  │              │                                           │
│  └──────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
```

## Component Details

### 1. Data Layer (Tables)

#### RWMS Warehouse (50000)
- **Purpose**: Master data for warehouse locations
- **Key Fields**: Code (PK), Name, Location Code, Status
- **Relations**: Links to BC Location table
- **Indexes**: Code, Name, Status
- **Special Features**: FlowField for total sensors count

#### RWMS Sensor Configuration (50001)
- **Purpose**: Sensor setup and configuration
- **Key Fields**: Sensor ID (PK), Warehouse Code (FK), Sensor Type
- **Relations**: Links to RWMS Warehouse
- **Indexes**: Sensor ID, Warehouse Code + Sensor Type, Status
- **Special Features**: Threshold configuration, maintenance tracking

#### RWMS Sensor Data (50002)
- **Purpose**: Historical sensor readings
- **Key Fields**: Entry No. (PK, AutoIncrement), Sensor ID (FK), Reading DateTime
- **Relations**: Links to Sensor Configuration and Warehouse
- **Indexes**: Entry No., Sensor ID + Reading DateTime, Warehouse Code + Sensor Type + Reading DateTime
- **Special Features**: Automatic anomaly detection on insert, alert level calculation
- **Data Type**: BigInteger for Entry No. to support millions of records

#### RWMS Analytics Log (50003)
- **Purpose**: AI analysis results and recommendations
- **Key Fields**: Entry No. (PK, AutoIncrement), Warehouse Code, Analysis DateTime
- **Relations**: Links to RWMS Warehouse
- **Indexes**: Entry No., Warehouse Code + Analysis DateTime
- **Special Features**: BLOB field for recommendations, helper methods for BLOB management

### 2. Business Logic Layer (Codeunits)

#### RWMS Sensor Data Management (50000)
**Responsibilities:**
- Insert sensor readings with validation
- Calculate alert levels based on thresholds
- Detect anomalies using statistical methods (3-sigma rule)
- Send alerts when thresholds are breached
- Calculate aggregated statistics
- Data cleanup and archival

**Key Methods:**
```al
InsertSensorReading(SensorID, DateTime, Value): Boolean
DetermineAlertLevel(SensorConfig, Value): Enum
CheckForAnomalies(SensorData)
SendAlert(SensorData)
CalculateAverageValue(SensorID, StartDateTime, EndDateTime): Decimal
GetSensorStatus(SensorID): Text
CleanupOldData(DaysToKeep)
```

**Algorithms:**
- **Anomaly Detection**: Uses running mean and standard deviation over last 100 readings
- **Alert Logic**: Compares against warning and critical thresholds (min/max)
- **Status Determination**: Based on last reading time vs polling interval

#### RWMS AI Analytics (50001)
**Responsibilities:**
- Run predictive analysis on warehouse data
- Analyze sensor trends
- Detect anomaly patterns across warehouse
- Generate optimization recommendations
- Framework for OpenAI integration

**Key Methods:**
```al
RunPredictiveAnalysis(WarehouseCode): Boolean
AnalyzeSensorTrends(SensorID): Text
DetectAnomaliesAcrossWarehouse(WarehouseCode): Integer
GenerateOptimizationRecommendations(WarehouseCode): Text
GenerateWarehouseSummary(WarehouseCode): Text
```

**Analysis Types:**
- Predictive Analysis: Forecasts based on historical patterns
- Trend Analysis: Calculates direction (increasing/decreasing/stable)
- Anomaly Detection: Counts anomalies within timeframe
- Optimization: Identifies maintenance needs and alert patterns

### 3. Presentation Layer (Pages)

#### Dashboard (Role Center) - 50006
- Main entry point for users
- Embedded parts for activities and alerts
- Quick navigation to all features
- Creation actions for new records

#### List Pages (50000, 50002, 50004, 50005)
- Warehouse List: All warehouses with key stats
- Sensor Config List: All sensor configurations
- Sensor Data List: Historical readings with styling
- Analytics Log List: AI analysis results

#### Card Pages (50001, 50003)
- Warehouse Card: Detailed warehouse management
- Sensor Config Card: Sensor configuration and thresholds

#### Part Pages (50007, 50008)
- Activities Part: KPI cuegroups with drill-down
- Sensor Alerts Part: Recent alerts widget

#### API Pages (50010-50012)
- RESTful OData v4 endpoints
- Support for GET, POST, PATCH operations
- JSON-based data exchange

### 4. Supporting Components

#### Enums (50000-50002)
- **RWMS Sensor Type**: 9 predefined types (extensible)
- **RWMS Sensor Status**: 5 status values (extensible)
- **RWMS Alert Level**: 4 severity levels (extensible)

#### Permission Sets (50000-50001)
- **RWMS Full Access**: Complete RIMD access
- **RWMS Read Only**: Read-only access to all objects

## Data Flow

### Sensor Data Ingestion Flow
```
External IoT Device
       │
       ▼ (HTTPS POST)
API Page (50010)
       │
       ▼ (Validation)
Table Trigger (OnInsert)
       │
       ├─▶ Update Sensor Config (Last Reading)
       │
       ▼ (Business Logic)
Sensor Data Management
       │
       ├─▶ Check Thresholds
       ├─▶ Determine Alert Level
       ├─▶ Detect Anomalies
       └─▶ Send Alerts (if needed)
       │
       ▼
Data Stored in Sensor Data Table
       │
       ▼
Dashboard Updated (Real-time)
```

### AI Analytics Flow
```
User Initiates Analysis
   OR
Scheduled Job Queue Entry
       │
       ▼
AI Analytics Codeunit
       │
       ├─▶ Query Sensor Data
       ├─▶ Calculate Statistics
       ├─▶ Run ML Algorithms
       ├─▶ (Optional) Call OpenAI API
       │
       ▼
Generate Recommendations
       │
       ▼
Store in Analytics Log
       │
       ├─▶ Set Alert Level (if needed)
       └─▶ Save Recommendations (BLOB)
       │
       ▼
Dashboard Updated
```

## Integration Points

### Internal BC Integration
- **Location Table**: Warehouse.Location Code
- **Country/Region**: Warehouse.Country/Region Code
- **User ID**: Created By fields
- **Email System**: Alert notifications (framework in place)

### External Integration
- **IoT Devices**: Via REST API (OData v4)
- **OpenAI API**: Framework in AI Analytics codeunit
- **External Analytics**: API export capabilities
- **Business Intelligence**: OData feed for Power BI

## Scalability Considerations

### Data Volume
- **Sensor Data**: BigInteger primary key supports billions of records
- **Indexing**: Optimized for time-based queries
- **Archival**: Built-in cleanup mechanism
- **Partitioning**: Consider date-based partitioning for large deployments

### Performance
- **FlowFields**: Used instead of calculated fields where possible
- **Indexes**: Strategic indexing on common filter fields
- **Batch Operations**: API supports bulk inserts
- **Caching**: Dashboard statistics calculated on-demand

### Concurrency
- **AutoIncrement**: Ensures unique Entry No. for concurrent inserts
- **Optimistic Locking**: BC standard record locking
- **Transaction Management**: Proper use of COMMIT in batch operations

## Security Architecture

### Authentication
- OAuth 2.0 for API access
- BC user authentication for UI
- Service-to-service accounts for automated systems

### Authorization
- Permission-based access control
- Two-tier permission sets (Full, Read-only)
- Field-level security through permissions

### Data Protection
- GDPR compliance: All fields marked CustomerContent
- Audit trail: Created By, timestamps on all records
- Data retention: Configurable cleanup policies

## Extensibility Points

### For Customization
1. **Enum Extension**: Add new sensor types, statuses, alert levels
2. **Table Extension**: Add custom fields to existing tables
3. **Page Extension**: Modify UI without changing base objects
4. **Event Subscribers**: Hook into business logic events
5. **API Extension**: Add custom API endpoints

### For Integration
1. **REST API**: Standard OData v4 interface
2. **Web Services**: BC web service framework
3. **Codeunit Functions**: Public methods for automation
4. **Job Queue**: Scheduled batch processing

## Deployment Architecture

```
┌─────────────────────────────────────────────────────┐
│            Business Central Cloud/On-Prem           │
│  ┌───────────────────────────────────────────────┐  │
│  │     RWMS Extension (This Extension)           │  │
│  │  - Tables, Pages, Codeunits, APIs             │  │
│  └───────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────┐  │
│  │     Base Application (Microsoft)              │  │
│  │  - Location, Country/Region, etc.             │  │
│  └───────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────┐  │
│  │     System Application (Microsoft)            │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
              │                │                │
              ▼                ▼                ▼
    ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
    │ IoT Sensors  │  │ Power BI     │  │ Mobile Apps  │
    │ (via API)    │  │ (via OData)  │  │ (via API)    │
    └──────────────┘  └──────────────┘  └──────────────┘
```

## Technology Stack

- **Platform**: Microsoft Dynamics 365 Business Central
- **Language**: AL (Application Language)
- **Runtime**: Business Central Server (version 23.0+)
- **Database**: SQL Server (managed by BC)
- **API Protocol**: OData v4 over HTTPS
- **Authentication**: OAuth 2.0
- **Data Format**: JSON (API), AL Records (internal)

## Future Architecture Enhancements

1. **Real-time Processing**: Event-driven architecture with Azure Event Hub
2. **ML Models**: Azure Machine Learning integration
3. **Time-series DB**: Dedicated time-series database for sensor data
4. **Message Queue**: Azure Service Bus for reliable delivery
5. **Caching Layer**: Redis for dashboard performance
6. **Mobile Backend**: Custom API gateway for mobile apps
7. **Notification Service**: Azure Notification Hub for push notifications
8. **Document Intelligence**: Azure Cognitive Services for report analysis
