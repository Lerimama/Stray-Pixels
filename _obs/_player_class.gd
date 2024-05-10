[gd_scene load_steps=121 format=2]

[ext_resource path="res://assets/theme/fonts/16bfZX.ttf" type="DynamicFontData" id=1]
[ext_resource path="res://assets/theme/theme_lerimama.tres" type="Theme" id=2]
[ext_resource path="res://assets/theme/font_title.tres" type="DynamicFont" id=3]
[ext_resource path="res://assets/theme/font_body.tres" type="DynamicFont" id=4]
[ext_resource path="res://assets/resources/tileset_titles.tres" type="TileSet" id=5]
[ext_resource path="res://game/hud/game_countdown.gd" type="Script" id=6]
[ext_resource path="res://assets/atlas_hud.png" type="Texture" id=7]
[ext_resource path="res://game/hud/hud energy_bar.gd" type="Script" id=8]
[ext_resource path="res://game/hud/hud_life_icons.gd" type="Script" id=9]
[ext_resource path="res://game/gui/pause_menu.gd" type="Script" id=10]
[ext_resource path="res://assets/atlas_controls.png" type="Texture" id=11]
[ext_resource path="res://game/hud/hud_color_indicator.tscn" type="PackedScene" id=12]
[ext_resource path="res://game/hud/hud_game_timer.gd" type="Script" id=13]
[ext_resource path="res://game/minimap_camera.gd" type="Script" id=14]
[ext_resource path="res://game/gui/highscore_table.gd" type="Script" id=15]
[ext_resource path="res://assets/theme/font_main.tres" type="DynamicFont" id=16]
[ext_resource path="res://game/hud/music_player.gd" type="Script" id=17]
[ext_resource path="res://assets/spectrum_bar.png" type="Texture" id=18]
[ext_resource path="res://game/hud/hud_patterns.gd" type="Script" id=19]
[ext_resource path="res://game/managers/game_manager_patterns.gd" type="Script" id=20]
[ext_resource path="res://game/gui/game_over_patterns.gd" type="Script" id=21]
[ext_resource path="res://game/player_camera.tscn" type="PackedScene" id=22]
[ext_resource path="res://game/arena.tscn" type="PackedScene" id=23]

[sub_resource type="Gradient" id=225]
colors = PoolColorArray( 1, 1, 1, 1, 0.390625, 0.390625, 0.390625, 1 )

[sub_resource type="GradientTexture" id=226]
gradient = SubResource( 225 )
width = 700

[sub_resource type="StyleBoxLine" id=228]
color = Color( 0.0784314, 0.0784314, 0.0784314, 1 )
grow_begin = 0.0
grow_end = 0.0
thickness = 2
vertical = true

[sub_resource type="StyleBoxFlat" id=239]
bg_color = Color( 0, 0, 0, 0.784314 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 0.952941, 0.356863, 0.498039, 1 )

[sub_resource type="AtlasTexture" id=359]
atlas = ExtResource( 11 )
region = Rect2( 80, 98, 70, 46 )

[sub_resource type="AtlasTexture" id=360]
atlas = ExtResource( 11 )
region = Rect2( 0, 98, 70, 46 )

[sub_resource type="AtlasTexture" id=361]
atlas = ExtResource( 11 )
region = Rect2( 138, 154, 22, 22 )

[sub_resource type="AtlasTexture" id=362]
atlas = ExtResource( 11 )
region = Rect2( 0, 154, 102, 22 )

[sub_resource type="AtlasTexture" id=363]
atlas = ExtResource( 11 )
region = Rect2( 113.919, 154, 22, 22 )

[sub_resource type="StreamTexture" id=364]
load_path = "res://.import/atlas_controls.png-75e6b40869d487066545840672dcb98d.stex"

[sub_resource type="AtlasTexture" id=392]
atlas = SubResource( 364 )
region = Rect2( 0, 0, 120, 86 )

[sub_resource type="AtlasTexture" id=366]
atlas = SubResource( 392 )
region = Rect2( 0, 0, 120, 86 )

[sub_resource type="AtlasTexture" id=367]
atlas = ExtResource( 11 )
region = Rect2( 10, 17, 22, 22 )

[sub_resource type="AtlasTexture" id=368]
atlas = ExtResource( 11 )
region = Rect2( 96, 32, 10, 10 )

[sub_resource type="AtlasTexture" id=369]
atlas = ExtResource( 11 )
region = Rect2( 146, 6, 6, 10 )

[sub_resource type="StyleBoxEmpty" id=405]

[sub_resource type="StreamTexture" id=422]
load_path = "res://.import/iconset_lerimama_theme.png-7ff4695cad905aee2e2e716d4a555101.stex"

[sub_resource type="AtlasTexture" id=406]
atlas = SubResource( 422 )
region = Rect2( 16, 16, 14, 16 )

[sub_resource type="AtlasTexture" id=407]
atlas = SubResource( 422 )
region = Rect2( 0, 16, 10, 16 )

[sub_resource type="StyleBoxFlat" id=408]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color( 0.494118, 0.517647, 0.545098, 1 )
expand_margin_left = 6.0
expand_margin_right = 6.0
expand_margin_top = 2.0
expand_margin_bottom = 3.0

[sub_resource type="StyleBoxEmpty" id=409]

[sub_resource type="StyleBoxEmpty" id=410]

[sub_resource type="StyleBoxLine" id=411]
color = Color( 1, 1, 1, 1 )
thickness = 2

[sub_resource type="AtlasTexture" id=412]
atlas = SubResource( 422 )
region = Rect2( 32, 0, 10, 10 )

[sub_resource type="StyleBoxEmpty" id=413]

[sub_resource type="StyleBoxFlat" id=414]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color( 0.494118, 0.517647, 0.545098, 1 )
expand_margin_left = 6.0
expand_margin_top = 6.0
expand_margin_bottom = 6.0

[sub_resource type="StreamTexture" id=415]
load_path = "res://.import/iconset_lerimama_theme.png-7ff4695cad905aee2e2e716d4a555101.stex"

[sub_resource type="AtlasTexture" id=423]
atlas = SubResource( 415 )
region = Rect2( 0, 4, 16, 8 )

[sub_resource type="StyleBoxTexture" id=416]
texture = SubResource( 423 )
region_rect = Rect2( 0, 0, 16, 8 )
margin_left = 3.34132
margin_right = 4.0
margin_top = 4.0
margin_bottom = 4.0
modulate_color = Color( 0.494118, 0.517647, 0.545098, 1 )

[sub_resource type="StyleBoxFlat" id=417]
bg_color = Color( 0, 0, 0, 0 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 1, 1, 1, 1 )

[sub_resource type="AtlasTexture" id=418]
atlas = SubResource( 422 )
region = Rect2( 16, 0, 16, 12 )
margin = Rect2( 4, 0, 0, 0 )

[sub_resource type="StyleBoxFlat" id=419]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 1, 1, 1, 0.901961 )
expand_margin_left = 6.0
expand_margin_right = 6.0
expand_margin_top = 2.0
expand_margin_bottom = 3.0

[sub_resource type="StyleBoxFlat" id=420]
bg_color = Color( 0, 0, 0, 0.862745 )
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 4
border_color = Color( 0.423529, 0.423529, 0.423529, 1 )

[sub_resource type="StyleBoxLine" id=421]
color = Color( 1, 1, 1, 1 )
thickness = 2
vertical = true

[sub_resource type="Theme" id=424]
default_font = ExtResource( 16 )
Button/colors/font_color = Color( 0.494118, 0.517647, 0.545098, 1 )
Button/colors/font_color_disabled = Color( 0.494118, 0.517647, 0.545098, 0.470588 )
Button/colors/font_color_focus = Color( 1, 1, 1, 1 )
Button/colors/font_color_hover = Color( 1, 1, 1, 1 )
Button/styles/disabled = SubResource( 405 )
Button/styles/focus = SubResource( 405 )
Button/styles/hover = SubResource( 405 )
Button/styles/normal = SubResource( 405 )
Button/styles/pressed = SubResource( 405 )
CheckBox/colors/font_color_focus = Color( 0.294118, 0.623529, 1, 1 )
CheckBox/colors/font_color_hover = Color( 0.996078, 0.976471, 0.545098, 1 )
CheckBox/colors/font_color_hover_pressed = Color( 0.368627, 1, 0.662745, 1 )
CheckBox/colors/font_color_pressed = Color( 0.494118, 0.517647, 0.545098, 1 )
CheckBox/constants/hseparation = 4
CheckBox/icons/checked = SubResource( 406 )
CheckBox/icons/unchecked = SubResource( 407 )
CheckBox/styles/focus = SubResource( 408 )
CheckBox/styles/hover = SubResource( 408 )
CheckBox/styles/hover_pressed = SubResource( 408 )
CheckBox/styles/normal = SubResource( 409 )
CheckBox/styles/pressed = SubResource( 410 )
HSeparator/styles/separator = SubResource( 411 )
HSlider/icons/grabber = SubResource( 412 )
HSlider/icons/grabber_disabled = null
HSlider/icons/grabber_highlight = SubResource( 412 )
HSlider/icons/tick = null
HSlider/styles/grabber_area = SubResource( 413 )
HSlider/styles/grabber_area_highlight = SubResource( 414 )
HSlider/styles/slider = SubResource( 416 )
Label/colors/font_color = Color( 0.980392, 0.980392, 0.980392, 1 )
Label/constants/line_spacing = 6
LineEdit/colors/font_color_selected = Color( 0, 0, 0, 1 )
LineEdit/colors/selection_color = Color( 0.72549, 0.737255, 0.764706, 1 )
LineEdit/styles/normal = SubResource( 417 )
OptionButton/colors/font_color = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_focus = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_hover = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_pressed = Color( 1, 1, 1, 1 )
OptionButton/icons/arrow = SubResource( 418 )
OptionButton/styles/focus = SubResource( 419 )
OptionButton/styles/hover = SubResource( 419 )
OptionButton/styles/pressed = SubResource( 419 )
Panel/styles/panel = SubResource( 420 )
VSeparator/styles/separator = SubResource( 421 )

[sub_resource type="AtlasTexture" id=425]
atlas = ExtResource( 11 )
region = Rect2( 72, 186, 22, 22 )
margin = Rect2( 0, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=426]
atlas = ExtResource( 11 )
region = Rect2( 0, 218, 40, 22 )
margin = Rect2( -2, 2, 0, 0 )

[sub_resource type="DynamicFont" id=141]
size = 341
font_data = ExtResource( 1 )

[sub_resource type="Animation" id=140]
length = 0.001
tracks/0/type = "value"
tracks/0/path = NodePath("Countdown/PositionControl/noz:text")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/keys = {
"times": PoolRealArray( 0 ),
"transitions": PoolRealArray( 1 ),
"update": 0,
"values": [ "05" ]
}

[sub_resource type="Animation" id=143]
resource_name = "countdown_3"
length = 5.0
step = 0.02
tracks/0/type = "value"
tracks/0/path = NodePath("Countdown/PositionControl/noz:text")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/keys = {
"times": PoolRealArray( 0, 0.6, 1.6, 2.6, 3.6, 5 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1 ),
"update": 1,
"values": [ "3", "3", "2", "1", "GO!", "GO!" ]
}
tracks/1/type = "value"
tracks/1/path = NodePath(".:modulate")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/keys = {
"times": PoolRealArray( 0, 0.6, 0.8, 4.8, 5 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ) ]
}
tracks/2/type = "value"
tracks/2/path = NodePath("Countdown/PositionControl:modulate")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/keys = {
"times": PoolRealArray( 0, 0.6, 0.8, 1.5, 1.6, 1.7, 1.8, 2.5, 2.6, 2.7, 2.8, 3.5, 3.6, 3.72, 3.82 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 0.368627, 1, 0.662745, 0 ), Color( 1, 1, 1, 1 ) ]
}
tracks/3/type = "value"
tracks/3/path = NodePath("Countdown/label:modulate:a")
tracks/3/interp = 1
tracks/3/loop_wrap = true
tracks/3/imported = false
tracks/3/enabled = true
tracks/3/keys = {
"times": PoolRealArray( 0.6, 0.8, 3.6, 3.7 ),
"transitions": PoolRealArray( 1, 1, 1, 1 ),
"update": 0,
"values": [ 0.0, 1.0, 1.0, 0.0 ]
}
tracks/4/type = "method"
tracks/4/path = NodePath(".")
tracks/4/interp = 1
tracks/4/loop_wrap = true
tracks/4/imported = false
tracks/4/enabled = true
tracks/4/keys = {
"times": PoolRealArray( 0.8, 1.8, 2.8, 3.82 ),
"transitions": PoolRealArray( 1, 1, 1, 1 ),
"values": [ {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_b_sound"
} ]
}

[sub_resource type="Animation" id=142]
resource_name = "countdown_5"
length = 7.0
step = 0.02
tracks/0/type = "value"
tracks/0/path = NodePath("Countdown/PositionControl/noz:text")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/keys = {
"times": PoolRealArray( 0, 0.6, 1.6, 2.6, 3.6, 4.6, 5.6, 7 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1, 1, 1 ),
"update": 1,
"values": [ "05", "05", "04", "03", "02", "01", "GO!", "GO!" ]
}
tracks/1/type = "value"
tracks/1/path = NodePath(".:modulate")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/keys = {
"times": PoolRealArray( 0, 0.6, 0.8, 6.8, 7 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ) ]
}
tracks/2/type = "value"
tracks/2/path = NodePath("Countdown/PositionControl:modulate")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/keys = {
"times": PoolRealArray( 0, 0.6, 0.8, 1.5, 1.6, 1.7, 1.8, 2.5, 2.6, 2.7, 2.8, 3.5, 3.6, 3.7, 3.8, 4.5, 4.6, 4.7, 4.8, 5.5, 5.6, 5.72, 5.82 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 0.368627, 1, 0.662745, 0 ), Color( 1, 1, 1, 1 ) ]
}
tracks/3/type = "value"
tracks/3/path = NodePath("Countdown/label:modulate:a")
tracks/3/interp = 1
tracks/3/loop_wrap = true
tracks/3/imported = false
tracks/3/enabled = true
tracks/3/keys = {
"times": PoolRealArray( 0.6, 0.8, 5.6, 5.7 ),
"transitions": PoolRealArray( 1, 1, 1, 1 ),
"update": 0,
"values": [ 0.0, 1.0, 1.0, 0.0 ]
}
tracks/4/type = "method"
tracks/4/path = NodePath(".")
tracks/4/interp = 1
tracks/4/loop_wrap = true
tracks/4/imported = false
tracks/4/enabled = true
tracks/4/keys = {
"times": PoolRealArray( 0.8, 1.8, 2.8, 3.8, 4.8, 5.8 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1 ),
"values": [ {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_a_sound"
}, {
"args": [  ],
"method": "play_countdown_b_sound"
} ]
}

[sub_resource type="Animation" id=135]
resource_name = "countdown_5_v1"
length = 7.6
step = 0.02
tracks/0/type = "value"
tracks/0/path = NodePath("Countdown/PositionControl/noz:text")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/keys = {
"times": PoolRealArray( 0, 1, 2, 3, 4, 5, 6, 7.6 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1, 1, 1 ),
"update": 1,
"values": [ "05", "05", "04", "03", "02", "01", "GO!", "GO!" ]
}
tracks/1/type = "value"
tracks/1/path = NodePath(".:modulate")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/keys = {
"times": PoolRealArray( 0, 0.8, 1, 7.4, 7.6 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ) ]
}
tracks/2/type = "value"
tracks/2/path = NodePath("Countdown/PositionControl:modulate")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/keys = {
"times": PoolRealArray( 0, 1.8, 1.9, 2, 2.1, 2.8, 2.9, 3, 3.1, 3.8, 3.9, 4, 4.1, 4.8, 4.9, 5, 5.1, 5.8, 5.9, 6.02, 6.12 ),
"transitions": PoolRealArray( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
"update": 0,
"values": [ Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 0 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 1 ), Color( 1, 1, 1, 0 ), Color( 0.368627, 1, 0.662745, 0 ), Color( 0.368627, 1, 0.662745, 1 ) ]
}
tracks/3/type = "value"
tracks/3/path = NodePath("Countdown/label:modulate:a")
tracks/3/interp = 1
tracks/3/loop_wrap = true
tracks/3/imported = false
tracks/3/enabled = true
tracks/3/keys = {
"times": PoolRealArray( 0.8, 1, 5.8, 5.9 ),
"transitions": PoolRealArray( 1, 1, 1, 1 ),
"update": 0,
"values": [ 0.0, 1.0, 1.0, 0.0 ]
}

[sub_resource type="AtlasTexture" id=147]
atlas = ExtResource( 7 )
region = Rect2( 0, 0, 16, 16 )

[sub_resource type="StreamTexture" id=144]
load_path = "res://.import/atlas_hud.png-e7dc1fba151c6637ba4698f0439dac44.stex"

[sub_resource type="AtlasTexture" id=123]
atlas = SubResource( 144 )
region = Rect2( 0, 16, 16, 16 )

[sub_resource type="AtlasTexture" id=122]
atlas = ExtResource( 7 )
region = Rect2( 0, 0, 16, 16 )

[sub_resource type="AtlasTexture" id=125]
atlas = ExtResource( 7 )
region = Rect2( 18, 48, 10, 16 )
margin = Rect2( -1, 0, 0, 0 )

[sub_resource type="AtlasTexture" id=126]
atlas = ExtResource( 7 )
region = Rect2( 32, 64, 48, 16 )

[sub_resource type="AtlasTexture" id=132]
atlas = ExtResource( 7 )
region = Rect2( 32, 80, 48, 16 )

[sub_resource type="StyleBoxEmpty" id=248]

[sub_resource type="AtlasTexture" id=129]
atlas = ExtResource( 7 )
region = Rect2( 64, 0, 16, 16 )

[sub_resource type="AtlasTexture" id=269]
atlas = ExtResource( 7 )
region = Rect2( 16, 0, 16, 16 )

[sub_resource type="AtlasTexture" id=268]
atlas = ExtResource( 7 )
region = Rect2( 48, 16, 16, 16 )

[sub_resource type="AtlasTexture" id=130]
atlas = ExtResource( 7 )
region = Rect2( 64, 16, 16, 16 )

[sub_resource type="AtlasTexture" id=131]
atlas = ExtResource( 7 )
region = Rect2( 64, 32, 16, 16 )

[sub_resource type="StyleBoxEmpty" id=275]

[sub_resource type="StreamTexture" id=175]
load_path = "res://.import/iconset_lerimama_theme.png-7ff4695cad905aee2e2e716d4a555101.stex"

[sub_resource type="AtlasTexture" id=276]
atlas = SubResource( 175 )
region = Rect2( 16, 16, 14, 16 )

[sub_resource type="AtlasTexture" id=349]
atlas = SubResource( 175 )
region = Rect2( 0, 16, 10, 16 )

[sub_resource type="StyleBoxFlat" id=278]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color( 0.494118, 0.517647, 0.545098, 1 )
expand_margin_left = 6.0
expand_margin_right = 6.0
expand_margin_top = 2.0
expand_margin_bottom = 3.0

[sub_resource type="StyleBoxEmpty" id=279]

[sub_resource type="StyleBoxEmpty" id=280]

[sub_resource type="StyleBoxLine" id=281]
color = Color( 1, 1, 1, 1 )
thickness = 2

[sub_resource type="AtlasTexture" id=350]
atlas = SubResource( 175 )
region = Rect2( 32, 0, 10, 10 )

[sub_resource type="StyleBoxEmpty" id=283]

[sub_resource type="StyleBoxFlat" id=351]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color( 0.494118, 0.517647, 0.545098, 1 )
expand_margin_left = 6.0
expand_margin_top = 6.0
expand_margin_bottom = 6.0

[sub_resource type="StreamTexture" id=352]
load_path = "res://.import/iconset_lerimama_theme.png-7ff4695cad905aee2e2e716d4a555101.stex"

[sub_resource type="AtlasTexture" id=152]
atlas = SubResource( 352 )
region = Rect2( 0, 4, 16, 8 )

[sub_resource type="StyleBoxTexture" id=353]
texture = SubResource( 152 )
region_rect = Rect2( 0, 0, 16, 8 )
margin_left = 3.34132
margin_right = 4.0
margin_top = 4.0
margin_bottom = 4.0
modulate_color = Color( 0.494118, 0.517647, 0.545098, 1 )

[sub_resource type="StyleBoxFlat" id=354]
bg_color = Color( 0, 0, 0, 0 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 1, 1, 1, 1 )

[sub_resource type="AtlasTexture" id=355]
atlas = SubResource( 175 )
region = Rect2( 16, 0, 16, 12 )
margin = Rect2( 4, 0, 0, 0 )

[sub_resource type="StyleBoxFlat" id=356]
bg_color = Color( 0.6, 0.6, 0.6, 0 )
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color( 1, 1, 1, 0.901961 )
expand_margin_left = 6.0
expand_margin_right = 6.0
expand_margin_top = 2.0
expand_margin_bottom = 3.0

[sub_resource type="StyleBoxFlat" id=357]
bg_color = Color( 0, 0, 0, 0.862745 )
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 4
border_color = Color( 0.423529, 0.423529, 0.423529, 1 )

[sub_resource type="StyleBoxLine" id=358]
color = Color( 1, 1, 1, 1 )
thickness = 2
vertical = true

[sub_resource type="Theme" id=194]
default_font = ExtResource( 16 )
Button/colors/font_color = Color( 0.494118, 0.517647, 0.545098, 1 )
Button/colors/font_color_disabled = Color( 0.494118, 0.517647, 0.545098, 0.470588 )
Button/colors/font_color_focus = Color( 1, 1, 1, 1 )
Button/colors/font_color_hover = Color( 1, 1, 1, 1 )
Button/styles/disabled = SubResource( 275 )
Button/styles/focus = SubResource( 275 )
Button/styles/hover = SubResource( 275 )
Button/styles/normal = SubResource( 275 )
Button/styles/pressed = SubResource( 275 )
CheckBox/colors/font_color_focus = Color( 0.294118, 0.623529, 1, 1 )
CheckBox/colors/font_color_hover = Color( 0.996078, 0.976471, 0.545098, 1 )
CheckBox/colors/font_color_hover_pressed = Color( 0.368627, 1, 0.662745, 1 )
CheckBox/colors/font_color_pressed = Color( 0.494118, 0.517647, 0.545098, 1 )
CheckBox/constants/hseparation = 4
CheckBox/icons/checked = SubResource( 276 )
CheckBox/icons/unchecked = SubResource( 349 )
CheckBox/styles/focus = SubResource( 278 )
CheckBox/styles/hover = SubResource( 278 )
CheckBox/styles/hover_pressed = SubResource( 278 )
CheckBox/styles/normal = SubResource( 279 )
CheckBox/styles/pressed = SubResource( 280 )
HSeparator/styles/separator = SubResource( 281 )
HSlider/icons/grabber = SubResource( 350 )
HSlider/icons/grabber_disabled = null
HSlider/icons/grabber_highlight = SubResource( 350 )
HSlider/icons/tick = null
HSlider/styles/grabber_area = SubResource( 283 )
HSlider/styles/grabber_area_highlight = SubResource( 351 )
HSlider/styles/slider = SubResource( 353 )
Label/colors/font_color = Color( 0.980392, 0.980392, 0.980392, 1 )
Label/constants/line_spacing = 6
LineEdit/colors/font_color_selected = Color( 0, 0, 0, 1 )
LineEdit/colors/selection_color = Color( 0.72549, 0.737255, 0.764706, 1 )
LineEdit/styles/normal = SubResource( 354 )
OptionButton/colors/font_color = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_focus = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_hover = Color( 1, 1, 1, 0.901961 )
OptionButton/colors/font_color_pressed = Color( 1, 1, 1, 1 )
OptionButton/icons/arrow = SubResource( 355 )
OptionButton/styles/focus = SubResource( 356 )
OptionButton/styles/hover = SubResource( 356 )
OptionButton/styles/pressed = SubResource( 356 )
Panel/styles/panel = SubResource( 357 )
VSeparator/styles/separator = SubResource( 358 )

[sub_resource type="AtlasTexture" id=148]
atlas = ExtResource( 7 )
region = Rect2( 2, 84, 14, 12 )
margin = Rect2( 0, 3, 0, 0 )

[sub_resource type="AtlasTexture" id=146]
atlas = ExtResource( 7 )
region = Rect2( 18, 84, 14, 12 )
margin = Rect2( 0, 3, 0, 0 )

[sub_resource type="AtlasTexture" id=128]
atlas = ExtResource( 7 )
region = Rect2( 16, 16, 16, 16 )

[sub_resource type="AtlasTexture" id=127]
atlas = ExtResource( 7 )
region = Rect2( 16, 0, 16, 16 )

[sub_resource type="AtlasTexture" id=192]
atlas = ExtResource( 11 )
region = Rect2( 0, 98, 70, 46 )

[sub_resource type="AtlasTexture" id=193]
atlas = ExtResource( 11 )
region = Rect2( 80, 98, 70, 46 )

[sub_resource type="StreamTexture" id=325]
load_path = "res://.import/atlas_controls.png-75e6b40869d487066545840672dcb98d.stex"

[sub_resource type="AtlasTexture" id=206]
atlas = SubResource( 325 )
region = Rect2( 0, 0, 120, 86 )

[sub_resource type="AtlasTexture" id=195]
atlas = ExtResource( 11 )
region = Rect2( 10, 17, 22, 22 )

[sub_resource type="AtlasTexture" id=196]
atlas = ExtResource( 11 )
region = Rect2( 30, 40, 18, 18 )

[sub_resource type="AtlasTexture" id=197]
atlas = ExtResource( 11 )
region = Rect2( 96, 32, 10, 10 )

[sub_resource type="AtlasTexture" id=235]
atlas = ExtResource( 11 )
region = Rect2( 0, 154, 102, 22 )

[sub_resource type="AtlasTexture" id=236]
atlas = ExtResource( 11 )
region = Rect2( 114, 154, 22, 22 )

[sub_resource type="AtlasTexture" id=237]
atlas = ExtResource( 11 )
region = Rect2( 138, 154, 22, 22 )

[sub_resource type="AtlasTexture" id=184]
atlas = ExtResource( 11 )
region = Rect2( 0, 186, 22, 22 )
margin = Rect2( 0, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=185]
atlas = ExtResource( 11 )
region = Rect2( 85, 218, 22, 22 )
margin = Rect2( -2, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=186]
atlas = ExtResource( 11 )
region = Rect2( 24, 186, 22, 22 )
margin = Rect2( 0, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=187]
atlas = ExtResource( 11 )
region = Rect2( 109, 218, 22, 22 )
margin = Rect2( -2, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=188]
atlas = ExtResource( 11 )
region = Rect2( 48, 186, 22, 22 )
margin = Rect2( 0, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=189]
atlas = ExtResource( 11 )
region = Rect2( 42, 218, 41, 22 )
margin = Rect2( -2, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=190]
atlas = ExtResource( 11 )
region = Rect2( 72, 186, 22, 22 )
margin = Rect2( 0, 2, 0, 0 )

[sub_resource type="AtlasTexture" id=191]
atlas = ExtResource( 11 )
region = Rect2( 0, 218, 40, 22 )
margin = Rect2( -2, 2, 0, 0 )

[node name="PatternsGame" type="Node2D"]
__meta__ = {
"_edit_horizontal_guides_": [ 1371.0, 1371.0, 208.0, 576.0, 224.0 ],
"_edit_vertical_guides_": [ 320.0, 336.0 ]
}

[node name="GameManager" type="Node" parent="."]
script = ExtResource( 20 )

[node name="Spectrum" type="TextureRect" parent="GameManager"]
visible = false
margin_top = -24.0
margin_right = 512.0
margin_bottom = -8.0
texture = ExtResource( 18 )
expand = true

[node name="SpectrumGradient" type="TextureRect" parent="GameManager"]
visible = false
margin_top = -48.0
margin_right = 512.0
margin_bottom = -32.0
size_flags_horizontal = 0
texture = SubResource( 226 )
expand = true

[node name="GameView" type="VBoxContainer" parent="."]
margin_right = 1280.0
margin_bottom = 720.0
custom_constants/separation = 0

[node name="ViewHeder" type="ColorRect" parent="GameView"]
unique_name_in_owner = true
margin_right = 1280.0
rect_min_size = Vector2( 1280, 0 )

[node name="Viewports" type="HBoxContainer" parent="GameView"]
margin_right = 1280.0
margin_bottom = 720.0
size_flags_horizontal = 3
size_flags_vertical = 3
custom_constants/separation = 0

[node name="ViewportContainer1" type="ViewportContainer" parent="GameView/Viewports"]
margin_right = 639.0
margin_bottom = 720.0
size_flags_horizontal = 3
size_flags_vertical = 3
stretch = true

[node name="Viewport1" type="Viewport" parent="GameView/Viewports/ViewportContainer1"]
unique_name_in_owner = true
size = Vector2( 639, 720 )
handle_input_locally = false
render_target_update_mode = 3

[node name="Arena" parent="GameView/Viewports/ViewportContainer1/Viewport1" instance=ExtResource( 23 )]
__meta__ = {
"_edit_horizontal_guides_": [ 44.0, 32.0, 20.0, 64.0, 660.0, 688.0, 676.0, 648.0 ]
}

[node name="PlayerCamera" parent="GameView/Viewports/ViewportContainer1/Viewport1" instance=ExtResource( 22 )]

[node name="ViewportSeparator" type="VSeparator" parent="GameView/Viewports"]
unique_name_in_owner = true
margin_left = 639.0
margin_right = 641.0
margin_bottom = 720.0
custom_constants/separation = 2
custom_styles/separator = SubResource( 228 )

[node name="ViewportContainer2" type="ViewportContainer" parent="GameView/Viewports"]
unique_name_in_owner = true
margin_left = 641.0
margin_right = 1280.0
margin_bottom = 720.0
size_flags_horizontal = 3
size_flags_vertical = 3
stretch = true

[node name="Viewport2" type="Viewport" parent="GameView/Viewports/ViewportContainer2"]
unique_name_in_owner = true
size = Vector2( 639, 720 )
handle_input_locally = false
render_target_update_mode = 3

[node name="PlayerCamera" parent="GameView/Viewports/ViewportContainer2/Viewport2" instance=ExtResource( 22 )]

[node name="ViewFuter" type="ColorRect" parent="GameView"]
unique_name_in_owner = true
margin_top = 720.0
margin_right = 1280.0
margin_bottom = 720.0
grow_horizontal = 0
rect_min_size = Vector2( 1280, 0 )

[node name="Minimap" type="ViewportContainer" parent="."]
modulate = Color( 1, 1, 1, 0.784314 )
margin_left = 992.0
margin_top = 72.0
margin_right = 1248.0
margin_bottom = 216.0
size_flags_horizontal = 3

[node name="MinimapViewport" type="Viewport" parent="Minimap"]
size = Vector2( 256, 144 )
transparent_bg = true
handle_input_locally = false
render_target_update_mode = 3

[node name="MinimapCam" type="Camera2D" parent="Minimap/MinimapViewport"]
current = true
zoom = Vector2( 30, 30 )
limit_smoothed = true
script = ExtResource( 14 )

[node name="GUI" type="Control" parent="."]
margin_right = 1280.0
margin_bottom = 720.0
theme = ExtResource( 2 )
__meta__ = {
"_editor_description_": ""
}

[node name="Hud" type="Control" parent="GUI"]
anchor_right = 1.0
anchor_bottom = 1.0
rect_min_size = Vector2( 1280, 720 )
script = ExtResource( 19 )

[node name="Popups" type="Control" parent="GUI/Hud"]
anchor_right = 1.0
anchor_bottom = 1.0

[node name="EnergyWarning" type="Control" parent="GUI/Hud/Popups"]
visible = false
anchor_right = 1.0
margin_top = 72.0
margin_bottom = 136.0
__meta__ = {
"_edit_group_": true
}

[node name="Solo" type="Control" parent="GUI/Hud/Popups/EnergyWarning"]
visible = false
anchor_left = 0.5
anchor_right = 0.5
margin_left = -288.0
margin_right = 288.0
margin_bottom = 64.0
__meta__ = {
"_edit_group_": true
}

[node name="Panel" type="Panel" parent="GUI/Hud/Popups/EnergyWarning/Solo"]
anchor_right = 1.0
anchor_bottom = 1.0
custom_styles/panel = SubResource( 239 )

[node name="StepsRemaining" type="Label" parent="GUI/Hud/Popups/EnergyWarning/Solo"]
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_top = 0.5
anchor_right = 1.0
anchor_bottom = 0.5
margin_left = 21.0
margin_top = -11.0
margin_right = -21.0
margin_bottom = 11.0
grow_horizontal = 2
size_flags_horizontal = 3
text = "NO ENERGY! Collect a color to revitalize."
align = 1

[node name="DuelP1" type="Control" parent="GUI/Hud/Popups/EnergyWarning"]
visible = false
anchor_left = 0.5
anchor_right = 0.5
margin_left = -598.0
margin_top = 11.0
margin_right = -43.0
margin_bottom = 53.0
__meta__ = {
"_edit_group_": true
}

[node name="Panel" type="Panel" parent="GUI/Hud/Popups/EnergyWarning/DuelP1"]
anchor_right = 1.0
anchor_bottom = 1.0
custom_styles/panel = SubResource( 239 )

[node name="StepsRemaining" type="Label" parent="GUI/Hud/Popups/EnergyWarning/DuelP1"]
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_top = 0.5
anchor_right = 1.0
anchor_bottom = 0.5
margin_left = 21.0
margin_top = -11.0
margin_right = -21.0
margin_bottom = 11.0
grow_horizontal = 2
size_flags_horizontal = 3
text = "NO ENERGY! Collect a color to revitalize."
align = 1

[node name="DuelP2" type="Control" parent="GUI/Hud/Popups/EnergyWarning"]
visible = false
anchor_left = 0.5
anchor_right = 0.5
margin_left = 43.0
margin_top = 11.0
margin_right = 598.0
margin_bottom = 53.0
__meta__ = {
"_edit_group_": true
}

[node name="Panel" type="Panel" parent="GUI/Hud/Popups/EnergyWarning/DuelP2"]
anchor_right = 1.0
anchor_bottom = 1.0
custom_styles/panel = SubResource( 239 )

[node name="StepsRemaining" type="Label" parent="GUI/Hud/Popups/EnergyWarning/DuelP2"]
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_top = 0.5
anchor_right = 1.0
anchor_bottom = 0.5
margin_left = 21.0
margin_top = -11.0
margin_right = -21.0
margin_bottom = 11.0
grow_horizontal = 2
size_flags_horizontal = 3
text = "NO ENERGY! Collect a color to revitalize."
align = 1

[node name="Instructions" type="Control" parent="GUI/Hud/Popups"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Background" type="ColorRect" parent="GUI/Hud/Popups/Instructions"]
anchor_right = 1.0
anchor_bottom = 1.0
size_flags_horizontal = 3
size_flags_vertical = 3
color = Color( 0, 0, 0, 0.784314 )

[node name="GameInstructions" type="Control" parent="GUI/Hud/Popups/Instructions"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -448.0
margin_top = -240.0
margin_right = 448.0
margin_bottom = 16.0

[node name="Title" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
anchor_left = 0.5
anchor_right = 0.5
margin_left = -304.0
margin_top = 6.0
margin_right = 304.0
margin_bottom = 38.0
custom_fonts/font = ExtResource( 3 )
text = "Game title"
align = 1

[node name="WinLabel" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
anchor_right = 1.0
margin_top = 54.0
margin_bottom = 76.0
text = "Win"
align = 1

[node name="Outline" type="VBoxContainer" parent="GUI/Hud/Popups/Instructions/GameInstructions"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -448.0
margin_top = 101.0
margin_right = 449.0
margin_bottom = 288.0
grow_horizontal = 2
grow_vertical = 2
custom_constants/separation = 10

[node name="Label" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_right = 897.0
margin_bottom = 18.0
custom_fonts/font = ExtResource( 4 )
text = "Game over conditions"
align = 1
autowrap = true

[node name="Label2" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_top = 28.0
margin_right = 897.0
margin_bottom = 46.0
custom_fonts/font = ExtResource( 4 )
text = "Energy and speed"
align = 1
autowrap = true

[node name="Label3" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_top = 56.0
margin_right = 897.0
margin_bottom = 74.0
custom_fonts/font = ExtResource( 4 )
text = "Burst"
align = 1
autowrap = true

[node name="Label4" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_top = 84.0
margin_right = 897.0
margin_bottom = 102.0
custom_fonts/font = ExtResource( 4 )
text = "Skills"
align = 1
autowrap = true

[node name="Label5" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_top = 112.0
margin_right = 897.0
margin_bottom = 130.0
custom_fonts/font = ExtResource( 4 )
text = "Time"
align = 1
autowrap = true

[node name="Label6" type="Label" parent="GUI/Hud/Popups/Instructions/GameInstructions/Outline"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
margin_top = 140.0
margin_right = 897.0
margin_bottom = 158.0
custom_fonts/font = ExtResource( 4 )
text = "Highscore"
align = 1
autowrap = true

[node name="Controls" type="Control" parent="GUI/Hud/Popups/Instructions"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -320.0
margin_top = 64.0
margin_right = 320.0
margin_bottom = 192.0
__meta__ = {
"_edit_group_": true
}

[node name="Keys" type="Control" parent="GUI/Hud/Popups/Instructions/Controls"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -192.0
margin_top = -41.5
margin_bottom = 47.5
__meta__ = {
"_edit_group_": true
}

[node name="KeyboardL" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -80.0
margin_top = 1.0
margin_right = -10.0
margin_bottom = 47.0
texture = SubResource( 359 )

[node name="KeyboardR" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = 10.0
margin_top = 1.0
margin_right = 80.0
margin_bottom = 47.0
texture = SubResource( 360 )

[node name="Ctrl" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -88.0
margin_top = 65.0
margin_right = -66.0
margin_bottom = 87.0
texture = SubResource( 361 )

[node name="Space" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -52.0
margin_top = 65.0
margin_right = 50.0
margin_bottom = 87.0
texture = SubResource( 362 )

[node name="Alt" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = 66.0
margin_top = 65.0
margin_right = 88.0
margin_bottom = 87.0
texture = SubResource( 363 )

[node name="Joypad" type="Control" parent="GUI/Hud/Popups/Instructions/Controls"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 73.0
margin_top = -40.0
margin_right = 193.0
margin_bottom = 46.0
__meta__ = {
"_edit_group_": true
}

[node name="jp" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Joypad"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_right = 120.0
margin_bottom = 86.0
texture = SubResource( 366 )

[node name="btns" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Joypad"]
margin_left = 10.0
margin_top = 17.0
margin_right = 32.0
margin_bottom = 39.0
texture = SubResource( 367 )

[node name="btn" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Joypad"]
margin_left = 96.0
margin_top = 32.0
margin_right = 106.0
margin_bottom = 42.0
texture = SubResource( 368 )

[node name="C1" type="TextureRect" parent="GUI/Hud/Popups/Instructions/Controls/Joypad"]
visible = false
margin_left = 57.0
margin_top = 76.0
margin_right = 63.0
margin_bottom = 86.0
texture = SubResource( 369 )

[node name="ControlsDuel" type="Control" parent="GUI/Hud/Popups/Instructions"]
visible = false
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -576.0
margin_top = 56.0
margin_right = 576.0
margin_bottom = 216.0
__meta__ = {
"_edit_group_": true
}

[node name="Label" type="Label" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -373.0
margin_top = -74.0
margin_right = -268.0
margin_bottom = -52.0
text = "PLAYER 1"
align = 1

[node name="Keys" type="Control" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -480.0
margin_top = -25.5
margin_right = -288.0
margin_bottom = 63.5
__meta__ = {
"_edit_group_": true
}

[node name="KeyboardL" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -54.0
margin_top = 1.0
margin_right = 16.0
margin_bottom = 47.0
texture = SubResource( 359 )

[node name="Ctrl" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -88.0
margin_top = 65.0
margin_right = -66.0
margin_bottom = 87.0
texture = SubResource( 361 )

[node name="Space" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Keys"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -52.0
margin_top = 65.0
margin_right = 50.0
margin_bottom = 87.0
texture = SubResource( 362 )

[node name="Joypad" type="Control" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -288.0
margin_top = -24.0
margin_right = -168.0
margin_bottom = 62.0
__meta__ = {
"_edit_group_": true
}

[node name="jp" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_right = 120.0
margin_bottom = 86.0
texture = SubResource( 366 )

[node name="btns" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad"]
margin_left = 10.0
margin_top = 17.0
margin_right = 32.0
margin_bottom = 39.0
texture = SubResource( 367 )

[node name="btn" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad"]
margin_left = 96.0
margin_top = 32.0
margin_right = 106.0
margin_bottom = 42.0
texture = SubResource( 368 )

[node name="C1" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad"]
margin_left = 57.0
margin_top = 76.0
margin_right = 63.0
margin_bottom = 86.0
texture = SubResource( 369 )

[node name="Label2" type="Label" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
modulate = Color( 0.980392, 0.980392, 0.980392, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 268.0
margin_top = -74.0
margin_right = 376.0
margin_bottom = -52.0
text = "PLAYER 2"
align = 1

[node name="Keys2" type="Control" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 216.0
margin_top = -24.0
margin_right = 296.0
margin_bottom = 72.0
__meta__ = {
"_edit_group_": true
}

[node name="KeyboardR" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Keys2"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -40.0
margin_right = 30.0
margin_bottom = 46.0
texture = SubResource( 360 )

[node name="Alt" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Keys2"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -16.0
margin_top = 64.0
margin_right = 6.0
margin_bottom = 86.0
texture = SubResource( 363 )

[node name="Joypad2" type="Control" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 336.0
margin_top = -24.0
margin_right = 456.0
margin_bottom = 62.0
__meta__ = {
"_edit_group_": true
}

[node name="jp" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad2"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_right = 120.0
margin_bottom = 86.0
texture = SubResource( 366 )

[node name="btns" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad2"]
margin_left = 10.0
margin_top = 17.0
margin_right = 32.0
margin_bottom = 39.0
texture = SubResource( 367 )

[node name="btn" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad2"]
margin_left = 96.0
margin_top = 32.0
margin_right = 106.0
margin_bottom = 42.0
texture = SubResource( 368 )

[node name="C1" type="TextureRect" parent="GUI/Hud/Popups/Instructions/ControlsDuel/Joypad2"]
margin_left = 57.0
margin_top = 76.0
margin_right = 63.0
margin_bottom = 86.0
texture = SubResource( 369 )

[node name="ScreenLine" type="Node2D" parent="GUI/Hud/Popups/Instructions/ControlsDuel"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
position = Vector2( 576, -56 )

[node name="Line2D" type="Line2D" parent="GUI/Hud/Popups/Instructions/ControlsDuel/ScreenLine"]
position = Vector2( -576, 240 )
points = PoolVector2Array( 576, 64, 576, 120 )
width = 1.0
default_color = Color( 1, 1, 1, 1 )

[node name="Line2D2" type="Line2D" parent="GUI/Hud/Popups/Instructions/ControlsDuel/ScreenLine"]
position = Vector2( -576, 176 )
points = PoolVector2Array( 576, 56, 576, -128 )
width = 1.0
default_color = Color( 1, 1, 1, 1 )

[node name="Line2D3" type="Line2D" parent="GUI/Hud/Popups/Instructions/ControlsDuel/ScreenLine"]
position = Vector2( -576, 176 )
points = PoolVector2Array( 576, -536, 576, -432 )
width = 1.0
default_color = Color( 1, 1, 1, 1 )

[node name="StartHint" type="HBoxContainer" parent="GUI/Hud/Popups/Instructions"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -73.0
margin_top = 616.0
margin_right = 103.0
margin_bottom = 638.0
custom_constants/separation = 8
__meta__ = {
"_edit_group_": true
}

[node name="Label" type="Label" parent="GUI/Hud/Popups/Instructions/StartHint"]
visible = false
margin_top = 2.0
margin_right = 44.0
margin_bottom = 20.0
theme = SubResource( 424 )
custom_colors/font_color = Color( 0.513726, 0.513726, 0.513726, 1 )
custom_fonts/font = ExtResource( 4 )
text = "Press"
align = 1

[node name="Enter" type="TextureRect" parent="GUI/Hud/Popups/Instructions/StartHint"]
margin_right = 22.0
margin_bottom = 22.0
texture = SubResource( 425 )

[node name="Label3" type="Label" parent="GUI/Hud/Popups/Instructions/StartHint"]
margin_left = 30.0
margin_top = 2.0
margin_right = 47.0
margin_bottom = 20.0
theme = SubResource( 424 )
custom_colors/font_color = Color( 0.513726, 0.513726, 0.513726, 1 )
custom_fonts/font = ExtResource( 4 )
text = "or"
align = 1

[node name="Start" type="TextureRect" parent="GUI/Hud/Popups/Instructions/StartHint"]
margin_left = 55.0
margin_right = 95.0
margin_bottom = 22.0
texture = SubResource( 426 )

[node name="Button" type="Button" parent="GUI/Hud/Popups/Instructions/StartHint/Start"]
margin_left = -58.0
margin_right = 122.0
margin_bottom = 26.0
mouse_default_cursor_shape = 2

[node name="Label2" type="Label" parent="GUI/Hud/Popups/Instructions/StartHint"]
margin_left = 103.0
margin_top = 2.0
margin_right = 170.0
margin_bottom = 20.0
theme = SubResource( 424 )
custom_colors/font_color = Color( 0.513726, 0.513726, 0.513726, 1 )
custom_fonts/font = ExtResource( 4 )
text = "to start"

[node name="GameCountdown" type="Control" parent="GUI/Hud/Popups"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
rect_min_size = Vector2( 1280, 720 )
size_flags_horizontal = 3
size_flags_vertical = 3
script = ExtResource( 6 )

[node name="Background" type="ColorRect" parent="GUI/Hud/Popups/GameCountdown"]
anchor_right = 1.0
anchor_bottom = 1.0
size_flags_horizontal = 3
size_flags_vertical = 3
color = Color( 0, 0, 0, 0.54902 )

[node name="Countdown" type="VBoxContainer" parent="GUI/Hud/Popups/GameCountdown"]
margin_left = 511.0
margin_top = 237.0
margin_right = 771.0
margin_bottom = 263.0
custom_constants/separation = 0

[node name="label" type="Label" parent="GUI/Hud/Popups/GameCountdown/Countdown"]
visible = false
modulate = Color( 1, 1, 1, 0 )
margin_right = 260.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "LEVEL 01 STARTS IN ..."
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="PositionControl" type="Control" parent="GUI/Hud/Popups/GameCountdown/Countdown"]
margin_right = 260.0
margin_bottom = 26.0
size_flags_vertical = 3

[node name="noz" type="Label" parent="GUI/Hud/Popups/GameCountdown/Countdown/PositionControl"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -171.0
margin_top = -38.0
margin_right = 191.0
margin_bottom = 197.0
size_flags_vertical = 8
custom_fonts/font = SubResource( 141 )
text = "05"
align = 1
valign = 2

[node name="AnimationPlayer" type="AnimationPlayer" parent="GUI/Hud/Popups/GameCountdown"]
anims/RESET = SubResource( 140 )
anims/countdown_3 = SubResource( 143 )
anims/countdown_5 = SubResource( 142 )
anims/countdown_5_v1 = SubResource( 135 )

[node name="Life" type="Label" parent="GUI/Hud"]
visible = false
margin_left = 32.0
margin_top = 69.0
margin_right = 114.0
margin_bottom = 91.0
text = "LIFE: 0"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Energy" type="Label" parent="GUI/Hud"]
visible = false
margin_left = 136.0
margin_top = 69.0
margin_right = 180.0
margin_bottom = 91.0
text = "E: 0"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Header" type="Control" parent="GUI/Hud"]
anchor_right = 1.0
margin_bottom = 40.0

[node name="HeaderUndi" type="ColorRect" parent="GUI/Hud/Header"]
anchor_right = 1.0
anchor_bottom = 1.0
color = Color( 0.0784314, 0.0784314, 0.0784314, 1 )

[node name="TopLineL" type="HBoxContainer" parent="GUI/Hud/Header"]
margin_left = 32.0
margin_top = 7.0
margin_right = 462.0
margin_bottom = 29.0
custom_constants/separation = 16
__meta__ = {
"_edit_group_": true
}

[node name="PlayerLabel" type="Label" parent="GUI/Hud/Header/TopLineL"]
visible = false
margin_right = 24.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_colors/font_color = Color( 0.494118, 0.517647, 0.545098, 1 )
text = "P1"
valign = 1
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="LifeIcons" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
margin_top = 3.0
margin_right = 52.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 19 )
size_flags_vertical = 8
custom_constants/separation = 2
script = ExtResource( 9 )

[node name="LifeIcon" type="Control" parent="GUI/Hud/Header/TopLineL/LifeIcons"]
margin_top = 1.0
margin_right = 16.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 147 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="LifeIcon2" type="Control" parent="GUI/Hud/Header/TopLineL/LifeIcons"]
margin_left = 18.0
margin_top = 1.0
margin_right = 34.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon2"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 122 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon2"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="LifeIcon3" type="Control" parent="GUI/Hud/Header/TopLineL/LifeIcons"]
margin_left = 36.0
margin_top = 1.0
margin_right = 52.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon3"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 122 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineL/LifeIcons/LifeIcon3"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="EnergyBar" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
margin_left = 68.0
margin_top = 3.0
margin_right = 132.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 19 )
size_flags_vertical = 8
custom_constants/separation = 6
script = ExtResource( 8 )

[node name="TextureRect7" type="TextureRect" parent="GUI/Hud/Header/TopLineL/EnergyBar"]
margin_top = 1.0
margin_right = 10.0
margin_bottom = 19.0
rect_min_size = Vector2( 0, 18 )
size_flags_vertical = 8
texture = SubResource( 125 )

[node name="TextureProgress" type="TextureProgress" parent="GUI/Hud/Header/TopLineL/EnergyBar"]
margin_left = 16.0
margin_top = 1.0
margin_right = 64.0
margin_bottom = 19.0
rect_min_size = Vector2( 0, 18 )
size_flags_vertical = 8
max_value = 192.0
step = 8.0
texture_over = SubResource( 126 )
texture_progress = SubResource( 132 )

[node name="VSeparator" type="VSeparator" parent="GUI/Hud/Header/TopLineL"]
visible = false
margin_left = 148.0
margin_right = 148.0
margin_bottom = 22.0
custom_constants/separation = 0
custom_styles/separator = SubResource( 248 )

[node name="PointsHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
margin_left = 148.0
margin_right = 186.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 22 )
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect4" type="TextureRect" parent="GUI/Hud/Header/TopLineL/PointsHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 129 )

[node name="Points" type="Label" parent="GUI/Hud/Header/TopLineL/PointsHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="ColorHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
margin_left = 202.0
margin_right = 240.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineL/ColorHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 269 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineL/ColorHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="StepsHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
visible = false
margin_left = 272.0
margin_right = 310.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineL/StepsHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 268 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineL/StepsHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="SkillHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
visible = false
margin_left = 326.0
margin_right = 364.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineL/SkillHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 130 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineL/SkillHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="BurstHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineL"]
visible = false
margin_left = 380.0
margin_right = 418.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect6" type="TextureRect" parent="GUI/Hud/Header/TopLineL/BurstHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 131 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineL/BurstHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="GameTimer" type="HBoxContainer" parent="GUI/Hud/Header"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -38.0
margin_top = 7.0
margin_right = 40.0
margin_bottom = 29.0
grow_horizontal = 2
theme = SubResource( 194 )
script = ExtResource( 13 )
__meta__ = {
"_edit_group_": true
}

[node name="Mins" type="Label" parent="GUI/Hud/Header/GameTimer"]
margin_right = 32.0
margin_bottom = 22.0
grow_horizontal = 0
rect_min_size = Vector2( 32, 0 )
size_flags_horizontal = 3
size_flags_vertical = 8
text = "00"
align = 2
valign = 2

[node name="Dots" type="Label" parent="GUI/Hud/Header/GameTimer"]
margin_left = 36.0
margin_right = 42.0
margin_bottom = 22.0
rect_min_size = Vector2( 6, 0 )
size_flags_vertical = 8
text = ":"
align = 1
valign = 2

[node name="Secs" type="Label" parent="GUI/Hud/Header/GameTimer"]
margin_left = 46.0
margin_right = 78.0
margin_bottom = 22.0
rect_min_size = Vector2( 32, 0 )
size_flags_vertical = 8
text = "00"
valign = 2

[node name="Timer" type="Timer" parent="GUI/Hud/Header/GameTimer"]

[node name="TopLineR" type="HBoxContainer" parent="GUI/Hud/Header"]
anchor_left = 1.0
anchor_right = 1.0
margin_left = -586.0
margin_top = 7.0
margin_right = -30.0
margin_bottom = 29.0
grow_horizontal = 0
alignment = 2

[node name="MusicPlayer" type="Label" parent="GUI/Hud/Header/TopLineR"]
margin_right = 46.0
margin_bottom = 22.0
rect_min_size = Vector2( 46, 0 )
text = "00"
align = 2
script = ExtResource( 17 )
__meta__ = {
"_editor_description_": ""
}

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/MusicPlayer"]
margin_top = 3.0
margin_right = 14.0
margin_bottom = 19.0
texture = SubResource( 148 )

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/MusicPlayer"]
margin_top = 3.0
margin_right = 14.0
margin_bottom = 19.0
texture = SubResource( 146 )

[node name="HighscoreLabel" type="Label" parent="GUI/Hud/Header/TopLineR"]
margin_left = 404.0
margin_right = 556.0
margin_bottom = 22.0
grow_horizontal = 0
size_flags_horizontal = 10
text = "Highscore 00"
align = 2

[node name="PlayerLineR" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR"]
visible = false
margin_left = 256.0
margin_right = 556.0
margin_bottom = 22.0
grow_horizontal = 0
size_flags_horizontal = 11
custom_constants/separation = 16
alignment = 2
__meta__ = {
"_edit_group_": true
}

[node name="PointsHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
margin_right = 38.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 22 )
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect4" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/PointsHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 129 )

[node name="Points" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR/PointsHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="ColorHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
margin_left = 54.0
margin_right = 92.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/ColorHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 269 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR/ColorHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="StepsHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
visible = false
margin_left = 248.0
margin_right = 286.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/StepsHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 268 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR/StepsHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="SkillHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
visible = false
margin_left = 194.0
margin_right = 232.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect5" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/SkillHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 130 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR/SkillHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="BurstHolder" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
visible = false
margin_left = 248.0
margin_right = 286.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect6" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/BurstHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 131 )

[node name="Label" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR/BurstHolder"]
margin_left = 24.0
margin_right = 38.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "0"
valign = 1
__meta__ = {
"_editor_description_": ""
}

[node name="VSeparator" type="VSeparator" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
visible = false
margin_left = 108.0
margin_right = 108.0
margin_bottom = 22.0
size_flags_vertical = 3
custom_constants/separation = 0
custom_styles/separator = SubResource( 248 )

[node name="EnergyBar" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
margin_left = 124.0
margin_top = 3.0
margin_right = 188.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 19 )
size_flags_vertical = 8
custom_constants/separation = 6
script = ExtResource( 8 )

[node name="TextureRect7" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/EnergyBar"]
margin_top = 1.0
margin_right = 10.0
margin_bottom = 19.0
rect_min_size = Vector2( 0, 18 )
size_flags_vertical = 8
texture = SubResource( 125 )

[node name="TextureProgress" type="TextureProgress" parent="GUI/Hud/Header/TopLineR/PlayerLineR/EnergyBar"]
margin_left = 16.0
margin_top = 1.0
margin_right = 64.0
margin_bottom = 19.0
rect_min_size = Vector2( 0, 18 )
size_flags_vertical = 8
max_value = 192.0
step = 8.0
texture_over = SubResource( 126 )
texture_progress = SubResource( 132 )

[node name="LifeIcons" type="HBoxContainer" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
margin_left = 204.0
margin_top = 3.0
margin_right = 256.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 19 )
size_flags_vertical = 8
custom_constants/separation = 2
script = ExtResource( 9 )

[node name="LifeIcon" type="Control" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons"]
margin_top = 1.0
margin_right = 16.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 147 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="LifeIcon2" type="Control" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons"]
margin_left = 18.0
margin_top = 1.0
margin_right = 34.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon2"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 122 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon2"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="LifeIcon3" type="Control" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons"]
margin_left = 36.0
margin_top = 1.0
margin_right = 52.0
margin_bottom = 19.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8

[node name="OffIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon3"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 122 )

[node name="OnIcon" type="TextureRect" parent="GUI/Hud/Header/TopLineR/PlayerLineR/LifeIcons/LifeIcon3"]
margin_right = 16.0
margin_bottom = 16.0
texture = SubResource( 123 )

[node name="PlayerLabel" type="Label" parent="GUI/Hud/Header/TopLineR/PlayerLineR"]
margin_left = 272.0
margin_right = 300.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_colors/font_color = Color( 0.494118, 0.517647, 0.545098, 1 )
text = "P2"
valign = 1
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Footer" type="Control" parent="GUI/Hud"]
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_top = -40.0
grow_vertical = 0
size_flags_horizontal = 3

[node name="FooterUndi" type="ColorRect" parent="GUI/Hud/Footer"]
anchor_right = 1.0
anchor_bottom = 1.0
color = Color( 0.0784314, 0.0784314, 0.0784314, 1 )

[node name="FooterLine" type="HBoxContainer" parent="GUI/Hud/Footer"]
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 32.0
margin_top = -31.0
margin_right = -30.0
margin_bottom = -9.0
custom_constants/separation = 32
__meta__ = {
"_edit_group_": true
}

[node name="GameLine" type="HBoxContainer" parent="GUI/Hud/Footer/FooterLine"]
margin_right = 110.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="Game" type="Label" parent="GUI/Hud/Footer/FooterLine/GameLine"]
margin_right = 60.0
margin_bottom = 22.0
size_flags_horizontal = 8
text = "GAME"
align = 2
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Level" type="Label" parent="GUI/Hud/Footer/FooterLine/GameLine"]
margin_left = 68.0
margin_right = 110.0
margin_bottom = 22.0
size_flags_horizontal = 8
text = "XXL"
align = 2
__meta__ = {
"_editor_description_": ""
}

[node name="SpectrumHolder" type="Control" parent="GUI/Hud/Footer/FooterLine"]
margin_left = 142.0
margin_right = 1038.0
margin_bottom = 22.0
grow_horizontal = 2
size_flags_horizontal = 3

[node name="ColorSpectrum" type="HBoxContainer" parent="GUI/Hud/Footer/FooterLine/SpectrumHolder"]
anchor_top = 0.5
anchor_right = 1.0
anchor_bottom = 0.5
margin_top = -5.0
margin_bottom = 7.0
grow_horizontal = 2
grow_vertical = 2
rect_min_size = Vector2( 0, 12 )
custom_constants/separation = 0
alignment = 1

[node name="SpectrumColorIndicator3" parent="GUI/Hud/Footer/FooterLine/SpectrumHolder/ColorSpectrum" instance=ExtResource( 12 )]
visible = false
margin_right = 896.0
grow_horizontal = 2
grow_vertical = 2
color = Color( 0.494118, 0.517647, 0.545098, 1 )

[node name="StraysLine" type="HBoxContainer" parent="GUI/Hud/Footer/FooterLine"]
margin_left = 1070.0
margin_right = 1218.0
margin_bottom = 22.0
size_flags_horizontal = 9
custom_constants/separation = 16
__meta__ = {
"_edit_group_": true
}

[node name="AstrayHolder" type="HBoxContainer" parent="GUI/Hud/Footer/FooterLine/StraysLine"]
margin_right = 66.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect3" type="TextureRect" parent="GUI/Hud/Footer/FooterLine/StraysLine/AstrayHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 128 )

[node name="Label" type="Label" parent="GUI/Hud/Footer/FooterLine/StraysLine/AstrayHolder"]
margin_left = 24.0
margin_right = 66.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "000"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="PickedHolder" type="HBoxContainer" parent="GUI/Hud/Footer/FooterLine/StraysLine"]
margin_left = 82.0
margin_right = 148.0
margin_bottom = 22.0
size_flags_vertical = 8
custom_constants/separation = 8

[node name="TextureRect2" type="TextureRect" parent="GUI/Hud/Footer/FooterLine/StraysLine/PickedHolder"]
margin_top = 4.0
margin_right = 16.0
margin_bottom = 22.0
rect_min_size = Vector2( 16, 18 )
size_flags_vertical = 8
texture = SubResource( 127 )

[node name="Label" type="Label" parent="GUI/Hud/Footer/FooterLine/StraysLine/PickedHolder"]
margin_left = 24.0
margin_right = 66.0
margin_bottom = 22.0
size_flags_vertical = 8
text = "000"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="PauseMenu" type="Control" parent="GUI"]
pause_mode = 2
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource( 10 )

[node name="Background" type="ColorRect" parent="GUI/PauseMenu"]
anchor_right = 1.0
anchor_bottom = 1.0
color = Color( 0, 0, 0, 0.784314 )

[node name="Title" type="Label" parent="GUI/PauseMenu"]
margin_left = 322.0
margin_top = 94.0
margin_right = 960.0
margin_bottom = 126.0
size_flags_horizontal = 3
custom_colors/font_color = Color( 0.952941, 0.356863, 0.498039, 1 )
custom_fonts/font = ExtResource( 3 )
text = "Game title on pause"
align = 1

[node name="HSeparator" type="HSeparator" parent="GUI/PauseMenu/Title"]
visible = false
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_top = 1.0
margin_right = -3.0
margin_bottom = 5.0

[node name="Controls" type="Control" parent="GUI/PauseMenu"]
margin_left = 288.0
margin_top = 174.0
margin_right = 632.0
margin_bottom = 393.0

[node name="Title" type="Label" parent="GUI/PauseMenu/Controls"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
anchor_right = 1.0
margin_bottom = 22.0
rect_min_size = Vector2( 0, 38 )
size_flags_horizontal = 3
theme = SubResource( 194 )
text = "Player controls"
uppercase = true

[node name="HSeparator" type="HSeparator" parent="GUI/PauseMenu/Controls/Title"]
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 1.0
margin_top = -7.0
margin_right = -1.0
margin_bottom = -3.0

[node name="Keys" type="Control" parent="GUI/PauseMenu/Controls"]
margin_top = 55.0
margin_right = 328.0
margin_bottom = 186.0
rect_pivot_offset = Vector2( 264, 104 )

[node name="Keyboard1" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 96.0
margin_top = 53.0
margin_right = 166.0
margin_bottom = 99.0
texture = SubResource( 192 )

[node name="Keyboard2" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys"]
margin_top = 53.0
margin_right = 70.0
margin_bottom = 99.0
texture = SubResource( 193 )

[node name="Joypad" type="Control" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 224.0
margin_top = 28.0
margin_right = 344.0
margin_bottom = 114.0
__meta__ = {
"_edit_group_": true
}

[node name="jp" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys/Joypad"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
margin_right = 120.0
margin_bottom = 86.0
texture = SubResource( 206 )

[node name="btns" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys/Joypad"]
margin_left = 10.0
margin_top = 17.0
margin_right = 32.0
margin_bottom = 39.0
texture = SubResource( 195 )

[node name="stick" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys/Joypad"]
visible = false
margin_left = 30.0
margin_top = 40.0
margin_right = 48.0
margin_bottom = 58.0
texture = SubResource( 196 )

[node name="btn" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys/Joypad"]
margin_left = 96.0
margin_top = 32.0
margin_right = 106.0
margin_bottom = 42.0
texture = SubResource( 197 )

[node name="Space2" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys"]
margin_top = 133.0
margin_right = 102.0
margin_bottom = 155.0
texture = SubResource( 235 )

[node name="Alt2" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 109.0
margin_top = 133.0
margin_right = 131.0
margin_bottom = 155.0
texture = SubResource( 236 )

[node name="Ctrl" type="TextureRect" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 138.0
margin_top = 133.0
margin_right = 160.0
margin_bottom = 155.0
texture = SubResource( 237 )

[node name="Line2D4" type="Line2D" parent="GUI/PauseMenu/Controls/Keys"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
position = Vector2( -265, 221 )
points = PoolVector2Array( 380, -149, 368, -196 )
width = 0.5
default_color = Color( 1, 1, 1, 1 )
sharp_limit = 0.0
antialiased = true

[node name="Line2D6" type="Line2D" parent="GUI/PauseMenu/Controls/Keys"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
position = Vector2( -298, 229 )
points = PoolVector2Array( 349, -157, 382, -204 )
width = 0.5
default_color = Color( 1, 1, 1, 1 )
sharp_limit = 0.0
antialiased = true

[node name="Line2D5" type="Line2D" parent="GUI/PauseMenu/Controls/Keys"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
position = Vector2( -259, 221 )
points = PoolVector2Array( 496, -172, 445, -197 )
width = 0.5
default_color = Color( 1, 1, 1, 1 )
sharp_limit = 0.0
antialiased = true

[node name="DirKeys" type="Label" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 81.0
margin_top = 3.0
margin_right = 192.0
margin_bottom = 21.0
size_flags_vertical = 1
custom_fonts/font = ExtResource( 4 )
text = "Direction keys"
autowrap = true

[node name="Line2D" type="Line2D" parent="GUI/PauseMenu/Controls/Keys"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
position = Vector2( -149.302, 218.142 )
scale = Vector2( 0.913793, 1.00769 )
points = PoolVector2Array( 485.123, -66.6296, 517.953, -143.042 )
width = 0.5
default_color = Color( 1, 1, 1, 1 )
sharp_limit = 0.0
antialiased = true

[node name="Line2D2" type="Line2D" parent="GUI/PauseMenu/Controls/Keys"]
modulate = Color( 0.494118, 0.517647, 0.545098, 1 )
position = Vector2( -367.895, 238 )
scale = Vector2( 1.17742, 1 )
points = PoolVector2Array( 503.554, -81, 452.595, -93 )
width = 0.5
default_color = Color( 1, 1, 1, 1 )
sharp_limit = 0.0
antialiased = true

[node name="BurstKey" type="Label" parent="GUI/PauseMenu/Controls/Keys"]
margin_left = 232.0
margin_top = 147.0
margin_right = 309.0
margin_bottom = 165.0
size_flags_vertical = 1
custom_fonts/font = ExtResource( 4 )
text = "Burst key"

[node name="Shortcuts" type="Control" parent="GUI/PauseMenu"]
margin_left = 696.0
margin_top = 174.0
margin_right = 992.0
margin_bottom = 383.0

[node name="Title" type="Label" parent="GUI/PauseMenu/Shortcuts"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_right = 296.0
margin_bottom = 38.0
rect_min_size = Vector2( 0, 38 )
size_flags_horizontal = 3
theme = SubResource( 194 )
text = "Shortcuts"
uppercase = true

[node name="HSeparator" type="HSeparator" parent="GUI/PauseMenu/Shortcuts/Title"]
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 1.0
margin_top = -7.0
margin_right = -1.0
margin_bottom = -3.0

[node name="Mute" type="HBoxContainer" parent="GUI/PauseMenu/Shortcuts"]
margin_top = 56.0
margin_right = 262.0
margin_bottom = 78.0
custom_constants/separation = 8
__meta__ = {
"_edit_group_": true
}

[node name="M" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Mute"]
margin_right = 22.0
margin_bottom = 22.0
texture = SubResource( 184 )

[node name="Label" type="Label" parent="GUI/PauseMenu/Shortcuts/Mute"]
margin_left = 30.0
margin_top = 2.0
margin_right = 47.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "or"
align = 1

[node name="L1" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Mute"]
margin_left = 55.0
margin_right = 77.0
margin_bottom = 22.0
texture = SubResource( 185 )

[node name="Label2" type="Label" parent="GUI/PauseMenu/Shortcuts/Mute"]
margin_left = 85.0
margin_top = 2.0
margin_right = 198.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "to mute music"

[node name="Skip" type="HBoxContainer" parent="GUI/PauseMenu/Shortcuts"]
margin_top = 104.0
margin_right = 262.0
margin_bottom = 126.0
custom_constants/separation = 8
__meta__ = {
"_edit_group_": true
}

[node name="N" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Skip"]
margin_right = 22.0
margin_bottom = 22.0
texture = SubResource( 186 )

[node name="Label" type="Label" parent="GUI/PauseMenu/Shortcuts/Skip"]
margin_left = 30.0
margin_top = 2.0
margin_right = 47.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "or"
align = 1

[node name="R1" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Skip"]
margin_left = 55.0
margin_right = 77.0
margin_bottom = 22.0
texture = SubResource( 187 )

[node name="Label2" type="Label" parent="GUI/PauseMenu/Shortcuts/Skip"]
margin_left = 85.0
margin_top = 2.0
margin_right = 257.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "to skip current track"

[node name="Pause" type="HBoxContainer" parent="GUI/PauseMenu/Shortcuts"]
margin_top = 152.0
margin_right = 296.0
margin_bottom = 174.0
custom_constants/separation = 8
__meta__ = {
"_edit_group_": true
}

[node name="Esc" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Pause"]
margin_right = 22.0
margin_bottom = 22.0
texture = SubResource( 188 )

[node name="Label" type="Label" parent="GUI/PauseMenu/Shortcuts/Pause"]
margin_left = 30.0
margin_top = 2.0
margin_right = 47.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "or"
align = 1

[node name="Select" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Pause"]
margin_left = 55.0
margin_right = 96.0
margin_bottom = 22.0
texture = SubResource( 189 )

[node name="Label2" type="Label" parent="GUI/PauseMenu/Shortcuts/Pause"]
margin_left = 104.0
margin_top = 2.0
margin_right = 296.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "to pause/unpause game"

[node name="Enter" type="HBoxContainer" parent="GUI/PauseMenu/Shortcuts"]
margin_top = 200.0
margin_right = 268.0
margin_bottom = 222.0
custom_constants/separation = 8
__meta__ = {
"_edit_group_": true
}

[node name="Enter" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Enter"]
margin_right = 22.0
margin_bottom = 22.0
texture = SubResource( 190 )

[node name="Label" type="Label" parent="GUI/PauseMenu/Shortcuts/Enter"]
margin_left = 30.0
margin_top = 2.0
margin_right = 47.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "or"
align = 1

[node name="Start" type="TextureRect" parent="GUI/PauseMenu/Shortcuts/Enter"]
margin_left = 55.0
margin_right = 95.0
margin_bottom = 22.0
texture = SubResource( 191 )

[node name="Label2" type="Label" parent="GUI/PauseMenu/Shortcuts/Enter"]
margin_left = 103.0
margin_top = 2.0
margin_right = 262.0
margin_bottom = 20.0
theme = SubResource( 194 )
custom_fonts/font = ExtResource( 4 )
text = "to confirm selection"

[node name="Settings" type="Control" parent="GUI/PauseMenu"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 288.0
margin_top = 446.0
margin_right = -288.0
margin_bottom = -192.0

[node name="Title" type="Label" parent="GUI/PauseMenu/Settings"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
anchor_right = 1.0
margin_bottom = 38.0
rect_min_size = Vector2( 0, 38 )
size_flags_horizontal = 3
theme = SubResource( 194 )
text = "Game settings"
uppercase = true

[node name="HSeparator" type="HSeparator" parent="GUI/PauseMenu/Settings/Title"]
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 1.0
margin_top = -7.0
margin_right = -1.0
margin_bottom = -3.0

[node name="GameMusicBtn" type="CheckButton" parent="GUI/PauseMenu/Settings"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_top = 51.0
margin_right = 90.0
margin_bottom = 83.0
focus_neighbour_left = NodePath("../CameraShakeBtn")
focus_neighbour_right = NodePath("../GameMusicSlider")
focus_neighbour_bottom = NodePath("../../Menu/QuitBtn")
mouse_default_cursor_shape = 2
pressed = true
text = "Music"

[node name="GameMusicSlider" type="HSlider" parent="GUI/PauseMenu/Settings"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_left = 282.0
margin_top = 60.0
margin_right = 401.0
margin_bottom = 76.0
focus_neighbour_bottom = NodePath("../../Menu/RestartBtn")
mouse_default_cursor_shape = 2
size_flags_vertical = 8
min_value = -30.0
max_value = 10.0
step = 5.0
value = -20.0
__meta__ = {
"_edit_group_": true
}

[node name="Tick" type="Polygon2D" parent="GUI/PauseMenu/Settings/GameMusicSlider"]
show_behind_parent = true
position = Vector2( 58, 5 )
color = Color( 0.513726, 0.513726, 0.513726, 1 )
polygon = PoolVector2Array( 0, 7, 0, -1, 2, -1, 2, 7 )

[node name="GameMusicVol" type="Label" parent="GUI/PauseMenu/Settings/GameMusicSlider"]
margin_left = -168.0
margin_top = -4.0
margin_right = -10.0
margin_bottom = 18.0
size_flags_horizontal = 3
text = "Music volume"

[node name="GameSfxBtn" type="CheckButton" parent="GUI/PauseMenu/Settings"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_left = 425.0
margin_top = 51.0
margin_right = 492.0
margin_bottom = 83.0
focus_neighbour_bottom = NodePath("../../Menu/PlayBtn")
mouse_default_cursor_shape = 2
pressed = true
text = "SFX"

[node name="CameraShakeBtn" type="CheckButton" parent="GUI/PauseMenu/Settings"]
modulate = Color( 0.513726, 0.513726, 0.513726, 1 )
margin_left = 516.0
margin_top = 51.0
margin_right = 704.0
margin_bottom = 83.0
focus_neighbour_right = NodePath("../GameMusicBtn")
focus_neighbour_bottom = NodePath("../../Menu/PlayBtn")
mouse_default_cursor_shape = 2
pressed = true
text = "Camera Shake"

[node name="Menu" type="HBoxContainer" parent="GUI/PauseMenu"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -240.0
margin_top = 238.0
margin_right = 242.0
margin_bottom = 260.0
custom_constants/separation = 32
__meta__ = {
"_edit_group_": true
}

[node name="QuitBtn" type="Button" parent="GUI/PauseMenu/Menu"]
margin_right = 226.0
margin_bottom = 22.0
focus_neighbour_top = NodePath("../../Settings/GameMusicBtn")
focus_neighbour_right = NodePath("../RestartBtn")
mouse_default_cursor_shape = 2
size_flags_vertical = 0
text = "QUIT TO MAIN MENU"

[node name="RestartBtn" type="Button" parent="GUI/PauseMenu/Menu"]
margin_left = 258.0
margin_right = 356.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../QuitBtn")
focus_neighbour_right = NodePath("../PlayBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 6
size_flags_vertical = 0
text = "RESTART"

[node name="PlayBtn" type="Button" parent="GUI/PauseMenu/Menu"]
margin_left = 388.0
margin_right = 482.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../RestartBtn")
mouse_default_cursor_shape = 2
size_flags_vertical = 0
text = "PLAY ON"

[node name="GameOver" type="Control" parent="GUI"]
pause_mode = 2
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
theme = ExtResource( 2 )
script = ExtResource( 21 )

[node name="Background" type="ColorRect" parent="GUI/GameOver"]
anchor_right = 1.0
anchor_bottom = 1.0
color = Color( 0, 0, 0, 0 )

[node name="GameoverTitle" type="Control" parent="GUI/GameOver"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Duel" type="Control" parent="GUI/GameOver/GameoverTitle"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Win" type="Control" parent="GUI/GameOver/GameoverTitle/Duel"]
visible = false
modulate = Color( 0.368627, 1, 0.662745, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -512.0
margin_top = -160.0
margin_right = 512.0
margin_bottom = 128.0

[node name="PlayerLabel" type="Label" parent="GUI/GameOver/GameoverTitle/Duel/Win"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -272.0
margin_top = -2.0
margin_right = 272.0
margin_bottom = 30.0
grow_horizontal = 2
custom_fonts/font = ExtResource( 3 )
text = "player 1"
align = 1
autowrap = true
uppercase = true

[node name="Win" type="TileMap" parent="GUI/GameOver/GameoverTitle/Duel/Win"]
position = Vector2( 120, 56 )
tile_set = ExtResource( 5 )
cell_size = Vector2( 16, 16 )
cell_custom_transform = Transform2D( 16, 0, 0, 16, 0, 0 )
format = 1
tile_data = PoolIntArray( 14, 0, 0, 16, 0, 0, 18, 0, 0, 20, 0, 0, 22, 0, 0, 26, 0, 0, 29, 0, 0, 30, 0, 0, 31, 0, 0, 34, 0, 0, 65550, 0, 0, 65552, 0, 0, 65554, 0, 0, 65556, 0, 0, 65558, 0, 0, 65562, 0, 0, 65564, 0, 0, 65570, 0, 0, 131086, 0, 0, 131088, 0, 0, 131090, 0, 0, 131092, 0, 0, 131094, 0, 0, 131095, 0, 0, 131098, 0, 0, 131100, 0, 0, 131101, 0, 0, 131102, 0, 0, 131103, 0, 0, 131106, 0, 0, 196622, 0, 0, 196624, 0, 0, 196626, 0, 0, 196628, 0, 0, 196630, 0, 0, 196632, 0, 0, 196634, 0, 0, 196640, 0, 0, 196642, 0, 0, 262158, 0, 0, 262160, 0, 0, 262162, 0, 0, 262164, 0, 0, 262166, 0, 0, 262169, 0, 0, 262170, 0, 0, 262176, 0, 0, 262178, 0, 0, 327694, 0, 0, 327696, 0, 0, 327698, 0, 0, 327700, 0, 0, 327702, 0, 0, 327706, 0, 0, 327712, 0, 0, 393230, 0, 0, 393231, 0, 0, 393233, 0, 0, 393234, 0, 0, 393236, 0, 0, 393238, 0, 0, 393242, 0, 0, 393244, 0, 0, 393245, 0, 0, 393246, 0, 0, 393247, 0, 0, 393248, 0, 0, 393250, 0, 0 )

[node name="ReasonLabel" type="Label" parent="GUI/GameOver/GameoverTitle/Duel/Win"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -160.0
margin_top = 214.0
margin_right = 160.0
margin_bottom = 264.0
grow_horizontal = 2
text = "Winner was better by ..."
align = 1
autowrap = true

[node name="Draw" type="Control" parent="GUI/GameOver/GameoverTitle/Duel"]
visible = false
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -512.0
margin_top = -104.0
margin_right = 512.0
margin_bottom = 160.0

[node name="PlayerLabel" type="Label" parent="GUI/GameOver/GameoverTitle/Duel/Draw"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -272.0
margin_top = -58.0
margin_right = 272.0
margin_bottom = -26.0
grow_horizontal = 2
custom_fonts/font = ExtResource( 3 )
text = "Nobody wins"
align = 1
autowrap = true

[node name="Draw" type="TileMap" parent="GUI/GameOver/GameoverTitle/Duel/Draw"]
position = Vector2( 168, 0 )
tile_set = ExtResource( 5 )
cell_size = Vector2( 16, 16 )
cell_custom_transform = Transform2D( 16, 0, 0, 16, 0, 0 )
format = 1
tile_data = PoolIntArray( 10, 0, 0, 11, 0, 0, 12, 0, 0, 13, 0, 0, 16, 0, 0, 17, 0, 0, 18, 0, 0, 19, 0, 0, 23, 0, 0, 24, 0, 0, 25, 0, 0, 28, 0, 0, 30, 0, 0, 32, 0, 0, 65546, 0, 0, 65550, 0, 0, 65552, 0, 0, 65556, 0, 0, 65558, 0, 0, 65562, 0, 0, 65564, 0, 0, 65566, 0, 0, 65568, 0, 0, 131082, 0, 0, 131086, 0, 0, 131088, 0, 0, 131089, 0, 0, 131090, 0, 0, 131091, 0, 0, 131094, 0, 0, 131095, 0, 0, 131096, 0, 0, 131097, 0, 0, 131098, 0, 0, 131100, 0, 0, 131102, 0, 0, 131104, 0, 0, 196618, 0, 0, 196622, 0, 0, 196624, 0, 0, 196628, 0, 0, 196630, 0, 0, 196634, 0, 0, 196636, 0, 0, 196638, 0, 0, 196640, 0, 0, 262154, 0, 0, 262158, 0, 0, 262160, 0, 0, 262164, 0, 0, 262166, 0, 0, 262170, 0, 0, 262172, 0, 0, 262174, 0, 0, 262176, 0, 0, 327690, 0, 0, 327694, 0, 0, 327696, 0, 0, 327700, 0, 0, 327702, 0, 0, 327706, 0, 0, 327708, 0, 0, 327710, 0, 0, 327712, 0, 0, 393226, 0, 0, 393227, 0, 0, 393228, 0, 0, 393229, 0, 0, 393232, 0, 0, 393236, 0, 0, 393238, 0, 0, 393242, 0, 0, 393244, 0, 0, 393245, 0, 0, 393247, 0, 0, 393248, 0, 0 )

[node name="DrawLabel" type="Label" parent="GUI/GameOver/GameoverTitle/Duel/Draw"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -176.0
margin_top = 158.0
margin_right = 176.0
margin_bottom = 216.0
grow_horizontal = 2
text = "You both collected the same amount of points."
align = 1
autowrap = true

[node name="Menu" type="HBoxContainer" parent="GUI/GameOver/GameoverTitle/Duel"]
visible = false
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -180.0
margin_top = 198.0
margin_right = 180.0
margin_bottom = 220.0
custom_constants/separation = 32
__meta__ = {
"_edit_group_": true
}

[node name="QuitBtn" type="Button" parent="GUI/GameOver/GameoverTitle/Duel/Menu"]
margin_right = 226.0
margin_bottom = 22.0
focus_neighbour_right = NodePath("../RestartBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 2
size_flags_vertical = 8
text = "QUIT TO MAIN MENU"

[node name="RestartBtn" type="Button" parent="GUI/GameOver/GameoverTitle/Duel/Menu"]
margin_left = 258.0
margin_right = 360.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../QuitBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 8
size_flags_vertical = 8
text = "REMATCH"

[node name="ReasonCleaned" type="Control" parent="GUI/GameOver/GameoverTitle"]
visible = false
modulate = Color( 0.368627, 1, 0.662745, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -512.0
margin_top = -104.0
margin_right = 512.0
margin_bottom = 72.0

[node name="Congrats" type="TileMap" parent="GUI/GameOver/GameoverTitle/ReasonCleaned"]
position = Vector2( 120, 0 )
tile_set = ExtResource( 5 )
cell_size = Vector2( 16, 16 )
cell_custom_transform = Transform2D( 16, 0, 0, 16, 0, 0 )
format = 1
tile_data = PoolIntArray( 0, 0, 0, 1, -1610612736, 0, 2, -1610612736, 0, 3, -1610612736, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0, 10, 0, 0, 12, 0, 0, 16, 0, 0, 18, 0, 0, 19, 0, 0, 20, 0, 0, 21, 0, 0, 24, 0, 0, 25, 0, 0, 26, 0, 0, 27, 0, 0, 31, 0, 0, 32, 0, 0, 33, 0, 0, 36, 0, 0, 37, 0, 0, 38, 0, 0, 39, 0, 0, 40, 0, 0, 43, 0, 0, 44, 0, 0, 45, 0, 0, 48, 0, 0, 65536, 0, 0, 65542, -1610612736, 0, 65546, 0, 0, 65548, 0, 0, 65552, 0, 0, 65554, 0, 0, 65560, 0, 0, 65564, 0, 0, 65566, 0, 0, 65570, 0, 0, 65574, 0, 0, 65578, 0, 0, 65584, 0, 0, 131072, 0, 0, 131078, -1610612736, 0, 131082, 0, 0, 131084, 0, 0, 131085, 0, 0, 131088, 0, 0, 131090, 0, 0, 131096, 0, 0, 131097, 0, 0, 131098, 0, 0, 131099, 0, 0, 131102, 0, 0, 131103, 0, 0, 131104, 0, 0, 131105, 0, 0, 131106, 0, 0, 131110, 0, 0, 131114, 0, 0, 131115, 0, 0, 131116, 0, 0, 131117, 0, 0, 131120, 0, 0, 196608, 0, 0, 196614, -1610612736, 0, 196618, 0, 0, 196620, 0, 0, 196622, 0, 0, 196624, 0, 0, 196626, 0, 0, 196632, 0, 0, 196636, 0, 0, 196638, 0, 0, 196642, 0, 0, 196646, 0, 0, 196654, 0, 0, 196656, 0, 0, 262144, 0, 0, 262150, -1610612736, 0, 262154, 0, 0, 262156, 0, 0, 262159, 0, 0, 262160, 0, 0, 262162, 0, 0, 262164, 0, 0, 262165, 0, 0, 262168, 0, 0, 262172, 0, 0, 262174, 0, 0, 262178, 0, 0, 262182, 0, 0, 262190, 0, 0, 262192, 0, 0, 327680, -1610612736, 0, 327686, -1610612736, 0, 327690, 0, 0, 327692, 0, 0, 327696, 0, 0, 327698, 0, 0, 327702, 0, 0, 327704, 0, 0, 327708, 0, 0, 327710, 0, 0, 327714, 0, 0, 327718, 0, 0, 327726, 0, 0, 393216, 0, 0, 393217, 0, 0, 393218, 0, 0, 393219, 0, 0, 393220, 0, 0, 393222, 0, 0, 393223, 0, 0, 393224, 0, 0, 393225, 0, 0, 393226, 0, 0, 393228, 0, 0, 393232, 0, 0, 393234, 0, 0, 393235, 0, 0, 393236, 0, 0, 393237, -1610612736, 0, 393238, -1610612736, 0, 393240, 0, 0, 393244, 0, 0, 393246, 0, 0, 393250, 0, 0, 393254, 0, 0, 393258, 0, 0, 393259, 0, 0, 393260, 0, 0, 393261, 0, 0, 393262, 0, 0, 393264, 0, 0 )

[node name="CleanedLabel" type="Label" parent="GUI/GameOver/GameoverTitle/ReasonCleaned"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -252.0
margin_top = 142.0
margin_right = 252.0
margin_bottom = 174.0
grow_horizontal = 2
custom_fonts/font = ExtResource( 3 )
text = "You are full of colors again!"
align = 1

[node name="ReasonTime" type="Control" parent="GUI/GameOver/GameoverTitle"]
visible = false
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -512.0
margin_top = -104.0
margin_right = 512.0
margin_bottom = 72.0

[node name="GameOver" type="TileMap" parent="GUI/GameOver/GameoverTitle/ReasonTime"]
position = Vector2( 120, 0 )
tile_set = ExtResource( 5 )
cell_size = Vector2( 16, 16 )
cell_custom_transform = Transform2D( 16, 0, 0, 16, 0, 0 )
format = 1
tile_data = PoolIntArray( 0, 0, 0, 1, -1610612736, 0, 2, -1610612736, 0, 3, -1610612736, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0, 12, 0, 0, 16, 0, 0, 18, 0, 0, 19, 0, 0, 20, 0, 0, 21, 0, 0, 27, -1610612736, 0, 28, -1610612736, 0, 29, -1610612736, 0, 30, 0, 0, 32, 0, 0, 36, 0, 0, 38, -1610612736, 0, 39, -1610612736, 0, 40, -1610612736, 0, 41, -1610612736, 0, 44, -1610612736, 0, 45, -1610612736, 0, 46, -1610612736, 0, 47, -1610612736, 0, 65536, 0, 0, 65542, -1610612736, 0, 65546, 0, 0, 65548, 0, 0, 65549, 0, 0, 65551, 0, 0, 65552, 0, 0, 65554, 0, 0, 65562, -1610612736, 0, 65566, -1610612736, 0, 65568, 0, 0, 65572, 0, 0, 65574, 0, 0, 65580, -1610612736, 0, 65584, -1610612736, 0, 131072, 0, 0, 131078, -1610612736, 0, 131079, 0, 0, 131080, 0, 0, 131081, 0, 0, 131082, 0, 0, 131084, 0, 0, 131086, 0, 0, 131088, 0, 0, 131090, 0, 0, 131091, 0, 0, 131092, 0, 0, 131098, -1610612736, 0, 131102, -1610612736, 0, 131104, 0, 0, 131108, 0, 0, 131110, 0, 0, 131111, 0, 0, 131112, 0, 0, 131116, -1610612736, 0, 131117, -1610612736, 0, 131118, -1610612736, 0, 131119, -1610612736, 0, 196608, 0, 0, 196614, -1610612736, 0, 196618, 0, 0, 196620, 0, 0, 196624, 0, 0, 196626, 0, 0, 196634, -1610612736, 0, 196638, -1610612736, 0, 196640, 0, 0, 196644, 0, 0, 196646, 0, 0, 196652, -1610612736, 0, 196656, -1610612736, 0, 262144, 0, 0, 262146, 0, 0, 262147, 0, 0, 262150, -1610612736, 0, 262154, 0, 0, 262156, 0, 0, 262160, 0, 0, 262162, 0, 0, 262170, -1610612736, 0, 262174, -1610612736, 0, 262176, 0, 0, 262180, 0, 0, 262182, 0, 0, 262188, -1610612736, 0, 262192, -1610612736, 0, 327680, -1610612736, 0, 327684, 0, 0, 327686, -1610612736, 0, 327690, 0, 0, 327692, 0, 0, 327696, 0, 0, 327698, 0, 0, 327706, -1610612736, 0, 327710, -1610612736, 0, 327713, 0, 0, 327715, 0, 0, 327718, 0, 0, 327724, -1610612736, 0, 327728, -1610612736, 0, 393216, 0, 0, 393217, 0, 0, 393218, 0, 0, 393219, 0, 0, 393220, 0, 0, 393222, -1610612736, 0, 393226, 0, 0, 393228, 0, 0, 393232, 0, 0, 393234, 0, 0, 393235, 0, 0, 393236, 0, 0, 393237, -1610612736, 0, 393238, -1610612736, 0, 393242, -1610612736, 0, 393243, 0, 0, 393244, 0, 0, 393245, 0, 0, 393246, -1610612736, 0, 393250, 0, 0, 393254, 0, 0, 393255, 0, 0, 393256, 0, 0, 393257, 0, 0, 393258, 0, 0, 393260, -1610612736, 0, 393264, -1610612736, 0 )

[node name="TimeupLabel" type="Label" parent="GUI/GameOver/GameoverTitle/ReasonTime"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -177.0
margin_top = 142.0
margin_right = 177.0
margin_bottom = 174.0
grow_horizontal = 2
custom_fonts/font = ExtResource( 3 )
text = "You are out of time!"
align = 1

[node name="ReasonLife" type="Control" parent="GUI/GameOver/GameoverTitle"]
visible = false
modulate = Color( 0.952941, 0.356863, 0.498039, 1 )
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -512.0
margin_top = -104.0
margin_right = 512.0
margin_bottom = 72.0

[node name="GameOver" type="TileMap" parent="GUI/GameOver/GameoverTitle/ReasonLife"]
position = Vector2( 120, 0 )
tile_set = ExtResource( 5 )
cell_size = Vector2( 16, 16 )
cell_custom_transform = Transform2D( 16, 0, 0, 16, 0, 0 )
format = 1
tile_data = PoolIntArray( 0, 0, 0, 1, -1610612736, 0, 2, -1610612736, 0, 3, -1610612736, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0, 12, 0, 0, 16, 0, 0, 18, 0, 0, 19, 0, 0, 20, 0, 0, 21, 0, 0, 27, -1610612736, 0, 28, -1610612736, 0, 29, -1610612736, 0, 30, 0, 0, 32, 0, 0, 36, 0, 0, 38, -1610612736, 0, 39, -1610612736, 0, 40, -1610612736, 0, 41, -1610612736, 0, 44, -1610612736, 0, 45, -1610612736, 0, 46, -1610612736, 0, 47, -1610612736, 0, 65536, 0, 0, 65542, -1610612736, 0, 65546, 0, 0, 65548, 0, 0, 65549, 0, 0, 65551, 0, 0, 65552, 0, 0, 65554, 0, 0, 65562, -1610612736, 0, 65566, -1610612736, 0, 65568, 0, 0, 65572, 0, 0, 65574, 0, 0, 65580, -1610612736, 0, 65584, -1610612736, 0, 131072, 0, 0, 131078, -1610612736, 0, 131079, 0, 0, 131080, 0, 0, 131081, 0, 0, 131082, 0, 0, 131084, 0, 0, 131086, 0, 0, 131088, 0, 0, 131090, 0, 0, 131091, 0, 0, 131092, 0, 0, 131098, -1610612736, 0, 131102, -1610612736, 0, 131104, 0, 0, 131108, 0, 0, 131110, 0, 0, 131111, 0, 0, 131112, 0, 0, 131116, -1610612736, 0, 131117, -1610612736, 0, 131118, -1610612736, 0, 131119, -1610612736, 0, 196608, 0, 0, 196614, -1610612736, 0, 196618, 0, 0, 196620, 0, 0, 196624, 0, 0, 196626, 0, 0, 196634, -1610612736, 0, 196638, -1610612736, 0, 196640, 0, 0, 196644, 0, 0, 196646, 0, 0, 196652, -1610612736, 0, 196656, -1610612736, 0, 262144, 0, 0, 262146, 0, 0, 262147, 0, 0, 262150, -1610612736, 0, 262154, 0, 0, 262156, 0, 0, 262160, 0, 0, 262162, 0, 0, 262170, -1610612736, 0, 262174, -1610612736, 0, 262176, 0, 0, 262180, 0, 0, 262182, 0, 0, 262188, -1610612736, 0, 262192, -1610612736, 0, 327680, -1610612736, 0, 327684, 0, 0, 327686, -1610612736, 0, 327690, 0, 0, 327692, 0, 0, 327696, 0, 0, 327698, 0, 0, 327706, -1610612736, 0, 327710, -1610612736, 0, 327713, 0, 0, 327715, 0, 0, 327718, 0, 0, 327724, -1610612736, 0, 327728, -1610612736, 0, 393216, 0, 0, 393217, 0, 0, 393218, 0, 0, 393219, 0, 0, 393220, 0, 0, 393222, -1610612736, 0, 393226, 0, 0, 393228, 0, 0, 393232, 0, 0, 393234, 0, 0, 393235, 0, 0, 393236, 0, 0, 393237, -1610612736, 0, 393238, -1610612736, 0, 393242, -1610612736, 0, 393243, 0, 0, 393244, 0, 0, 393245, 0, 0, 393246, -1610612736, 0, 393250, 0, 0, 393254, 0, 0, 393255, 0, 0, 393256, 0, 0, 393257, 0, 0, 393258, 0, 0, 393260, -1610612736, 0, 393264, -1610612736, 0 )

[node name="DiedLabel" type="Label" parent="GUI/GameOver/GameoverTitle/ReasonLife"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -234.0
margin_top = 142.0
margin_right = 234.0
margin_bottom = 174.0
grow_horizontal = 2
custom_fonts/font = ExtResource( 3 )
text = "You are forever colorless!"
align = 1

[node name="GameSummary" type="Control" parent="GUI/GameOver"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="NoHS" type="Control" parent="GUI/GameOver/GameSummary"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Title" type="Label" parent="GUI/GameOver/GameSummary/NoHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -132.0
margin_top = -226.5
margin_right = 132.0
margin_bottom = -194.5
custom_colors/font_color = Color( 0.952941, 0.356863, 0.498039, 1 )
custom_fonts/font = ExtResource( 3 )
text = "GAME SUMMARY"

[node name="DataContainer" type="VBoxContainer" parent="GUI/GameOver/GameSummary/NoHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -112.0
margin_top = -152.0
margin_right = 111.0
margin_bottom = 122.0
custom_constants/separation = 14
alignment = 1
__meta__ = {
"_edit_group_": true
}

[node name="Game" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_right = 223.0
margin_bottom = 18.0
custom_fonts/font = ExtResource( 4 )
text = "Game: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Level" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 32.0
margin_right = 223.0
margin_bottom = 50.0
custom_fonts/font = ExtResource( 4 )
text = "Level: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Points" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 64.0
margin_right = 223.0
margin_bottom = 82.0
custom_fonts/font = ExtResource( 4 )
text = "Points total: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Time" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 96.0
margin_right = 223.0
margin_bottom = 114.0
custom_fonts/font = ExtResource( 4 )
text = "Time used:  %s seconds"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="CellsTraveled" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 128.0
margin_right = 223.0
margin_bottom = 146.0
custom_fonts/font = ExtResource( 4 )
text = "Cells travelled: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="BurstCount" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 160.0
margin_right = 223.0
margin_bottom = 178.0
custom_fonts/font = ExtResource( 4 )
text = "Burst count: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="SkillsUsed" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 192.0
margin_right = 223.0
margin_bottom = 210.0
custom_fonts/font = ExtResource( 4 )
text = "Skill count: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="PixelsOff" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 224.0
margin_right = 223.0
margin_bottom = 242.0
custom_fonts/font = ExtResource( 4 )
text = "Colors collected: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="AstrayPixels" type="Label" parent="GUI/GameOver/GameSummary/NoHS/DataContainer"]
margin_top = 256.0
margin_right = 223.0
margin_bottom = 274.0
custom_fonts/font = ExtResource( 4 )
text = "Pixels left astray: %s"
align = 1
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Menu" type="HBoxContainer" parent="GUI/GameOver/GameSummary/NoHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -195.0
margin_top = 222.0
margin_right = 21.0
margin_bottom = 244.0
custom_constants/separation = 32
__meta__ = {
"_edit_group_": true
}

[node name="QuitBtn" type="Button" parent="GUI/GameOver/GameSummary/NoHS/Menu"]
margin_right = 226.0
margin_bottom = 22.0
focus_neighbour_right = NodePath("../RestartBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 2
size_flags_vertical = 8
text = "QUIT TO MAIN MENU"

[node name="RestartBtn" type="Button" parent="GUI/GameOver/GameSummary/NoHS/Menu"]
margin_left = 258.0
margin_right = 390.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../QuitBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 8
size_flags_vertical = 8
text = "PLAY AGAIN"

[node name="WithHS" type="Control" parent="GUI/GameOver/GameSummary"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Title" type="Label" parent="GUI/GameOver/GameSummary/WithHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -132.0
margin_top = -226.5
margin_right = 132.0
margin_bottom = -194.5
custom_colors/font_color = Color( 0.952941, 0.356863, 0.498039, 1 )
custom_fonts/font = ExtResource( 3 )
text = "GAME SUMMARY"

[node name="DataContainer" type="VBoxContainer" parent="GUI/GameOver/GameSummary/WithHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -215.0
margin_top = -152.0
margin_right = 8.0
margin_bottom = 122.0
custom_constants/separation = 14
__meta__ = {
"_edit_group_": true
}

[node name="Game" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_right = 223.0
margin_bottom = 18.0
custom_fonts/font = ExtResource( 4 )
text = "Game: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Level" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 32.0
margin_right = 223.0
margin_bottom = 50.0
custom_fonts/font = ExtResource( 4 )
text = "Level: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Points" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 64.0
margin_right = 223.0
margin_bottom = 82.0
custom_fonts/font = ExtResource( 4 )
text = "Points total: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="Time" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 96.0
margin_right = 223.0
margin_bottom = 114.0
custom_fonts/font = ExtResource( 4 )
text = "Time used:  %s seconds"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="CellsTraveled" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 128.0
margin_right = 223.0
margin_bottom = 146.0
custom_fonts/font = ExtResource( 4 )
text = "Cells travelled: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="BurstCount" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 160.0
margin_right = 223.0
margin_bottom = 178.0
custom_fonts/font = ExtResource( 4 )
text = "Bursts used: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="SkillsUsed" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 192.0
margin_right = 223.0
margin_bottom = 210.0
custom_fonts/font = ExtResource( 4 )
text = "Skills used: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="PixelsOff" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 224.0
margin_right = 223.0
margin_bottom = 242.0
custom_fonts/font = ExtResource( 4 )
text = "Colors collected: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="AstrayPixels" type="Label" parent="GUI/GameOver/GameSummary/WithHS/DataContainer"]
margin_top = 256.0
margin_right = 223.0
margin_bottom = 274.0
custom_fonts/font = ExtResource( 4 )
text = "Pixels left astray: %s"
valign = 2
__meta__ = {
"_editor_description_": ""
}

[node name="HighscoreTable" type="VBoxContainer" parent="GUI/GameOver/GameSummary/WithHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 38.0
margin_top = -154.0
margin_right = 216.0
margin_bottom = 124.0
custom_constants/separation = 6
script = ExtResource( 15 )
__meta__ = {
"_edit_group_": true
}

[node name="Title" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_right = 178.0
margin_bottom = 26.0
rect_min_size = Vector2( 28, 26 )
size_flags_horizontal = 6
size_flags_vertical = 0
custom_colors/font_color = Color( 0.513726, 0.513726, 0.513726, 1 )
text = "Top 9 cleaners"

[node name="ScoreLine1" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 32.0
margin_right = 178.0
margin_bottom = 54.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine1"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine1"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine1"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine2" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 60.0
margin_right = 178.0
margin_bottom = 82.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine2"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine2"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine2"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine3" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 88.0
margin_right = 178.0
margin_bottom = 110.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine3"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine3"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine3"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine4" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 116.0
margin_right = 178.0
margin_bottom = 138.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine4"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine4"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine4"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine5" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 144.0
margin_right = 178.0
margin_bottom = 166.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine5"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine5"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine5"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine6" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 172.0
margin_right = 178.0
margin_bottom = 194.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine6"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine6"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine6"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine7" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 200.0
margin_right = 178.0
margin_bottom = 222.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine7"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine7"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine7"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine8" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 228.0
margin_right = 178.0
margin_bottom = 250.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine8"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine8"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine8"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="ScoreLine9" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable"]
margin_top = 256.0
margin_right = 178.0
margin_bottom = 278.0
rect_min_size = Vector2( 72, 0 )

[node name="Position" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine9"]
margin_right = 24.0
margin_bottom = 22.0
rect_min_size = Vector2( 24, 0 )
text = "2."

[node name="Owner" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine9"]
margin_left = 28.0
margin_top = 2.0
margin_right = 100.0
margin_bottom = 20.0
rect_min_size = Vector2( 72, 0 )
custom_fonts/font = ExtResource( 4 )
text = "PLAYERRR"
clip_text = true
uppercase = true
__meta__ = {
"_editor_description_": ""
}

[node name="Score" type="Label" parent="GUI/GameOver/GameSummary/WithHS/HighscoreTable/ScoreLine9"]
margin_left = 108.0
margin_right = 178.0
margin_bottom = 22.0
rect_min_size = Vector2( 70, 0 )
size_flags_horizontal = 10
text = "00000"
align = 2

[node name="Menu" type="HBoxContainer" parent="GUI/GameOver/GameSummary/WithHS"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -195.0
margin_top = 222.0
margin_right = 195.0
margin_bottom = 244.0
custom_constants/separation = 32
__meta__ = {
"_edit_group_": true
}

[node name="QuitBtn" type="Button" parent="GUI/GameOver/GameSummary/WithHS/Menu"]
margin_right = 226.0
margin_bottom = 22.0
focus_neighbour_right = NodePath("../RestartBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 2
size_flags_vertical = 8
text = "QUIT TO MAIN MENU"

[node name="RestartBtn" type="Button" parent="GUI/GameOver/GameSummary/WithHS/Menu"]
margin_left = 258.0
margin_right = 390.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../QuitBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 8
size_flags_vertical = 8
text = "PLAY AGAIN"

[node name="NameInputPopup" type="Control" parent="GUI/GameOver"]
visible = false
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -256.0
margin_top = 112.0
margin_right = 256.0
margin_bottom = 336.0

[node name="Undi" type="Panel" parent="GUI/GameOver/NameInputPopup"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0

[node name="Label" type="Label" parent="GUI/GameOver/NameInputPopup"]
anchor_right = 1.0
margin_left = 40.0
margin_top = 22.0
margin_right = -40.0
margin_bottom = 44.0
size_flags_vertical = 3
text = "%s"
align = 1
autowrap = true

[node name="Label2" type="Label" parent="GUI/GameOver/NameInputPopup"]
anchor_right = 1.0
margin_left = -32.0
margin_top = 54.0
margin_right = 32.0
margin_bottom = 80.0
size_flags_vertical = 3
custom_constants/line_spacing = 2
text = "You rank among the all-time best."
align = 1
autowrap = true

[node name="NameInput" type="LineEdit" parent="GUI/GameOver/NameInputPopup"]
anchor_right = 1.0
margin_left = 166.0
margin_top = 101.0
margin_right = -166.0
margin_bottom = 141.0
rect_min_size = Vector2( 180, 40 )
focus_neighbour_bottom = NodePath("../HBoxContainer/ConfirmBtn")
focus_next = NodePath("../HBoxContainer/ConfirmBtn")
size_flags_horizontal = 4
size_flags_vertical = 6
text = "00000000000"
align = 1
caret_blink = true

[node name="HBoxContainer" type="HBoxContainer" parent="GUI/GameOver/NameInputPopup"]
anchor_left = 0.5
anchor_right = 0.5
margin_left = -88.0
margin_top = 166.0
margin_right = 88.0
margin_bottom = 188.0
size_flags_horizontal = 4
size_flags_vertical = 11

[node name="CancelBtn" type="Button" parent="GUI/GameOver/NameInputPopup/HBoxContainer"]
margin_right = 52.0
margin_bottom = 22.0
focus_neighbour_top = NodePath("../../NameInput")
focus_neighbour_right = NodePath("../ConfirmBtn")
focus_next = NodePath("../../NameInput")
mouse_default_cursor_shape = 2
size_flags_horizontal = 2
text = "SKIP"
align = 0

[node name="ConfirmBtn" type="Button" parent="GUI/GameOver/NameInputPopup/HBoxContainer"]
margin_left = 78.0
margin_right = 176.0
margin_bottom = 22.0
focus_neighbour_left = NodePath("../CancelBtn")
focus_neighbour_top = NodePath("../../NameInput")
focus_next = NodePath("../CancelBtn")
mouse_default_cursor_shape = 2
size_flags_horizontal = 9
size_flags_vertical = 9
text = "CONFIRM"
align = 0

[connection signal="animation_finished" from="GUI/Hud/Popups/GameCountdown/AnimationPlayer" to="GUI/Hud/Popups/GameCountdown" method="_on_AnimationPlayer_animation_finished"]
[connection signal="gametime_is_up" from="GUI/Hud/Header/GameTimer" to="GUI/Hud" method="_on_GameTimer_gametime_is_up"]
[connection signal="sudden_death_active" from="GUI/Hud/Header/GameTimer" to="GUI/Hud" method="_on_GameTimer_sudden_death_active"]
[connection signal="timeout" from="GUI/Hud/Header/GameTimer/Timer" to="GUI/Hud/Header/GameTimer" method="_on_Timer_timeout"]
[connection signal="toggled" from="GUI/PauseMenu/Settings/GameMusicBtn" to="GUI/PauseMenu" method="_on_GameMusicBtn_toggled"]
[connection signal="value_changed" from="GUI/PauseMenu/Settings/GameMusicSlider" to="GUI/PauseMenu" method="_on_GameMusicSlider_value_changed"]
[connection signal="toggled" from="GUI/PauseMenu/Settings/GameSfxBtn" to="GUI/PauseMenu" method="_on_GameSfxBtn_toggled"]
[connection signal="toggled" from="GUI/PauseMenu/Settings/CameraShakeBtn" to="GUI/PauseMenu" method="_on_CameraShakeBtn_toggled"]
[connection signal="pressed" from="GUI/PauseMenu/Menu/QuitBtn" to="GUI/PauseMenu" method="_on_QuitBtn_pressed"]
[connection signal="pressed" from="GUI/PauseMenu/Menu/RestartBtn" to="GUI/PauseMenu" method="_on_RestartBtn_pressed"]
[connection signal="pressed" from="GUI/PauseMenu/Menu/PlayBtn" to="GUI/PauseMenu" method="_on_PlayBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameoverTitle/Duel/Menu/QuitBtn" to="GUI/GameOver" method="_on_QuitBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameoverTitle/Duel/Menu/RestartBtn" to="GUI/GameOver" method="_on_RestartBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameSummary/NoHS/Menu/QuitBtn" to="GUI/GameOver" method="_on_QuitBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameSummary/NoHS/Menu/RestartBtn" to="GUI/GameOver" method="_on_RestartBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameSummary/WithHS/Menu/QuitBtn" to="GUI/GameOver" method="_on_QuitBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/GameSummary/WithHS/Menu/RestartBtn" to="GUI/GameOver" method="_on_RestartBtn_pressed"]
[connection signal="text_changed" from="GUI/GameOver/NameInputPopup/NameInput" to="GUI/GameOver" method="_on_NameEdit_text_changed"]
[connection signal="text_entered" from="GUI/GameOver/NameInputPopup/NameInput" to="GUI/GameOver" method="_on_PopupNameEdit_text_entered"]
[connection signal="pressed" from="GUI/GameOver/NameInputPopup/HBoxContainer/CancelBtn" to="GUI/GameOver" method="_on_CancelBtn_pressed"]
[connection signal="pressed" from="GUI/GameOver/NameInputPopup/HBoxContainer/ConfirmBtn" to="GUI/GameOver" method="_on_ConfirmBtn_pressed"]