# Godot Camera Controller 2D
## A 2D Camera Controller Singleton with Dev Tools

* Created with Godot Version 3.2.1

1. About
2. Setup
3. Usage

## 2. About
Currently this camera controller only handles screen shake. I will be adding functionality for other effects related to zooming, panning etc.

The screen shake function of the camera controller is designed using the principles outlined in the following video https://www.youtube.com/watch?v=tu-Qe66AvtY 

## 3. Setup
### Sample Project
The easiest way to check out this project is to download or clone it and then import the Godot project file (project.godot) in to your Godot project list. 
This project contains a small scene with a player that you can move around to test the controller functions.

### Your Own Project (no Dev Tools)
1. Copy the CameraController folder (from src/singletons) to your project wherever you keep singletons. 

2. Add CameraController.tscn as a singleton in the AutoLoad tab of the project settings.

3. Call CameraController.set_current_camera({ reference_to_camera }) from a script in a scene that has access to the camera you want to attach the 
controller too. For example you might have a line like this CameraController.set_current_camera($Camera2D) in the _ready() function of your Player script.

### Your Own Project (with Dev Tools)
1. Copy the CameraController and CameraControllerWithDevTools folders (from src/singletons) to your project wherever you keep singletons. 

2. Add CameraControllerWithDevTools.tscn as a singleton in the AutoLoad tab of the project settings.

3. Aall CameraControllerWithDevTools.set_current_camera({ reference_to_camera }) from a script in a scene that has access to the camera you want to attach the 
controller too. In the example scene this line is in the Player script (src/player/Player.gd) and looks like this CameraControllerWithDevTools.set_current_camera($Camera2D)

4. Add the following key bindings under Project Settings > Input Map:

*Binding Name* | *Key*

- increase_camera_shake | Control+UP
- decrease_camera_shake | Control+DOWN
- small_shake | 1
- medium_shake | 2
- large_shake | 3

<small>* The binding name must be the same but you can change which keys are used.</small>

## 3. Usage
### Screen Shake
You can initiate screen shake simply by calling: 

CameraController.shake_screen({ value })

Where 'value' is a float between 0.1 and 1, the number you pass in gets ADDED to the current amount of screen shake so that you can simply add more shake as other things happen. 

<small>This is an alternative to using a priority system. In this way you can add smaller or larger shakes and they are inclusive to a total amount of shake.</small>

### Screen Shake Dev Tools
With the Dev Tool enabled you should see a bar at the bottom of the camera and several options along the right side of the screen. This options are:

**Shake Lock** - With Shake Lock enabled the screen shake will remain at whatever it's current value is. With is disabled the screen shake will gradually slow to nothing based on a cool_down_speed variable. 

If you press the key attached to the "medium_shake" binding you should see the bar at the bottom move to half, then screen will then either continue to shake or shake as the bar returns to 0 depending on if Shake Lock is on or off.

**Noise** - The amount that the camera moves each shake is determined by some contstraints (max angle, max offset x and y) multiplied by a random number between -1 and 1. 

When noise is enabled we get that random number using a perlin noise algorithm as opposed to a standard random number when it is disabled.

**Tween** - This determines whether we move the camera from one position to the next or pop the camera there. 

When enabled the speed in which the camera travels is determined a shake_speed variable.

**Rotation** - Determines whether the shake includes rotational movement of the camera. 

<small>* The rotating variable of the camera must be turned on for this to work. The Camera Controller automatically turns it on when you use the set_current_camera method.</small>

**Offset** - Determines whether the shake should include left/right and up/down movement.

By leaving the Shake Lock turned on you can set a shake using the key bindings and then turn functions on and off to see the differences. 

### 5. Contact

~ I'd love to hear if you use this Camera Controller in your project! Find me through www.burtonmediainc.com 
