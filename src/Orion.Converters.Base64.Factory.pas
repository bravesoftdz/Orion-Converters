unit Orion.Converters.Base64.Factory;

interface

uses
  Orion.Converters.interfaces;

type
  TBase64ConverterFactory = class(TInterfacedObject, iBase64ConverterFactory)

    class function New : iBase64ConverterFactory;
    function Base64Converter : iBase64Converter;
  end;

implementation

uses
  Orion.Converters.Base64;

{ TBase64ConverterFactory }

function TBase64ConverterFactory.Base64Converter: iBase64Converter;
begin
  Result := TBase64Converter.New;
end;

class function TBase64ConverterFactory.New: iBase64ConverterFactory;
begin
  Result := Self.Create;
end;

end.
