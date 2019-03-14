class Hash
  def +(other)
    merge(other)
  end
end

class String
  def humanize
    tr('_', ' ').capitalize
  end
end
