require File.expand_path('../helper', __FILE__)

class KandanTest < Service::TestCase
  def setup
    @stubs = Faraday::Adapter::Test::Stubs.new
    @token = 't0ken'
  end

  def test_push
    @stubs.post "/endpoints/github/push" do |env|
      assert_equal 't0ken', env[:params]['auth_token']
      assert_equal 'Lobby', env[:request_headers]['X-Kandan-Room']
      [200, {}, '']
    end

    svc = service({'token' => @token, 'url' => 'http://example.com/endpoints/github', 'room' => 'Lobby'}, push_payload)
    svc.receive_event
  end

  def service(*args)
    super Service::Kandan, *args
  end
end
