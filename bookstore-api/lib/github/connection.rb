require 'octokit'

class Github::Connection
  attr_reader :client, :repo

  def initialize
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    @repo   = client.repo('monteirobrena/bookstore')
  end
end