#!/usr/local/bin/ruby
require "fileutils"
require 'nokogiri'
require 'open-uri'


class String
  def to_camel
    self.strip.gsub(/(-|\/|\s|<)(.)/) {|e| $2.upcase}
  end

  def to_readble_key
    st = self.to_camel.gsub(/ /, '').gsub(/>/,'')
    .gsub(/…/, '').gsub(/\.\.\./,'').gsub(/:/,'')
    .gsub(/\//,'').gsub(/\"/,'').gsub(/\(/, '')
    .gsub(/\)/,'').gsub(/%/, 'Percent').gsub(/\+/,'Plus')
    .gsub(/\-/, 'Minus')
    .gsub(/0/, 'Zero').gsub(/1/, 'One').gsub(/2/, 'Two')
    .gsub(/3/, 'Three').gsub(/4/, 'Four').gsub(/5/, 'Five')
    .gsub(/6/, 'Six').gsub(/7/, 'Seven').gsub(/8/, 'Eight')
    .gsub(/9/, 'Nine').gsub(/\./, 'Point').gsub(/,/,'').gsub(/\#/,'Sharp')
    return st.slice(0,1).capitalize + st.slice(1..-1)
  end
end

current_folder = `pwd`.chomp
if current_folder.end_with? "ResourcesManager"
  current_folder = "#{current_folder}/scripts"
end
Current_folder = current_folder
Resource_folder = "#{Current_folder}/iina_i18n"
Readable_key_file = "#{Current_folder}/readble_map.rb"
FileUtils.rm_rf Readable_key_file
Map_for_string_file = {"MainMenu.strings"=> "MainMenu", "PrefControlViewController.strings"=> "Pref", "InspectorWindowController.strings"=> "Inspector", "QuickSettingViewController.strings"=> "QuickSetting", "SubSelectWindowController.strings"=> "SubSelect", "HistoryWindowController.strings"=> "History", "FreeSelectingViewController.strings"=> "FreeSelecting", "CropSettingsViewController.strings"=> "CropSettings", "PlaylistViewController.strings"=> "Playlist", "FilterWindowController.strings"=> "Filter", "OpenURLAccessoryViewController.strings"=> "OpenURLAccessory", "AboutWindowController.strings"=> "About", "PrefGeneralViewController.strings"=> "PrefGeneral", "PrefKeyBindingViewController.strings"=> "PrefKeyBinding", "InitialWindowController.strings"=> "Initial", "PrefUIViewController.strings"=> "PrefUI", "PrefNetworkViewController.strings"=> "PrefNetwork", "FontPickerWindowController.strings"=> "FontPicker", "KeyRecordViewController.strings"=> "KeyRecord", "PrefAdvancedViewController.strings"=> "PrefAdvanced", "MainWindowController.strings"=> "Main", "PrefCodecViewController.strings"=> "PrefCodec", "PrefSubViewController.strings"=> "PrefSub", }
def do_generated
  language_list = ["zh-Hans"]
  # ignoreFile =
  base = "#{Resource_folder}/Base.lproj"
  language_list.each do |lang|
    current = "#{Resource_folder}/#{lang}.lproj"
    output_file = "#{current}/Localizable-generated.strings"
    FileUtils.rm_rf output_file
    files = Dir["#{current}/*.strings"]
    total_i18n = "#!/usr/local/bin/ruby\nReadable_map = {\n"
    total_map = "{"
    files.each do |file|
      name = File.basename(file)
      if name == "InfoPlist.strings" || name == "Localizable.strings" || name == "FilterPresets.strings" || name == "KeyBinding.strings"
        next
      end
      xib = "#{base}/#{name.gsub(/.strings/, '')}.xib"
      doc = {}
      can_search = false
      if File.exists?(xib)
        can_search = true
        doc = Nokogiri::XML(open(xib))
      end

      value = name.gsub(/.strings/, '')
      .gsub(/ControlViewController/,'')
      .gsub(/ViewControllers/,'')
      .gsub(/ViewController/,'')
      .gsub(/WindowController/,'')
      total_map += "\"#{name}\"=> \"#{value}\", "
      # puts value
      text = File.open(file).read
      text.gsub!(/\r\n?/, "\n")

      debug_hash = {}
      text.each_line do |line|
        if line == "" || (line.start_with? "/*") || can_search == false || line == "\n" || (line.start_with? "//")
          next
        end
        parser_line = line
          values = Array.new
          key_to_split = ""
          if line.include? ".title\""
            key_to_split = ".title\""
          elsif line.include? ".label\""
            key_to_split = ".label\""
          elsif line.include? ".placeholderString\""
            key_to_split = ".placeholderString\""
          end

          values = line.split(key_to_split)
          if values.count < 1
            next
          end
          found = false
          ui_components = ["outlet","menuItem", "menu", "textFieldCell", "buttonCell", "tabViewItem", "box", "tableColumn"]
          ui_components.each do |component|

              key = values[0].gsub(/"/,'').gsub(/\r\n?/,'')
              keys = key.split(".")
              key_raw = "#{values[0]}#{key_to_split}".gsub(/\"/,'')
              key_org = "\"#{value}.#{key_raw}\""
              if keys.count >= 2
                doc.xpath("//#{component}[@id='#{keys[0]}']").each do |element|

                  element.children.each do |child|
                    c_key = child.attributes["key"]
                    if c_key != nil
                      if c_key.value == keys[1]
                        title = child.attributes["title"]
                        found = true
                        readable_key = title.value.to_readble_key
                        parser_line = "#{key_org}=> \"#{value}.#{readable_key}\","

                        # old_key = debug_hash["#{value}.#{readable_key}"]
                        # if old_key != nil
                        #   puts "got repeat value for key: #{old_key} and #{key_org}, value: #{value}.#{readable_key}"
                        # end
                        # debug_hash["#{value}.#{readable_key}"] = key_org

                        break
                      end#if c_key.value
                    end#if c_key
                  end#element

                  if found == true
                    break
                  end
                end#doc.xpath

              else

                doc.xpath("//#{component}[@id='#{key}']").each do |element|
                    # puts element.inspect
                    found = true
                    readable_key = element.attributes["title"]
                    if readable_key == nil
                      readable_key = element.attributes["label"]
                    end
                    if readable_key != nil
                      readable_key = readable_key.value.to_readble_key
                    end

                    parser_line = "#{key_org}=> \"#{value}.#{readable_key}\","

                    old_key = debug_hash["#{value}.#{readable_key}"]
                    if old_key != nil
                      puts "got repeat value for key: #{old_key} and #{key_org}, value: #{value}.#{readable_key}"
                    end
                    debug_hash["#{value}.#{readable_key}"] = key_org

                    break
                end#doc.xpath

                if found == false
                  doc.xpath("//#{component}[@destination='#{key}']").each do |element|
                      found = true
                      readable_key = element.attributes["property"].value.to_readble_key
                      parser_line = "#{key_org}=> \"#{value}.#{readable_key}\","

                      # old_key = debug_hash["#{value}.#{readable_key}"]
                      # if old_key != nil
                      #   puts "got repeat value for key: #{old_key} and #{key_org}, value: #{value}.#{readable_key}"
                      # end
                      # debug_hash["#{value}.#{readable_key}"] = key_org

                      break
                  end#doc.xpath
                end

              end#else
          end#ui_components.each
          if found == false
            puts ""
            # puts "not found #{line.gsub(/\n/,'')} in *.xib"
          else
            total_i18n += "#{parser_line}\n"
          end

      end
    end
    total_i18n += "}"
    open(Readable_key_file, 'w') { |f|
      f.puts total_i18n
    }
    total_map += "}"
    # puts total_map
  end
end
do_generated
