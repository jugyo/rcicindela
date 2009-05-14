require 'open-uri'

class RCicindela
  VERSION = '0.1.1'

  attr_reader :base_uri, :default_options

  def initialize(base_uri, default_options = {})
    @base_uri = base_uri.sub(/\/*$/, '')
    @default_options = default_options
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
      get(prefix, {:op => method}.merge(params))
    end
  end

  private

  def get(prefix, params)
    params = default_options.merge(params)
    url = base_uri + '/' + prefix + '?' + params.map{ |k, v| [k.to_s, v.to_s] }.sort.map{ |i| i.join('=') }.join('&')
    open(url).read
  end
end
