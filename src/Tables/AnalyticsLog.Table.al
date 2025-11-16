table 50003 "RWMS Analytics Log"
{
    Caption = 'Analytics Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = CustomerContent;
            TableRelation = "RWMS Warehouse";
        }
        field(3; "Analysis DateTime"; DateTime)
        {
            Caption = 'Analysis DateTime';
            DataClassification = CustomerContent;
        }
        field(4; "Analysis Type"; Text[50])
        {
            Caption = 'Analysis Type';
            DataClassification = CustomerContent;
        }
        field(5; "Analysis Result"; Text[250])
        {
            Caption = 'Analysis Result';
            DataClassification = CustomerContent;
        }
        field(6; "AI Model Used"; Text[50])
        {
            Caption = 'AI Model Used';
            DataClassification = CustomerContent;
        }
        field(7; "Data Points Analyzed"; Integer)
        {
            Caption = 'Data Points Analyzed';
            DataClassification = CustomerContent;
        }
        field(8; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(9; "Recommendations"; Blob)
        {
            Caption = 'Recommendations';
            DataClassification = CustomerContent;
        }
        field(10; "Alert Level"; Enum "RWMS Alert Level")
        {
            Caption = 'Alert Level';
            DataClassification = CustomerContent;
        }
        field(11; "Action Taken"; Text[250])
        {
            Caption = 'Action Taken';
            DataClassification = CustomerContent;
        }
        field(12; "Processing Time (ms)"; Integer)
        {
            Caption = 'Processing Time (ms)';
            DataClassification = CustomerContent;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
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
