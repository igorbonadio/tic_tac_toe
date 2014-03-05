-module(roboto_tic_tac_toe).
-export([create/0, set/4, get/3]).

create() ->
  {tic_tac_toe_board, {tic_tac_toe_row, empty, empty, empty},
                      {tic_tac_toe_row, empty, empty, empty},
                      {tic_tac_toe_row, empty, empty, empty}}.

set({tic_tac_toe_board, Row0, Row1, Row2}, 0, ColumnNumber, Piece) ->
  {tic_tac_toe_board, set_row(Row0, ColumnNumber, Piece), Row1, Row2};
set({tic_tac_toe_board, Row0, Row1, Row2}, 1, ColumnNumber, Piece) ->
  {tic_tac_toe_board, Row0, set_row(Row1, ColumnNumber, Piece), Row2};
set({tic_tac_toe_board, Row0, Row1, Row2}, 2, ColumnNumber, Piece) ->
  {tic_tac_toe_board, Row0, Row1, set_row(Row2, ColumnNumber, Piece)}.

set_row({tic_tac_toe_row, _, Column1, Column2}, 0, Piece) ->
  {tic_tac_toe_row, Piece, Column1, Column2};
set_row({tic_tac_toe_row, Column0, _, Column2}, 1, Piece) ->
  {tic_tac_toe_row, Column0, Piece, Column2};
set_row({tic_tac_toe_row, Column0, Column1, _}, 2, Piece) ->
  {tic_tac_toe_row, Column0, Column1, Piece}.

get({tic_tac_toe_board, Row0, _, _}, 0, ColumnNumber) ->
  get_row(Row0, ColumnNumber);
get({tic_tac_toe_board, _, Row1, _}, 1, ColumnNumber) ->
  get_row(Row1, ColumnNumber);
get({tic_tac_toe_board, _, _, Row2}, 2, ColumnNumber) ->
  get_row(Row2, ColumnNumber).

get_row({tic_tac_toe_row, Column0, _, _}, 0) ->
  Column0;
get_row({tic_tac_toe_row, _, Column1, _}, 1) ->
  Column1;
get_row({tic_tac_toe_row, _, _, Column2}, 2) ->
  Column2.