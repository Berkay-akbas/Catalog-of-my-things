require_relative '../labels/label'
require_relative '../books/book'

describe Label do
  before :each do
    @label = Label.new('Gift', 'pink')
  end

  context "When creating a new instance of the Label class" do
    it "should be an instance of the Label class" do
      expect(@label).to be_instance_of Label
    end
    it "should have the following properties: title, color, id" do
      expect(@label.title).to eql('GIFT')
      expect(@label.color).to eql('pink')
      expect(@label.color).to be_kind_of String
      expect(@label.id).to be_kind_of Integer
    end
  end

  context "When using the add_item method" do
    it "should add the item to the items array" do
      book = Book.new('Book123', 'Maisy', 'good', '1980-10-30')
      @label.add_item(book)
      expect(@label.items[0]).to be_instance_of Book
      expect(@label.items[0].title).to eql('Book123')
    end
  end
end