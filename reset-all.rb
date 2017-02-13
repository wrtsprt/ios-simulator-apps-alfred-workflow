#!/bin/env ruby
xcodes = Dir.glob("/Applications/Xcode*.app")

puts "all xcodes #{xcodes}"


current_developer_dir = %x{xcode-select -p}.chomp
puts "current dev dir: #{current_developer_dir}"

xcrun_path = "/usr/bin/xcrun"
xcodes.each do |xcode|

    puts "----------------> #{xcode} ---------------------->"
	developer_dir = "#{xcode}/Contents/Developer"

	simctl = if developer_dir == current_developer_dir
	  "#{xcrun_path} simctl erase all"
	else
	  "DEVELOPER_DIR=#{developer_dir} #{xcrun_path} simctl erase all"
	end

	puts "removing core service"
	remove_core_service = "launchctl remove com.apple.CoreSimulator.CoreSimulatorService || true"
	output1 = %x{#{remove_core_service}}

	puts simctl
	output = %x{#{simctl}}
	puts output 
end
