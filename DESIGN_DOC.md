# Game Design Document: PixelQuest

## 1. Story Outline
*   **Premise:** "PixelQuest" is set in **Neo-Arcadia**, a solarpunk world where nature and technology coexist in harmony. However, a mysterious digital corruption known as "The Static" is beginning to consume the environment, turning lush forests into glitched, hazardous data wastelands.
*   **Main Character:** **Nova**, a young "System Gardener" equipped with a specialized Tech-Gauntlet capable of purifying corrupted code.
*   **Narrative Arc:** Nova discovers the corruption originating from the old Underground Server Core. She must travel from the surface forests down into the digital depths, defeating "Glitch Beasts" (corrupted wildlife) to reboot the Core and save Neo-Arcadia.

## 2. Technical Architecture (Godot 4.x)
*   **Design Pattern:** Component-Entity-System.
    *   **Actors:** Use composition (`HealthComponent`, `VelocityComponent`, `StateMachine`). Avoid inheritance trees where possible.
    *   **State Machine:** Node-based Finite State Machine for Player and Enemy logic.
    *   **Typing:** Strict GDScript static typing (`:=`, `: float`) enforced.
*   **Project Structure:**
    *   `src/actors/`: Player and NPC scenes/scripts.
    *   `src/levels/`: Game world scenes.
    *   `src/components/`: Reusable logic nodes (StateMachine, Hurtbox).
    *   `src/autoload/`: Global singletons (Events, GameState).
    *   `assets/`: Raw resources.
*   **Rendering:**
    *   **Resolution:** 640x360 (Pixel Art).
    *   **Stretch Mode:** Viewport (Integer scaling).
    *   **Filtering:** Nearest Neighbor.

## 3. Core Gameplay Mechanics
*   **Genre:** 2D Action-Platformer.
*   **Controls (Input Map):**
    *   `Move Left/Right` (A/D or Arrows): Standard movement.
    *   `Jump` (Space/W): Variable height jump.
    *   `Dash/Interact` (Shift/K): A short burst of speed that also activates data nodes.
*   **Game Feel (Juice):**
    *   **Coyote Time:** 0.1s buffer to jump after leaving a ledge.
    *   **Jump Buffer:** 0.1s buffer to register jumps before landing.
    *   **Hit Stop:** Micro-pause on impact.
    *   **Screen Shake:** Procedural noise-based camera shake.

## 4. Level Design
*   **Design Philosophy:** "Teach, Test, Twist." Introduce a mechanic safely, test the player's mastery in a combat situation, then twist it with a environmental hazard.
*   **Level 1: The Overgrown Server (Forest Zone)**
    *   **Visuals:** Lush green grass, trees with glowing data-cables roots, blue sky.
    *   **Layout:** Horizontal progression. Introduction to jumping gaps and basic enemies.
    *   **Key Setpiece:** A large, ancient computer terminal covered in vines that serves as a checkpoint.
*   **Level 2: The Corrupted Root (Underground Zone)**
    *   **Visuals:** Darker earth tones, neon purple/green "static" pools, industrial pipes.
    *   **Layout:** Vertical descent. Introduction to moving platforms and "glitch blocks" (platforms that toggle on/off).

## 5. Art & Sound
*   **Visual Style:**
    *   **Aesthetic:** 16-bit "Hi-Bit" Pixel Art.
    *   **Palette:** High contrast. Lush greens (#4b8f23, #a7d665) mixed with "Neon Cyberpunk" accents (#00ffff, #f58ec6).
    *   **References:** *Celeste*, *Hyper Light Drifter*, *Sonic Mania*.
*   **Sprite Guidelines:**
    *   **Nova:** Distinct silhouette, purple hair/jacket to contrast with green backgrounds. Expressive idle animations (checking her gauntlet).
    *   **Environment:** Tilesets should have clear "readable" edges. Foreground elements (grass) should not obscure gameplay hazards.
*   **Audio Direction:**
    *   **Music:** Upbeat Chiptune blended with atmospheric Synthwave. "Forest" track is airy and light; "Underground" is bass-heavy and glitchy.
    *   **SFX:** Crunchy "retro" sounds for jumping and collecting. Digital "zap" sounds for the dash and enemy hits.