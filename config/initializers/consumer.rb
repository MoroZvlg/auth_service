channel = RabbitMq.consumer_channel
queue = channel.queue("auth", durable: true)
exchange = channel.default_exchange

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON.parse(payload)

  decoded_result = JwtEncoder.decode(payload["token"])
  service = Auth::FetchUserService.call(decoded_result["uuid"])

  exchange.publish(
      service.user[:id].to_s,
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
  )

end
