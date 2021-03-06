#!/usr/bin/env ruby

def bit_table
  # responsible bits in the @chars
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
# "⠀⠁⠈⠉⠂⠃⠊⠋⠐⠑⠘⠙⠒⠓⠚⠛⠄⠅⠌⠍⠆⠇⠎⠏⠔⠕⠜⠝⠖⠗⠞⠟⠠⠡⠨⠩⠢⠣⠪⠫⠰⠱⠸⠹⠲⠳⠺⠻⠤⠥⠬⠭⠦⠧⠮⠯⠴⠵⠼⠽⠶⠷⠾⠿⡀⡁⡈⡉⡂⡃⡊⡋⡐⡑⡘⡙⡒⡓⡚⡛⡄⡅⡌⡍⡆⡇⡎⡏⡔⡕⡜⡝⡖⡗⡞⡟⡠⡡⡨⡩⡢⡣⡪⡫⡰⡱⡸⡹⡲⡳⡺⡻⡤⡥⡬⡭⡦⡧⡮⡯⡴⡵⡼⡽⡶⡷⡾⡿⢀⢁⢈⢉⢂⢃⢊⢋⢐⢑⢘⢙⢒⢓⢚⢛⢄⢅⢌⢍⢆⢇⢎⢏⢔⢕⢜⢝⢖⢗⢞⢟⢠⢡⢨⢩⢢⢣⢪⢫⢰⢱⢸⢹⢲⢳⢺⢻⢤⢥⢬⢭⢦⢧⢮⢯⢴⢵⢼⢽⢶⢷⢾⢿⣀⣁⣈⣉⣂⣃⣊⣋⣐⣑⣘⣙⣒⣓⣚⣛⣄⣅⣌⣍⣆⣇⣎⣏⣔⣕⣜⣝⣖⣗⣞⣟⣠⣡⣨⣩⣢⣣⣪⣫⣰⣱⣸⣹⣲⣳⣺⣻⣤⣥⣬⣭⣦⣧⣮⣯⣴⣵⣼⣽⣶⣷⣾⣿"

def f(chars, i = 0)
  counter = 0
  Enumerator.new do |y|
    loop do
      y << chars[i % chars.length]
      i = yield i, counter
      counter += 1
    end
  end
end

def print(chars)
  $>.write("\r#{chars} ")
  $>.flush
  sleep(ENV.fetch('INT', '0.20').to_f)
end

def display(enum)
  enum.each(&method(:print))
end

def displays(enums)
  loop do
    print enums.map(&:next).join('   .   ')
  end
end

def setbits(*ns)
  ns.map { |n| 2 ** (n % 8) }.sum
end
alias :setbit :setbits

if __FILE__ == $0
  animations = {
    'seq'       => f(chars) { |i, count| i + 1 },
    'seq-tr'    => f(chars_tr) { |i, count| i + 1 },
    'falls'     => f(chars_tr, 3) { |i, c| i ^ setbit(c) ^ setbit(2 + c) },
    'line'      => f(chars_tr, 1+4+16+64) { |i, c| i ^ setbit(c * 2) ^ setbit(c * 2 + 1) },
    'updown'    => f(chars_tr, 0) { |i, c| i ^ setbit(c * 2) ^ setbit((7 - c) * 2 + 1) },
    'rand'      => f(chars, 0) { |i| i ^ setbit(rand(8)) },
    'rand-2'    => f(chars, 0) { |i| i ^ setbits(*(0..7).to_a.shuffle.take(2)) },

    'snake'     => f(chars, 2+1+16) do |state, c|
      order = [8, 4, 2, 1, 16, 32, 64, 128]
      state ^ order[(c + 2) % order.length] ^ order[(c + 5) % order.length]
    end,
  }

  if ARGV.length == 0
    puts('usage: braille.rb ANIMATIONS')
    puts('  see list of animations with -l or --list')
    exit
  end

  if ARGV.first =~ /^--list|-l$/
    puts animations.keys.join(' ')
    exit
  end

  selected = (ARGV || ['snake']).map { |a| animations.fetch(a) }
  displays(selected)
end
