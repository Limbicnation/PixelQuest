# PixelQuest
Welcome to PixelQuest, an immersive cyber and sci-fi themed game!

## How to Run (Testing)
This project is built with **Godot 4.3**.

1.  **Open the Project**: Launch Godot Engine and import the `project.godot` file from this repository.
2.  **Play**:
    *   Press **F5** (or click the "Play" button in the top-right corner) to run the main scene (`Level1.tscn`).
    *   Use **WASD** or **Arrow Keys** to move and jump.

## How to Build (Exporting)
To create a standalone executable (e.g., for Linux, Windows, or Web):

1.  **Install Export Templates**: In Godot, go to `Editor > Manage Export Templates` and download the templates for Godot 4.3.
2.  **Configure Export**:
    *   Go to `Project > Export`.
    *   Click **Add...** and select your target platform (e.g., **Linux/X11**).
    *   (Optional) Adjust settings like "Embed Pck" for a single-file executable.
3.  **Export**: Click **Export Project**, choose a destination folder (e.g., `builds/`), and save.

**Note**: The `export_presets.cfg` file is not currently tracked. You will need to create your own presets locally.

## Troubleshooting

### Linux (X11) Errors
If you encounter **`BadWindow`** errors or crashes with messages like *"Attempting to make child window exclusive"*:
1.  In the Godot Editor, go to **Editor > Editor Settings**.
2.  Navigate to **Interface > Editor**.
3.  Enable **Single Window Mode**.
4.  Restart the Editor.

This forces all floating windows (popups, tooltips) to be embedded within the main editor window, resolving most X11 window management conflicts.
