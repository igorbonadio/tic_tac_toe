-module(roboto_tic_tac_toe_3d_client).
-export([start/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-compile(export_all).
-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop()  -> gen_server:call(?MODULE, stop).

connect() -> gen_server:call(?MODULE, connect).
move(BoardX, BoardY, X, Y) -> gen_server:call(?MODULE, {move, BoardX, BoardY, X, Y}).

init([]) -> {ok, []}.

handle_call(connect, _From, State) ->
  roboto_tic_tac_toe_3d_game:connect(),
  {reply, ok, State};

handle_call({move, BoardX, BoardY, X, Y}, _From, State) ->
  {reply, roboto_tic_tac_toe_3d_game:move(BoardX, BoardY, X, Y), State}.

handle_cast({your_turn, {last_moviment, none}, {board, Board}}, State) ->
  roboto_tic_tac_toe_3d:display(Board),
  io:fwrite("You can choose where to put your piece!\n"),
  {noreply, State};

handle_cast({your_turn, {last_moviment, X, Y}, {board, Board}}, State) ->
  roboto_tic_tac_toe_3d:display(Board),
  io:fwrite("Current Board: ~w, ~w\n", [X, Y]),
  {noreply, State};

handle_cast({end_of_game, {winner, _Winner}, {board, Board}}, State) ->
  roboto_tic_tac_toe_3d:display(Board),
  {noreply, State}.

handle_info(_Info, State)           -> {noreply, State}.
terminate(_Reason, _State)          -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.