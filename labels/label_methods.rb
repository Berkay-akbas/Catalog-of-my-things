require 'json'

module LabelMethods
  def add_label
    label_type = set_label_type
    color = set_color
    @labels = load_all_labels if @labels.length.zero?
    label1 = Label.new(label_type, color)
    @labels << label1
    save_label
    label1
  end

  def save_label
    return if @labels.empty?

    file = './labels/labels.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @labels.each do |label|
      data << { title: label.title, color: label.color }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_labels
    if @labels.empty?
      puts "The list is empty, add some items with labels...\n\n"
    else
      puts 'Labels list:'
      @labels.each_with_index do |label, index|
        print "#{index}) Title: #{label.title}, Color: #{label.color} \n\n"
      end
    end
  end

  def load_all_labels
    file = './labels/labels.json'
    labels = []
    return labels unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).map do |label|
      new_label = Label.new(label['title'], label['color'])
      labels << new_label
    end
    labels
  end

  def set_label_type
    type = ''
    loop do
      puts 'Give a label for the item: (e.g. Gift, New...)'
      type = gets.chomp
      type.upcase!
      break if type != ''
    end
    type
  end

  def set_color
    color = ''
    loop do
      puts 'Choose a color for the item\'s label: (e.g. Pink, Black, Gold...)'
      color = gets.chomp
      break if color != ''
    end
    color
  end
end
