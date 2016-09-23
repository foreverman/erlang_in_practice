-module(chat_client).
-compile(export_all).


send_message(ClientName, MessageBody) ->
  message_router:send_chat_message(ClientName, MessageBody).

print_message(Who, MessageBody) ->
  io:format("~p received: ~p~n", [Who, MessageBody]).

register_nickname(Nickname) ->
  message_router:register_nick(Nickname, fun(MessageBody) -> print_message(Nickname, MessageBody) end).

unregister_nickname(Nickname) ->
  message_router:unregister_nick(Nickname).
start_router() ->
  message_router:start().
