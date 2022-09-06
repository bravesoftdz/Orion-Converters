unit Orion.Converters.Json.Nativo;

interface

uses
  Orion.Converters.interfaces,
  System.JSON,
  System.SysUtils,
  System.Generics.Collections,
  Rest.JSON;

type
  TJsonConverterNativo = class(TInterfacedObject, iJsonConverter)
  private

  public
    class function New : iJsonConverter;

    procedure JsonObjectToObject(aJson : TJsonObject; aObject : TObject); overload;
    procedure JsonObjectToObject(aJson : string; aObject : TObject); overload;
    procedure ObjectToJsonObject(aObject : TObject; var aJson : TJsonObject);
    procedure JsonArrayToObjectList(aJson : TJSONArray; aObjectList : TObjectList<TObject>; aClassType : TClass); overload;
    procedure JsonArrayToObjectList(aJson : string; aObjectList : TObjectList<TObject>; aClassType : TClass); overload;
    procedure ObjectListToJsonArray(aObjectList: TObjectList<TObject>; var aJson: TJSONArray);
  end;
implementation

{ TJsonConverterNativo }

procedure TJsonConverterNativo.JsonArrayToObjectList(aJson: TJSONArray; aObjectList: TObjectList<TObject>;
  aClassType: TClass);
var
  lJsonObject : TJSONValue;
  lObject : TObject;
begin
  if not Assigned(aJson) then
    Exit;

  if not Assigned(aObjectList) then
    Exit;

  for lJsonObject in aJson do begin
    lObject := aClassType.Create;
    TJson.JsonToObject(lObject, TJSONObject(lJsonObject));
    aObjectList.Add(lObject);
  end;
end;

procedure TJsonConverterNativo.JsonArrayToObjectList(aJson: string; aObjectList: TObjectList<TObject>;
  aClassType: TClass);
var
  lJsonObject : TJSONValue;
  lJsonArray : TJSONArray;
  lObject : TObject;
begin
  if aJson.Trim.IsEmpty then
    Exit;

  if not Assigned(aObjectList) then
    Exit;

  lJsonArray := TJSONArray.ParseJSONValue(aJson) as TJSONArray;
  try
    for lJsonObject in lJsonArray do begin
      lObject := aClassType.Create;
      TJson.JsonToObject(lObject, TJSONObject(lJsonObject));
      aObjectList.Add(lObject);
    end;
  finally
    lJsonArray.DisposeOf;
  end;

end;

procedure TJsonConverterNativo.JsonObjectToObject(aJson: TJsonObject; aObject: TObject);
begin
  if not Assigned(aJson) then
    Exit;

  if not Assigned(aObject) then
    Exit;

  TJson.JsonToObject(aObject, aJson);
end;

procedure TJsonConverterNativo.JsonObjectToObject(aJson: string; aObject: TObject);
var
  lJsonObject : TJSONValue;
begin
  if aJson.Trim.IsEmpty then
    Exit;

  if not Assigned(aObject) then
    Exit;

  lJsonObject := TJSONValue.ParseJSONValue(aJson);
  try
    TJson.JsonToObject(aObject, TJSONObject(lJsonObject));
  finally
    lJsonObject.DisposeOf;
  end;
end;

class function TJsonConverterNativo.New: iJsonConverter;
begin
  Result := Self.Create;
end;

procedure TJsonConverterNativo.ObjectListToJsonArray(aObjectList: TObjectList<TObject>; var aJson: TJSONArray);
var
  lObject: TObject;
  lJsonObject : TJSONObject;
begin
  if not Assigned(aObjectList) then
    Exit;

  if not Assigned(aJson) then
    aJson := TJSONArray.Create;

  for lObject in aObjectList do begin
    lJsonObject := TJson.ObjectToJsonObject(lObject);
    aJson.Add(lJsonObject);
  end;
end;

procedure TJsonConverterNativo.ObjectToJsonObject(aObject: TObject; var aJson: TJsonObject);
begin
  if not Assigned(aObject) then
    Exit;

  if Assigned(aJson) then
    aJson.DisposeOf;

  aJson := TJson.ObjectToJsonObject(aObject);
end;

end.
