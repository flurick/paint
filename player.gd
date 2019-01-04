extends KinematicBody2D

var gravity_vector = Vector2(0,1000)
var move_speed = 3000
var move_jump_speed = 16000
var friction = 0.8
var velocity = Vector2(0,0)
var jump_combo = 0
var jump_combo_max = 1

var super_mode = false
var cursor_speed = 5
var is_cursor_active = true

func _input(event):
	
	if event.is_action("move_jump") and is_cursor_active:
		#todo: 3d raytracing?
		global.grp_clear("held")
		if $cursor/RayCast2D.is_colliding():
			$cursor/RayCast2D.get_collider().add_to_group("held")
	
	if event.is_action("super_mode") and event.pressed:
		if super_mode: 
			#enter normal mode
			super_mode = false
			set_collision_mask_bit( global.layer.platform, true )
			show_layer_mask()
			$cursor.hide()
			$gloria.hide()
		else:
			#enter super mode
			super_mode = true
			move_speed = 1000
			$cursor.position = Vector2(0,0)
			set_collision_mask_bit( global.layer.platform_bg, false )
			set_collision_mask_bit( global.layer.platform, false )
			set_collision_mask_bit( global.layer.platform_fg, false )
			show_layer_mask()
			$cursor.show()
			$gloria.show()
		velocity = Vector2(0,0)
#		$Label.text = str("super_mode: ", super_mode)


func show_layer_mask():
	for i in range(1,21):
		get_node( str("layermask/Button",i) ).pressed = get_collision_mask_bit( i )
	update()

func _process(delta):
	
	print( is_on_ceiling(), is_on_floor() )
	
	if super_mode:
		 move_in_super_mode(delta)
	else: 
		move_in_play(delta)
	
	if is_cursor_active:
		$cursor.position.y += Input.get_joy_axis(0, JOY_AXIS_4) * cursor_speed
		$cursor.position.x += Input.get_joy_axis(0, JOY_AXIS_3) * cursor_speed
		$cursor.velocity.y += Input.get_joy_axis(0, JOY_AXIS_4) * cursor_speed
		$cursor.velocity.x += Input.get_joy_axis(0, JOY_AXIS_3) * cursor_speed
		if global.grp("held") and global.grp("held").has_method("push"):
			global.grp("held").push($cursor)



func move_in_super_mode(delta):
	if Input.is_action_pressed("move_left"):
		velocity -= Vector2(move_speed,0)
	if Input.is_action_pressed("move_right"):
		velocity += Vector2(move_speed,0)
	if Input.is_action_pressed("move_up"):
		velocity -= Vector2(0,move_speed)
	if Input.is_action_pressed("move_down"):
		velocity += Vector2(0,move_speed)
	
	velocity *= 0.9
	move_and_slide(velocity*delta)



func move_in_play(delta):
	if Input.is_action_pressed("move_left"):
		velocity -= Vector2(move_speed,0)
	if Input.is_action_pressed("move_right"):
		velocity += Vector2(move_speed,0)
	if Input.is_action_pressed("move_jump"):
		if jump_combo < jump_combo_max:
			jump_combo += 1
			velocity.y = -move_jump_speed
	
	
	if Input.is_action_pressed("move_up"):
		if $timer_layer_switching.time_left == 0:
			$timer_layer_switching.start()
			if get_collision_mask_bit( global.layer.platform ):
				set_collision_mask_bit( global.layer.platform, false )
				set_collision_mask_bit( global.layer.platform_bg, true )
			if get_collision_mask_bit( global.layer.platform_fg ):
				set_collision_mask_bit( global.layer.platform_fg, false )
				set_collision_mask_bit( global.layer.platform, true )
			show_layer_mask()
		
	if Input.is_action_pressed("move_down"):
		if $timer_layer_switching.time_left == 0:
			$timer_layer_switching.start()
			if get_collision_mask_bit( global.layer.platform_bg ):
				set_collision_mask_bit( global.layer.platform_bg, false )
				set_collision_mask_bit( global.layer.platform, true )
			if get_collision_mask_bit( global.layer.platform ):
				set_collision_mask_bit( global.layer.platform, false )
				set_collision_mask_bit( global.layer.platform_fg, true )
			show_layer_mask()
		
	if $head.is_colliding():
		if velocity.y > 0: velocity.y *= -0.5
	
	if $RayCast2D.is_colliding():
		velocity *= friction
		move_speed = 1000
		jump_combo = 0
	else:
		velocity += gravity_vector
		move_speed = 60
		
	move_and_slide(velocity*delta)


func _draw():
	var width = 1
	for i in range( 1,21):  draw_line( Vector2(i*width, 0),       Vector2(i*width+width, 0),       Color(get_collision_mask_bit(i),1,1), width )
	for i in range(11,21):  draw_line( Vector2(i*width, width*2), Vector2(i*width+width, width*2), Color(get_collision_mask_bit(i),1,1), width )