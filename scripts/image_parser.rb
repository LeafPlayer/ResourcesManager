#!/usr/local/bin/ruby
require "fileutils"
class String
  def to_camel
    self.strip.gsub(/(-|\/|\s|<|_)(.)/) {|e| $2.upcase}
  end
end
current_folder = `pwd`.chomp
if current_folder.end_with? "ResourcesManager"
  current_folder = "#{current_folder}/scripts"
end
Current_folder = current_folder
Parent_folder = File.dirname(Current_folder)
Resources_Bundle_folder = "#{Parent_folder}/Resources.bundle"
Resource_folder = "#{Resources_Bundle_folder}/images"
Output_file = "#{Parent_folder}/generated/Image.swift"
FileUtils.rm_rf Output_file

def generated
  class_name = "ImageResource"
  preface = "// This file is auto-generated by image_parser.rb, do not modify! \n"
  preface += "// Generated at " + Time.now.strftime("%d/%m/%Y %H:%M") + "\n\n"
  total_line = preface
  total_line += "public final class #{class_name} {\n" +
  "\tstatic var bundle = Bundle(for: #{class_name}.self)\n" +
  "\tprivate static func fileName(name: String) -> String {\n" +
  "\t\tlet prefixed = \"Resources.bundle/images/\"\n" +
  "\t\tlet path = bundle.url(forResource: prefixed + name, withExtension: \"pdf\")?.absoluteString ?? \"\"\n" +
  "\t\treturn path.replacingOccurrences(of: \".pdf\", with: \"\")\n" +
  "\t}\n" +
  "\tprivate static func image(named: String) -> UIImage {\n" +
  "\t\tvar image: UIImage! = UIImage.pdfAssetNamed(#{class_name}.fileName(name: named))\n" +
  "\t\tif image == nil { image = UIImage() }\n" +
  "\t\treturn image\n" +
  "\t}\n" +
  "\tprivate static func pngImage(named: String) -> UIImage {\n" +
  "\t\tlet prefixed = \"Resources.bundle/images/\"\n" +
  "\t\tif let path = bundle.path(forResource: prefixed + named, ofType: \"png\"), let image = UIImage(contentsOfFile: path) { return image }\n" +
  "\t\treturn UIImage()\n" +
  "\t}\n"

  pngs = Dir["#{Resource_folder}/*.png"]
  pngs.each do |png|
    base_name = File.basename(png).gsub(/.png/,'')
    var_name = base_name.to_camel
    file_name = base_name.gsub(/.png/,'')
    total_line += "\tpublic static var #{var_name}: UIImage { return pngImage(named: \"#{file_name}\") }\n"
  end

  pdfs = Dir["#{Resource_folder}/*.pdf"]
  pdfs.each do |png|
    base_name = File.basename(png).gsub(/.pdf/,'')
    var_name = base_name.to_camel
    file_name = base_name
    total_line += "\tpublic static var #{var_name}: UIImage { return image(named: \"#{file_name}\") }\n"
  end

  total_line += "}"
  open(Output_file, 'w') { |f|
    f.puts total_line
  }
end
generated
