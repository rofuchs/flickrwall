# encoding: utf-8
# module FlickrWall
module FlickrWall
  def self.get_random_words(dictfile, n)
    # count lines
    wordlist = []
    count = 0
    File.foreach(dictfile) { count += 1 }

    wordlines = []
    n.times do
      wordlines << rand(1..count)
    end
    wordlines.sort!

    # open a dictfile for reading
    file = File.open(dictfile, 'r')
    word = ''
    wordlines.first.times { word = file.readline }
    wordlist << word
    for i in (1..n - 1) do
      (wordlines[i] - wordlines[i - 1]).times do
        word = file.readline
      end
      wordlist << word
    end
    file.close

    wordlist.shuffle
    wordlist
  end

  private_class_method :get_random_words
end
