module Slugs

  module InstanceMethods

    def slugU
      self.username.gsub(' ', '-').downcase
    end

    def slugF
      self.title.gsub(' ', '-').downcase
    end

  end

  module ClassMethods

    def find_by_slugU(slug)
      self.all.find{ |i| i.slugU == slug}
    end

    def find_by_slugF(slug)
      self.all.find{ |i| i.slugF == slug}
    end

  end

end
