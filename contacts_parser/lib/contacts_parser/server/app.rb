require "sinatra"

module ContactsParser
  class Server < Sinatra::Base
    set :public_folder, File.dirname(__FILE__) + '/static'

    get '/' do
      erb :index
    end

    post '/upload' do
      # Get file details
      @filename = params[:csv][:filename]
      file = params[:csv][:tempfile]

      # Store the file
      File.open("#{File.dirname(__FILE__)}/static/data/#{@filename}", "wb") do |f|
        f.write(file.read)
      end

      # Read as CSV
      raw_data = Files::read("#{File.dirname(__FILE__)}/static/data/#{@filename}")

      # Convert file to object
      @contacts = Formatter::contacts(raw_data[1..])

      # Store total
      @total_records = @contacts.length

      # Validate records
      @contacts, @invalid = Validator::contacts(@contacts)

      # Merge duplicates
      @contacts, @merges = Merger::contacts(@contacts)

      # Save files as json
      @contact_file = "#{@filename}.json"
      Files::write("#{File.dirname(__FILE__)}/static/data/#{@contact_file}", @contacts)
      @invalid_file = "#{@filename}.invalid.json"
      Files.write("#{File.dirname(__FILE__)}/static/data/#{@invalid_file}", @invalid)
      @merges_file = "#{@filename}.merges.json"
      Files.write("#{File.dirname(__FILE__)}/static/data/#{@merges_file}", @merges)

      # Display results in browser
      erb :upload
    end
  end
end