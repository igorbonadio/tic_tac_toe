-module(roboto_tic_tac_toe_3d_game).
-export([start/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-compile(export_all).
-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop()  -> gen_server:call(?MODULE, stop).

connect() -> gen_server:call({?MODULE, roboto@marvin}, connect).
move(BoardX, BoardY, X, Y) -> gen_server:call({?MODULE, roboto@marvin}, {move, BoardX, BoardY, X, Y}).

init([]) -> {ok, {tic_tac_toe_3d, {players, 0, empty, empty},
                                  {current_player, 1},
                                  {last_moviment, none},
                                  {board, roboto_tic_tac_toe_3d:create()}}}.

handle_call(connect, From, Game) ->
  Game2 = add_player(Game, From),
  {tic_tac_toe_3d, {players, N, _, _}, _, _, _} = Game2,
  case N of
    1 -> true;
    2 -> next_player(Game)
  end,
  {reply, {ok, {player_symbol, player_symbol(N)}}, Game2};

handle_call({move, BoardX, BoardY, X, Y}, _From, Game) ->
  {tic_tac_toe_3d, _, _, LastMoviment, _} = Game,
  case LastMoviment of
    {last_moviment, none} -> do_move(Game, BoardX, BoardY, X, Y);
    {last_moviment, LastX, LastY} -> if
      (LastX == BoardX) and (LastY == BoardY) -> do_move(Game, BoardX, BoardY, X, Y);
      true -> {reply, {error, wrong_place}, Game}
    end
  end.

handle_cast(_Msg, State)            -> {noreply, State}.
handle_info(_Info, State)           -> {noreply, State}.
terminate(_Reason, _State)          -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

add_player({tic_tac_toe_3d, {players, 0, _, _}, _, _, Board}, Player1) ->
  {tic_tac_toe_3d, {players, 1, Player1, empty}, {current_player, 1}, {last_moviment, none}, Board};
add_player({tic_tac_toe_3d, {players, 1, Player1, _}, _, _, Board}, Player2) ->
  {tic_tac_toe_3d, {players, 2, Player1, Player2}, {current_player, 1}, {last_moviment, none}, Board}.

player_symbol(1) -> cross;
player_symbol(2) -> nought.

do_move(Game, BoardX, BoardY, X, Y) ->
  {tic_tac_toe_3d, _, _, _, {board, Board}} = Game,
  case roboto_tic_tac_toe_3d:get(Board, BoardX, BoardY, X, Y) of
    empty -> case roboto_tic_tac_toe:check_end(roboto_tic_tac_toe_3d:get_board(Board, BoardX, BoardY)) of
      true -> {reply, {error, wrong_place}, Game};
      false -> {reply, ok, do_move2(Game, BoardX, BoardY, X, Y)}
    end;
    cross -> {reply, {error, wrong_place}, Game};
    nought -> {reply, {error, wrong_place}, Game}
  end.

do_move2(Game, BoardX, BoardY, X, Y) ->
  {tic_tac_toe_3d, Players, {current_player, CurrentPlayer}, _, {board, Board}} = Game,
  Board2 = roboto_tic_tac_toe_3d:set(Board, BoardX, BoardY, X, Y, player_symbol(CurrentPlayer)),
  Game2 = {tic_tac_toe_3d, Players, {current_player, next_player_id(CurrentPlayer)}, last_moviment(Board2, {last_moviment, X, Y}), {board, Board2}},
  case roboto_tic_tac_toe_3d:check_end(Board2) of
    true -> end_game(Game2);
    false -> next_player(Game2)
  end,
  Game2.

next_player({tic_tac_toe_3d, {players, _, {Pid, _}, _}, {current_player, 1}, LastMoviment, {board, Board}}) ->
  gen_server:cast(Pid, {your_turn, LastMoviment, {board, Board}});

next_player({tic_tac_toe_3d, {players, _, _, {Pid, _}}, {current_player, 2}, LastMoviment, {board, Board}}) ->
  gen_server:cast(Pid, {your_turn, LastMoviment, {board, Board}}).

last_moviment(Board, {last_moviment, none}) -> {last_moviment, none};
last_moviment(Board, {last_moviment, X, Y}) ->
  case roboto_tic_tac_toe:check_end(roboto_tic_tac_toe_3d:get_board(Board, X, Y)) of
    true -> {last_moviment, none};
    false -> {last_moviment, X, Y}
  end.

next_player_id(1) -> 2;
next_player_id(2) -> 1.

end_game({tic_tac_toe_3d, {players, _N, {Player1, _}, {Player2, _}}, _, _, {board, Board}}) ->
  gen_server:cast(Player1, {end_of_game, {winner, cross}, {board, Board}}),
  gen_server:cast(Player2, {end_of_game, {winner, cross}, {board, Board}}).