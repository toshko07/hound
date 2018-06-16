class GitHubAuthOptions
  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def to_hash
    if @request.params["access"] == "full"
      { scope: "repo,user:email" }
    elsif @request.params["access"] == "public"
      { scope: "public_repo,user:email" }
    else
      {}
    end
  end
end
