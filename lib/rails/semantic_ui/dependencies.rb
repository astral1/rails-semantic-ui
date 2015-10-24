class Rails::SemanticUI::Dependencies
  def initialize(hashes)
    @dependencies = hashes.map {|d| {}.merge d}
  end

  def add(name, version_spec)
    @dependencies << {'name' => name, 'version' => version_spec}
  end

  def to_s
    @dependencies.uniq!
    @dependencies.to_yaml.lines[1..-1].map(&:rstrip).join("\n").gsub('"', "'").gsub /^/, '    '
  end
end
