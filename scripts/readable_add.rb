#!/usr/local/bin/ruby
key_main_menu_minimize_all = "MainMenu.MinimizeAll"
Readable_add_map = {
  "keys"=> [
    key_main_menu_minimize_all,
  ],
  "en"=> {
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
  if lang_value == nil
    lang_value = Readable_add_map["en"]
  end
  return lang_value[key]
end
