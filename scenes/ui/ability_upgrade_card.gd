extends PanelContainer

signal selected


var disabled = false

@onready var name_label: Label = $VBoxContainer/PanelContainer/NameLabel
@onready var description_label: Label = $VBoxContainer/DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_animaition_player: AnimationPlayer = $HoverAnimaitionPlayer


func _ready() -> void:
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await  get_tree().create_timer(delay).timeout
	animation_player.play("in")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.discription


func select_card():
	disabled = true
	animation_player.play("selected")
	
	var cards = get_tree().get_nodes_in_group("upgrade_card")
	for other_card in cards:
		if other_card == self:
			continue
		
		other_card.animation_player.play("discard")
	
	await animation_player.animation_finished
	selected.emit()


func on_gui_input(event: InputEvent):
	if disabled:
		return
	
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return
	
	hover_animaition_player.play("hover")
