# Інструкція по запуску автотестів для Robotic Warehouse Management System

## Опис автотестів

Створено 15 автоматичних тестів, які покривають основну функціональність системи:

### 1. **Warehouse Tests** (50100) - 4 тести
- `TestCreateWarehouse` - Перевірка створення нового складу
- `TestWarehouseCodeMandatory` - Перевірка обов'язковості коду складу
- `TestWarehouseStatusChange` - Перевірка зміни статусу складу
- `TestWarehouseCapacityValidation` - Перевірка валідації місткості

### 2. **Sensor Tests** (50101) - 4 тести
- `TestCreateSensorConfiguration` - Створення конфігурації сенсора
- `TestSensorDataInsertion` - Вставка даних сенсора
- `TestSensorThresholdValidation` - Валідація порогових значень
- `TestSensorStatusTransition` - Перехід між статусами сенсора

### 3. **Alert Tests** (50102) - 3 тести
- `TestCreateAlert` - Створення сповіщення
- `TestAlertStatusProgression` - Прогресія статусів сповіщень
- `TestAlertLevelClassification` - Класифікація рівнів сповіщень

### 4. **Zone Tests** (50103) - 3 тести
- `TestCreateZone` - Створення зони
- `TestZoneTypeAssignment` - Призначення типів зон
- `TestZoneTemperatureRange` - Перевірка температурного діапазону

### 5. **Analytics Tests** (50104) - 4 тести
- `TestCreateAnalyticsLog` - Створення аналітичного запису
- `TestCreatePerformanceMetrics` - Створення метрик продуктивності
- `TestAnalyticsConfidenceScore` - Перевірка показників впевненості
- `TestPerformanceMetricsAggregation` - Агрегація метрик

## Як запустити тести

### Метод 1: Через VS Code (рекомендовано)

1. **Відкрийте термінал** в VS Code (`Ctrl + ``)

2. **Скомпілюйте та опублікуйте розширення з тестами:**
```powershell
# Переконайтеся, що ви в кореневій директорії проекту
cd "d:\Studying\Magistratura\Дисертація\RoboticWarehouseManagementSystem"

# Опублікуйте розширення
Publish-NAVApp -ServerInstance BC190 -Path ".\Roman Machylo_Robotic Warehouse Management System_1.0.0.0.app" -SkipVerification
```

3. **Запустіть всі тести:**
```powershell
Invoke-BCContainerTest -containerName BC `
    -extensionId "YourExtensionId" `
    -detailed
```

### Метод 2: Через Business Central Web Client

1. **Відкрийте Business Central** в браузері

2. **Знайдіть сторінку "Test Tool":**
   - Натисніть на лупу (Search)
   - Введіть "Test Tool"
   - Відкрийте сторінку

3. **Виберіть тестові Codeunits:**
   - Codeunit 50100 "RWMS Warehouse Tests"
   - Codeunit 50101 "RWMS Sensor Tests"
   - Codeunit 50102 "RWMS Alert Tests"
   - Codeunit 50103 "RWMS Zone Tests"
   - Codeunit 50104 "RWMS Analytics Tests"

4. **Запустіть тести:**
   - Натисніть кнопку "Run" або "Run Selected"
   - Перегляньте результати в колонці "Result"

### Метод 3: Через PowerShell (автоматизація)

Створіть PowerShell скрипт `RunTests.ps1`:

```powershell
# RunTests.ps1
$ServerInstance = "BC190"
$CompanyName = "Your Company Name"

# Масив Codeunit ID для тестування
$TestCodeunits = @(50100, 50101, 50102, 50103, 50104)

foreach ($CodeunitId in $TestCodeunits) {
    Write-Host "Running tests in Codeunit $CodeunitId..." -ForegroundColor Cyan
    
    Invoke-NAVCodeunit -ServerInstance $ServerInstance `
        -CompanyName $CompanyName `
        -CodeunitId $CodeunitId
    
    Write-Host "Completed Codeunit $CodeunitId" -ForegroundColor Green
}

Write-Host "`nAll tests completed!" -ForegroundColor Yellow
```

Запустіть скрипт:
```powershell
.\RunTests.ps1
```

### Метод 4: Через AL Test Tool Extension

1. **Встановіть AL Test Tool** з VS Code Marketplace

2. **Налаштуйте launch.json:**
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Run Tests",
            "type": "al",
            "request": "launch",
            "environmentType": "OnPrem",
            "server": "http://localhost",
            "serverInstance": "BC190",
            "authentication": "Windows",
            "startupObjectId": 130401,
            "startupObjectType": "Page",
            "breakOnError": true,
            "launchBrowser": true,
            "enableLongRunningSqlStatements": true,
            "enableSqlInformationDebugger": true,
            "tenant": "default"
        }
    ]
}
```

3. **Запустіть тести натиснувши F5**

## Інтерпретація результатів

### Успішний тест
```
✓ TestCreateWarehouse - SUCCESS
  Duration: 125ms
```

### Неуспішний тест
```
✗ TestWarehouseCodeMandatory - FAILURE
  Error: Expected error but none occurred
  Duration: 89ms
```

## Структура тестів

Кожен тест використовує патерн **Given-When-Then**:

```al
[Test]
procedure TestExample()
begin
    // [GIVEN] Початкові умови
    CreateTestData();
    
    // [WHEN] Дія, яку тестуємо
    PerformAction();
    
    // [THEN] Очікуваний результат
    Assert.IsTrue(Condition, 'Error message');
    
    // Cleanup
    CleanupTestData();
end;
```

## Автоматизація в CI/CD

Додайте до вашого CI/CD pipeline:

```yaml
# azure-pipelines.yml
- task: PowerShell@2
  displayName: 'Run AL Tests'
  inputs:
    targetType: 'inline'
    script: |
      Import-Module 'C:\Program Files\Microsoft Dynamics 365 Business Central\190\Service\NavAdminTool.ps1'
      Invoke-BCContainerTest -containerName BC -extensionId "YourExtensionId"
```

## Очікувані результати

При правильній роботі системи всі 15 тестів повинні завершитися успішно:

```
Test Summary:
- Total: 15
- Passed: 15 ✓
- Failed: 0
- Skipped: 0
Duration: ~2500ms
```

## Troubleshooting

### Проблема: Тести не знаходяться
**Рішення:** Переконайтеся, що розширення опубліковано та встановлено:
```powershell
Get-NAVAppInfo -ServerInstance BC190 | Where-Object {$_.Name -like "*Robotic Warehouse*"}
```

### Проблема: Помилки доступу до даних
**Рішення:** Перевірте права користувача та встановіть правильний Permission Set:
```powershell
Set-NAVServerUser -ServerInstance BC190 -UserName "testuser" -PermissionSetId "RWMS FULL ACCESS"
```

### Проблема: Timeout при виконанні тестів
**Рішення:** Збільште timeout в налаштуваннях:
```powershell
Set-NAVServerConfiguration -ServerInstance BC190 -KeyName "SqlCommandTimeout" -KeyValue "00:05:00"
```

## Додаткова інформація

- **Документація по AL Testing:** https://docs.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-testing-application
- **Assert методи:** Використовуйте codeunit "Library Assert" для перевірок
- **Test Coverage:** Використовуйте Code Coverage tool для аналізу покриття

## Контакти

При виникненні проблем з тестами:
1. Перевірте логи в Event Viewer
2. Перегляньте Application Log в Business Central
3. Запустіть тести з увімкненим debugger
