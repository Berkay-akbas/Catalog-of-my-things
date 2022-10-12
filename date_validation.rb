require 'date'

def validate_date(string)
  format_ok = string.match(/\d{4}-\d{2}-\d{2}/)
  parseable = begin
    Date.strptime(string, '%Y-%m-%d')
  rescue StandardError
    false
  end

  if string == 'never' || (format_ok && parseable)
    true
  else
    puts '-' * 25
    puts '   Date is not valid!'
    puts '-' * 25
  end
end
