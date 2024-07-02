# typed: strict
# frozen_string_literal: true

require "abstract_command"

module Homebrew
  module Cmd
    class TapsCmd < AbstractCommand
      cmd_args do

      end

      def run
        taps = Tap.all
        name_col = taps.map{|x| x.name.size}.max
        path_col = taps.map{|x| x.path.to_s.size}.max
        fmt = "%-#{name_col}s %4s %4s %4s %3s %s"
        puts( sprintf("%-#{name_col}s %4s ", "Tap", "Size") + "  🍺   🍷 Cmd")

        taps.sort_by{|t| t.name}.each do |tap|
          extra = []

          if tap.installed?
            extra << tap.path if args.verbose?
            extra << "(#{tap.git_repository.branch_name})" unless tap.git_repository.default_origin_branch?
            dirty = %x[cd #{tap.path}; git status --porcelain].strip
            extra << "*" unless dirty.strip.empty?
            size = `du -sh #{tap.path}`.split.first
          else
            size = "-"
          end

          puts sprintf fmt, tap.name, size, tap.formula_files.size, tap.cask_files.size, tap.command_files.size, extra.join(" ")
        end
      end
    end
  end
end
