namespace :authors do
  desc 'Create authors on GitHub'
  task create: :environment do
    github_connection = Github::Connection.new

    Author.all.each do |author|
      github_connection.client.create_issue(github_connection.repo.full_name, author.name, author.bio)
    end
  end
end
