-module(roboto_board).
-compile(export_all).

create() ->
  array:new([{size, 8}, {default, array:new([{size, 8}, {default, 0}])}]).

set(Board, Row, Column, Piece) ->
  array:set(Row, array:set(Column, Piece, array:get(Row, Board)), Board).

get(Board, Row, Column) ->
  array:get(Column, array:get(Row, Board)).