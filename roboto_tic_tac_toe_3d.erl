-module(roboto_tic_tac_toe_3d).
-export([create/0, set/6, get/5, check_end/1, score/2, display/1, get_board/3]).

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

get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, Board, _, _},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _}}, 0, 0) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, Board, _},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _}}, 0, 1) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, Board},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _}}, 0, 2) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, Board, _, _},
                                 {tic_tac_toe_3d_row, _, _, _}}, 1, 0) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, Board, _},
                                 {tic_tac_toe_3d_row, _, _, _}}, 1, 1) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, Board},
                                 {tic_tac_toe_3d_row, _, _, _}}, 1, 2) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, Board, _, _}}, 2, 0) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, Board, _}}, 2, 1) -> Board;
get_board({tic_tac_toe_3d_board, {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, _},
                                 {tic_tac_toe_3d_row, _, _, Board}}, 2, 2) -> Board.

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

display({tic_tac_toe_3d_board,
          {tic_tac_toe_3d_row,
            {tic_tac_toe_board, {tic_tac_toe_row, A1, A2, A3},
                                {tic_tac_toe_row, A4, A5, A6},
                                {tic_tac_toe_row, A7, A8, A9}},
            {tic_tac_toe_board, {tic_tac_toe_row, B1, B2, B3},
                                {tic_tac_toe_row, B4, B5, B6},
                                {tic_tac_toe_row, B7, B8, B9}},
            {tic_tac_toe_board, {tic_tac_toe_row, C1, C2, C3},
                                {tic_tac_toe_row, C4, C5, C6},
                                {tic_tac_toe_row, C7, C8, C9}}},
          {tic_tac_toe_3d_row,
            {tic_tac_toe_board, {tic_tac_toe_row, D1, D2, D3},
                                {tic_tac_toe_row, D4, D5, D6},
                                {tic_tac_toe_row, D7, D8, D9}},
            {tic_tac_toe_board, {tic_tac_toe_row, E1, E2, E3},
                                {tic_tac_toe_row, E4, E5, E6},
                                {tic_tac_toe_row, E7, E8, E9}},
            {tic_tac_toe_board, {tic_tac_toe_row, F1, F2, F3},
                                {tic_tac_toe_row, F4, F5, F6},
                                {tic_tac_toe_row, F7, F8, F9}}},
          {tic_tac_toe_3d_row,
            {tic_tac_toe_board, {tic_tac_toe_row, G1, G2, G3},
                                {tic_tac_toe_row, G4, G5, G6},
                                {tic_tac_toe_row, G7, G8, G9}},
            {tic_tac_toe_board, {tic_tac_toe_row, H1, H2, H3},
                                {tic_tac_toe_row, H4, H5, H6},
                                {tic_tac_toe_row, H7, H8, H9}},
            {tic_tac_toe_board, {tic_tac_toe_row, I1, I2, I3},
                                {tic_tac_toe_row, I4, I5, I6},
                                {tic_tac_toe_row, I7, I8, I9}}}}) ->
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(A1), symbol(A2), symbol(A3), symbol(B1), symbol(B2), symbol(B3), symbol(C1), symbol(C2), symbol(C3)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(A4), symbol(A5), symbol(A6), symbol(B4), symbol(B5), symbol(B6), symbol(C4), symbol(C5), symbol(C6)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(A7), symbol(A8), symbol(A9), symbol(B7), symbol(B8), symbol(B9), symbol(C7), symbol(C8), symbol(C9)]),
  io:fwrite("============++=============++============\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(D1), symbol(D2), symbol(D3), symbol(E1), symbol(E2), symbol(E3), symbol(F1), symbol(F2), symbol(F3)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(D4), symbol(D5), symbol(D6), symbol(E4), symbol(E5), symbol(E6), symbol(F4), symbol(F5), symbol(F6)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(D7), symbol(D8), symbol(D9), symbol(E7), symbol(E8), symbol(E9), symbol(F7), symbol(F8), symbol(F9)]),
  io:fwrite("============++=============++============\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(G1), symbol(G2), symbol(G3), symbol(H1), symbol(H2), symbol(H3), symbol(I1), symbol(I2), symbol(I3)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(G4), symbol(G5), symbol(G6), symbol(H4), symbol(H5), symbol(H6), symbol(I4), symbol(I5), symbol(I6)]),
  io:fwrite("---+---+--- || ---+---+--- || ---+---+---\n"),
  io:fwrite(" ~s | ~s | ~s  ||  ~s | ~s | ~s  ||  ~s | ~s | ~s \n", [symbol(G7), symbol(G8), symbol(G9), symbol(H7), symbol(H8), symbol(H9), symbol(I7), symbol(I8), symbol(I9)]).

symbol(empty)  -> " ";
symbol(cross)  -> "x";
symbol(nought) -> "o".