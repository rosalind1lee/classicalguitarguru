namespace :getpieces do
  desc "TODO"
  task pieces: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "all_composers.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|

      htmltext = URI.open(row["url"])
      response = Nokogiri::HTML(htmltext)
      nodeset = response.xpath("//*[contains(@class, 'entry-title-link')]")
      #links = nodeset.map {|element| element["href"]}.compact
      #p links

      pieces = nodeset.map{|element| element.text}.compact
      pieces.each do |piece|
        new_piece = Piece.new
        new_piece.title = piece
        new_piece.composer_id = Composer.where({ :name => row["name"] }).at(0).id
        new_piece.save
        puts "#{new_piece.composer_id}, #{new_piece.title}, #{row["name"]} saved" 
      end

      #c = Composer.new
      #c.name = row["name"]
      #c.era = row["era"]
      #c.save
      #puts "#{c.name}, #{c.era} saved"
    end

    puts "There are now #{Composer.count} rows in the composers table"
  end

end
