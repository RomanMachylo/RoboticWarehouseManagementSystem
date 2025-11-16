page 50011 "RWMS Warehouse API"
{
    PageType = API;
    APIPublisher = 'romanmachylo';
    APIGroup = 'warehouse';
    APIVersion = 'v1.0';
    EntityName = 'warehouse';
    EntitySetName = 'warehouses';
    SourceTable = "RWMS Warehouse";
    DelayedInsert = true;
    ODataKeyFields = "Code";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(squareMeters; Rec."Square Meters")
                {
                    Caption = 'Square Meters';
                }
                field(maxCapacity; Rec."Max Capacity")
                {
                    Caption = 'Max Capacity';
                }
                field(activeRobots; Rec."Active Robots")
                {
                    Caption = 'Active Robots';
                }
                field(totalSensors; Rec."Total Sensors")
                {
                    Caption = 'Total Sensors';
                }
                field(lastDataUpdate; Rec."Last Data Update")
                {
                    Caption = 'Last Data Update';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(managerName; Rec."Manager Name")
                {
                    Caption = 'Manager Name';
                }
                field(operatingHours; Rec."Operating Hours")
                {
                    Caption = 'Operating Hours';
                }
                field(aiAnalyticsEnabled; Rec."AI Analytics Enabled")
                {
                    Caption = 'AI Analytics Enabled';
                }
            }
        }
    }
}
