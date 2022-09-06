unit Orion.Converters;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.JSON,
  System.JSON.Serializers,
  Rest.JSON, Orion.Converters.interfaces;

type
  TConverter = class(TInterfacedObject, iConverters)
  private
    FJsonConverter : iJsonConverter;
    FBase64Converter : iBase64Converter;
  public
    constructor Create;
    class function New : iConverters;

    function Json : iJsonConverter;
    function Base64 : iBase64Converter;
  end;

implementation

uses
  Orion.Converters.Json.Factory,
  Orion.Converters.Base64.Factory;

{ TConverter }

function TConverter.Base64: iBase64Converter;
begin
  Result := FBase64Converter;
end;

constructor TConverter.Create;
begin
  FJsonConverter := TjsonConverterFactory.New.JsonConverter;
  FBase64Converter := TBase64ConverterFactory.New.Base64Converter;
end;

function TConverter.Json: iJsonConverter;
begin
  Result := FJsonConverter;
end;

class function TConverter.New: iConverters;
begin
  Result := Self.Create;
end;

end.
