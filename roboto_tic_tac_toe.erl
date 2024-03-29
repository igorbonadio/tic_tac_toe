-module(roboto_tic_tac_toe).
-export([create/0, set/4, get/3, check_winner/2, check_end/1, check_full/1, display/1]).

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

check_winner({tic_tac_toe_board, {tic_tac_toe_row, A, B, C},
                                 {tic_tac_toe_row, _, _, _},
                                 {tic_tac_toe_row, _, _, _}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, _, _, _},
                                 {tic_tac_toe_row, A, B, C},
                                 {tic_tac_toe_row, _, _, _}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, _, _, _},
                                 {tic_tac_toe_row, _, _, _},
                                 {tic_tac_toe_row, A, B, C}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, A, _, _},
                                 {tic_tac_toe_row, B, _, _},
                                 {tic_tac_toe_row, C, _, _}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, _, A, _},
                                 {tic_tac_toe_row, _, B, _},
                                 {tic_tac_toe_row, _, C, _}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, _, _, A},
                                 {tic_tac_toe_row, _, _, B},
                                 {tic_tac_toe_row, _, _, C}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, A, _, _},
                                 {tic_tac_toe_row, _, B, _},
                                 {tic_tac_toe_row, _, _, C}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner({tic_tac_toe_board, {tic_tac_toe_row, _, _, A},
                                 {tic_tac_toe_row, _, B, _},
                                 {tic_tac_toe_row, C, _, _}}, Piece)
  when (A == B) and (B == C) and (C == Piece) -> true;

check_winner(_, _) -> false.

check_full({tic_tac_toe_board, {tic_tac_toe_row, A, B, C},
                              {tic_tac_toe_row, D, E, F},
                              {tic_tac_toe_row, G, H, I}})
  when (A =/= empty) and (B =/= empty) and (C =/= empty) and
       (D =/= empty) and (E =/= empty) and (F =/= empty) and
       (G =/= empty) and (H =/= empty) and (I =/= empty) -> true;
check_full(_Board) -> false.

check_end(Board) -> check_winner(Board, cross) or check_winner(Board, nought) or check_full(Board).

display({tic_tac_toe_board, {tic_tac_toe_row, A, B, C},
                            {tic_tac_toe_row, D, E, F},
                            {tic_tac_toe_row, G, H, I}}) ->
  io:fwrite(" ~s | ~s | ~s \n", [symbol(A), symbol(B), symbol(C)]),
  io:fwrite("---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s \n", [symbol(D), symbol(E), symbol(F)]),
  io:fwrite("---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s \n", [symbol(G), symbol(H), symbol(I)]).

symbol(empty)  -> " ";
symbol(cross)  -> "x";
symbol(nought) -> "o".
