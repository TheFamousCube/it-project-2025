unit Wire_u;

interface

uses Vcl.Graphics, Math, Generics.Collections, Winapi.Windows;

type
  TConnector = record
    id, gateId, cableId, x, y : Integer;
    isInput : Boolean;
    constructor Create(id, gateId, cableId, x, y : Integer; isInput : Boolean);
end;

type
  TSplit = record
    id, inCableId, x, y : Integer;
    outCableId : TList<Integer>;
    constructor Create(id, inCableId : Integer; outCableId : TList<Integer>; x, y : Integer);
end;

type
  PCable = ^TCable;

  TCable = record
    id, startId, endId : Integer;
    isStartConnector, isEndConnector : Boolean; // otherwise its a split
    parentCable : PCable;
    childCables : TList<PCable>;
    path : TList<TPoint>;

    constructor Create(id : Integer; parentCable : PCable; childCables : TList<PCable>; startId : Integer; isStartConnector : Boolean; endId : Integer; isEndConnector : Boolean; path : TList<TPoint>);
end;

type
  TWire = record
    id, inputConnectorId : Integer;
    cables : TList<TCable>;
    outputConnectorIds : TList<Integer>;

    constructor Create(id : Integer);
    procedure addCable(cable : TCable);
end;

implementation

constructor TConnector.Create(id, gateId, cableId, x, y : Integer; isInput : Boolean);
begin
  Self.id := id;
  Self.gateId := gateId;
  self.cableId := cableId;
  Self.x := x;
  Self.y := y;
  Self.isInput := isInput;
end;

constructor TSplit.Create(id, inCableId : Integer; outCableId : TList<Integer>; x, y : Integer);
begin
  Self.id := id;
  Self.inCableId := inCableId;
  Self.outCableId := outCableId;
  Self.x := x;
  Self.y := y;
end;

constructor TCable.Create(id : Integer; parentCable : PCable; childCables : TList<PCable>; startId : Integer; isStartConnector : Boolean; endId : Integer; isEndConnector : Boolean; path : TList<TPoint>);
begin
  Self.id := id;
  Self.startId := startId;
  Self.isStartConnector := isStartConnector;
  Self.endId := endId;
  Self.isEndConnector := isEndConnector;
  Self.parentCable := parentCable;
  Self.childCables := childCables;
  Self.path := path;
  //cables.Add(TLine.Create(x, y, IfThen(dir = 0, x, IfThen(dir = 1, x + dir, IfThen(dir = 2, x, x - dir))), IfThen(dir = 0, y - dir, IfThen(dir = 1, y, IfThen(dir = 2, y + dir, y))), clWhite));
end;

constructor TWire.Create(id : Integer);
begin
  Self.id := id;
end;

procedure TWire.addCable(cable : TCable);
begin
  Self.cables.Add(cable);
  if cable.isEndConnector then
    Self.outputConnectorIds.Add(cable.endId);
end;

end.
