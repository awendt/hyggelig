module I18n

    def self.with_scope(*scope)
      return unless block_given?
      with_options :scope => scope do |i18n_with_scope|
        yield(i18n_with_scope)
      end
    end

end