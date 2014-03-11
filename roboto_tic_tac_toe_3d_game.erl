-module(roboto_tic_tac_toe_3d_game).
-export([start/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-compile(export_all).
-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop()  -> gen_server:call(?MODULE, stop).

connect() -> gen_server:call({?MODULE, roboto@marvin}, connect).
move(BoardX, BoardY, X, Y) -> gen_server:call({?MODULE, roboto@marvin}, {move, BoardX, BoardY, X, Y}).

init([]) -> {ok, {tic_tac_toe_3d, {players, 0, empty, empty},
                                  {board, roboto_tic_tac_toe_3d:create()}}}.

handle_call(connect, From, Game) ->
  Game2 = add_player(Game, From),
  {tic_tac_toe_3d, {players, N, Player1, _}, {board, Board}} = Game2,
  case N of
    1 -> true;
    2 -> {Pid, _} = Player1,
         gen_server:cast(Pid, {your_turn, {board, Board}})
  end,
  {reply, {ok, {player_symbol, player_symbol(N)}}, Game2};

handle_call({move, BoardX, BoardY, X, Y}, From, Game) ->
  {tic_tac_toe_3d, Players, {board, Board}} = Game,
  case roboto_tic_tac_toe_3d:get(Board, BoardY, BoardX, Y, X) of
    empty ->
      Board2 = roboto_tic_tac_toe_3d:set(Board, BoardY, BoardX, Y, X, cross),
      Game2 = {tic_tac_toe_3d, Players, {board, Board2}},
      case roboto_tic_tac_toe_3d:check_end(Board2) of
        true -> end_game(Game);
        false ->
          {players, _, {Pid, _}, _} = Players,
          gen_server:cast(Pid, {your_turn, {board, Board2}})
      end,
      {reply, ok, Game2};
    cross -> {reply, {error, there_is_a_cross_in_this_place}, Game};
    nought -> {reply, {error, there_is_a_nought_in_this_place}, Game}
  end.

end_game({tic_tac_toe_3d, {players, _N, {Player1, _}, {Player2, _}}, {board, Board}}) ->
  gen_server:cast(Player1, {end_of_game, {winner, cross}, {board, Board}}),
  gen_server:cast(Player2, {end_of_game, {winner, cross}, {board, Board}}).

handle_cast(_Msg, State)            -> {noreply, State}.
handle_info(_Info, State)           -> {noreply, State}.
terminate(_Reason, _State)          -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

add_player({tic_tac_toe_3d, {players, 0, _, _}, Board}, Player1) ->
  {tic_tac_toe_3d, {players, 1, Player1, empty}, Board};
add_player({tic_tac_toe_3d, {players, 1, Player1, _}, Board}, Player2) ->
  {tic_tac_toe_3d, {players, 2, Player1, Player2}, Board}.

player_symbol(1) -> cross;
player_symbol(2) -> nought.