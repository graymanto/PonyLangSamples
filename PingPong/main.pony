actor Main
  """ Entry point for the application """
  new create(env: Env) =>
    env.out.print("Starting ping pong!")

    let pong = Pong(env)
    let ping = Ping(env, pong)

    ping.receive()


actor Pong
  let _env: Env

  new create(env: Env) =>
    _env = env

  be receive(sender : Ping) =>
    _env.out.print("pong!")
    sender.receive()


actor Ping
  let _env: Env
  let _pong : Pong
  var _messageCount: U32 = 0

  new create(env: Env, pong : Pong) =>
    _env = env
    _pong = pong

  be receive() =>
    if _messageCount > 20 then
      _env.out.print("Finished pinging and ponging!")
      return
    end

    _messageCount = _messageCount + 1

    _env.out.print("ping!")
    _pong.receive(this)
