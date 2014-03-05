-module(roboto_tic_tac_toe_3d).
-export([create/0, set/6, get/5, check_end/1, score/2]).

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

get({tic_tac_toe_3d_board, Row0, _, _}, 0, ColumnNumber, InnerRowNumber, InnerColumnNumber) ->
  get_row(Row0, ColumnNumber, InnerRowNumber, InnerColumnNumber);
get({tic_tac_toe_3d_board, _, Row1, _}, 1, ColumnNumber, InnerRowNumber, InnerColumnNumber) ->
  get_row(Row1, ColumnNumber, InnerRowNumber, InnerColumnNumber);
get({tic_tac_toe_3d_board, _, _, Row2}, 2, ColumnNumber, InnerRowNumber, InnerColumnNumber) ->
  get_row(Row2, ColumnNumber, InnerRowNumber, InnerColumnNumber).

get_row({tic_tac_toe_3d_row, Column0, _, _}, 0, InnerRowNumber, InnerColumnNumber) ->
  roboto_tic_tac_toe:get(Column0, InnerRowNumber, InnerColumnNumber);
get_row({tic_tac_toe_3d_row, _, Column1, _}, 1, InnerRowNumber, InnerColumnNumber) ->
  roboto_tic_tac_toe:get(Column1, InnerRowNumber, InnerColumnNumber);
get_row({tic_tac_toe_3d_row, _, _, Column2}, 2, InnerRowNumber, InnerColumnNumber) ->
  roboto_tic_tac_toe:get(Column2, InnerRowNumber, InnerColumnNumber).

check_end({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, A, B, C},
                                 {tic_tac_toe_3d_row, D, E, F},
                                 {tic_tac_toe_3d_row, G, H, I}}) ->
  roboto_tic_tac_toe:check_end(A) and roboto_tic_tac_toe:check_end(B) and
  roboto_tic_tac_toe:check_end(C) and roboto_tic_tac_toe:check_end(D) and
  roboto_tic_tac_toe:check_end(E) and roboto_tic_tac_toe:check_end(F) and
  roboto_tic_tac_toe:check_end(G) and roboto_tic_tac_toe:check_end(H) and
  roboto_tic_tac_toe:check_end(I).

score({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, A, B, C},
                             {tic_tac_toe_3d_row, D, E, F},
                             {tic_tac_toe_3d_row, G, H, I}}, Piece) ->
  score_aux([A, B, C, D, E, F, G, H, I], Piece, 0).

score_aux([], _, Score) -> Score;
score_aux([Board| BoardList], Piece, Score) ->
  case roboto_tic_tac_toe:check_winner(Board, Piece) of
    true  -> score_aux(BoardList, Piece, Score + 1);
    false -> score_aux(BoardList, Piece, Score)
  end.
