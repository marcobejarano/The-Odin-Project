require 'erb'
require 'csv'
require 'google/apis/civicinfo_v2'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone_number)
  cleaned_phone_number = phone_number.gsub('(', '').gsub(')', '').gsub('-', '').gsub('.', '').gsub(' ', '')
  length = cleaned_phone_number.length
  if length < 10 || length > 11 || (length == 11 && cleaned_phone_number[0] != 1)
    'It is a bad phone number'
  elsif length == 11 && cleaned_phone_number[0] == 1
    cleaned_phone_number[1..10]
  elsif length == 10
    cleaned_phone_number
  end
end

def get_parsed_date(date)
  if date.length == 12
    date = "0" + date.insert(2, '0')
  end
  date.insert(6, '20')
  Time.strptime(date, '%m/%d/%Y %k:%M')
end

def get_most_registered_day(days)
  days.reduce(Hash.new(0)) do |result, day|
    result[day] += 1
    result
  end
end

def get_most_registered_hour(hours)
  hours.reduce(Hash.new(0)) do |result, hour|
    result[hour] += 1
    result
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
days = []
hours = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  date = row[1]
  date = get_parsed_date(date)

  days += [date.strftime('%A')]
  hours += [date.hour]

  phone_number = row[5]
  cleaned_phone_number = clean_phone_number(phone_number)
  puts cleaned_phone_number
end

puts get_most_registered_day(days).sort_by { |_k, v| v }.reverse.to_h
puts 'The days of the week most people registered are Wednesday, Thursday, and Sunday.'
puts get_most_registered_hour(hours).sort_by { |_k, v| v }.reverse.to_h
puts 'The peak registration hours are from 13 to 22 hours.'
