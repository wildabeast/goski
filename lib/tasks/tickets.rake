namespace :tickets do
  desc "fetches data from mthood api"
  task fetch: :environment do
    months = [
      "2022-12-01T08:00:00.000Z", 
      "2023-01-01T08:00:00.000Z",
      "2023-02-01T08:00:00.000Z",
      "2023-03-01T08:00:00.000Z",
      "2023-04-01T08:00:00.000Z",
    ]
    data = []
    url = URI("https://skihood.com/products/read")

    months.each do |month|
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump({
        "schedDate": month,
        "prodType": "a"
      })
      
      response = https.request(request)
      data += JSON.parse(response.read_body)
    end

    data.filter! { |item| item['ageRange'] == 'Adult' && item['accessType'] == 'a'}

    now = DateTime.now

    curDate = nil
    data.each do |item|
      price = item['title'].split(' ')[0].gsub('$', '').to_i
      start_datetime = item['start'].to_datetime.change(:offset => "-0800")
      end_datetime = item['end'].to_datetime.change(:offset => "-0800")

      if start_datetime.to_date != curDate
        curDate = start_datetime.to_date
        puts curDate
      end
      print "  [#{start_datetime.strftime("%H:%M")}]:[#{item['id']}] $#{price}"

      ticket = Ticket.find_or_initialize_by(start_datetime: start_datetime, end_datetime: end_datetime) do |t|
        t.description = item['description']
      end

      if ticket.new_record?
        puts ' created!'
      else
        puts ' found!'
      end

      ticket.price = price
    
      tp = TicketPrice.new(
        ticket: ticket,
        price: price,
        fetched_at: now
      )

      ticket.save
      tp.save
    end

    puts "got #{data.length} items"
  end
end
