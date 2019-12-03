#!/usr/bin/env ruby

def bit_table
  [
    [0, 4],
    [1, 5],
    [2, 6],
    [3, 7],
  ]
end

# the bitmap is stupid easy and faster to compute manually, but I wanted to figure out the code
def bitmap
  bit_table.flatten.each_with_index.map do |bit, index|
    [index, bit_table.transpose.flatten.index(bit)]
  end.to_h
end

def remap_bits(bitmap, int)
  expos = (("0" * 8) + int.to_s(2)).split('').last(8).reverse.each_with_index.map do |chr, idx|
    idx if chr == '1'
  end.compact

  expos.map { |e| 2 ** bitmap[e] }.sum
end

def transpose(chars)
  chars.each_char.each_with_index.map do |_char, idx|
    chars[remap_bits(bitmap, idx)]
  end.join
end

# https://github.com/andraaspar/bitmap-to-braille/commit/214814a8dfd77f46ce3b446c09482e33603a33fc#diff-ed009b6b86b017532ef0489c77de5100R4
# 2x4 each, full: ⣿
@chars = chars = '⠀⠁⠂⠃⠄⠅⠆⠇⡀⡁⡂⡃⡄⡅⡆⡇⠈⠉⠊⠋⠌⠍⠎⠏⡈⡉⡊⡋⡌⡍⡎⡏⠐⠑⠒⠓⠔⠕⠖⠗⡐⡑⡒⡓⡔⡕⡖⡗⠘⠙⠚⠛⠜⠝⠞⠟⡘⡙⡚⡛⡜⡝⡞⡟⠠⠡⠢⠣⠤⠥⠦⠧⡠⡡⡢⡣⡤⡥⡦⡧⠨⠩⠪⠫⠬⠭⠮⠯⡨⡩⡪⡫⡬⡭⡮⡯⠰⠱⠲⠳⠴⠵⠶⠷⡰⡱⡲⡳⡴⡵⡶⡷⠸⠹⠺⠻⠼⠽⠾⠿⡸⡹⡺⡻⡼⡽⡾⡿⢀⢁⢂⢃⢄⢅⢆⢇⣀⣁⣂⣃⣄⣅⣆⣇⢈⢉⢊⢋⢌⢍⢎⢏⣈⣉⣊⣋⣌⣍⣎⣏⢐⢑⢒⢓⢔⢕⢖⢗⣐⣑⣒⣓⣔⣕⣖⣗⢘⢙⢚⢛⢜⢝⢞⢟⣘⣙⣚⣛⣜⣝⣞⣟⢠⢡⢢⢣⢤⢥⢦⢧⣠⣡⣢⣣⣤⣥⣦⣧⢨⢩⢪⢫⢬⢭⢮⢯⣨⣩⣪⣫⣬⣭⣮⣯⢰⢱⢲⢳⢴⢵⢶⢷⣰⣱⣲⣳⣴⣵⣶⣷⢸⢹⢺⢻⢼⢽⢾⢿⣸⣹⣺⣻⣼⣽⣾⣿'
@chars = chars_tr = transpose(@chars)

# normal / transposed
# "⠀⠁⠂⠃⠄⠅⠆⠇⡀⡁⡂⡃⡄⡅⡆⡇⠈⠉⠊⠋⠌⠍⠎⠏⡈⡉⡊⡋⡌⡍⡎⡏⠐⠑⠒⠓⠔⠕⠖⠗⡐⡑⡒⡓⡔⡕⡖⡗⠘⠙⠚⠛⠜⠝⠞⠟⡘⡙⡚⡛⡜⡝⡞⡟⠠⠡⠢⠣⠤⠥⠦⠧⡠⡡⡢⡣⡤⡥⡦⡧⠨⠩⠪⠫⠬⠭⠮⠯⡨⡩⡪⡫⡬⡭⡮⡯⠰⠱⠲⠳⠴⠵⠶⠷⡰⡱⡲⡳⡴⡵⡶⡷⠸⠹⠺⠻⠼⠽⠾⠿⡸⡹⡺⡻⡼⡽⡾⡿⢀⢁⢂⢃⢄⢅⢆⢇⣀⣁⣂⣃⣄⣅⣆⣇⢈⢉⢊⢋⢌⢍⢎⢏⣈⣉⣊⣋⣌⣍⣎⣏⢐⢑⢒⢓⢔⢕⢖⢗⣐⣑⣒⣓⣔⣕⣖⣗⢘⢙⢚⢛⢜⢝⢞⢟⣘⣙⣚⣛⣜⣝⣞⣟⢠⢡⢢⢣⢤⢥⢦⢧⣠⣡⣢⣣⣤⣥⣦⣧⢨⢩⢪⢫⢬⢭⢮⢯⣨⣩⣪⣫⣬⣭⣮⣯⢰⢱⢲⢳⢴⢵⢶⢷⣰⣱⣲⣳⣴⣵⣶⣷⢸⢹⢺⢻⢼⢽⢾⢿⣸⣹⣺⣻⣼⣽⣾⣿"
# "⠀⠀⡀⡀⠂⠂⡂⡂⡂⡂⠊⠊⡄⡄⠌⠌⠄⠄⡄⡄⠆⠆⡆⡆⡆⡆⠎⠎⠈⠈⡈⡈⡄⡄⠌⠌⡆⡆⠎⠎⠎⠎⡎⡎⡈⡈⠐⠐⠈⠈⡈⡈⠊⠊⡊⡊⡊⡊⠒⠒⡌⡌⠔⠔⠆⠆⡆⡆⡀⡀⠈⠈⠈⠈⡈⡈⠊⠊⡊⡊⡂⡂⠊⠊⡄⡄⠌⠌⠌⠌⡌⡌⠎⠎⡎⡎⠊⠊⡊⡊⠌⠌⡌⡌⡌⡌⠔⠔⡎⡎⠖⠖⠎⠎⡎⡎⡈⡈⠐⠐⠐⠐⡐⡐⠒⠒⡒⡒⡆⡆⠎⠎⠈⠈⡈⡈⡈⡈⠐⠐⡊⡊⠒⠒⠊⠊⡊⡊⠌⠌⡌⡌⡌⡌⠔⠔⡎⡎⠖⠖⡊⡊⠒⠒⡌⡌⠔⠔⠔⠔⡔⡔⠖⠖⡖⡖⡎⡎⠖⠖⠐⠐⡐⡐⡐⡐⠘⠘⡒⡒⠚⠚⠌⠌⡌⡌⠎⠎⡎⡎⡎⡎⠖⠖⠐⠐⡐⡐⡈⡈⠐⠐⡊⡊⠒⠒⠒⠒⡒⡒⠔⠔⡔⡔⠐⠐⡐⡐⠒⠒⡒⡒⡒⡒⠚⠚⡔⡔⠜⠜⠔⠔⡔⡔⠖⠖⡖⡖⡖⡖⠞⠞⠘⠘⡘⡘"

def f(chars, i = 0)
  counter = 0
  loop do
    $>.write("\r#{chars[i % chars.length]} ")
    $>.flush
    i = yield i, counter
    counter += 1
    sleep(ENV.fetch('INT', '0.25').to_f)
  end
end

def setbit(n)
  2 ** (n % 8)
end

if __FILE__ == $0
  case (ARGV.first || 'snake')
  when 'seq'
    f(chars) { |i, count| i + 1 }
  when 'seq-tr'
    f(chars_tr) { |i, count| i + 1 }
  when 'snake'
    f(chars_tr, 3) { |i, c| i ^ setbit(c) ^ setbit(2 + c) }
  end
end
