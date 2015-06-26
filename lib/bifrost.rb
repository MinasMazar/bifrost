require "bifrost/version"
require "logger"

$logger = Logger.new STDOUT

module Bifrost

  def system_exec(cmds)
    cmds = [ cmds ] if cmds.is_a? String
    cmds.map do |cmd|
      $logger.debug "Executing system command: #{cmd}"
      system "#{cmd}"
    end
  end

  def system_exec_and_get_output(cmds)
    cmds = [ cmds ] if cmds.is_a? String
    cmds.map do |cmd|
      $logger.debug "Executing system command: #{cmd}"
      `#{cmd}`
    end
  end

  def select_executable(cmds)
    cmds.find { |c| check_executable c }
  end

  def check_executable(cmd)
    system(cmd + ">/dev/null 2>/dev/null") != nil ? cmd : false
  end

end
