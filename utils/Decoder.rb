class Decoder
  def self.decode_purchase_link(data)
    string_begin = "9px;\" href=\""
    string_end = "\" title"

    data[/#{string_begin}(.*?)#{string_end}/m, 1]
  end
end
