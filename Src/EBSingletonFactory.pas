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

unit EBSingletonFactory;

interface

uses
  EBFactory;

type
  { A factory that works on top of another factory. At the time of the first
    call to GetInstance, it will use the base factory to get the result and will
    cache it. On later calls, it will always return the cached result }
  TSingletonFactory = class(TInterfacedObject, IFactory)
  private
    FActualFactory: IFactory;
    FInstance: IInterface;
    function GetGUID: TGUID;
    function GetInstance: IInterface;
  public
    constructor Create(const ActualFactory: IFactory);
  end;

implementation

{ TSingletonFactory }

constructor TSingletonFactory.Create(const ActualFactory: IFactory);
begin
  FActualFactory := ActualFactory;
end;

function TSingletonFactory.GetGUID: TGUID;
begin
  Result := FActualFactory.GUID;
end;

function TSingletonFactory.GetInstance: IInterface;
begin
  if not Assigned(FInstance) then
    FInstance := FActualFactory.GetInstance;

  Result := FInstance;
end;

end.
