unit Orion.Converters.Json.Factory;

interface

uses
  Orion.Converters.interfaces;

type
  TJsonConverterFactory = class(TInterfacedObject, iJsonConverterFactory)
  private

  public
    class function New : iJsonConverterFactory;

    function JsonConverter : iJsonConverter;
  end;

implementation

uses
  Orion.Converters.Json.Nativo;

{ TJsonConverterFactory }

function TJsonConverterFactory.JsonConverter: iJsonConverter;
begin
  Result := TJsonConverterNativo.New;
end;

class function TJsonConverterFactory.New: iJsonConverterFactory;
begin
  Result := Self.Create;
end;

end.
