require 'json'

module LabelMethods
  def add_label
    label_type = sets_label('name for the label')
    color = sets_label('color for the label')
    @labels = load_all_labels if @labels.length.zero?
    label1 = Label.new(label_type, color)
    @labels << label1
    save_label
    label1
  end

  def save_label
    return if @labels.empty?

    file = './storage/labels.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @labels.each do |label|
      data << { title: label.title, color: label.color }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_labels
    if @labels.empty?
      puts 'The list is empty, add some items with labels...'
    else
      puts "🔖 Labels list:\n\n"
      @labels.each_with_index do |label, index|
        puts "#{index}) Title: #{label.title}, Color: #{label.color} \n\n"
      end
    end
  end

  def load_all_labels
    file = './storage/labels.json'
    labels = []
    return labels unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).map do |label|
      new_label = Label.new(label['title'], label['color'])
      labels << new_label
    end
    labels
  end

  def sets_label(val)
    label = ''
    loop do
      puts "Choose a #{val} "
      label = gets.chomp
      break if label != ''
    end
    label
  end
end
