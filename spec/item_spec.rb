require_relative '../item'

describe Item do
  before :each do
    @item = Item.new('2010-02-05')
  end

  context 'When testing the Item class' do
    it 'Creates an instance of the Item class' do
      expect(@item).to be_an_instance_of Item
    end

    it 'Should archive the book' do
      expect(@item.can_be_archived?).to be_truthy
    end
  end
end
