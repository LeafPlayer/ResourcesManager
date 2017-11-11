#!/usr/local/bin/ruby
key_main_menu_minimize_all = "MainMenu.MinimizeAll"
key_github = "Github"
Readable_add_map = {
  "keys"=> [
    key_main_menu_minimize_all,
    key_github
  ],
  "en"=> {
    "#{key_github}"=> "#{key_github}",
    "#{key_main_menu_minimize_all}"=> "Minimize All",
  },
  "zh-Hans"=> {
    "#{key_main_menu_minimize_all}"=> "最小化全部",
  },
  "zh-Hant"=> {
    "#{key_main_menu_minimize_all}"=> "全部縮到最小",
  },
}

def value_for_adding_key_in_lang(lang, key)
  lang_value = Readable_add_map[lang]
  en_lang = Readable_add_map["en"]
  value = ""
  if lang_value == nil
    value = en_lang[key]
  else
    value = lang_value[key]
    if value == nil
      value = en_lang[key]
    end
  end
  return value
end
