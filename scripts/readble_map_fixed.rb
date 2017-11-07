#!/usr/local/bin/ruby
require_relative 'readble_map.rb'
readable_map_fixed = {
  "Fqo-1c-3L1.ibShadowedLabels[0]"=> "Inspector.General",
  "Fqo-1c-3L1.ibShadowedLabels[1]"=> "Inspector.Tracks",
  "Fqo-1c-3L1.ibShadowedLabels[2]"=> "Inspector.File",
  "Fqo-1c-3L1.ibShadowedLabels[3]"=> "Inspector.Status",

  "cMu-YF-riv.ibShadowedLabels[0]"=> "QuickSetting.Default",
  "cMu-YF-riv.ibShadowedLabels[1]"=> "QuickSetting.FourThree",
  "cMu-YF-riv.ibShadowedLabels[2]"=> "QuickSetting.SixteenNine",
  "cMu-YF-riv.ibShadowedLabels[3]"=> "QuickSetting.SixteenTen",
  "cMu-YF-riv.ibShadowedLabels[4]"=> "QuickSetting.FiveFour",

  "iuN-rN-jT7.ibShadowedLabels[0]"=> "QuickSetting.None",
  "iuN-rN-jT7.ibShadowedLabels[1]"=> "QuickSetting.FourThree",
  "iuN-rN-jT7.ibShadowedLabels[2]"=> "QuickSetting.SixteenNine",
  "iuN-rN-jT7.ibShadowedLabels[3]"=> "QuickSetting.SixteenTen",
  "iuN-rN-jT7.ibShadowedLabels[4]"=> "QuickSetting.FiveFour",

  "z1L-0N-dfK.ibShadowedLabels[0]"=> "QuickSetting.Zero",
  "z1L-0N-dfK.ibShadowedLabels[1]"=> "QuickSetting.NightZero",
  "z1L-0N-dfK.ibShadowedLabels[2]"=> "QuickSetting.OneEightZero",
  "z1L-0N-dfK.ibShadowedLabels[3]"=> "QuickSetting.TwoSevenZeo",

  "AB5-UZ-euc.ibShadowedLabels[0]"=> "QuickSetting.LoadSubtitle",

  "Rbb-wh-cLc.ibShadowedLabels[0]"=> "QuickSetting.SearchOnline",

  "bQc-2s-1MS.ibShadowedLabels[0]"=> "QuickSetting.FourThree",
  "bQc-2s-1MS.ibShadowedLabels[1]"=> "QuickSetting.SixteenNine",
  "bQc-2s-1MS.ibShadowedLabels[2]"=> "QuickSetting.SixteenTen",
  "bQc-2s-1MS.ibShadowedLabels[3]"=> "QuickSetting.FiveFour",
  "bQc-2s-1MS.ibShadowedLabels[4]"=> "QuickSetting.ThreeTwo",
  "bQc-2s-1MS.ibShadowedLabels[5]"=> "QuickSetting.TwentyOneNight",

}
Readable_i18n_key_map = Readable_map.merge(readable_map_fixed)
