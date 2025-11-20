# PixelQuest - Project Context

## Project Overview
**PixelQuest** is a 2D cyber/sci-fi themed game built using the **Godot Engine (v4.3)**. It utilizes a pixel art aesthetic, evidenced by the texture filter settings and asset organization.

## Architecture & Structure

### Key Directories
- **`assets/`**: Contains raw game assets.
    - `sprites/`: Character and environment sprites (e.g., `PixelArtCharacterGenerator_v2_2_Anim-Sheet.png`).
- **`scenes/`**: Contains Godot scene files (`.tscn`).
    - `player/`: Player-specific scenes.
- **`scripts/`**: Contains GDScript logic files (`.gd`).
    - `player/`: Player logic.
- **Root**:
    - `project.godot`: Main configuration file.
    - `Level1.tscn`: The current main entry scene.

### Configuration (`project.godot`)
- **Engine Version**: Godot 4.3
- **Rendering**: Mobile renderer.
- **Texture Filtering**: Nearest-neighbor (pixel art friendly) is enabled (`textures/canvas_textures/default_texture_filter=0`).
- **Main Scene**: `res://Level1.tscn`

## Development Conventions

### Language & Style
- **Language**: GDScript.
- **Typing**: Static typing hints are observed in some places (e.g., `delta: float`), though not strictly enforced everywhere in the snippet seen.
- **Conventions**:
    - Standard Godot naming conventions (snake_case for functions/variables, PascalCase for nodes/classes).
    - Physics logic is handled in `_physics_process`.
    - `move_and_slide()` is used for `CharacterBody2D` movement.

### Building & Running
This project is designed to be opened and run within the Godot Editor.
1.  **Open Project**: Launch Godot 4.3 and import the `project.godot` file.
2.  **Run**: Press F5 (or the Play button) to run the main scene (`Level1.tscn`).

## Current Status
- Basic player movement (gravity, jumping, horizontal movement) is implemented in `scripts/player/player.gd`.
- A `Level1` scene exists as the starting point.
