table 50003 "RWMS Analytics Log"
{
    Caption = 'Analytics Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Analysis DateTime"; DateTime)
        {
            Caption = 'Analysis DateTime';
            DataClassification = ToBeClassified;
        }
        field(4; "Analysis Type"; Text[50])
        {
            Caption = 'Analysis Type';
            DataClassification = ToBeClassified;
        }
        field(5; "Analysis Result"; Text[250])
        {
            Caption = 'Analysis Result';
            DataClassification = ToBeClassified;
        }
        field(6; "AI Model Used"; Text[50])
        {
            Caption = 'AI Model Used';
            DataClassification = ToBeClassified;
        }
        field(7; "Data Points Analyzed"; Integer)
        {
            Caption = 'Data Points Analyzed';
            DataClassification = ToBeClassified;
        }
        field(8; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(9; "Recommendations"; Blob)
        {
            Caption = 'Recommendations';
            DataClassification = ToBeClassified;
        }
        field(10; "Alert Level"; Enum "RWMS Alert Level")
        {
            Caption = 'Alert Level';
            DataClassification = ToBeClassified;
        }
        field(11; "Action Taken"; Text[250])
        {
            Caption = 'Action Taken';
            DataClassification = ToBeClassified;
        }
        field(12; "Processing Time (ms)"; Integer)
        {
            Caption = 'Processing Time (ms)';
            DataClassification = ToBeClassified;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Warehouse Code", "Analysis DateTime")
        {
        }
        key(Key3; "Analysis DateTime")
        {
        }
        key(Key4; "Alert Level")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Created By" = '' then
            "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
    end;

    procedure GetRecommendations(): Text
    var
        InStr: InStream;
        Result: Text;
    begin
        CalcFields(Recommendations);
        if Recommendations.HasValue() then begin
            Recommendations.CreateInStream(InStr);
            InStr.Read(Result);
        end;
        exit(Result);
    end;

    procedure SetRecommendations(NewRecommendations: Text)
    var
        OutStr: OutStream;
    begin
        Clear(Recommendations);
        Recommendations.CreateOutStream(OutStr);
        OutStr.Write(NewRecommendations);
        Modify();
    end;
}
