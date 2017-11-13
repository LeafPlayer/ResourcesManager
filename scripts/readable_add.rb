#!/usr/local/bin/ruby
key_main_menu_minimize_all = "MainMenu.MinimizeAll"
key_github = "MainMenu.Github"
key_music_mode = "MainMenu.MusicMode"
key_delogo = "MainMenu.DeLogo"
Readable_add_map = {
  "keys"=> [
    key_main_menu_minimize_all,
    key_github,
    key_music_mode,
    key_delogo
  ],
  "en"=> {
    "#{key_github}"=> "Github",
    "#{key_music_mode}"=> "Music Mode",
    "#{key_delogo}"=> "DeLogo",
    "#{key_main_menu_minimize_all}"=> "Minimize All",
  },
  "zh-Hans"=> {
    "#{key_music_mode}"=> "音乐模式",
    "#{key_delogo}"=> "去台标",
    "#{key_main_menu_minimize_all}"=> "最小化全部",
  },
  "zh-Hant"=> {
    "#{key_music_mode}"=> "音樂模式",
    "#{key_delogo}"=> "去台標",
    "#{key_main_menu_minimize_all}"=> "全部縮到最小",
  },
  "de"=> { },
  "es"=> { },
  "fr"=> { "#{key_music_mode}"=> "Mode musique", },
  "it"=> { "#{key_music_mode}"=> "Modalità audio", },
  "ja"=> {
    "#{key_music_mode}"=> "ミュージックモード",
    "#{key_delogo}"=> "ウォーターマーク除去",
  },
  "ko"=> {
    "#{key_music_mode}"=> "미니 플레이어",
    "#{key_delogo}"=> "로고 제거",
  },
  "nl"=> {
    "#{key_music_mode}"=> "Muziek modus",
  },
  "pl"=> { },
  "ru"=> {
    "#{key_music_mode}"=> "Mузыкальный режим",
    "#{key_delogo}"=> "Убрать логотип",
  },
  "tr"=> { },
  "uk"=> { },
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
