unit TelegAPI.Utils.Json;

interface

uses
  DJSON.Params;

type
  TJsonUtils = class
    class function ArrayToJString<T>(LArray: TArray<T>): string;
    class function DJsonConfig(const AByProperty: Boolean = False): IdjParams;
  end;

implementation

uses
  DJSON,
  TelegAPI.Utils.Converters,
  TelegAPI.Types.Enums,
  System.Rtti;
{ TJsonUtils }

class function TJsonUtils.ArrayToJString<T>(LArray: TArray<T>): string;
var
  I: Integer;
begin
  Result := '[';
  for I := Low(LArray) to High(LArray) do
  begin
    Result := Result + dj.From(TValue.From<T>(LArray[I]), dj.Default).ToJson;
    if I <> High(LArray) then
      Result := Result + ',';
  end;
  Result := Result + ']';
end;

class function TJsonUtils.DJsonConfig(const AByProperty: Boolean): IdjParams;
begin
  if AByProperty then
    Result := dj.DefaultByProperty
  else
    Result := dj.DefaultByFields;
  Result.Engine := TdjEngine.eJDO;
  Result.DateTimeFormat := TdjDateTimeFormat.dfUnix;

  Result.EnableCustomSerializers := True;
  Result.Serializers.Register<TtgChatType>(TConverterEnums<TtgChatType>);
  Result.Serializers.Register<TtgMessageEntityType>(TConverterEnums<TtgMessageEntityType>);
  Result.Serializers.Register<TtgMaskPositionPoint>(TConverterEnums<TtgMaskPositionPoint>);
  Result.Serializers.Register<TDateTime>(TConverterDate);
end;

end.

