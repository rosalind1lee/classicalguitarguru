namespace :slurp do
  desc "TODO"
  task composers: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "all_composers.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = Composer.new
      c.name = row["name"]
      c.era = row["era"]
      c.save
      puts "#{c.name}, #{c.era} saved"
    end

    puts "There are now #{Composer.count} rows in the composers table"

  end

end
