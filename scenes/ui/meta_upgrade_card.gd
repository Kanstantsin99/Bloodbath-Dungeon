extends PanelContainer

signal selected

var upgrade: MetaUpgrade

@onready var name_label: Label = $VBoxContainer/PanelContainer/NameLabel
@onready var description_label: Label = $VBoxContainer/DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel


func _ready() -> void:
	purchase_button.pressed.connect(on_purchase_pressed)


func set_meta_upgrade(upgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)


func select_card():
	animation_player.play("selected")


func on_purchase_pressed():
	if !upgrade:
		return
	
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	animation_player.play("selected")
