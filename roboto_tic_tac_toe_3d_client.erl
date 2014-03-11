-module(roboto_tic_tac_toe_3d_client).
-export([start/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-compile(export_all).
-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop()  -> gen_server:call(?MODULE, stop).

connect() -> gen_server:call(?MODULE, connect).

init([]) -> {ok, []}.

handle_call(connect, _From, State) ->
  roboto_tic_tac_toe_3d_game:connect(),
  {reply, ok, State}.

handle_cast({your_turn, {board, Board}}, State) ->
  roboto_tic_tac_toe_3d:display(Board),
  {noreply, State}.

handle_info(_Info, State)           -> {noreply, State}.
terminate(_Reason, _State)          -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.