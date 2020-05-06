class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
    self
  end

  def self.create
    new.save
  end

  def self.new_by_name(name)
    song = new
    song.name = name
    song
  end

  def self.create_by_name(name)
    new_by_name(name).save
  end

  def self.find_by_name name
    all.find{ |song| song.name == name }
  end

  def self.find_or_create_by_name name
    (find_by_name name) || (create_by_name name)
  end

  def self.alphabetical
    all.sort_by(&:name)
  end

  def self.new_from_filename(filename)
    song = create_by_name get_name_from_filename(filename)
    song.artist_name = get_artist_from_filename filename
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename filename
    song.save
    song
  end

  def self.get_artist_from_filename(filename)
    # filename.split(" - ").first
    /^(.*)\s\-/.match(filename).captures.first
  end

  def self.get_name_from_filename(filename)
    # name = filename.split(" - ")[1]
    # File.basename(name, File.extname(name))
    /\-\s(.*)\./.match(filename).captures.first
  end

  def self.destroy_all
    all.clear
  end
end
