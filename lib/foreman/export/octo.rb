require "erb"
require "foreman/export"

class Foreman::Export::Octo < Foreman::Export::Base

  def export
    super

    engine.each_process do |name, process|
      next if engine.formation[name] < 1
      next if ['rake', 'console'].include?(name)

      port = engine.port_for(process, 1)
      write_template "octo/run.erb", "run-#{app}-#{name}", binding
      chmod 0755, "run-#{app}-#{name}"
    end
  end
end
