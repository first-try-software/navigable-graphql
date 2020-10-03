RSpec::Matchers.define :match_route do |verb, path, endpoint_class|
  match do |router|
    nav_router = router.send(:router)
    adapter = nav_router.send(:find_endpoint, verb.to_s.upcase, path) {}
    endpoint = adapter&.endpoint_class
    expect(endpoint).to eq(endpoint_class)
  end
  failure_message do |actual|
    "expected router to have a route matching '#{verb}: #{path}' that is handled by #{endpoint_class}"
  end
end
