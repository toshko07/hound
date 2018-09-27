module Linter
  class Rubocop < Base
    FILE_REGEXP = /.+(\.rb|\.rake)|Gemfile\z/

    private

    def job_class
      case version.presence
      when "0.59.2"
        # AlmondJoy? Antelope?
        LintersV2Job
      else
        LintersJob
      end
    end
  end
end
