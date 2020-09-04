module RabbitMq
  extend self

  @mutex = Mutex.new

  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new.start
    end
  end

  def consumer_channel
    Thread.current[:rabbitmq_consumer_channel] ||= connection.create_channel(nil, Settings.rabbit.pool_size)
  end
end
