require 'net/http'

class RCicindela
  class APIError < StandardError
    attr_reader :response
    def initialize(response, message = '')
      super(message)
      @response = response
    end
  end

  class TimeoutError < StandardError
    attr_reader :error
    def initialize(error, message = '')
      @error = error
    end
  end

  attr_reader :host, :port, :base_path, :timeout, :default_params

  def initialize(host, options = {})
    @host = host
    @port = options[:port] || 80
    @base_path = options[:base_path] || '/'
    @timeout = options[:timeout] || 1
    @default_params = options[:default_params] || {}

    @base_path.sub!(/\/+$/, '')
  end

  %w(
    record/insert_pick
    record/insert_rating
    record/insert_tag
    record/set_category
    record/insert_uninterested
    record/delete_pick
    record/delete_rating
    record/delete_tag
    record/delete_uninterested
    record/remove_category
    recommend/for_item
    recommend/for_user
    recommend/similar_users
  ).each do |api_method|
    prefix, method = api_method.split('/')
    define_method(method) do |params|
      request(prefix, {:op => method}.merge(params))
    end
  end

  private

  def request(prefix, params)
    params = default_params.merge(params)
    path = base_path + '/' + prefix + '?' + params.map{ |k, v| [k.to_s, v.to_s] }.sort.map{ |i| i.join('=') }.join('&')
    get(path)
  end

  def get(path)
    http = Net::HTTP.new(host, port)
    http.open_timeout = timeout
    http.read_timeout = timeout
    http.start do |http|
      response = http.get(path)
      if response.code =~ /^2/
        response.body
      else
        raise APIError.new(response)
      end
    end
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  end
end
