class Fitbit::Graphite::BaseProcessor

  TOKENS_FILE = '.tokens.json'
  SERVER="217.69.254.96"
  PORT="2003"

  def initialize(opts = {})
    unless opts.nil?

      @client = Fitgem::Client.new({
        consumer_key: opts[:consumer_key], 
        consumer_secret: opts[:consumer_secret],
        unit_system: opts[:unit_system]
      })

      if authenticated?
        reauthenticate!
      else
        authenticate!
      end

      @socket = TCPSocket.open(opts[:graphite_host], opts[:graphite_port])

    else
      puts "Options not set. Aborting..."
    end
  end

  private
  def authenticate!
    request_token = @client.request_token
    puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{request_token.token} and then enter the verifier code below and hit Enter"
    verifier = gets.chomp
    access_token = @client.authorize(request_token.token, request_token.secret, { oauth_verifier: verifier })
    write_token({ access_token: { token: access_token.token, secret: access_token.secret }})
  end
 
  def reauthenticate!
    access_token = read_token['access_token'] || {} 
    if access_token.nil?
      authenticate!
    else 
      @client.reconnect(access_token['token'], access_token['secret'])
    end
  end

  def authenticated?
    access_token = read_token['access_token'] || {}
    access_token.length > 1 || !access_token['token'].nil? && !access_token['secret'].nil?
  end

  private
  def read_token
    token = {}
    if File.exists?(TOKENS_FILE)
      token = JSON.parse(File.read(TOKENS_FILE))
    end
    token
  end

  def write_token(tokens)
    File.write(TOKENS_FILE, JSON.generate(tokens))
  end

end
