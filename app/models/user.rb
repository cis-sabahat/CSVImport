class User < ApplicationRecord
  validates :name, :telephone, presence: true

  COLUMNS_TO_IMPORT = {name: "Name", email: "Email Address", telephone: "Telephone Number", website: "Website"}

  def self.import_users(file)
    rowNumber = 0
    file.each(COLUMNS_TO_IMPORT).with_index do |row, index|
      unless index == 0 || row[:email].blank? || row[:name].blank?
        user = User.find_by(email: row[:email])
        if user
          user.update_attributes(row)
        else
          rowNumber += 1
          self.create(row)
        end
      end
    end
    puts "#{rowNumber} rows imported"
  end
end
