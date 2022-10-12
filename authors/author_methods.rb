require 'json'

module AuthorMethods
  def add_author(author)
    File.new('./authors/authors.json', 'w+') unless File.exist?('./authors/authors.json')

    if File.empty?('./authors/authors.json')
      authors = []
    else
      data = File.read('./authors/authors.json').split
      authors = JSON.parse(data.join)
    end

    authors.push({ id: author.id, first_name: author.first_name, last_name: author.last_name })

    File.write('./authors/authors.json', authors.to_json)
  end

  def list_authors
    File.new('./authors/authors.json', 'w+') unless File.exist?('./authors/authors.json')

    if File.empty?('./authors/authors.json')
      puts 'No authors yet'
    else
      data = File.read('./authors/authors.json').split
      authors = JSON.parse(data.join)
      puts 'All Authors:'
      authors.each_with_index do |author, index|
        puts "#{index + 1}-First name: #{author['first_name']} | Last name: #{author['last_name']}"
      end
    end
  end
end
