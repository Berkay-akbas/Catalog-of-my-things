require_relative '../music'

describe MusicAlbum do
  before :each do
    @musicalbum = MusicAlbum.new(true, '2010-01-02')
  end

  context 'When testing the MusicAlbum class' do
    it 'Should create an instance of the class' do
      expect(@musicalbum).to be_an_instance_of MusicAlbum
    end

    it 'Should allow the music album to be archived' do
      expect(@musicalbum.can_be_archived?).to be_truthy
    end
  end
end
