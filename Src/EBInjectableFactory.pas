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

unit EBInjectableFactory;

interface

uses
  EBInjectable, EBFactory, Classes, EBFieldEnumerator;

type
  { A factory that can instantiate objects from TInjectable }
  TInjectableFactory = class(TInterfacedObject, IFactory)
  private
    FGUID: TGUID;
    FInjectable: TInjectableClass;
    function GetGUID: TGUID;
    function GetInstance: IInterface;
  public
    constructor Create(GUID: TGUID; Injectable: TInjectableClass);
  end;

implementation

uses
  SysUtils, EBInvalidTypeException;

{ TInjectableFactory }

constructor TInjectableFactory.Create(Guid: TGUID;
  Injectable: TInjectableClass);
begin
  if not Supports(Injectable, Guid) then
    raise EInvalidType.Create('TInjectableFactory can only be created with compatible injectable class and guid');

  FGuid := Guid;
  FInjectable := Injectable;
end;

function TInjectableFactory.GetGUID: TGUID;
begin
  Result := FGUID;
end;

function TInjectableFactory.GetInstance: IInterface;
begin
  Result := FInjectable.Create as IInterface
end;

end.
