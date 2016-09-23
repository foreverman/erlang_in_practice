-module(chat_client).
-compile(export_all).


send_message(ClientName, MessageBody) ->
  message_router:send_chat_message(ClientName, MessageBody).

register_nickname(Nickname) ->
  Pid = spawn(chat_client, handle_messages, [Nickname]),
  message_router:register_nick(Nickname, Pid).

handle_messages(Nickname) ->
  receive
    {printmsg, MessageBody} ->
      io:format("~p received: ~p ~n", [Nickname, MessageBody]),
      handle_messages(Nickname);
    stop ->
      ok
  end.

unregister_nickname(Nickname) ->
  message_router:unregister_nick(Nickname).
start_router() ->
  message_router:start().
