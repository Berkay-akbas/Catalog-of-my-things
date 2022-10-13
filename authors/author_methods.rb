require 'json'

module AuthorMethods
  def add_author(author)
    File.new('./storage/authors.json', 'w+') unless File.exist?('./storage/authors.json')

    if File.empty?('./storage/authors.json')
      authors = []
    else
      data = File.read('./storage/authors.json').split
      authors = JSON.parse(data.join)
    end

    authors.push({ id: author.id, first_name: author.first_name, last_name: author.last_name })

    File.write('./storage/authors.json', authors.to_json)
  end

  def list_authors
    File.new('./storage/authors.json', 'w+') unless File.exist?('./storage/authors.json')

    if File.empty?('./storage/authors.json')
      puts "\n"
      puts 'The authors list is empty, please add some items with authors...'
    else
      data = File.read('./storage/authors.json').split
      authors = JSON.parse(data.join)
      puts "👤 Author's list:\n\n"
      authors.each_with_index do |author, index|
        print "#{index}) First name: #{author['first_name']}, Last name: #{author['last_name']} \n\n"
      end
    end
  end
end
