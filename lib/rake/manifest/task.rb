# frozen_string_literal: true

require "rake/tasklib"

module Rake
  module Manifest
    # Tasks to create and check manifest file
    class Task < Rake::TaskLib
      attr_accessor :manifest_file, :patterns, :name

      def initialize(name = :manifest)
        super()

        self.manifest_file = "Manifest.txt"
        self.patterns = ["**/*"]
        self.name = name

        yield self if block_given?

        namespace name do
          define_tasks
        end
      end

      private

      def gemmable_files
        Rake::FileList.new(*patterns).existing.select { |fn| File.file?(fn) }
      end

      def manifest_files
        File.read(manifest_file).split
      end

      def define_generate_task
        desc "Create or update manifest"
        task :generate do
          File.open(manifest_file, "w") do |manifest|
            gemmable_files.each { |file| manifest.puts file }
          end
        end
      end

      def define_check_task
        desc "Check manifest"
        task :check do
          if gemmable_files == manifest_files
            puts "Manifest check succesful"
          else
            raise "Manifest check failed, try recreating the manifest" \
                  " using #{name}:generate"
          end
        end
      end

      def define_tasks
        define_generate_task
        define_check_task
      end
    end
  end
end
