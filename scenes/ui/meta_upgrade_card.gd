extends PanelContainer

signal selected


@onready var name_label: Label = $VBoxContainer/PanelContainer/NameLabel
@onready var description_label: Label = $VBoxContainer/DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_animaition_player: AnimationPlayer = $HoverAnimaitionPlayer


func _ready() -> void:
	gui_input.connect(on_gui_input)


func set_ability_upgrade(upgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.discription


func select_card():
	animation_player.play("selected")


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		select_card()
