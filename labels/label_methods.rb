require 'json'

module LabelMethods
  def list_all_labels
    puts "Labels list:\n\n"
    @labels = load_all_labels
    if @labels.length.zero?
      puts "List is empty, please add some labels...\n\n"
    else
      @labels.each_with_index do |label, index|
        print "#{index}) Title: #{label.title.upcase!}, Color: #{label.color} \n\n"
      end
    end
  end

  def load_all_labels
    file = '../storage/labels.json'
    labels = []
    if File.exist?(file) && File.read(file) != ''
      labels = JSON.parse(File.read(file)).map do |label|
        Label.new(label['title'], label['color'])
      end
    end
    labels
  end
end
