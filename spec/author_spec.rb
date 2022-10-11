require_relative '../authors/author'
require_relative '../authors/author_methods'

describe Author do
  include AuthorMethods
  it 'Should be an instance of Author' do
    author = Author.new('Kim', 'Butler')
    expect(author).to be_instance_of Author
  end

  it 'Shoud store author' do
    add_author(Author.new('Kim', 'Butler'))
    expect(File.exist?('./authors/authors.json') && File.read('./authors/authors.json') != '').to eq true
  end
end