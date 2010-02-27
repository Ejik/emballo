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

unit EBDynamicFactory;

interface

uses
  EBFactory, EBFieldEnumerator;

type
  { This is a factory that dynamically instantiate your class, given its class
    type and the address of a constructor. The constructor must take NO
    arguments and  the class must support the specified guid }
  TDynamicFactory = class(TInterfacedObject, IFactory)
  private
    FGUID: TGUID;
    FClassType: TClass;
    FConstructorAddress: Pointer;
    function GetInstance: IInterface;
    function GetGUID: TGUID;
  public
    constructor Create(GUID: TGUID; ClassType: TClass; ConstructorAddress: Pointer);
  end;

implementation

uses
  SysUtils, EBInvalidTypeException;

{ TDynamicFactory }

constructor TDynamicFactory.Create(GUID: TGUID; ClassType: TClass; ConstructorAddress: Pointer);
begin
  if not Supports(ClassType, Guid) then
    raise EInvalidType.Create('Class ' + ClassType.ClassName + ' doesn''t supports ' + GUIDToString(Guid));

  FGuid := Guid;
  FClassType := ClassType;
  FConstructorAddress := ConstructorAddress;
end;

function TDynamicFactory.GetGUID: TGUID;
begin
  Result := FGUID;
end;

function TDynamicFactory.GetInstance: IInterface;
var
  Info: Pointer;
  Addr: Pointer;
  O: TObject;
begin
  Info := Pointer(FClassType);
  Addr := FConstructorAddress;
  asm
    mov eax, Info
    mov dl, $01
    call Addr
    mov O, eax
  end;
  Supports(O, IInterface, Result);
end;

end.
