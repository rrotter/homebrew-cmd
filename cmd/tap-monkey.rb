# typed: strict
# frozen_string_literal: true

require "abstract_command"

module Homebrew
  module Cmd
    class TapMonkey < AbstractCommand
      cmd_args do
        usage_banner "`tap-monkey` --repair|--rename [<tap>] [<branch name>]"
        description <<~EOS
          break/fix/modify a tap (mostly for testing `brew`)
        EOS

        switch "--rename",
               description: "Rename main branch in tap. This emulates what happens when the " \
                            "upstream changes the name of its main branch."
        switch "--repair",
               description: "Rename main branch in tap to track upstream. Similar to " \
                            "`tap --repair`, but can be executed per tap and doesn't repair " \
                            "other unrelated tap problems."

        named_args :tap
      end

      def print_tap_info(tap)
        puts "name: #{tap}"
        puts "formulae: #{tap.formula_files.size}"
        puts "official: #{tap.official?}"
        puts "report_analytics?: #{tap.should_report_analytics?}"
        puts "repo:"
        puts "  remote: #{tap.remote}"
        puts "  branch: #{tap.git_branch}"
        puts "  HEAD:   #{tap.git_head}"
        puts "  remote/origin: #{tap.git_repository.origin_url}"
        puts "  HEAD ref: #{tap.git_repository.head_ref}"
        puts "  origin branch name: #{tap.git_repository.origin_branch_name}"
        puts "  default origin br?: #{tap.git_repository.default_origin_branch?}"
      end

      def run
        taps = if args.no_named?
          Tap.installed
        else
          args.named.to_installed_taps
        end

        taps.each do |tap|
          print_tap_info(tap)
          # see also:
          #   set_head_origin_auto
          #   set_upstream_branch
          #   fix_remote_configuration
          # binding.irb
          puts ""
        end
      end
    end
  end
end
