{   Copyright 2009 - Magno Machado Paulo (magnomp@gmail.com)

    This file is part of Emballo.

    Emballo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Emballo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>. }

unit EBInjectable;

interface

type
  { Base class for implementing interfaces that can be injected.
    You are not required to use this class, but if you does, it'd be easier to
    register it }
  TInjectable = class(TInterfacedObject)
  public
    constructor Create; virtual;
  end;
  TInjectableClass = class of TInjectable;

implementation

{ TInjectable }

constructor TInjectable.Create;
begin
end;

end.