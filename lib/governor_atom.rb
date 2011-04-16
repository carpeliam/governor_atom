require 'governor_atom/rails'

atom = Governor::Plugin.new('atom feed')
atom.responds_to :atom, :only => [:index]
Governor::PluginManager.register atom