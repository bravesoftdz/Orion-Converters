unit Orion.Converters.interfaces;

interface

uses
  System.JSON,
  System.Classes,
  System.Generics.Collections,
  Data.DB
  {$IFDEF VCL}
    , VCL.Graphics
  {$ELSE}
    , FMX.Graphics,
    FMX.Objects
  {$ENDIF}
  ;

type
  iJsonConverter = interface
    procedure JsonObjectToObject(aJson : TJsonObject; aObject : TObject); overload;
    procedure JsonObjectToObject(aJson : string; aObject : TObject); overload;
    procedure ObjectToJsonObject(aObject : TObject; var aJson : TJsonObject);
    procedure JsonArrayToObjectList(aJson : TJSONArray; aObjectList : TObjectList<TObject>; aClassType : TClass); overload;
    procedure JsonArrayToObjectList(aJson : string; aObjectList : TObjectList<TObject>; aClassType : TClass); overload;
    procedure ObjectListToJsonArray(aObjectList : TObjectList<TObject>; var aJson : TJSONArray);
  end;

  iBase64Converter = interface
    function BlobToBase64(aField : TField) : string;
    function Base64ToBitmap(aValue : string) : TBitmap;
    function Base64ToStream(aValue : string) : TStream;
    function Base64ToImage(aValue : string; aOwner : TComponent = nil) : TImage;
  end;

  iJsonConverterFactory = interface
    function JsonConverter : iJsonConverter;
  end;

  iBase64ConverterFactory = interface
    function Base64Converter : iBase64Converter;
  end;

  iConverters = interface
    function Json : iJsonConverter;
    function Base64 : iBase64Converter;
  end;

implementation

end.
