# lib/string_extensions.rb
module StringExtensions
  VIETNAMESE_MAP = {
    "a" => %w[á à ả ã ạ ă ắ ằ ẳ ẵ ặ â ấ ầ ẩ ẫ ậ],
    "A" => %w[Á À Ả Ã Ạ Ă Ắ Ằ Ẳ Ẵ Ặ Â Ấ Ầ Ẩ Ẫ Ậ],
    "d" => ["đ"],
    "D" => ["Đ"],
    "e" => %w[é è ẻ ẽ ẹ ê ế ề ể ễ ệ],
    "E" => %w[É È Ẻ Ẽ Ẹ Ê Ế Ề Ể Ễ Ệ],
    "i" => %w[í ì ỉ ĩ ị],
    "I" => %w[Í Ì Ỉ Ĩ Ị],
    "o" => %w[ó ò ỏ õ ọ ô ố ồ ổ ỗ ộ ơ ớ ờ ở ỡ ợ],
    "O" => %w[Ó Ò Ỏ Õ Ọ Ô Ố Ồ Ổ Ỗ Ộ Ơ Ớ Ờ Ở Ỡ Ợ],
    "u" => %w[ú ù ủ ũ ụ ư ứ ừ ử ữ ự],
    "U" => %w[Ú Ù Ủ Ũ Ụ Ư Ứ Ừ Ử Ữ Ự],
    "y" => %w[ý ỳ ỷ ỹ ỵ],
    "Y" => %w[Ý Ỳ Ỷ Ỹ Ỵ]
  }

  def to_ascii
    s = self.dup
    VIETNAMESE_MAP.each do |ascii, accents|
      accents.each { |accent| s.gsub!(accent, ascii) }
    end
    s
  end

  def to_slug
    to_ascii.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/^-|-$/, "")
  end
end

String.include StringExtensions
