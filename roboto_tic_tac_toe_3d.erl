-module(roboto_tic_tac_toe_3d).
-export([create/0, set/6]).

create() -> {tic_tac_toe_3d_board, {tic_tac_toe_3d_row, roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create()},
                                   {tic_tac_toe_3d_row, roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create()},
                                   {tic_tac_toe_3d_row, roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create(), roboto_tic_tac_toe:create()}}.

set({tic_tac_toe_3d_board, Row0, Row1, Row2}, 0, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_board, set_row(Row0, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece), Row1, Row2};
set({tic_tac_toe_3d_board, Row0, Row1, Row2}, 1, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_board, Row0, set_row(Row1, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece), Row2};
set({tic_tac_toe_3d_board, Row0, Row1, Row2}, 2, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_board, Row0, Row1, set_row(Row2, ColumnNumber, InnerRowNumber, InnerColumnNumber, Piece)}.

set_row({tic_tac_toe_3d_row, Column0, Column1, Column2}, 0, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_row, roboto_tic_tac_toe:set(Column0, InnerRowNumber, InnerColumnNumber, Piece), Column1, Column2};
set_row({tic_tac_toe_3d_row, Column0, Column1, Column2}, 1, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_row, Column0, roboto_tic_tac_toe:set(Column1, InnerRowNumber, InnerColumnNumber, Piece), Column2};
set_row({tic_tac_toe_3d_row, Column0, Column1, Column2}, 2, InnerRowNumber, InnerColumnNumber, Piece) ->
  {tic_tac_toe_3d_row, Column0, Column1, roboto_tic_tac_toe:set(Column2, InnerRowNumber, InnerColumnNumber, Piece)}.