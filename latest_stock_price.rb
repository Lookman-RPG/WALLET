require 'net/http'
require 'json'

class LatestStockPrice
  API_BASE = 'https://latest-stock-price.p.rapidapi.com'

  def initialize(api_key)
    @api_key = api_key
  end

  def price(symbol)
    request("/price/#{symbol}")
  end

  def prices(symbols)
    request("/prices/#{symbols.join(',')}")
  end

  def price_all
    request('/price_all')
  end

  private

  def request(endpoint)
    uri = URI("#{API_BASE}#{endpoint}")
    req = Net::HTTP::Get.new(uri)
    req['X-RapidAPI-Key'] = @api_key

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    JSON.parse(res.body)
  rescue StandardError => e
    { error: e.message }
  end
end
