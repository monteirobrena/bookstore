namespace :authors do
  desc 'Create authors on GitHub'
  task create: :environment do
    github_connection = Github::Connection.new

    Author.all.each do |author|
      issue = github_connection.client.create_issue(github_connection.repo.full_name, author.name, author.bio)
      author.books.each { |book| github_connection.client.add_comment(github_connection.repo.full_name, issue.number, book.title) }
    end
  end
end