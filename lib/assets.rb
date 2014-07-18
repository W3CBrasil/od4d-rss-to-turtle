class Assets
  def self.assets_path
    directory = File.expand_path '../', File.dirname(__FILE__)
    File.join(directory, 'assets')
  end

  def self.static_datasets
    File.join(assets_path, 'static-datasets')
  end
end
