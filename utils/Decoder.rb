class Decoder
  def self.decode_data(data, string_begin, string_end)
    #string_begin = "9px;\" href=\""
    #string_end = "\" title"

    data[/#{string_begin}(.*?)#{string_end}/m, 1]
  end
end
