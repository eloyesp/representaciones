# frozen_string_literal: true

# json 3.0 removed the legacy positional `options` argument from JSON.parse
# (signature became `parse(source, on_load:, object_class:, array_class:, **options)`),
# but ActiveSupport 8.1.3.1 (ActiveSupport::JSON.decode) and other gems still pass
# the options hash as a second positional argument, which raises
# `ArgumentError: wrong number of arguments (given 2, expected 1)`.
# Accept both calling conventions, forwarding any options as keyword arguments.
#
# Rails fixed ActiveSupport::JSON.decode to use keyword arguments, so once this
# app runs a Rails newer than the one with the bug, the shim is not needed
# anymore and should be removed.
if Gem::Version.new(Rails.version) > Gem::Version.new("8.1.3.1")
  raise <<~MSG
    This shim is not needed anymore: Rails #{Rails.version} already parses JSON
    with keyword arguments. Remove config/initializers/json.rb.
  MSG
end
module JSON
  class << self
    alias_method :parse_without_legacy_options, :parse

    def parse(source, options = nil, **kwargs)
      kwargs = kwargs.merge(options) if options
      parse_without_legacy_options(source, **kwargs)
    end
  end
end