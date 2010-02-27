{   Copyright 2009, 2010 - Magno Machado Paulo (magnomp@gmail.com)

    This file is part of Emballo.

    Emballo is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    Emballo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with Emballo.
    If not, see <http://www.gnu.org/licenses/>. }

unit EBDependencyInjection;

interface

type
  TEmballo = class
    function Get(GUID: TGUID): IInterface;
  end;

procedure InjectDependencies(Instance: TObject);
function Emballo: TEmballo;

implementation

uses
  EBFieldEnumerator, EBDIRegistry, SysUtils;

function Emballo: TEmballo;
begin
  Result := Nil;
end;

procedure InjectDependencies(Instance: TObject);
var
  Fields: TFieldsData;
  Dependency: IInterface;
  i: Integer;
begin
  Fields := EnumerateFields(Instance.ClassType);

  for i := 0 to High(Fields) do
  begin
    Dependency := GetDIRegistry.Instantiate(Fields[i].Guid);

    if Assigned(Dependency) then
      Fields[i].Inject(Instance, Dependency);
  end;
end;

{ TEmballo }

function TEmballo.Get(GUID: TGUID): IInterface;
begin
  Result := GetDIRegistry.Instantiate(GUID);
end;

end.
